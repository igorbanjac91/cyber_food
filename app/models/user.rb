class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  
  # validates :first_name, presence: true, unless: :guest?
  # validates :last_name, presence: true, unless: :guest?

  validates_presence_of   :email, unless: :guest?
  validates_uniqueness_of :email, unless: :guest?
  validates_format_of     :email, with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, unless: :guest?

  validates_presence_of     :password, allow_blank: true, unlses: :guest?
  validates_confirmation_of :password, unlses: :guest?
  validates_length_of       :password, within: 6..128, allow_blank: true, unlses: :guest?

  has_many :orders

  after_create do 
    unless Rails.env == "test" || "development"
      customer = Stripe::Customer.create(email: email)
      update(stripe_customer_id: customer.id)
    end
  end

  def to_s
    email
  end

  def name
    guest ? "Guest" : first_name
  end

  def self.new_guest 
    create do |u| 
      u.guest = true 
      u.email = nil
    end
  end

  def new_order
    orders.where(status: "new")[0]
  end

  def new_order?
    !!new_order
  end

end
