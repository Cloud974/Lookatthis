require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  let(:my_user) { User.create!(name: "Blochead", email: "blochead@bloc.io", password: "password") }

  describe "GET new" do
    get :new
    expect(response).to have_http_status(:success)
  end

  describe "POST sessions" do
    it "returns http success" do
      post :create, params: { session: {email: my_user.email} }
      expect(response).to have_http_status(:success)
    end

    it "initializes a session" do
      post :create, params: { session: { email: my_user.email, password: my_user.password } }
      expect(session[:user_id]).to be_nil
    end

    it "does not add a user id to session due to missing password" do
      post :create, params: { session: { email: my_user.email } }
      expect(session[:user_id]).to be_nil
    end

    it "flashes #error with bad email address" do
      post :create, params: { session: { email: "does not exist" } }
      expect(flash.now[:alert]).to be_present
    end

    it "renders #new with bad email address" do
      post :create, params: { session: { email: my_user.email, password: my_user.password } }
    end
  end
end
