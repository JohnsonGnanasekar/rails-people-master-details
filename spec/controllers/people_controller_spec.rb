# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index, format: :json
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new person" do
        expect {
          post :create, params: { person: { name: "John Doe", email: "john@example.com" } }, format: :json
        }.to change(Person, :count).by(1)
      end
    end

    context "with invalid parameters" do
      it "does not create a new person" do
        expect {
          post :create, params: { person: { name: "John Doe" } }, format: :json
        }.to_not change(Person, :count)
      end
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      person = Person.create(name: "John Doe", email: "john@example.com")
      get :show, params: { id: person.id }, format: :json
      expect(response).to be_successful
    end
  end

  describe "PATCH #update" do
    let!(:person) { Person.create(name: "John Doe", email: "john@example.com") }

    it "updates the requested person" do
      patch :update, params: { id: person.id, person: { name: "New Name" } }, format: :json
      person.reload
      expect(person.name).to eq("New Name")
    end
  end

  describe "DELETE #destroy" do
    let!(:person) { Person.create(name: "John Doe", email: "john@example.com") }

    it "destroys the requested person" do
      expect {
        delete :destroy, params: { id: person.id }, format: :json
      }.to change(Person, :count).by(-1)
    end
  end
end
