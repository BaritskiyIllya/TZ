#
experiment_options_btn = [{ experiment_id: 1, option: { btn_color: "#ff0000" }, max_percentage: 33.3 }, { experiment_id: 1, option: { btn_color: "#0000ff" }, max_percentage: 33.3 }, { experiment_id: 1, option: { btn_color: "#00ff00" }, max_percentage: 33.3 }]
experiment_options_price = [{ experiment_id: 2, option: { price: "10" }, max_percentage: 75 }, { experiment_id: 2, option: { price: "20" }, max_percentage: 10 }, { experiment_id: 2, option: { price: "50" }, max_percentage: 5 }, { experiment_id: 2, option: { price: "5" }, max_percentage: 10 }]
experiment_names = [{ name: 'btn_color' }, { name: 'price' }]

Experiment.create!(experiment_names)
ExperimentsOption.create!(experiment_options_btn)
ExperimentsOption.create!(experiment_options_price)
#
