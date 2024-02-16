class Device < ApplicationRecord
  has_many :device_experiments, dependent: :destroy
  has_many :experiments_options, through: :device_experiments

  after_create :assign_to_experiments

  def assign_to_experiments
    Experiments::ButtonColorExperimentService.new(self).call
    Experiments::PriceExperimentService.new(self).call
  end
end