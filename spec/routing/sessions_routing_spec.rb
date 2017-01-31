require 'rails_helper'

  RSpec.describe SessionsController, type: :routing do
  describe 'routing' do
    it 'routes to #login' do
      expect(:post => '/login').to route_to('sessions#login')
    end
  end
end
