When(/^I click the reset password link$/) do
  click_link I18n.t('sessions.new.recover')
end

When(/^I fill in email$/) do
  fill_in 'Email', with: 'test@test.com'
end

When(/^I fill in email with '(.*?)'$/) do |value|
  fill_in 'Email', with: value
end

When(/^I fill in first name$/) do
  fill_in 'Name', with: 'Test'
end

When(/^I fill in first name with '(.*?)'$/) do |value|
  fill_in 'Name', with: value
end

When(/^I submit the form$/) do
  click_on 'submit'
end

Then(/^I should receive an email with my password reset link$/) do
  last_email.should be_present
  last_email.to.should include('test@test.com')
  last_email.to_s.should match(
    %r{http://#{ActionMailer::Base.default_url_options[:host]}/password_resets/[\w\-]{12}})
end

Then(/^I should not receive an email$/) do
  last_email.should_not be_present
end

Given(/^I request a password reset$/) do
  step('I click the reset password link')
  step('I fill in email')
  step('I fill in first name')
  step('I submit the form')
end

When(/^I go to the URL from the password reset email$/) do
  url = last_email.to_s.match(
    %r{http://#{ActionMailer::Base.default_url_options[:host]}/password_resets/[\w\-]{12}}
  ).to_s

  visit(url)
end

Then(/^I should be logged in$/) do
  page.should have_xpath(".//a[@href=\"#{logout_path}\"]")
end

Then(/^the Password Reset should (\w+)$/i) do |expected_result|
  case expected_result.downcase
  when 'fail'
    step('I should see the Password_Resets:update failure message')
    step('I should see the Password_Resets:show instructions message')
  when 'succeed'
    step('I should be logged in')
    step('I should see the Password_Resets:update success message')
    step('I should be at the root path')
  end
end

When(/^I fill in (Password(?: Confirmation)?) with '(.+?)'$/i) do |field_name, password|
  label = I18n.translate("simple_form.labels.user.#{field_name.downcase.gsub(/\s+/,'_')}")
  fill_in label, with: password
end