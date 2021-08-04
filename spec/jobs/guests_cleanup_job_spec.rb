require 'rails_helper'

RSpec.describe GuestsCleanupJob, type: :job do
  
  describe "#perform_later" do 

    it "removes old guest users" do 
      user = create(:user, :guest)
      ActiveJob::Base.queue_adapter = :test
      expect {
        GuestsCleanupJob.set(wait: 1.week).perform_later(user)
      }.to have_enqueued_job
    end
  end
end
