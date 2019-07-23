local overrides={}

local ingredient_replace = function (recipe, old, new)
if type(recipe) == "string" then
local R = data.raw.recipe[recipe]
recipe = R
end
local ningredients
local eingredients
		if recipe.ingredients ~= nil then
			local ingredients = recipe.ingredients
			for i, ing in pairs(ingredients) do
			--log("get past for loop into ingredients")
				if ing.name ~= nil then
					if ing.name == old then
					--log("pasted check for if ingredients = old item")
					--log(recipe.name)
					--log(serpent.block(ing))
					local T = table.deepcopy(ing.type)
					local A = table.deepcopy(ing.amount)
					data.raw.recipe[recipe.name].ingredients[i] = {type = T, name = new, amount = A}
					--log(recipe.name)
					--log(serpent.block(recipe.ingredients))
					--log("hit count")
					end
				else
					--for j, v in pairs(ing) do
					--TODO:fix duplicated ingredients on some items
						if ing[1] == old then
						--log("pasted check for if ingredients = old item")
						--log(recipe.name)
						--log(serpent.block(ing))
						--local T = table.deepcopy(ing.type)
						local A = table.deepcopy(ing[2])
						--log(new)
						--log(A)
						data.raw.recipe[recipe.name].ingredients[i] = {new, A}
						--log(recipe.name)
						--log(serpent.block(data.raw.recipe[recipe.name].ingredients))
						--log("hit count")
						end
					--end
				end
			end
			--TODO:need to check for ingredients that dont have name declared
		elseif recipe.normal or recipe.expensive then
		--log(serpent.block(recipe))
			if recipe.normal ~= nil then
			--log("is check good")
				ningredients = recipe.normal.ingredients
			end
			if recipe.expensive ~= nil then
				eingredients = recipe.expensive.ingredients
			end
			if recipe.normal then
			--log(serpent.block(recipe.normal))
			--log(serpent.block(ningredients))
				for i, ing in pairs(ningredients) do
				--log("get past for loop into normal ingredients")
				--log("ningredients")
				--log(serpent.block(ningredients))
				--log(serpent.block(ing))
				--log("ing name")
				--log(ing.name)
				--log("old")
				--log(old)
					if ing.name ~= nil then
						if ing.name == old then
							--log("pasted check for if ingredients = old item")
							--log(recipe.name)
							--log(serpent.block(ing))
							local T = table.deepcopy(ing.type)
							local A = table.deepcopy(ing.amount)
							data.raw.recipe[recipe.name].normal.ingredients[i] = {type = T, name = new, amount = A}
							--log(recipe.name)
							--log(serpent.block(recipe.ingredients))
							--log("hit count")
							--log(serpent.block(data.raw.recipe[recipe.name]))
						end
					else
						--for j,v in pairs(ing) do
							if ing[1] == old then
							local A = table.deepcopy(ing[2])
							data.raw.recipe[recipe.name].normal.ingredients[i] = {new, A}
							end
						--end
					end
				end
			end
			if recipe.expensive then
				for i, ing in pairs(eingredients) do
				--log("get past for loop into ingredients")
					if ing.name ~= nil then
						if ing.name == old then
							--log("pasted check for if ingredients = old item")
							--log(recipe.name)
							--log(serpent.block(ing))
							local T = table.deepcopy(ing.type)
							local A = table.deepcopy(ing.amount)
							data.raw.recipe[recipe.name].expensive.ingredients[i] = {type = T, name = new, amount = A}
							--log(recipe.name)
							--log(serpent.block(recipe.ingredients))
							--log("hit count")
						end
					else
						--for j,v in pairs(ing) do
						--log("check this still works")
						--log(serpent.block(ing))
							if ing[1] == old then
							local A = table.deepcopy(ing[2])
							data.raw.recipe[recipe.name].expensive.ingredients[i] = {new, A}
							end
						--log(serpent.block(recipe))
						--end
					end
				end
			end
		end
end

local results_replacer = function (recipe, old, new)
if type(recipe) == "string" then
local R = data.raw.recipe[recipe]
recipe = R
end
	if recipe ~= nil then
	--log(recipe.name)
	--log(serpent.block(recipe))
		if recipe.result then
			if recipe.result == old then
			data.raw.recipe[recipe.name].result = new
			end
		end
		if recipe.results then
			for r, result in pairs(recipe.results) do
				if result.name == old then
					data.raw.recipe[recipe.name].results[r].name = new
				end
			end
		end
		if recipe.main_product ~= nil then
		--log("should replace main_product")
			if recipe.main_product == old then
				--log("getting here for iron plate 1?")
				data.raw.recipe[recipe.name].main_product = new
			end
		end
		if recipe.normal or recipe.expensive then
			if recipe.normal then
				if recipe.normal.result then
					if recipe.normal.result == old then
						data.raw.recipe[recipe.name].normal.result = new
					end
				end
				if recipe.normal.results then
					for r, result in pairs(recipe.normal.results) do
						if result.name == old then
							data.raw.recipe[recipe.name].normal.results[r].name = new
						end
					end
				end
				if recipe.normal.main_product then
					if recipe.normal.main_product == old then
						data.raw.recipe[recipe.name].normal.main_product = new
					end
				end
			end
			if recipe.expensive then
				if recipe.expensive.result then
					if recipe.expensive.result == old then
						data.raw.recipe[recipe.name].expensive.result = new
					end
				end
				if recipe.expensive.results then
					for r, result in pairs(recipe.expensive.results) do
						if result.name == old then
							data.raw.recipe[recipe.name].expensive.results[r].name = new
						end
					end
				end
				if recipe.expensive.main_product then
					if recipe.expensive.main_product == old then
						data.raw.recipe[recipe.name].expensive.main_product = new
					end
				end
			end
		end
	end
end

function overrides.global_item_replacer(old, new, blackrecipe)
local recipes = table.deepcopy(data.raw.recipe)
if type(blackrecipe) ~= "table" and blackrecipe ~= nil then
	blackrecipe = {blackrecipe}
end
local brecipeset = {}
	if blackrecipe ~= nil then
		for _, brecipe in pairs(blackrecipe) do
			brecipeset[brecipe] = true
		end
	end
	--log(serpent.block(brecipeset))
	for recipe in pairs(recipes) do
		--for b, brecipe in pairs(blackrecipe) do
			if not brecipeset[recipe] then
				--log(serpent.block(recipe))
				--log(serpent.block(recipe.name))
				--log(serpent.block(brecipeset))
				ingredient_replace(recipe,old,new)
				results_replacer(recipe,old,new)
			end
		--end
	end
end

local hab = {}

--blacklist for hot air recipes script to avoid
function overrides.HAB(blist)
	if type(blist) ~= "table" and blist ~= nil then
		blist = {blist}
	end
	if blist ~= nil then
		for _, bl in pairs(blist) do
			if data.raw.recipe[bl] ~= nil then
				hab[bl] = true
			end
		end
	end
end

--add 50 hot-air ingredient, reduce ingredients by set %
function overrides.hotairrecipes(recipepercenttable)
log(serpent.block(recipepercenttable))
--gather recipes for the advanced-foundry
local recipes = table.deepcopy(data.raw.recipe)
local afrecipes = {}
local afrecipesnames = {}
local afrcount = 0
local altrec = 0
	for _, recipe in pairs(recipes) do
		if recipe.category == "advanced-foundry" then
			table.insert(afrecipes,recipe)
			table.insert(afrecipesnames,recipe.name)
		end
		if recipe.category == "smelting" then
			table.insert(afrecipes,recipe)
			table.insert(afrecipesnames,recipe.name)
		end
	end

--cycle thru afrecipes to make changes
	for _,recipe in pairs(afrecipes) do
		if not hab[recipe.name] then
		--log(recipe.name)
		--log(serpent.block(recipe))
		afrcount=afrcount+1
		--add ingredient
		if recipe.normal == nil and recipe.expensive == nil then
			
			local ingredients = recipe.ingredients
			recipe.ingredients = {}
			
			for i, ing in pairs(ingredients) do
			
				if ing.name == nil then
				
					local formating = ing
					ing = {type = "item", name = formating[1], amount = formating[2]}
					
					local modamount = ing.amount - math.floor(ing.amount * recipepercenttable[recipe.name])
					
					--log(modamount)
					
					ing.amount = modamount
					
					--log(serpent.block(ing))
					
				else
				
					local modamount = ing.amount - math.floor(ing.amount * recipepercenttable[recipe.name])
					
					--log(modamount)
					
					ing.amount = modamount
					
					--log(serpent.block(ing))
					
				end
				
				table.insert(recipe.ingredients, ing)
				
			end
			
			--log(serpent.block(recipe.ingredients))
			
			table.insert(recipe.ingredients, {type = "fluid", name = "hot-air", amount = 50})
			
		end
		
		--log(serpent.block(recipe))

		if recipe.normal or recipe.expensive then
			if recipe.normal then
			
				local ingredients = recipe.normal.ingredients
				recipe.normal.ingredients = {}
				
				for i, ing in pairs(ingredients) do
				
					if ing.name == nil then
					
						local formating = ing
						ing = {type = "item", name = formating[1], amount = formating[2]}
						
						local modamount = ing.amount - math.floor(ing.amount * recipepercenttable[recipe.name])
						
						--log(modamount)
						
						ing.amount = modamount
						
						--log(serpent.block(ing))
						
					else
					
						local modamount = ing.amount - math.floor(ing.amount * recipepercenttable[recipe.name])
						
						--log(modamount)
						
						ing.amount = modamount
						
						--log(serpent.block(ing))
						
					end
					
					table.insert(recipe.normal.ingredients, ing)
					
				end
				
				--log(serpent.block(recipe.ingredients))
				
				table.insert(recipe.normal.ingredients, {type = "fluid", name = "hot-air", amount = 50})
				
			end

			if recipe.expensive then
						
				local ingredients = recipe.expensive.ingredients
				recipe.expensive.ingredients = {}
				
				for i, ing in pairs(ingredients) do
				
					if ing.name == nil then
					
						local formating = ing
						ing = {type = "item", name = formating[1], amount = formating[2]}
						
						local modamount = ing.amount - math.floor(ing.amount * recipepercenttable[recipe.name])
						
						--log(modamount)
						
						ing.amount = modamount
						
						--log(serpent.block(ing))
						
					else
					
						local modamount = ing.amount - math.floor(ing.amount * recipepercenttable[recipe.name])
						
						--log(modamount)
						
						ing.amount = modamount
						
						--log(serpent.block(ing))
						
					end
					
					table.insert(recipe.expensive.ingredients, ing)
					
				end
				
				--log(serpent.block(recipe.ingredients))
				
				table.insert(recipe.expensive.ingredients, {type = "fluid", name = "hot-air", amount = 50})
				
			end
		end

		--find tech unlock of og recipe
		local unlock
		for _,t in pairs(data.raw.technology) do
		--log(serpent.block(t))
			if t.effects ~= nil then
				for _,u in pairs(t.effects) do
					if u.recipe == recipe.name then
						unlock = t.name
						--log(unlock)
					end
				end
			end
		end
		--log(serpent.block(recipe))
		local hname = "hotair-" .. recipe.name
		if recipe.results then
			RECIPE {
			type = "recipe",
			name = hname,
			category = "hot-air-advanced-foundry",
			enabled = false,
			energy_required = recipe.energy_required,
			ingredients = recipe.ingredients,
			results = recipe.results,
			icon = recipe.icon,
			icons = recipe.icons,
			icon_size = 32,
			main_product = recipe.main_product or nil
			}--:add_unlock(unlock)
			altrec=altrec+1
			if recipe.enabled == false then
				if unlock ~= nil then
					table.insert(data.raw.technology[unlock].effects,{type="unlock-recipe",recipe=hname})
				end
			elseif recipe.enabled == true then
				data.raw.recipe[hname].enabled = true
			elseif recipe.enabled == nil then
				--log(recipe.name)
				--log(serpent.block(recipe))
				data.raw.recipe[hname].enabled = true
				--log(serpent.block(data.raw.recipe[hname]))
			end
		end
		if recipe.normal or recipe.expensive then
			RECIPE {
				type = "recipe",
				name = hname,
				category = "hot-air-advanced-foundry",
				normal = {
					category = "hot-air-advanced-foundry",
					enabled = false,
					energy_required = recipe.expensive.energy_required,
					ingredients = recipe.normal.ingredients,
					results = recipe.normal.results,
					},
				expensive = {
					category = "hot-air-advanced-foundry",
					enabled = false,
					energy_required = recipe.expensive.energy_required,
					ingredients = recipe.expensive.ingredients,
					results = recipe.expensive.results,
					},
				icon = recipe.icon,
				icons = recipe.icons,
				icon_size = 32,
				main_product = recipe.main_product or nil
				}--:add_unlock(unlock)
			altrec=altrec+1
			if recipe.normal.enabled == false or recipe.expensive.enabled == false then
				if unlock ~= nil then
					table.insert(data.raw.technology[unlock].effects,{type="unlock-recipe",recipe=hname})
				end
			elseif recipe.normal.enabled == true or recipe.expensive.enabled == true then
				if recipe.normal.enabled == true then
					data.raw.recipe[hname].normal.enabled = true
				end
				if recipe.expensive.enabled == true then
					data.raw.recipe[hname].expensive.enabled = true
				end
			end
		end
		--log(serpent.block(data.raw.recipe[hname]))
	end
end
--log(serpent.block(afrecipesnames))
--log(afrcount)
--log(altrec)
--[[
for _, r in pairs(data.raw.recipe) do
	if r.name == "iron-plate" then
	log(serpent.block(r))
	end
	if r.category == "hot-air-advanced-foundry" then
	log(serpent.block(r))
	end
end
]]--
end



return overrides