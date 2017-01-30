require 'rails_helper'

  RSpec.describe SessionsController, type: :routing do
  describe 'routing' do
    it 'routes to #signin' do
      expect(:post => '/signin').to route_to('sessions#signin')
    end
  end
end
