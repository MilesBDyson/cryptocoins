
router_cycle = 10
router_radius = 30

function default.router_off_formspec(pos)
	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
	local formspec = "size[10,10]"..
		"label[2,2;Powered Off...]"
	return formspec
end

function default.router_on_formspec(pos)
	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
	local formspec = "size[10,10]"..
		"label[1,0;Powered On...]"..
		"label[2,0.5;Computers:]"..
		"label[2,0.8;Active: "..#active_computers.."]"..
		"label[2,1;Inactive: "..#inactive_computers.."]"..
		"label[4,0.5;Routers:]"..
		"label[4,0.8;Active: "..#active_routers.."]"..
		"label[4,1;Inactive: "..#inactive_routers.."]"..
		"label[6,0.5;Available Networks:]"..
		"label[6,0.8;Active: "..#active_isp.."]"..
		"label[6,1;Inactive: "..#inactive_isp.."]"..
		"label[3,2.5;Test:]"..
		"label[3,2.8;Active: "..#active_isp.."]"..
		"label[3,3;Inactive: "..#inactive_isp.."]"..
		"button_exit[4,7;2,1;exit;Exit]"
	return formspec
end

function default.router_error_formspec(pos)
	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
	local formspec = "size[10,10]"..
		"label[2,2;No Networks Available...]"
	return formspec
end

function default.find_network(pos)

-- need to do some owner checking and report isp networks accordingly using the router owner function or similar.....




	active_computers = minetest.find_nodes_in_area({x=pos.x-16, y=pos.y-16, z=pos.z-16}, {x=pos.x+16, y=pos.y+16, z=pos.z+16}, {"cryptocoins:home_computer_active","cryptocoins:game_computer_active","cryptocoins:alien_computer_active"})
	inactive_computers = minetest.find_nodes_in_area({x=pos.x-16, y=pos.y-16, z=pos.z-16}, {x=pos.x+16, y=pos.y+16, z=pos.z+16}, {"cryptocoins:home_computer","cryptocoins:game_computer","cryptocoins:alien_computer"})
	active_routers = minetest.find_nodes_in_area({x=pos.x-16, y=pos.y-16, z=pos.z-16}, {x=pos.x+16, y=pos.y+16, z=pos.z+16}, {"cryptocoins:router_on"})
	inactive_routers = minetest.find_nodes_in_area({x=pos.x-16, y=pos.y-16, z=pos.z-16}, {x=pos.x+16, y=pos.y+16, z=pos.z+16}, {"cryptocoins:router"})	
	active_isp = minetest.find_nodes_in_area({x=pos.x-16, y=pos.y-16, z=pos.z-16}, {x=pos.x+16, y=pos.y+16, z=pos.z+16}, {"cryptocoins:isp_on"})
	inactive_isp = minetest.find_nodes_in_area({x=pos.x-16, y=pos.y-16, z=pos.z-16}, {x=pos.x+16, y=pos.y+16, z=pos.z+16}, {"cryptocoins:isp"})
end

local function router_owner(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end

-- WIFI Router
minetest.register_node("cryptocoins:router_on", {
	description = "WIFI Router",
	tiles = {"cryptocoins_router_t.png","cryptocoins_router_bt.png","cryptocoins_router_l.png","cryptocoins_router_r.png","cryptocoins_router_b.png",
			{name="cryptocoins_router_f_animated.png", animation={type="vertical_frames", aspect_w=32, aspect_h=32, length=1.0}},}, --"cryptocoins_router_f.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	is_ground_content = true,
	groups = {snappy=3, not_in_creative_inventory = 1},
	sound = default.node_sound_wood_defaults(),
	drop = "cryptocoins:router",
	drawtype = "nodebox",
	light_source = 4,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.0625, 0.25, -0.375, 0.3125},
			{-0.1875, -0.4375, 0.3125, -0.125, -0.1875, 0.375},
			{0.125, -0.4375, 0.3125, 0.1875, -0.1875, 0.375},
			{-0.0625, -0.4375, 0.3125, 0.0625, -0.25, 0.375},
			},
		},
	on_punch = function(pos)
		local node = minetest.get_node(pos)
		minetest.swap_node(pos, {name = 'cryptocoins:router', param2 = node.param2})
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", default.router_off_formspec(pos))
		meta:set_string("infotext", "Router (owner "..meta:get_string("owner")..")")
	end,
	on_timer = function(pos)
		default.find_network(pos)
		local isp = minetest.find_node_near(pos, router_radius, {"cryptocoins:isp_on"})
		if isp == nil then
			local timer = minetest.get_node_timer(pos)
			local node = minetest.get_node(pos)
			local meta = minetest.get_meta(pos)
			minetest.swap_node(pos, {name = 'cryptocoins:router_error', param2 = node.param2})
			meta:set_string("formspec", default.router_error_formspec(pos))
			meta:set_string("infotext", "Router (owner "..meta:get_string("owner")..")")
			timer:start(router_cycle)
		else
			
			local timer = minetest.get_node_timer(pos)
			local node = minetest.get_node(pos)
			local meta = minetest.get_meta(pos)
			minetest.swap_node(pos, {name = 'cryptocoins:router_on', param2 = node.param2})
			meta:set_string("formspec", default.router_on_formspec(pos))
			meta:set_string("infotext", "Router (owner "..meta:get_string("owner")..")")
			timer:start(router_cycle)
		end
	end,
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		local timer = minetest.get_node_timer(pos)
		meta:set_string("formspec", default.router_on_formspec(pos))
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Router (owner "..meta:get_string("owner")..")")
		timer:start(router_cycle)
	end,
	on_construct = function(pos)
		default.find_network(pos)
		local isp = minetest.find_node_near(pos, router_radius, {"cryptocoins:isp_on"})
		if isp == nil then
			local node = minetest.get_node(pos)
			local meta = minetest.get_meta(pos)
			minetest.swap_node(pos, {name = 'cryptocoins:router_error', param2 = node.param2})
			meta:set_string("formspec", default.router_error_formspec(pos))
			meta:set_string("infotext", "Router (owner "..meta:get_string("owner")..")")
		else
			local node = minetest.get_node(pos)
			local meta = minetest.get_meta(pos)
			minetest.swap_node(pos, {name = 'cryptocoins:router_on', param2 = node.param2})
			meta:set_string("formspec", default.router_on_formspec(pos))
			meta:set_string("infotext", "Router (owner "..meta:get_string("owner")..")")
		end
	end,
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos);
		return router_owner(meta, player)
	end,
})

minetest.register_node("cryptocoins:router", {
	description = "WIFI Router",
	tiles = {"cryptocoins_router_t.png","cryptocoins_router_bt.png","cryptocoins_router_l.png","cryptocoins_router_r.png","cryptocoins_router_b.png", "cryptocoins_router_f.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	is_ground_content = true,
	groups = {snappy=3},
	sound = default.node_sound_wood_defaults(),
	drop = "cryptocoins:router",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.0625, 0.25, -0.375, 0.3125},
			{-0.1875, -0.4375, 0.3125, -0.125, -0.1875, 0.375},
			{0.125, -0.4375, 0.3125, 0.1875, -0.1875, 0.375},
			{-0.0625, -0.4375, 0.3125, 0.0625, -0.25, 0.375},
			},
		},
	on_punch = function(pos)
		local isp = minetest.find_node_near(pos, router_radius, {"cryptocoins:isp_on"})
		default.find_network(pos)
		if isp == nil then
			local timer = minetest.get_node_timer(pos)
			local meta = minetest.get_meta(pos)
			local node = minetest.get_node(pos)
			minetest.swap_node(pos, {name = 'cryptocoins:router_error', param2 = node.param2})
			meta:set_string("formspec", default.router_error_formspec(pos))
			meta:set_string("infotext", "Router (owner "..meta:get_string("owner")..")")
			timer:start(router_cycle)
		else
			local timer = minetest.get_node_timer(pos)
			local meta = minetest.get_meta(pos)
			local node = minetest.get_node(pos)
			minetest.swap_node(pos, {name = 'cryptocoins:router_on', param2 = node.param2})
			meta:set_string("formspec", default.router_on_formspec(pos))
			meta:set_string("infotext", "Router (owner "..meta:get_string("owner")..")")
			timer:start(router_cycle)
		end
	end,
	on_timer = function(pos)
		default.find_network(pos)
		local timer = minetest.get_node_timer(pos)
		local node = minetest.get_node(pos)
		local meta = minetest.get_meta(pos)
		minetest.swap_node(pos, {name = 'cryptocoins:router', param2 = node.param2})
		meta:set_string("formspec", default.router_off_formspec(pos))
		meta:set_string("infotext", "Router (owner "..meta:get_string("owner")..")")
		timer:stop()
	end,
	after_place_node = function(pos, placer)
		local timer = minetest.get_node_timer(pos)
		local node = minetest.get_node(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", default.router_on_formspec(pos))
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Router (owner "..meta:get_string("owner")..")")
		timer:start(router_cycle)
	end,
	on_construct = function(pos)
		default.find_network(pos)
		local isp = minetest.find_node_near(pos, router_radius, {"cryptocoins:isp_on"})
		if isp == nil then
			local node = minetest.get_node(pos)
			local meta = minetest.get_meta(pos)
			minetest.swap_node(pos, {name = 'cryptocoins:router_error', param2 = node.param2})
			meta:set_string("formspec", default.router_error_formspec(pos))
			meta:set_string("infotext", "Router (owner "..meta:get_string("owner")..")")
		else
			local node = minetest.get_node(pos)
			local meta = minetest.get_meta(pos)
			minetest.swap_node(pos, {name = 'cryptocoins:router_on', param2 = node.param2})
			meta:set_string("formspec", default.router_on_formspec(pos))
			meta:set_string("infotext", "Router (owner "..meta:get_string("owner")..")")
		end
	end,
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos);
		return router_owner(meta, player)
	end,
})

minetest.register_node("cryptocoins:router_error", {
	description = "WIFI Router",
	tiles = {"cryptocoins_router_t.png","cryptocoins_router_bt.png","cryptocoins_router_l.png","cryptocoins_router_r.png","cryptocoins_router_b.png",
			{name="cryptocoins_router_f_error.png", animation={type="vertical_frames", aspect_w=32, aspect_h=32, length=1.0}},}, --"cryptocoins_router_f.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	is_ground_content = true,
	groups = {snappy=3, not_in_creative_inventory = 1},
	sound = default.node_sound_wood_defaults(),
	drop = "cryptocoins:router",
	drawtype = "nodebox",
	light_source = 4,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.0625, 0.25, -0.375, 0.3125},
			{-0.1875, -0.4375, 0.3125, -0.125, -0.1875, 0.375},
			{0.125, -0.4375, 0.3125, 0.1875, -0.1875, 0.375},
			{-0.0625, -0.4375, 0.3125, 0.0625, -0.25, 0.375},
			},
		},
	on_punch = function(pos)
		local node = minetest.get_node(pos)
		minetest.swap_node(pos, {name = 'cryptocoins:router', param2 = node.param2})
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", default.router_off_formspec(pos))
			meta:set_string("infotext", "Router (owner "..meta:get_string("owner")..")")
	end,
	on_timer = function(pos)
		default.find_network(pos)
		local isp = minetest.find_node_near(pos, router_radius, {"cryptocoins:isp_on"})
		if isp == nil then
			local timer = minetest.get_node_timer(pos)
			local node = minetest.get_node(pos)
			local meta = minetest.get_meta(pos)
			minetest.swap_node(pos, {name = 'cryptocoins:router_error', param2 = node.param2})
			meta:set_string("formspec", default.router_error_formspec(pos))
			meta:set_string("infotext", "Router (owner "..meta:get_string("owner")..")")
			timer:start(router_cycle)
		else
			local timer = minetest.get_node_timer(pos)
			local node = minetest.get_node(pos)
			local meta = minetest.get_meta(pos)
			minetest.swap_node(pos, {name = 'cryptocoins:router_on', param2 = node.param2})
			meta:set_string("formspec", default.router_on_formspec(pos))
			meta:set_string("infotext", "Router (owner "..meta:get_string("owner")..")")
			timer:start(router_cycle)
		end
		
	end,
	on_construct = function(pos)
		local isp = minetest.find_node_near(pos, router_radius, {"cryptocoins:isp_on"})
		if isp == nil then
			local node = minetest.get_node(pos)
			local meta = minetest.get_meta(pos)
			minetest.swap_node(pos, {name = 'cryptocoins:router_error', param2 = node.param2})
			meta:set_string("formspec", default.router_error_formspec(pos))
			meta:set_string("infotext", "Router (owner "..meta:get_string("owner")..")")
		else
			local node = minetest.get_node(pos)
			local meta = minetest.get_meta(pos)
			minetest.swap_node(pos, {name = 'cryptocoins:router_on', param2 = node.param2})
			meta:set_string("formspec", default.router_on_formspec(pos))
			meta:set_string("infotext", "Router (owner "..meta:get_string("owner")..")")
		end
	end,
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos);
		return router_owner(meta, player)
	end,
})


