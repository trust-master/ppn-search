

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
