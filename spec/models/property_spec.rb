# frozen_string_literal: true

require "rails_helper"

RSpec.describe Property do
  context "when validations are run" do
    it "must have the uprn set" do
      property = build(:property, uprn: nil)
      property.save

      expect(property.errors.messages).to include(:uprn)
    end

    it "must have the type set" do
      property = build(:property, type: nil)
      property.save

      expect(property.errors.messages).to include(:type)
    end

    it "must have the code set" do
      property = build(:property, code: nil)
      property.save

      expect(property.errors.messages).to include(:code)
    end
  end

  describe "#set_exponential_notation" do
    let(:property) do
      build(:property, uprn: "1.00081E+11")
    end

    it "has the right uprn format" do
      property.save!

      expect(property.reload.uprn).to eq("100081000000")
    end
  end

  describe "#set_missing_zeros" do
    let(:property) do
      build(:property, uprn: "123456789")
    end

    it "has the right uprn format" do
      property.save!

      expect(property.reload.uprn).to eq("000123456789")
    end
  end
end
