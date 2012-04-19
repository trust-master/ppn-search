require 'spec_helper'

describe PasswordResetsController do
  describe 'routing' do

    it 'routes to #new' do
      get('/password_resets/new').should route_to('password_resets#new')
    end

    it 'routes to #create' do
      post('/password_resets').should route_to("password_resets#create")
    end

    it 'routes to #show only with the token-URL' do
      get('/password_resets/1').should_not be_routable
      get('/password_resets/0123456789AB').should route_to(
        controller: 'password_resets',
        action: 'show',
        id: '0123456789AB'
      )
    end

  end
end
