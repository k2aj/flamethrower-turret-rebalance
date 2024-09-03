local damage_mult            = settings.startup["flamethrower-turret-damage-multiplier"].value
local fuel_use_mult          = settings.startup["flamethrower-turret-fuel-consumption-multiplier"].value
local fuel_damage_bonus_mult = settings.startup["flamethrower-turret-fuel-damage-bonus-multiplier"].value

local function full_scan(tree, callback)
    callback(tree)
    if type(tree) == "table" then
        for _, v in pairs(tree) do
            full_scan(v, callback)
        end
    end
end

local function update_fluid_turret(proto_name, fuel_use_mult, fuel_damage_bonus_mult)
    local turret_params = data.raw["fluid-turret"][proto_name].attack_parameters
    turret_params.fluid_consumption = turret_params.fluid_consumption * fuel_use_mult

    for _, fluid in pairs(turret_params.fluids) do
        local fuel_damage_bonus = (fluid.damage_modifier or 1) - 1
        fluid.damage_modifier = math.max(
            1 + fuel_damage_bonus*fuel_damage_bonus_mult,
            0.2
        )
    end
end

local function update_stream_damage(proto_name, damage_mult)
    local stream = data.raw.stream[proto_name]
    full_scan(stream.action, function(tbl)
        if type(tbl) == "table" and tbl.damage ~= nil then
            tbl.damage.amount = tbl.damage.amount * damage_mult
        end
    end)
end

local function update_fire_resistance(proto_type, proto_name, setting_name)
    local wall = data.raw[proto_type][proto_name]
    if wall == nil then return end

    local fire_res = nil
    full_scan(wall.resistances, function(res)
        if type(res) == "table" and res.type == "fire" then
            fire_res = res
        end
    end)
    
    if fire_res == nil then
        fire_res = {type = "fire", decrease = 0}
        wall.resistances[#wall.resistances+1] = fire_res
    end
    fire_res.percent = settings.startup[setting_name].value
end

local ground_flame = data.raw.fire["fire-flame"]
ground_flame.damage_per_tick.amount = ground_flame.damage_per_tick.amount * damage_mult

local sticker = data.raw.sticker["fire-sticker"]
sticker.damage_per_tick.amount = sticker.damage_per_tick.amount * damage_mult



update_fluid_turret("flamethrower-turret", fuel_use_mult, fuel_damage_bonus_mult)
update_stream_damage("flamethrower-fire-stream", damage_mult)

update_fire_resistance("wall", "stone-wall", "stone-wall-fire-resistance")
update_fire_resistance("gate", "gate",       "stone-wall-fire-resistance")



if mods["aai-industry"] then
    update_fire_resistance("wall", "concrete-wall", "aai-industry-concrete-wall-fire-resistance")
    update_fire_resistance("wall", "steel-wall",    "aai-industry-steel-wall-fire-resistance")
end



if mods["RampantArsenal"] then
    update_fluid_turret(
        "suppression-cannon-fluid-turret-rampant-arsenal",
        settings.startup["rampant-arsenal-advanced-flamethrower-turret-fuel-consumption-multiplier"].value,
        fuel_damage_bonus_mult
    )
    update_stream_damage("suppression-cannon-stream-rampant-arsenal", damage_mult)
    
    update_fire_resistance("wall", "mending-wall-rampant-arsenal",    "rampant-arsenal-mending-wall-fire-resistance")
    update_fire_resistance("gate", "mending-gate-rampant-arsenal",    "rampant-arsenal-mending-wall-fire-resistance")
    update_fire_resistance("wall", "reinforced-wall-rampant-arsenal", "rampant-arsenal-reinforced-wall-fire-resistance")
    update_fire_resistance("gate", "reinforced-gate-rampant-arsenal", "rampant-arsenal-reinforced-wall-fire-resistance")
end