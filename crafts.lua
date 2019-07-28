
--= CHANGED TenPlus1 (moreores tin is now default steel, moreores silver is now copper, removed Moreores dependancy)

-- Home Computer

minetest.register_craft({
    output = "cryptocoins:home_computer";
    recipe = {
        { "cryptocoins:home_computer_powersupply", "cryptocoins:ribbonwire", "cryptocoins:home_computer_cdrom", },
        { "cryptocoins:home_computer_ram", "cryptocoins:home_computer_cpu", "cryptocoins:home_computer_fan", },
        { "cryptocoins:home_computer_soundcard", "cryptocoins:home_computer_motherboard", "cryptocoins:home_computer_harddrive", },
    };
});



minetest.register_craft({
    output = "cryptocoins:home_computer_video";
    recipe = {
        { "homedecor:plastic_base", "homedecor:plastic_base", "homedecor:plastic_base", },
        { "homedecor:ic", "cryptocoins:copper_ribbonwire", "homedecor:ic", },
        { "default:gold_ingot", "default:gold_ingot", "default:gold_ingot", },
    };
});

minetest.register_craft({
    output = "cryptocoins:home_computer_motherboard";
    recipe = {
        { "homedecor:ic", "homedecor:ic", "homedecor:ic", },
        { "default:gold_ingot", "default:gold_ingot", "default:steel_ingot", },
        { "homedecor:plastic_base", "default:steel_ingot", "default:coalblock", },
    };
});

minetest.register_craft({
    output = "cryptocoins:home_computer_powersupply";
    recipe = {
        { "cryptocoins:ribbonwire", "cryptocoins:ribbonwire", "cryptocoins:ribbonwire", },
        { "default:steel_ingot", "default:steelblock", "default:steel_ingot", },
        { "homedecor:ic", "homedecor:ic", "homedecor:ic", },
    };
});

minetest.register_craft({
    output = "cryptocoins:home_computer_cpu";
    recipe = {
        { "homedecor:ic", "default:gold_ingot", "homedecor:ic", },
        { "homedecor:ic", "default:diamond", "homedecor:ic", },
        { "homedecor:ic", "default:gold_ingot", "homedecor:ic", },
    };
});

minetest.register_craft({
    output = "cryptocoins:home_computer_soundcard";
    recipe = {
        { "default:steel_ingot", "default:steel_ingot", "default:steel_ingot", },
        { "default:steel_ingot", "default:glass", "default:steel_ingot", },
        { "default:gold_ingot", "default:steel_ingot", "default:gold_ingot", },
    };
});

minetest.register_craft({
    output = "cryptocoins:home_computer_fan";
    recipe = {
        { "cryptocoins:copper_ribbonwire", "cryptocoins:copper_ribbonwire", "cryptocoins:copper_ribbonwire", },
        { "default:steel_ingot", "default:coalblock", "default:steel_ingot", },
        { "cryptocoins:copper_ribbonwire", "cryptocoins:copper_ribbonwire", "cryptocoins:copper_ribbonwire", },
    };
});

minetest.register_craft({
    output = "cryptocoins:home_computer_harddrive";
    recipe = {
        { "default:gold_ingot", "default:gold_ingot", "default:gold_ingot", },
        { "default:coalblock", "default:steelblock", "default:coalblock", },
        { "cryptocoins:copper_ribbonwire", "cryptocoins:copper_ribbonwire", "cryptocoins:copper_ribbonwire", },
    };
});

minetest.register_craft({
    output = "cryptocoins:home_computer_cdrom";
    recipe = {
        { "default:steel_ingot", "homedecor:plastic_base", "default:glass", },
        { "default:coal_lump", "default:steel_ingot", "default:coal_lump", },
        { "default:gold_ingot", "default:copper_ingot", "default:gold_ingot", },
    };
});

minetest.register_craft({
    output = "cryptocoins:home_computer_ram";
    recipe = {
        { "homedecor:plastic_sheeting", "cryptocoins:copper_ribbonwire", "homedecor:plastic_sheeting", },
        { "homedecor:ic", "homedecor:ic", "homedecor:ic", },
        { "default:gold_ingot", "default:gold_ingot", "default:gold_ingot", },
    };
});


-- Game Computer

minetest.register_craft({
    output = "cryptocoins:game_computer";
    recipe = {
        { "cryptocoins:game_computer_powersupply", "cryptocoins:ribbonwire", "cryptocoins:game_computer_dvdrom", },
        { "cryptocoins:game_computer_ram", "cryptocoins:game_computer_cpu", "cryptocoins:home_computer", },
        { "cryptocoins:game_computer_soundcard", "cryptocoins:game_computer_motherboard", "cryptocoins:game_computer_harddrive", },
    };
});

minetest.register_craft({
    output = "cryptocoins:game_computer_video";
    recipe = {
        { "homedecor:plastic_sheeting", "default:steel_ingot", "homedecor:ic", },
        { "homedecor:ic", "cryptocoins:copper_ribbonwire", "homedecor:ic", },
        { "default:gold_ingot", "default:gold_ingot", "default:gold_ingot", },
    };
});

minetest.register_craft({
    output = "cryptocoins:game_computer_motherboard";
    recipe = {
        { "homedecor:ic", "homedecor:ic", "homedecor:ic", },
        { "default:gold_ingot", "default:goldblock", "cryptocoins:copper_ribbonwire", },
        { "homedecor:plastic_base", "cryptocoins:copper_ribbonwire", "default:coalblock", },
    };
});

minetest.register_craft({
    output = "cryptocoins:game_computer_powersupply";
    recipe = {
        { "cryptocoins:ribbonwire", "cryptocoins:ribbonwire", "cryptocoins:ribbonwire", },
        { "cryptocoins:copper_ribbonwire", "default:bronzeblock", "cryptocoins:copper_ribbonwire", },
        { "homedecor:ic", "homedecor:ic", "homedecor:ic", },
    };
});

minetest.register_craft({
    output = "cryptocoins:game_computer_cpu";
    recipe = {
        { "homedecor:ic", "default:gold_ingot", "homedecor:ic", },
        { "homedecor:ic", "default:diamondblock", "homedecor:ic", },
        { "homedecor:ic", "default:gold_ingot", "homedecor:ic", },
    };
});

minetest.register_craft({
    output = "cryptocoins:game_computer_soundcard";
    recipe = {
        { "cryptocoins:copper_ribbonwire", "cryptocoins:copper_ribbonwire", "cryptocoins:copper_ribbonwire", },
        { "homedecor:plastic_sheeting", "homedecor:ic", "homedecor:plastic_sheeting", },
        { "default:gold_ingot", "default:gold_ingot", "default:gold_ingot", },
    };
});

minetest.register_craft({
    output = "cryptocoins:game_computer_harddrive";
    recipe = {
        { "default:gold_ingot", "default:gold_ingot", "default:gold_ingot", },
        { "default:coalblock", "default:bronzeblock", "default:coalblock", },
        { "default:gold_ingot", "default:gold_ingot", "default:gold_ingot", },
    };
});

minetest.register_craft({
    output = "cryptocoins:game_computer_dvdrom";
    recipe = {
        { "default:steel_ingot", "homedecor:plastic_base", "default:diamond", },
        { "default:coal_lump", "default:steel_ingot", "default:coal_lump", },
        { "default:gold_ingot", "default:bronze_ingot", "default:gold_ingot", },
    };
});

minetest.register_craft({
    output = "cryptocoins:game_computer_ram";
    recipe = {
        { "cryptocoins:home_computer_ram", "cryptocoins:home_computer_ram", },
        { "cryptocoins:home_computer_ram", "cryptocoins:home_computer_ram", },
    };
});

-- Alineware Computer

minetest.register_craft({
    output = "cryptocoins:alien_computer";
    recipe = {
        { "cryptocoins:alien_computer_powersupply", "cryptocoins:ribbonwire", "cryptocoins:alien_computer_cooler", },
        { "cryptocoins:alien_computer_ram", "cryptocoins:alien_computer_cpu", "cryptocoins:game_computer", },
        { "cryptocoins:alien_computer_soundcard", "cryptocoins:alien_computer_motherboard", "cryptocoins:alien_computer_harddrive", },
    };
});

minetest.register_craft({
    output = "cryptocoins:alien_computer_video";
    recipe = {
        { "cryptocoins:home_computer_fan", "cryptocoins:game_computer_video", "default:obsidian_shard", },
        { "cryptocoins:home_computer_fan", "cryptocoins:game_computer_video", "default:obsidian_shard", },
    };
});

minetest.register_craft({
    output = "cryptocoins:alien_computer_motherboard";
    recipe = {
        { "homedecor:ic", "homedecor:ic", "homedecor:ic", },
        { "default:gold_ingot", "default:diamondblock", "default:gold_ingot", },
        { "homedecor:plastic_base", "cryptocoins:copper_ribbonwire", "default:coalblock", },
    };
});

minetest.register_craft({
    output = "cryptocoins:alien_computer_powersupply";
    recipe = {
        { "cryptocoins:ribbonwire", "cryptocoins:ribbonwire", "cryptocoins:ribbonwire", },
        { "default:bronze_ingot", "default:goldblock", "default:bronze_ingot", },
        { "homedecor:ic", "homedecor:ic", "homedecor:ic", },
    };
});

minetest.register_craft({
    output = "cryptocoins:alien_computer_cpu";
    recipe = {
        { "homedecor:ic", "default:gold_ingot", "homedecor:ic", },
        { "homedecor:ic", "default:mese", "homedecor:ic", },
        { "homedecor:ic", "default:gold_ingot", "homedecor:ic", },
    };
});

minetest.register_craft({
    output = "cryptocoins:alien_computer_soundcard";
    recipe = {
        { "cryptocoins:copper_ribbonwire", "cryptocoins:copper_ribbonwire", "cryptocoins:copper_ribbonwire", },
        { "homedecor:plastic_sheeting", "default:diamondblock", "homedecor:plastic_sheeting", },
        { "default:gold_ingot", "default:gold_ingot", "default:gold_ingot", },
    };
});

minetest.register_craft({
    output = "cryptocoins:alien_computer_harddrive";
    recipe = {
        { "homedecor:ic", "default:bronze_ingot", "homedecor:ic", },
        { "homedecor:ic", "default:goldblock", "homedecor:ic", },
        { "homedecor:ic", "cryptocoins:ribbonwire", "homedecor:ic", },
    };
});

minetest.register_craft({
    output = "cryptocoins:alien_computer_ram";
    recipe = {
        { "cryptocoins:game_computer_ram", "cryptocoins:game_computer_ram", },
    };
});

minetest.register_craft({
    output = "cryptocoins:alien_computer_cooler";
    recipe = {
        { "default:coal_lump", "default:steelblock", "default:coal_lump", },
        { "homedecor:plastic_base", "bucket:bucket_water", "vessels:glass_bottle", },
        { "homedecor:plastic_base", "homedecor:plastic_base", "homedecor:plastic_base", },
    };
});

-- bitcent

minetest.register_craft({
        output = 'cryptocoins:bitcent 100',
        recipe = {
                {'', '', 'cryptocoins:bitcent'},
                {'', '', ''},
                {'', 'cryptocoins:bitcoin', ''},
        }
})

minetest.register_craft({
        output = 'cryptocoins:bitcent 25',
        recipe = {
                {'', '', 'cryptocoins:bitcent'},
                {'', '', ''},
                {'', 'cryptocoins:bitqu', ''},
        }
})

minetest.register_craft({
        output = 'cryptocoins:bitcent 10',
        recipe = {
                {'', '', 'cryptocoins:bitcent'},
                {'', '', ''},
                {'', 'cryptocoins:bitdi', ''},
        }
})

minetest.register_craft({
        output = 'cryptocoins:bitcent 5',
        recipe = {
                {'', '', 'cryptocoins:bitcent'},
                {'', '', ''},
                {'', 'cryptocoins:bitni', ''},
        }
})


-- bitnickel

minetest.register_craft({
        output = 'cryptocoins:bitni 20',
        recipe = {
                {'', '', 'cryptocoins:bitcent'},
                {'', '', ''},
                {'', 'cryptocoins:bitcoin', ''},
        }
})

minetest.register_craft({
        output = 'cryptocoins:bitni 5',
        recipe = {
                {'', '', 'cryptocoins:bitcent'},
                {'', '', ''},
                {'', 'cryptocoins:bitqu', ''},
        }
})

minetest.register_craft({
        output = 'cryptocoins:bitni 2',
        recipe = {
                {'', '', 'cryptocoins:bitcent'},
                {'', '', ''},
                {'', 'cryptocoins:bitdi', ''},
        }
})

minetest.register_craft({
	output = 'cryptocoins:bitni',
	recipe = {
		{'', '', 'cryptocoins:bitcent'},
		{'cryptocoins:bitcent', 'cryptocoins:bitcent', ''},
		{'cryptocoins:bitcent', 'cryptocoins:bitcent', 'cryptocoins:bitcent'},
	}
})

-- bitdime

minetest.register_craft({
        output = 'cryptocoins:bitdi 10',
        recipe = {
                {'', '', 'cryptocoins:bitcent'},
                {'', '', ''},
                {'', 'cryptocoins:bitcoin', ''},
        }
})

minetest.register_craft({
	output = 'cryptocoins:bitdi',
	recipe = {
		{'', '', 'cryptocoins:bitcent'},
		{'', 'cryptocoins:bitni', ''},
		{'', 'cryptocoins:bitni', ''},
	}
})

--bitquarter

minetest.register_craft({
        output = 'cryptocoins:bitqu 4',
        recipe = {
                {'', '', 'cryptocoins:bitcent'},
                {'', '', ''},
                {'', 'cryptocoins:bitcoin', ''},
        }
})

minetest.register_craft({
	output = 'cryptocoins:bitqu',
	recipe = {
		{'cryptocoins:bitcent', 'cryptocoins:bitdi', 'cryptocoins:bitcent'},
		{'cryptocoins:bitcent', 'cryptocoins:bitdi', ''},
		{'cryptocoins:bitcent', 'cryptocoins:bitcent', 'cryptocoins:bitcent'},
	}
})

minetest.register_craft({
	output = 'cryptocoins:bitqu',
	recipe = {
		{'', 'cryptocoins:bitni', 'cryptocoins:bitcent'},
		{'', 'cryptocoins:bitdi', ''},
		{'', 'cryptocoins:bitdi', ''},
	}
})

minetest.register_craft({
	output = 'cryptocoins:bitqu',
	recipe = {
		{'', '', 'cryptocoins:bitcent'},
		{'cryptocoins:bitni', 'cryptocoins:bitni', ''},
		{'cryptocoins:bitni', 'cryptocoins:bitni', 'cryptocoins:bitni'},
	}
})

-- bitcoin

minetest.register_craft({
	output = 'cryptocoins:bitcoin',
	recipe = {
		{'', '', 'cryptocoins:bitcent'},
		{'', 'cryptocoins:bitqu', ''},
		{'cryptocoins:bitqu', 'cryptocoins:bitqu', 'cryptocoins:bitqu'},
	}
})

minetest.register_craft({
    output = "cryptocoins:router";
    recipe = {
        { "default:steel_ingot", "homedecor:ic", "default:steel_ingot", },
        { "homedecor:ic", "default:mese", "homedecor:ic", },
        { "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", },
    };
});


-- copper wire

minetest.register_craft({
    output = "cryptocoins:copper_ribbonwire 9";
    recipe = {
        { "default:copper_ingot", "default:copper_ingot", "default:copper_ingot", },
    };
});

minetest.register_craft({
    output = "cryptocoins:ribbonwire 3";
    recipe = {
        { "dye:red", "dye:green", "dye:yellow", },
        { "cryptocoins:copper_ribbonwire", "cryptocoins:copper_ribbonwire", "cryptocoins:copper_ribbonwire", },
        { "dye:blue", "homedecor:plastic_sheeting", "dye:violet", },
    };
});

-- ISP

minetest.register_craft({
    output = "cryptocoins:isp";
    recipe = {
        { "cryptocoins:copper_ribbonwire", "homedecor:ic", "default:clay_lump", },
        { "cryptocoins:ribbonwire", "homedecor:ic", "cryptocoins:ribbonwire", },
        { "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", },
    };
});





