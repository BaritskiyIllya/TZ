class Experiments::PriceExperimentService
  def initialize(device)
    @device = device
  end

  def call
    price_experiment_options_ids = price_experiment_options.ids
    assigned_price_experiments_ids = assigned_price_experiments.pluck(:experiments_option_id)
    percentages = calculate_percentages(assigned_price_experiments_ids)

    preferred_option_id = find_preferred_option(percentages)
    preferred_option_id ||= 4

    DeviceExperiment.create!(device_id: @device.id, experiments_option_id: preferred_option_id)
  end

  private

  def price_experiment
    Experiment.find_by(name: 'price')
  end

  def price_experiment_options
    price_experiment.experiments_options
  end

  def assigned_price_experiments
    DeviceExperiment.where(experiments_option_id: price_experiment_options.ids)
  end

  def calculate_percentages(experiments_ids)
    counts = experiments_ids.group_by(&:itself).transform_values(&:count)
    total_assigned = experiments_ids.size
    counts.transform_values { |count| (count.to_f / total_assigned * 100).round }
  end

  def find_preferred_option(percentages)
    ids = price_experiment_options.pluck(:id, :max_percentage)
    percentages.reject do |key, value|
      value == ids.find { |id, _| id == key }[1] || value >= ids.find { |id, _| id == key }[1]
    end.keys.min
  end
end