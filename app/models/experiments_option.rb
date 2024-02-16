class ExperimentsOption < ApplicationRecord
  belongs_to :experiment
  has_many :device_experiment
  has_many :devices, through: :device_experiment
end