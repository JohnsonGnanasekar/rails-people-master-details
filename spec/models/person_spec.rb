# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Person, type: :model do
  it "is valid with valid attributes" do
    person = Person.new(name: "John Doe", email: "john@example.com")
    expect(person).to be_valid
  end

  it "is not valid without a name" do
    person = Person.new(email: "john@example.com")
    expect(person).to_not be_valid
  end

  it "is not valid without an email" do
    person = Person.new(name: "John Doe")
    expect(person).to_not be_valid
  end
end

