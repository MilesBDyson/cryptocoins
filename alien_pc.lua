math.randomseed(os.time())
alien_boot = 30					-- seconds it takes to boot the computer
alien_miner = math.random(250,325)					-- seconds it takes to mine one bitcent
alien_upgrade_step = 45			-- seconds to subtract from alien_miner per upgrade

local function computer_owner(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end

local function upgrade_timer(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local expansion1 = inv:get_stack("exp1", 1)
	local expansion2 = inv:get_stack("exp2", 1)
	local expansion3 = inv:get_stack("exp3", 1)
	local upgraded_miner = alien_miner
	if expansion1:get_name()== "cryptocoins:alien_computer_video" then
		upgraded_miner = upgraded_miner - alien_upgrade_step
	else
		if expansion1:get_name()== "" then
			upgraded_miner = upgraded_miner
		else
			upgraded_miner = upgraded_miner + 99999
		end
	end
	if expansion2:get_name()=="cryptocoins:alien_computer_video" then
		upgraded_miner = upgraded_miner - alien_upgrade_step
	else
		if expansion2:get_name()== "" then
			upgraded_miner = upgraded_miner
		else
			upgraded_miner = upgraded_miner + 99999
		end
	end
	if expansion3:get_name()== "cryptocoins:alien_computer_video" then
		upgraded_miner = upgraded_miner - alien_upgrade_step
	else
		if expansion3:get_name()== "" then
			upgraded_miner = upgraded_miner
		else
			upgraded_miner = upgraded_miner + 99999
		end
	end
	return upgraded_miner
end
 
function default.alien_boot_formspec(pos)
	local formspec = "invsize[10,10]"..
	   "image[1,0.5;1.2,1.2;tux.png]"..
		"label[2,0.8;Initializing basic system settings	... OK]" ..
		"label[2,1.1;Mounting local filesystems			... OK]" ..
		"label[2,1.4;Enabling swap space						... OK]" ..
		"label[2,1.7;Setting up console						... OK]" ..
		"label[2,2;Operaing System Loaded					... OK]" ..
		"label[2,2.3;Starting cgminer 3.7.2 ]" ..
		"list[current_name;main;1,3;1,1;]"..
		"list[current_player;main;3,9.5;4,1;]"
	return formspec
end

function default.alien_off_formspec(pos)
	local formspec = "invsize[10,10]"..
		"background[1,2.5;8,7;cryptocoins_alien_computer_motherboard.png]"..
		"label[2,2;Powered Off...]"..
		"list[current_name;main;1,3;1,1;]"..
		"list[current_name;exp1;2,5.94;1,1;]"..
		"list[current_name;exp2;3,7.11;1,1;]"..
		"list[current_name;exp3;2,8.29;1,1;]"..
		"list[current_player;main;3,9.5;4,1;]"
	return formspec
end
 
function default.alien_active_formspec(pos)
	local formspec = "invsize[10,10]"..
		"background[1,2.5;8,7;cryptocoins_alien_computer_motherboard.png]"..
		"label[2,0.0;cgminer version 3.7.2 - Started]" ..
		"label[2,0.2;----------------------------------------------------------------------------------]" ..
		"label[2,0.4;5s:468.9K avg:468.8Kh/s : A:2304 R:0 HW:0 WU:394.4/m]" ..
		"label[2,0.7;ST: 2  SS: 0  NB: 1909  LW: 34901  GF: 14  RF: 7]" ..
		"label[2,1;Connected to stratum.max.bitcoin.com diff 1.02k with stratum.]" ..
		"label[2,1.3;Block: 31dca6d... Diff:104 Started: 09:24:05 Best share: 618K.]" ..
		"label[2,1.5;----------------------------------------------------------------------------------]" ..
		"list[current_name;main;1,3;1,1;]"..
		"list[current_name;exp1;2,5.94;1,1;]"..
		"list[current_name;exp2;3,7.11;1,1;]"..
		"list[current_name;exp3;2,8.29;1,1;]"..
		"list[current_player;main;3,9.5;4,1;]"
	return formspec
end
 
function default.alien_wifi_formspec(pos)
	local formspec = "invsize[10,10]"..
		"background[1,2.5;8,7;cryptocoins_alien_computer_motherboard.png]"..
		"label[2,0;No Internet Connection.]" ..
		"label[2,0.3;Is your ISP Router On?]"..
		"label[2,0.6;Contact Your Network Administrator For More Information.]" ..
		"list[current_name;main;1,3;1,1;]"..
		"list[current_name;exp1;2,5.94;1,1;]"..
		"list[current_name;exp2;3,7.11;1,1;]"..
		"list[current_name;exp3;2,8.29;1,1;]"..
		"list[current_player;main;3,9.5;4,1;]"
	return formspec
end

function default.alien_off(pos)
	local timer = minetest.get_node_timer(pos)
	local meta = minetest.get_meta(pos)
	local node = minetest.get_node(pos)
	local inv = meta:get_inventory()
	minetest.swap_node(pos, {name = 'cryptocoins:alien_computer', param2 = node.param2})
	meta:set_string("formspec", default.alien_off_formspec(pos))
	meta:set_string("infotext", "Alienware Computer (owner "..
	meta:get_string("owner")..")")
	inv:set_size("main", 1*1)
	timer:stop()
end

function default.alien_wifi(pos)
	local timer = minetest.get_node_timer(pos)
	local meta = minetest.get_meta(pos)
	local node = minetest.get_node(pos)
	local inv = meta:get_inventory()
	minetest.swap_node(pos, {name = 'cryptocoins:alien_computer', param2 = node.param2})
	meta:set_string("formspec", default.alien_wifi_formspec(pos))
	meta:set_string("infotext", "Alienware Computer (owner "..
	meta:get_string("owner")..")")
	inv:set_size("main", 1*1)
	timer:stop()
end

function default.alien_boot(pos)
	local timer = minetest.get_node_timer(pos)
	local meta = minetest.get_meta(pos)
	local node = minetest.get_node(pos)
	local inv = meta:get_inventory()		
	meta:set_string("formspec", default.alien_boot_formspec(pos))
	meta:set_string("infotext", "Alienware Computer (owner "..
	meta:get_string("owner")..")")
	inv:set_size("main", 1*1)
	timer:start(alien_boot)
end


-- Alienware Computer
minetest.register_node("cryptocoins:alien_computer",{
	drawtype = "nodebox",
	description = "Alienware Computer",
	tiles = {"cryptocoins_alien_computer_tp.png","cryptocoins_alien_computer_bt.png","cryptocoins_alien_computer_rt.png","cryptocoins_alien_computer_lt.png","cryptocoins_alien_computer_bk.png","cryptocoins_alien_computer_ft_off.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	drop = "cryptocoins:alien_computer",
	groups = {cracky=2, oddly_breakable_by_hand=2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,-0.500000,0.03125,0.500000,0.500000,0.40625},
			{-0.40625,-0.40625,0.40625,0.40625,0.40625,0.50000},
			{-0.500000,-0.500000,-0.500000,0.500000,-0.375,-0.03125},
		},
	},
	sounds = default.node_sound_wood_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		local timer = minetest.get_node_timer(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		default.alien_off(pos)
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		meta:set_string("formspec", default.alien_boot_formspec(pos))
		meta:set_string("infotext", "Alienware Computer (owner "..
		meta:get_string("owner")..")")
		inv:set_size("main", 1*1)
		inv:set_size("exp1", 1*1)
		inv:set_size("exp2", 1*1)
		inv:set_size("exp3", 1*1)
		end,
	on_timer = function(pos)
		local isp = minetest.find_node_near(pos, 1, {"cryptocoins:isp_on"})
		if isp == nil then
			local wifi = minetest.find_node_near(pos, 16, {"cryptocoins:router_on"})
			if wifi == nil then
				default.alien_wifi(pos)
			else
				local meta = minetest.get_meta(pos)
				if ( minetest.get_player_by_name(meta:get_string("owner")) == nil ) then
					default.alien_off(pos)
				else
					local timer = minetest.get_node_timer(pos)
					local meta = minetest.get_meta(pos)
					local node = minetest.get_node(pos)
					local inv = meta:get_inventory()
					minetest.swap_node(pos, {name = 'cryptocoins:alien_computer_active', param2 = node.param2})
					meta:set_string("formspec", default.alien_active_formspec(pos))
					meta:set_string("infotext", "Alienware Computer (owner "..
					meta:get_string("owner")..")")
					inv:set_size("main", 1*1)
					if ( upgrade_timer(pos) < alien_miner ) then
						timer:start(upgrade_timer(pos))
					else
						default.alien_off(pos)
					end
				end
			end
		else
			local meta = minetest.get_meta(pos)
			if ( minetest.get_player_by_name(meta:get_string("owner")) == nil ) then
				default.alien_off(pos)
			else
				local timer = minetest.get_node_timer(pos)
				local meta = minetest.get_meta(pos)
				local node = minetest.get_node(pos)
				local inv = meta:get_inventory()
				minetest.swap_node(pos, {name = 'cryptocoins:alien_computer_active', param2 = node.param2})
				meta:set_string("formspec", default.alien_active_formspec(pos))
				meta:set_string("infotext", "Alienware Computer (owner "..
				meta:get_string("owner")..")")
				inv:set_size("main", 1*1)
				if ( upgrade_timer(pos) < alien_miner ) then
					timer:start(upgrade_timer(pos))
				else
					default.alien_off(pos)
				end
			end
		end
	end,
	on_punch = function(pos)
		local isp = minetest.find_node_near(pos, 1, {"cryptocoins:isp_on"})
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if upgrade_timer(pos) < alien_miner then
			if isp == nil then
				local wifi = minetest.find_node_near(pos, 16, {"cryptocoins:router_on"})
				if wifi == nil then
					default.alien_wifi(pos)
				else
					if ( upgrade_timer(pos) < alien_miner ) then
						default.alien_boot(pos)
					else
						default.alien_off(pos)
					end
				end
			else
				default.alien_boot(pos)
			end
		else
			default.alien_off(pos)
		end
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if not computer_owner(meta, player) then
			return 0
		end
		return count
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.env:get_meta(pos)
		if not computer_owner(meta, player) then
			return 0
		end
		return stack:get_count()
	end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not computer_owner(meta, player) then
			return 0
		end
		return stack:get_count()
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main") and inv:is_empty("exp1") and inv:is_empty("exp2") and inv:is_empty("exp3") and computer_owner(meta, player)
	end,
})

minetest.register_node("cryptocoins:alien_computer_active",{
	drawtype = "nodebox",
	description = "Alienware Computer",
	tiles = {"cryptocoins_alien_computer_tp.png","cryptocoins_alien_computer_bt.png","cryptocoins_alien_computer_rt.png","cryptocoins_alien_computer_lt.png","cryptocoins_alien_computer_bk.png","cryptocoins_alien_computer_ft.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 8,
	drop = "cryptocoins:alien_computer",
	groups = {cracky=2, not_in_creative_inventory=1, oddly_breakable_by_hand=2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,-0.500000,0.03125,0.500000,0.500000,0.40625},
			{-0.40625,-0.40625,0.40625,0.40625,0.40625,0.50000},
			{-0.500000,-0.500000,-0.500000,0.500000,-0.375,-0.03125},
		},
	},
	sounds = default.node_sound_wood_defaults(),
	on_timer = function(pos)
		local timer = minetest.get_node_timer(pos)
		local meta = minetest.get_meta(pos)
		local node = minetest.get_node(pos)
		local inv = meta:get_inventory()
		local isp = minetest.find_node_near(pos, 1, {"cryptocoins:isp_on"})
		if isp == nil then
			local wifi = minetest.find_node_near(pos, 16, {"cryptocoins:router_on"})
			if wifi == nil then
				default.alien_off(pos)
			else
				local meta = minetest.get_meta(pos)
				if ( minetest.get_player_by_name(meta:get_string("owner")) == nil ) then
					default.alien_off(pos)
				else
					if ( upgrade_timer(pos) < alien_miner ) then
						timer:start(upgrade_timer(pos))
						minetest.get_meta(pos):get_inventory():add_item("main", "cryptocoins:bitcent")
					else
						default.alien_off(pos)
					end
				end
			end
		else
			local meta = minetest.get_meta(pos)
			if ( minetest.get_player_by_name(meta:get_string("owner")) == nil ) then
				default.alien_off(pos)
			else					
				if ( upgrade_timer(pos) < alien_miner ) then
					minetest.get_meta(pos):get_inventory():add_item("main", "cryptocoins:bitcent")
					timer:start(upgrade_timer(pos))
				else
					default.alien_off(pos)
				end
			end
		end
	end,	
	on_punch = function(pos)
		default.alien_off(pos)
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if not computer_owner(meta, player) then
			return 0
		end
		return count
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.env:get_meta(pos)
		if not computer_owner(meta, player) then
			return 0
		end
		return stack:get_count()
	end,
   allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not computer_owner(meta, player) then
			return 0
		end
		return stack:get_count()
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main") and inv:is_empty("exp1") and inv:is_empty("exp2") and inv:is_empty("exp3") and computer_owner(meta, player)
	end,
})



