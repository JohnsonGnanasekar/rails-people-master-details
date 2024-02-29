# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DetailsController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      person = Person.create(name: "John Doe", email: "john@example.com")
      get :index, params: { person_id: person.id }, format: :json
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new detail" do
        person = Person.create(name: "John Doe", email: "john@example.com")
        expect {
          post :create, params: { person_id: person.id, detail: { detail_type: "Phone", detail_value: "1234567890" } }, format: :json
        }.to change(Detail, :count).by(1)
      end
    end

    context "with invalid parameters" do
      it "does not create a new detail" do
        person = Person.create(name: "John Doe", email: "john@example.com")
        expect {
          post :create, params: { person_id: person.id, detail: { detail_value: "1234567890" } }, format: :json
        }.to_not change(Detail, :count)
      end
    end
  end


  describe "PATCH #update" do
    let!(:person) { Person.create(name: "John Doe", email: "john@example.com") }
    let!(:detail) { Detail.create(detail_type: "Phone", detail_value: "1234567890", person_id: person.id) }

    it "updates the requested detail" do
      patch :update, params: { person_id: person.id, id: detail.id, detail: { detail_type: "Address" } }, format: :json
      detail.reload
      expect(detail.detail_type).to eq("Address")
    end
  end

  describe "DELETE #destroy" do
    let!(:person) { Person.create(name: "John Doe", email: "john@example.com") }
    let!(:detail) { Detail.create(detail_type: "Phone", detail_value: "1234567890", person_id: person.id) }

    it "destroys the requested detail" do
      expect {
        delete :destroy, params: { person_id: person.id, id: detail.id }, format: :json
      }.to change(Detail, :count).by(-1)
    end
  end
end

