require 'spec_helper'

describe 'UserAuthToken' do
  before(:all) do
    @user = FactoryGirl.create(:user)
  end

  before(:each) do
    @auth_token = @user.auth_tokens.create(created_by_ip: '5.6.7.8')
  end

  describe '#token' do
    it 'generates a 12-byte URL-safe Base64-encoded token before save' do
      # Notice there is no room for '=', here. I want a fully utilized 12-digit base64 string
      @auth_token.token.should match(/[0-9a-zA-Z_\-]{12}/)
    end

    it 'ensures uniqueness of the token' do
      erroneous_token = @user.auth_tokens.create
      erroneous_token.token = @auth_token.token
      erroneous_token.save
      erroneous_token.should_not be_valid
    end

    it 'scopes each token to the User ID' do
      Base64.urlsafe_decode64(@auth_token.token).unpack('L*').first.should == @auth_token.user_id
    end
  end

  describe '#create' do
    it 'will persist to the database when calling create with no attributes' do
      @auth_token.should be_persisted
    end

    it 'will only allow for setting the created_by_ip during creation' do
      @auth_token.created_by_ip = '1.2.3.4'
      @auth_token.save
      @auth_token.reload
      @auth_token.created_by_ip.should match('5.6.7.8')
    end

    it 'will set an expiration time (set in the future) during creation' do
      @auth_token.expires_at.should_not be_blank
      @auth_token.expires_at.should be > 1.minute.from_now
    end
  end

  describe '#fullfill' do
    it 'will accept only a valid IP address' do
      expect { @auth_token.fullfill!('123.2.55.243') }.not_to raise_error
      expect { @auth_token.fullfill!('also.not.an.ip') }.to raise_error
    end

    it 'will save the IP address and current time to the db' do
      @auth_token.fullfill!('123.2.55.243')
      @auth_token.fullfilled_by_ip.should_not be_blank
      @auth_token.fullfilled_by_ip.should match('123.2.55.243')
      @auth_token.fullfilled_at.should_not be_blank
    end
  end

  describe '#expired?' do
    it 'will return true only after the expiration time has passed' do
      @auth_token.should_not be_expired
      @auth_token.expires_at = 1.minute.ago
      @auth_token.should be_expired
    end
  end

  describe '#fullfilled?' do
    it 'will return true only after the fullfilled_at column has a value' do
      @auth_token.should_not be_fullfilled
      @auth_token.fullfill!('8.6.77.9')
      @auth_token.should be_fullfilled
    end
  end

  describe '#active?' do
    it 'will return true only if neither fullfilled or expired.' do
      @auth_token.should be_active # active upon creation

      @auth_token.fullfill!('8.6.77.9')
      @auth_token.should_not be_active # not active, since fullfilled?

      @auth_token.expires_at = 1.minute.ago
      @auth_token.should_not be_active # not active, since fullfilled? AND expired?

      @auth_token.fullfilled_at = nil
      @auth_token.should_not be_active # not active, since expired?
    end
  end

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
#  expires_at       :datetime
#  created_at       :datetime
#  created_by_ip    :string(255)
#  updated_at       :datetime
#

