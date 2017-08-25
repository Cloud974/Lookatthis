require 'rails_helper'

RSpec.describe Question, type: :model do
  let (:question) {Question.create!(title: "New Question title", body: "New Question body", resolved: true) }

  describe "attributes" do
    it "has a title attribute" do
      expect(question).to have_attributes(title: "New Question title")
    end

    it "has a body" do
      expect(question).to have_attributes(body: "New Question body")
    end

    it "has a boolean for resolved" do
      expect(question).to have_attributes(resolved: true)
    end
  end
end
