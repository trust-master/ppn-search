require 'spec_helper'

shared_examples 'UserAuthToken' do |association_name|
  let(:user) { FactoryGirl.create(:user) }
  let(:token_object) { user.send(association_name).create }

  describe '#token' do
    it 'generates a 12-byte URL-safe Base64-encoded token before save' do
      # Notice there is no room for '=', here. I want a fully utilized 12-digit base64 string
      token_object.token.should match(/[0-9a-zA-Z_\-]{12}/)
    end

    it 'ensures uniqueness of the token' do
      erroneous_token = user.send(association_name).create
      erroneous_token.token = token_object.token
      erroneous_token.save
      erroneous_token.should_not be_valid
    end

    it 'scopes each token to the User ID' do
      Base64.urlsafe_decode64(token_object.token).unpack('L*').first.should == token_object.user_id
    end
  end

  describe '#create' do
    it 'will persist to the database when calling create with no attributes' do
      token_object.should be_persisted
    end

    # it 'will only allow for setting the created_by_ip during creation' do
    #   token_object.created_by_ip = '1.2.3.4'
    #   token_object.save
    #   token_object.reload
    #   token_object.created_by_ip.should match('5.6.7.8')
    # end

    it 'will set an expiration time (set in the future) during creation' do
      token_object.expires_at.should_not be_blank
      token_object.expires_at.should be > 1.minute.from_now
    end
  end

  # describe '#fullfill' do
  #   it 'will accept only a valid IP address' do
  #     expect { token_object.fullfill!('123.2.55.243') }.not_to raise_error
  #     expect { token_object.fullfill!('also.not.an.ip') }.to raise_error
  #   end

  #   it 'will save the IP address and current time to the db' do
  #     token_object.fullfill!('123.2.55.243')
  #     token_object.fullfilled_by_ip.should_not be_blank
  #     token_object.fullfilled_by_ip.should match('123.2.55.243')
  #     token_object.fullfilled_at.should_not be_blank
  #   end
  # end

  describe '#expired?' do
    it 'will return true only after the expiration time has passed' do
      token_object.should_not be_expired
      token_object.expires_at = 1.minute.ago
      token_object.should be_expired
    end
  end

  describe '#fullfilled?' do
    it 'will return true only after the fullfilled_at column has a value' do
      token_object.should_not be_fullfilled
      token_object.fullfill! #('8.6.77.9')
      token_object.should be_fullfilled
    end
  end

  describe '#active?' do
    it 'will return true only if neither fullfilled or expired.' do
      token_object.should be_active # active upon creation

      token_object.fullfill! #('8.6.77.9')
      token_object.should_not be_active # not active, since fullfilled?

      token_object.expires_at = 1.minute.ago
      token_object.should_not be_active # not active, since fullfilled? AND expired?

      token_object.fullfilled_at = nil
      token_object.should_not be_active # not active, since expired?
    end
  end

end

describe 'UserAuthToken' do
  it_should_behave_like 'UserAuthToken', :auth_tokens
end
describe 'PasswordReset' do
  it_should_behave_like 'UserAuthToken', :password_resets
end


# == Schema Information
#
# Table name: user_auth_tokens
#
#  id               :integer         not null, primary key
#  user_id          :integer
#  token            :string(255)
#  type             :string(255)
#  fullfilled_by_ip :string(255)
#  fullfilled_at    :datetime
#  email_sent_at    :datetime
#  expires_at       :datetime        not null
#  created_at       :datetime        not null
#  created_by_ip    :string(255)
#  updated_at       :datetime        not null
#

