class Device < ApplicationRecord
  # Base STI record

  validates :name,          presence: true
  #validates :configuration, presence: true
end