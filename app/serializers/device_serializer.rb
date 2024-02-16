class DeviceSerializer < ActiveModel::Serializer
  # has_many :device_experiments, dependent: :destroy
  has_many :experiments_options, through: :device_experiments

  def experiments_options
    merged_options = {}
    object.experiments_options.each do |experiment_option|
      merged_options.merge!(experiment_option.options)
    end
    merged_options
  end
end
