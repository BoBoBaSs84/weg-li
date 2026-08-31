# frozen_string_literal: true

require "rails_helper"

RSpec.describe Blueprint, type: :model do
  let(:blueprint) { Fabricate.build(:blueprint) }

  context "validation" do
    it "is valid" do
      expect(blueprint).to be_valid
    end
  end

  context "apply" do
    let(:notice) { Fabricate.build(:notice) }

    it "applies blueprint to notice" do
      notice.blueprint = blueprint

      notice.apply_blueprint
      expect(notice.flags).to eq(blueprint.flags)
      expect(notice.tbnr).to eq(blueprint.tbnr)
      expect(notice.note).to eq(blueprint.note)
    end
  end
end
