# frozen_string_literal: true

module Details
  extend ActiveSupport::Concern

  DETAILS = {
    1 => :vehicle_empty,
    2 => :hazard_lights,
    4 => :expired_tuv,
    8 => :expired_eco,
    16 => :over_2_8_tons,
  }

  included do
    include Bitfields
    bitfield :flags, DETAILS

    def self.details
      bitfields[:flags].keys
    end
  end
end
