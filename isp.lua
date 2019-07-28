-- internet usage timer config
payment_bitcoin = 24000
payment_bitqu = 6000
payment_bitdi = 2400
payment_bitni = 1200
payment_bitcent = 600

local currency_mod = minetest.get_modpath("currency")
if currency_mod then
   -- Currency usage timer config
   payment_mg100 = 24000
   payment_mg50 = 6000
   payment_mg10 = 2400
   payment_mg5 = 1200
   payment_mg1 = 600
   payment_mg25c = 150
   payment_mg10c = 60
   payment_mg5c = 30
end




function default.isp_on_formspec(pos)
	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
	local formspec = "size[10,10]"..
		"label[1,2;Powered On...]"..

		"label[1,2.6;Payment:]"..
		"list[nodemeta:".. spos .. ";main;1,3;1,1;]"..
		"list[current_player;main;1,6;8,4;]"..
		"button_exit[4,5;2,1;exit;Exit]"
	return formspec
end

function default.isp_off_formspec(pos)
	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
	local formspec = "size[10,10]"..
		"label[1,2;Powered Off...]"..
		"list[nodemeta:".. spos .. ";main;1,3;1,1;]"..
		"list[current_player;main;1,6;8,4;]"..
		"button_exit[4,5;2,1;exit;Exit]"
	return formspec
end

function default.isp_on(pos)
	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
	local formspec = "size[10,10]"..
		"label[2,2;Powered Off...]"..
		"list[nodemeta:".. spos .. ";main;1,3;1,1;]"..
		"list[current_player;main;1,6;8,4;]"..
		"button_exit[4,5;2,1;exit;Exit]"
	return formspec
end

local function isp_owner(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end

-- ISP

minetest.register_node("cryptocoins:isp", {
	description = "Internet Service Provider",
	tiles = {
		"cryptocoins_isp_tp.png",
		"cryptocoins_isp_bt.png",
		"cryptocoins_isp_rt.png",
		"cryptocoins_isp_lt.png",
		"cryptocoins_isp_bk.png",
		"cryptocoins_isp_ft_off.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	is_ground_content = true,
	groups = {snappy=3},
	sound = default.node_sound_wood_defaults(),
	drop = "cryptocoins:isp",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.153531, -0.5, -0.405738, 0.153531, -0.315951, 0.405738},
			{-0.122825, -0.315951, -0.374616, 0.122825, 0.371166, 0.375},
		},
	},
	on_punch = function(pos)
		local node = minetest.get_node(pos)
		local timer = minetest.get_node_timer(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		minetest.swap_node(pos, {name = 'cryptocoins:isp_on', param2 = node.param2})
		meta:set_string("formspec", default.isp_on_formspec(pos))
		meta:set_string("infotext", "Internet Service Provider (owner "..meta:get_string("owner")..")")
		inv:set_size("main", 1*1)
		timer:start(2)
	end,
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		local timer = minetest.get_node_timer(pos)
		local inv = meta:get_inventory()
		meta:set_string("formspec", default.isp_off_formspec(pos))
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Internet Service Provider (owner "..meta:get_string("owner")..")")
		inv:set_size("main", 1*1)
		timer:stop()
	end,
	on_construct = function(pos)
		local node = minetest.get_node(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		meta:set_string("formspec", default.isp_off_formspec(pos))
		meta:set_string("infotext", "Internet Service Provider")
		inv:set_size("main", 1*1)
	end,
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main") and isp_owner(meta, player)
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if not isp_owner(meta, player) then
			return 0
		end
		return count
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not isp_owner(meta, player) then
			return 0
		end
		return stack:get_count()
	end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not isp_owner(meta, player) then
			return 0
		end
		return stack:get_count()
	end,
})

minetest.register_node("cryptocoins:isp_on", {
	description = "Internet Service Provider",
	tiles = {
		"cryptocoins_isp_tp.png",
		"cryptocoins_isp_bt.png",
		"cryptocoins_isp_rt.png",
		"cryptocoins_isp_lt.png",
		"cryptocoins_isp_bk.png",
		{name="cryptocoins_isp_f_animated.png", animation={type="vertical_frames", aspect_w=32, aspect_h=32, length=1.0}},}, --"cryptocoins_isp_f.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	is_ground_content = true,
	groups = {snappy=3, not_in_creative_inventory = 1},
	sound = default.node_sound_wood_defaults(),
	drop = "cryptocoins:isp",
	drawtype = "nodebox",
	light_source = 4,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.153531, -0.5, -0.405738, 0.153531, -0.315951, 0.405738},
			{-0.122825, -0.315951, -0.374616, 0.122825, 0.371166, 0.375},
		},
	},
	on_punch = function(pos)

		local timer = minetest.get_node_timer(pos)
		local node = minetest.get_node(pos)
		local meta = minetest.get_meta(pos)
		minetest.swap_node(pos, {name = 'cryptocoins:isp', param2 = node.param2})
		meta:set_string("formspec", default.isp_off_formspec(pos))
		meta:set_string("infotext", "Internet Service Provider (owner "..meta:get_string("owner")..")")
		local inv = meta:get_inventory()
		inv:set_size("main", 1*1)
		timer:stop()

	end,
	on_timer = function(pos)
		local meta = minetest.get_meta(pos)
		if ( minetest.get_player_by_name(meta:get_string("owner")) == nil ) then
			local timer = minetest.get_node_timer(pos)
			local node = minetest.get_node(pos)
			local meta = minetest.get_meta(pos)
			minetest.swap_node(pos, {name = 'cryptocoins:isp', param2 = node.param2})
			meta:set_string("formspec", default.isp_off_formspec(pos))
			meta:set_string("infotext", "Internet Service Provider (owner "..meta:get_string("owner")..")")
			local inv = meta:get_inventory()
			inv:set_size("main", 1*1)
			timer:stop()
		else
			local timer = minetest.get_node_timer(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", default.isp_on_formspec(pos))
			meta:set_string("infotext", "Internet Service Provider (owner "..meta:get_string("owner")..")")
			local inv = meta:get_inventory()
			inv:set_size("main", 1*1)
			local payment = inv:get_stack("main", 1)
			if payment:get_name()== "" then
				local timer = minetest.get_node_timer(pos)
				local node = minetest.get_node(pos)
				local meta = minetest.get_meta(pos)
				minetest.swap_node(pos, {name = 'cryptocoins:isp', param2 = node.param2})
				meta:set_string("formspec", default.isp_off_formspec(pos))
				meta:set_string("infotext", "Internet Service Provider (owner "..meta:get_string("owner")..")")
				local inv = meta:get_inventory()
				inv:set_size("main", 1*1)
				timer:stop()
			else
			   if currency_mod then
			   if payment:get_name()=="currency:minegeld_100" then
   			   payment:take_item()
  	   	   	inv:set_stack("main",1,payment)
  	   	   	timer:start(payment_mg100)
   			else
   				if payment:get_name()=="currency:minegeld_50" then
   					payment:take_item()
     	   			inv:set_stack("main",1,payment)
   					timer:start(payment_mg50)
   				else
   					if payment:get_name()=="currency:minegeld_10" then
   						payment:take_item()
        					inv:set_stack("main",1,payment)
   						timer:start(payment_mg10)
   					else
   						if payment:get_name()=="currency:minegeld_5" then
   							payment:take_item()
         					inv:set_stack("main",1,payment)
   							timer:start(payment_mg5)
   						else
   							if payment:get_name()=="currency:minegeld" then
   								payment:take_item()
         						inv:set_stack("main",1,payment)
   								timer:start(payment_mg1)
   							else
   								if payment:get_name()=="currency:minegeld_cent_25" then
   						   		payment:take_item()
         				   		inv:set_stack("main",1,payment)
   						   		timer:start(payment_mg1)
      							else
         							if payment:get_name()=="currency:minegeld_cent_10" then
         								payment:take_item()
               						inv:set_stack("main",1,payment)
         								timer:start(payment_mg1)
         							else
            							if payment:get_name()=="currency:minegeld_cent_5" then
            								payment:take_item()
                  						inv:set_stack("main",1,payment)
            								timer:start(payment_mg1)
            							else
   											if payment:get_name()=="cryptocoins:bitcoin" then
		                  	       		payment:take_item()
  	                 	             		inv:set_stack("main",1,payment)
                        					timer:start(payment_bitcoin)
				                        else
                                       if payment:get_name()=="cryptocoins:bitqu" then
                                          payment:take_item()
                                          inv:set_stack("main",1,payment)
		                          				timer:start(payment_bitqu)
		                          			else
		                          				if payment:get_name()=="cryptocoins:bitdi" then
				                         			payment:take_item()
     		 	                        			inv:set_stack("main",1,payment)
				                         			timer:start(payment_bitdi)
				                         		else
				                         			if payment:get_name()=="cryptocoins:bitni" then
					                        			payment:take_item()
      			                          			inv:set_stack("main",1,payment)
				                        				timer:start(payment_bitni)
					                         		else
					                         			if payment:get_name()=="cryptocoins:bitcent" then
					                         				payment:take_item()
      			                          				inv:set_stack("main",1,payment)
					                         				timer:start(payment_bitcent)
					                         			else
					                         				local timer = minetest.get_node_timer(pos)
					                         				local node = minetest.get_node(pos)
					                         				local meta = minetest.get_meta(pos)
					                         				local inv = meta:get_inventory()
						                          			minetest.swap_node(pos, {name = 'cryptocoins:isp', param2 = node.param2})
						                          			meta:set_string("formspec", default.isp_off_formspec(pos))
						                          			meta:set_string("infotext", "Internet Service Provider (owner "..meta:get_string("owner")..")")
							                        		inv:set_size("main", 1*1)
							                        		timer:stop()
							                        	end
						                          	end
					                         	end
			         		               end
			                        	end
   		          					end
   		          				end
   		       				end
   		    				end
   						end
   					end
   				end
				end
				end
			end
		end
	
	
	
	
	
	
	
		
	end,
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main") and isp_owner(meta, player)
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if not isp_owner(meta, player) then
		return 0
		end
		return count
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not isp_owner(meta, player) then
			return 0
		end
		return stack:get_count()
	end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not isp_owner(meta, player) then
			return 0
		end
		return stack:get_count()
	end,
})