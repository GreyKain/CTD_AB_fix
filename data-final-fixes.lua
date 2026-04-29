-- ##############################################################################################
local item = data.raw.item
local recipe = data.raw.recipe
local gun = data.raw.gun
local tech_disable = CTDmod.lib.tech.disable
local replace_ingredient = CTDmod.lib.recipe.replace_ingredient
local add_tech_unlock = CTDmod.lib.recipe.add_tech_unlock
local add_ingredient = CTDmod.lib.recipe.add_ingredient
local duplicate = CTDmod.lib.recipe.duplicate
-- ----------------------------------------------------------------------------------------------

-- ##############################################################################################
-- ОТКЛЮЧЕНИЕ ТЕХНОЛОГИИ ДЛИННЫХ МАНИПУЛЯТОРОВ ОТ БОБА ПРИ ВКЛЮЧЕННОМ МОДЕ SMART INSERTERS
-- ----------------------------------------------------------------------------------------------
if mods ["boblogistics"] and mods ["Smart_Inserters"] then
    tech_disable("bob-long-inserters-1")
end
-- ----------------------------------------------------------------------------------------------

-- ##############################################################################################
-- ТРЕБОВАНИЕ АВТОМАТА ДЛЯ КРАФТА ТУРЕЛИ
-- ----------------------------------------------------------------------------------------------
replace_ingredient("gun-turret", "iron-plate", {name = "submachine-gun", amount = 1})
-- ----------------------------------------------------------------------------------------------

-- ##############################################################################################
-- ИЗМЕНЕНИЕ РЕЦЕПТА СНАЙПЕРСКОЙ ТУРЕЛИ
-- ----------------------------------------------------------------------------------------------
if recipe["bob-sniper-turret-1"] and gun["bob-sniper-rifle"] and item["bob-steel-gear-wheel"] then
	replace_ingredient("bob-sniper-turret-1", "iron-gear-wheel", "bob-steel-gear-wheel")
	replace_ingredient("bob-sniper-turret-1", "iron-plate", "steel-plate")
    add_ingredient("bob-sniper-turret-1", "bob-sniper-rifle")
end
-- ----------------------------------------------------------------------------------------------

-- ##############################################################################################
-- ДОБАВЛЕНИЕ УГЛЯ В РЕЦЕПТ ПАТРОНОВ ДЛЯ ДРОБОВИКА
-- ----------------------------------------------------------------------------------------------
add_ingredient("shotgun-shell", "coal")
-- ----------------------------------------------------------------------------------------------

-- ##############################################################################################
-- ДОБАВЛЕНИЕ ЛАМП В РЕЦЕПТЫ ЖД СВЕТОФОРОВ
-- ----------------------------------------------------------------------------------------------
add_ingredient("rail-signal", "small-lamp")
add_ingredient("rail-chain-signal", "small-lamp")
-- ----------------------------------------------------------------------------------------------

-- ##############################################################################################
-- УБИРАЕМ РЕЦЕПТ КАМНЯ ИЗ ЩЕБНЯ И ДОБАВЛЯЕМ ОБРАТНЫЙ РЕЦЕПТ
-- ----------------------------------------------------------------------------------------------
if recipe["angels-stone-from-crushed-stone"] then
    recipe["angels-stone-from-crushed-stone"].enabled = false
    recipe["angels-stone-from-crushed-stone"].hidden = true
    data:extend(
        {
            {
                type = "recipe",
                name = "CTD-crushed-stone-from-stone",
                category = "angels-ore-refining-t1",
                energy_required = 1,
                enabled = true,
                ingredients = {{type = "item", name = "stone", amount = 1}},
                results = {{type = "item", name = "angels-stone-crushed", amount = 2}},
                main_product = "angels-stone-crushed",
                allow_productivity = true
            }
        }
    )
    if data.raw.recipe["CTD-crushed-stone-from-stone"] and not mods ["CTDaddon_for_AB"] then
        duplicate("CTD-crushed-stone-from-stone", "CTD-crushed-stone-from-stone-handmade",
            {category = "angels-manual-crafting", energy_required = 5}, true)
    end
end
-- ----------------------------------------------------------------------------------------------

-- ##############################################################################################
-- ЗАМЕНА КАМНЯ НА ЩЕБЕНЬ В РЕЦЕПТЕ КАМЕННЫХ БЛОКОВ
-- ----------------------------------------------------------------------------------------------
if item["angels-stone-crushed"] then
    replace_ingredient("stone-brick", "stone", {type = "item", name = "angels-stone-crushed", amount = 4})
end
-- ----------------------------------------------------------------------------------------------

-- ##############################################################################################
-- УБИРАЕМ РЕЦЕПТ БАЗОВОГО КОНВЕЕРА ПОД ТЕХНОЛОГИЮ
-- ----------------------------------------------------------------------------------------------
if mods ["boblogistics"] then
	data.raw.recipe["bob-basic-transport-belt"].enabled = false
	add_tech_unlock("bob-basic-transport-belt", "logistics-0")
end
-- ----------------------------------------------------------------------------------------------