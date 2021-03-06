When(/^I click the reset password link$/) do
  click_link I18n.t('sessions.new.cant_log_in')
  reset_email
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
  # label = I18n.translate("simple_form.labels.user.#{field_name.downcase.gsub(/\s+/,'_')}")
  label = form_label_for([:user], field_name.downcase.gsub(/\s+/, '_'))
  fill_in label, with: password
end
