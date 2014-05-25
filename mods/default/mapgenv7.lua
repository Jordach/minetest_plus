-- mods/default/mapgenv7.lua

minetest.register_abm({
        nodenames = {"default:mgsapling"},
        interval = 1,
        chance = 1,
        action = function(pos, node)
                local is_soil = minetest.registered_nodes[minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name].groups.soil
                if is_soil == nil or is_soil == 0 then return end
                print("A sapling grows into a tree at "..minetest.pos_to_string(pos))
                local vm = minetest.get_voxel_manip()
                local minp, maxp = vm:read_from_map({x=pos.x-16, y=pos.y, z=pos.z-16}, {x=pos.x+16, y=pos.y+16, z=pos.z+16})
                local a = VoxelArea:new{MinEdge=minp, MaxEdge=maxp}
                local data = vm:get_data()
                default.grow_tree(data, a, pos, math.random(1, 4) == 1, math.random(1,100000))
                vm:set_data(data)
                vm:write_to_map(data)
                vm:update_map()
        end
})

minetest.register_abm({
        nodenames = {"default:mgjunglesapling"},
        interval = 1,
        chance = 1,
        action = function(pos, node)
		local is_soil = minetest.registered_nodes[minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name].groups.soil
		if is_soil == nil or is_soil == 0 then return end
		local vm = minetest.get_voxel_manip()
		local minp, maxp = vm:read_from_map({x=pos.x-16, y=pos.y-1, z=pos.z-16}, {x=pos.x+16, y=pos.y+24, z=pos.z+16})
		local a = VoxelArea:new{MinEdge=minp, MaxEdge=maxp}
		local data = vm:get_data()
		default.grow_jungletree(pos.x, pos.y, pos.z, a, data)--pos, math.random(1,100000))(x, y, z, area, data)--(data, a, pos, seed)
		vm:set_data(data)
		vm:write_to_map(data)
		vm:update_map()
        end
})

minetest.register_abm({
        nodenames = {"default:mgconifer_sapling"},
        interval = 1,
        chance = 1,
        action = function(pos, node)
		local is_soil = minetest.registered_nodes[minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name].groups.soil
		if is_soil == nil or is_soil == 0 then return end
		local vm = minetest.get_voxel_manip()
		local minp, maxp = vm:read_from_map({x=pos.x-16, y=pos.y-1, z=pos.z-16}, {x=pos.x+16, y=pos.y+17, z=pos.z+16})
		local a = VoxelArea:new{MinEdge=minp, MaxEdge=maxp}
		local data = vm:get_data()
		default.grow_conifer(pos.x, pos.y, pos.z, a, data)
		vm:set_data(data)
		vm:write_to_map(data)
		vm:update_map()
        end
})

-- special nodes

minetest.register_node("default:mgconifer_sapling", {
	description = "You hacker you",
	drawtype = "airlike",
	groups = {dig_immediate=1},
})

minetest.register_node("default:mgjunglesapling", {
	description = "You hacker you",
	drawtype = "airlike",
	groups = {dig_immediate=1},
})

minetest.register_node("default:mgsapling", {
	description = "You hacker you",
	drawtype = "airlike",
	groups = {dig_immediate=1},
})

-- biomes

minetest.register_biome({
	name = "plains",
	
	node_top = "default:dirt_with_grass",
	depth_top = 1,
	node_filler = "default:dirt",
	depth_filler = 3,
	node_dust = "air",
	
	height_min = -5,
	height_max = 80,
	heat_point = 45,
	humidity_point = 45,
})

minetest.register_biome({
	name = "desert",
	
	node_top = "default:desert_sand",
	depth_top = 1,
	node_filler = "default:desert_stone",
	depth_filler = 60,
	node_dust = "air",
	
	height_min = 4,
	height_max = 300,
	heat_point = 65,
	humidity_point = 35,
})

minetest.register_biome({
	name = "grass",
	
	node_top = "default:dirt_with_grass",
	depth_top = 1,
	node_filler = "default:dirt",
	depth_filler = 3,
	node_dust = "air",
	
	height_min = 5,
	height_max = 75,
	heat_point = 42,
	humidity_point = 47,
})

minetest.register_biome({
	name = "ocean",
	
	node_top = "default:dirt_with_grass",
	depth_top = 1,
	node_filler = "default:sand",
	depth_filler = 6,
	node_dust = "air",
	node_dust_water = "default:water_source",
	height_min = -5,
	height_max = -1000,
	heat_point = 45,
	humidity_point = 45,
})

minetest.register_biome({
	name = "beach",
	
	node_top = "default:sand",
	depth_top = 1,
	node_filler = "default:sand",
	depth_filler = 6,
	node_dust = "air",
	node_dust_water = "default:water_source",
	height_min = 5,
	height_max = -5,
	heat_point = 45,
	humidity_point = 45,
})

--spawn grasses (they don't work for some reason)

minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_grass",
	sidelen = 8,
	fill_ratio = 0.047,
	decoration = {"default:grass_1", "default:grass_2", "default:grass_3", "default:grass_4", "default:grass_5"},
	biomes = {"grass"},
	height = 1,
})