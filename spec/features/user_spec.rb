require 'spec_helper'
require 'rails_helper'

describe "the signin and signout process", type: :feature do
  let(:test_user) { FactoryGirl.create(:user) }
       
  it 'test user should exist' do
    expect(User.where(email: test_user.email)).to exist
  end

  it "user signs in" do
    log_in_as(test_user)
    expect(page).to have_link 'Sign out'
  end

  it "user signs out" do
    log_in_as(test_user)
    log_out
    expect(page).to have_link 'Sign in'
  end
end

# setup :activate_authlogic
# UserSession.create!(test_user)
# Capybara.current_session.driver.browser.set_cookie("user_credentials=#{test_user.persistence_token}::#{test_user.send(test_user.class.primary_key)}")
