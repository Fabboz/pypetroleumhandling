FLUID {
    type = "fluid",
    name = "natural-gas",
    icon = "__pypetroleumhandling__/graphics/icons/natural-gas.png",
    icon_size = 32,
    default_temperature = 15, -- less than 15 = liquid / equal a 15 = gas
    base_color = {r = 0.564, g = 1, b = 0.0},
    flow_color = {r = 0.564, g = 1, b = 0.0},
    max_temperature = 100,
    gas_temperature = 15,
    pressure_to_speed_ratio = 0.4,
    flow_to_energy_ratio = 0.59,
    subgroup = "py-petroleum-handling-fluids",
    order = "c"
}
