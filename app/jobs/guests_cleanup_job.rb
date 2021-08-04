class GuestsCleanupJob < ApplicationJob
  queue_as :default

  def perform(guest)
    guest.destroy
  end
end
