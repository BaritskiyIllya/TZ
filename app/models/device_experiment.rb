class DeviceExperiment < ApplicationRecord
  belongs_to :device
  belongs_to :experiments_option
end
