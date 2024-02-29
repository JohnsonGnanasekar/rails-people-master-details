# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Detail, type: :model do
  let(:person) { Person.create(name: "John Doe", email: "john@example.com") }

  it "is valid with valid attributes" do
    detail = Detail.new(detail_type: "Phone", detail_value: "1234567890", person: person)
    expect(detail).to be_valid
  end

  it "is not valid without a detail_type" do
    detail = Detail.new(detail_value: "1234567890", person: person)
    expect(detail).to_not be_valid
  end

  it "is valid without a detail_value" do
    detail = Detail.new(detail_type: "Phone", person: person)
    expect(detail).to be_valid
  end

  it "is not valid without a person_id" do
    detail = Detail.new(detail_type: "Phone", detail_value: "1234567890")
    expect(detail).to_not be_valid
  end
end

