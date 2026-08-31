# frozen_string_literal: true

class Blueprint < ApplicationRecord
  include Details

  belongs_to :user
  has_many :notices, dependent: :nullify
  belongs_to :charge, -> { order(valid_from: :desc) }, optional: true, foreign_key: :tbnr, primary_key: :tbnr

  validates :name, presence: true
end
