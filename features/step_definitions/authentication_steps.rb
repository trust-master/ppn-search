Given(/^I am not logged in$/) do
  reset_session!
end

Given(/^a valid user exists in the database$/) do
  c = Company.create(name: 'Company')
  u = User.new({ first_name: 'Test', last_name: 'User', company_id: c.id,
          password: 'test123!', password_confirmation: 'test123!', email: 'test@test.com' }, without_protection: true)
  u.company = c
  u.save
end

When(/^I go to the log[- ]?in page$/) do
  visit(login_path)
end

When(/^click the log[- ]?out (?:button|link)$/) do
  click_link I18n.t('session.destroy.action') # log out link
end

When(/^I enter a valid email and password$/) do
  within 'form.session' do
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'test123!'
    click_button 'login'
  end
end

When(/^I enter an invalid email and any password$/) do
  within 'form.session' do
    fill_in 'Email', with: 'invalid.email@nonexistent-domain.coe'
    fill_in 'Password', with: 'aaa'
    click_button 'login'
  end
end

When(/^I enter an valid email and invalid password$/) do
  within 'form.session' do
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'aaa'
    click_button 'login'
  end
end

