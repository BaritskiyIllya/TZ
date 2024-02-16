class Experiments::ButtonColorExperimentService
    def initialize(device)
      @device = device
    end

    def call
      btns_experiment_options_ids = experiment_option_ids('btn_color')
      assigned_btns_experiments_ids = assigned_experiments_ids(btns_experiment_options_ids)
      result = count_experiments(assigned_btns_experiments_ids, btns_experiment_options_ids)
      preferred_option_id = result.min_by { |_, value| value }.first

      create_device_experiment(preferred_option_id)
    end

    private

    def experiment_option_ids(name)
      Experiment.where(name: name).last.experiments_options.ids
    end

    def assigned_experiments_ids(experiment_option_ids)
      DeviceExperiment.where(experiments_option_id: experiment_option_ids).pluck(:experiments_option_id)
    end

    def count_experiments(assigned_ids, all_ids)
      all_ids.each_with_object({}) { |id, counts| counts[id] = assigned_ids.count(id) }
    end

    def create_device_experiment(preferred_option_id)
      DeviceExperiment.create!(device_id: @device.id, experiments_option_id: preferred_option_id)
    end
  end
