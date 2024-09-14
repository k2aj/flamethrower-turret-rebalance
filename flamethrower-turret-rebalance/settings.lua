data:extend({
    {
        type = "double-setting",
        name = "flamethrower-turret-fuel-consumption-multiplier",
        order = "a[turret]-a[fuel-consumption]-a[vanilla]",
        setting_type = "startup",
        default_value = 5,
        minimum_value = 0
    },
    {
        type = "double-setting",
        name = "flamethrower-turret-damage-multiplier",
        order = "a[turret]-b[damage]",
        setting_type = "startup",
        default_value = 0.2,
        minimum_value = 0
    },
    {
        type = "double-setting",
        name = "flamethrower-turret-fuel-damage-bonus-multiplier",
        order = "a[turret]-c[damage-bonus]",
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0
    },
    {
        type = "double-setting",
        name = "stone-wall-fire-resistance",
        order = "d[vanilla-wall]",
        setting_type = "startup",
        default_value = 100,
        maximum_value = 100
    },
})

if mods["aai-industry"] then data:extend({
    {
        type = "double-setting",
        name = "aai-industry-concrete-wall-fire-resistance",
        order = "e[modded-wall]-aai-a[concrete]",
        setting_type = "startup",
        default_value = 100,
        maximum_value = 100
    },
    {
        type = "double-setting",
        name = "aai-industry-steel-wall-fire-resistance",
        order = "e[modded-wall]-aai-b[steel]",
        setting_type = "startup",
        default_value = 100,
        maximum_value = 100
    },
})end

if mods["RampantArsenal"] then data:extend({
    {
        type = "double-setting",
        name = "rampant-arsenal-advanced-flamethrower-turret-fuel-consumption-multiplier",
        order = "a[turret]-a[fuel-consumption]-b[rampant-arsenal]",
        setting_type = "startup",
        default_value = 1,
        minimum_value = 0
    },
    {
        type = "double-setting",
        name = "rampant-arsenal-mending-wall-fire-resistance",
        order = "e[modded-wall]-rampant-arsenal-a[mending]",
        setting_type = "startup",
        default_value = 100,
        maximum_value = 100
    },
    {
        type = "double-setting",
        name = "rampant-arsenal-reinforced-wall-fire-resistance",
        order = "e[modded-wall]-rampant-arsenal-b[reinforced]",
        setting_type = "startup",
        default_value = 100,
        maximum_value = 100
    },
})end