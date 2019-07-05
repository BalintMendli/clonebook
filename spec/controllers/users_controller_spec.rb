require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before(:each) do 
    @user = create(:user)
    sign_in @user
  end

  describe "#index" do
    it "returns list of users" do
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:users)).to eq(User.all)
      expect(response).to render_template :index
    end
  end

  describe '#show' do
    it 'returns the profile page of the user' do
      get :show, params: {id: @user}
      expect(response.successful?)
      expect(assigns(:user)).to eql(@user)
      expect(response).to render_template :show
    end
  end

end