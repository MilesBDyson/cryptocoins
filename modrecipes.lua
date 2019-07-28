if ( minetest.get_modpath("mesecons") ) == nil then

	minetest.register_craftitem(":mesecons_materials:silicon", {
		description = ("Silicon lump"),
		inventory_image = "homedecor_silicon.png",
	})

	minetest.register_craft( {
		output = "mesecons_materials:silicon 4",
		recipe = {
			{ "default:sand", "default:sand" },
			{ "default:sand", "default:steel_ingot" },
		},
	})

end

if ( minetest.get_modpath("homedecor") ) == nil then

	minetest.register_craftitem(":homedecor:ic", {
		description = ("Simple Integrated Circuit"),
		inventory_image = "homedecor_ic.png",
	})

	minetest.register_craft( {
		output = "homedecor:ic 4",
		recipe = {
			{ "mesecons_materials:silicon", "mesecons_materials:silicon" },
			{ "mesecons_materials:silicon", "cryptocoins:copper_ribbonwire" },
		},
	})


	minetest.register_craftitem(":homedecor:plastic_sheeting", {
		description = ("Plastic sheet"),
		inventory_image = "homedecor_plastic_sheeting.png",
	})

	minetest.register_craftitem(":homedecor:plastic_base", {
		description = ("Unprocessed Plastic base"),
		wield_image = "homedecor_plastic_base.png",
		inventory_image = "homedecor_plastic_base_inv.png",
	})

	minetest.register_craft({
		type = "shapeless",
		output = 'homedecor:plastic_base 6',
		recipe = { "default:junglegrass",
			"default:junglegrass",
			"default:junglegrass"
		}
	})
    
	minetest.register_craft({
		type = "shapeless",
		output = 'homedecor:plastic_base 3',
		recipe = { "default:dry_shrub",
			"default:dry_shrub",
			"default:dry_shrub"
		},
	})
    
	minetest.register_craft({
		type = "shapeless",
		output = 'homedecor:plastic_base 4',
		recipe = { "default:leaves",
			"default:leaves",
			"default:leaves",
			"default:leaves",
			"default:leaves",
			"default:leaves"
		}
	})
    
	minetest.register_craft({
		type = "cooking",
		output = "homedecor:plastic_sheeting",
		recipe = "homedecor:plastic_base",
	})
    
	minetest.register_craft({
		type = 'fuel',
		recipe = 'homedecor:plastic_base',
		burntime = 30,
	})
    
	minetest.register_craft({
		type = 'fuel',
		recipe = 'homedecor:plastic_sheeting',
		burntime = 30,
	})

end