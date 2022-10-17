# frozen_string_literal: true

class LocalAuthority < ApplicationRecord
  has_many :planning_applications, dependent: :destroy

  validates :name, presence: true
end
