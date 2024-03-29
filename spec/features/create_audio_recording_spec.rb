# frozen_string_literal: true

# Generated via
#  `rails generate hyrax:work AudioRecording`
require "rails_helper"
include Warden::Test::Helpers

# NOTE: If you generated more than one work, you have to set "js: true"
RSpec.describe "Create a AudioRecording", js: false do
  context "a logged in user" do
    let(:user_attributes) do
      { email: "test@example.com" }
    end
    let(:user) do
      User.new(user_attributes) { |u| u.save(validate: false) }
    end

    before do
      AdminSet.find_or_create_default_admin_set_id
      login_as user
    end

    it do
      visit "/dashboard"
      click_link "Works"
      click_link "Add new work"

      # If you generate more than one work uncomment these lines
      # choose "payload_concern", option: "AudioRecording"
      # click_button "Create work"

      expect(page).to have_content "Add New Audio recording"
    end
  end
end
