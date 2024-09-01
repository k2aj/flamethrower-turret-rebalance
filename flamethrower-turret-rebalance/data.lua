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

local turret_params = data.raw["fluid-turret"]["flamethrower-turret"].attack_parameters
turret_params.fluid_consumption = turret_params.fluid_consumption * fuel_use_mult

for _, fluid in pairs(turret_params.fluids) do
    local fuel_damage_bonus = (fluid.damage_modifier or 1) - 1
    fluid.damage_modifier = math.max(
        1 + fuel_damage_bonus*fuel_damage_bonus_mult,
        0.2
    )
end

local stream = data.raw.stream["flamethrower-fire-stream"]
full_scan(stream.action, function(tbl)
    if type(tbl) == "table" and tbl.damage ~= nil then
        tbl.damage.amount = tbl.damage.amount * damage_mult
    end
end)

local ground_flame = data.raw.fire["fire-flame"]
ground_flame.damage_per_tick.amount = ground_flame.damage_per_tick.amount * damage_mult

local sticker = data.raw.sticker["fire-sticker"]
sticker.damage_per_tick.amount = sticker.damage_per_tick.amount * damage_mult