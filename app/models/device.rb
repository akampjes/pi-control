class Device < ApplicationRecord
  # Base STI record

  has_many :device_logs

  validates :name, presence: true
end