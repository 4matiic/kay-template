

return {
	-- 0	vehicle has no storage
	-- 1	vehicle has no trunk storage
	-- 2	vehicle has no glovebox storage
	-- 3	vehicle has trunk in the hood
	Storage = {
		[`jester`] = 3,
		[`adder`] = 3,
		[`osiris`] = 1,
		[`pfister811`] = 1,
		[`penetrator`] = 1,
		[`autarch`] = 1,
		[`bullet`] = 1,
		[`cheetah`] = 1,
		[`cyclone`] = 1,
		[`voltic`] = 1,
		[`reaper`] = 3,
		[`entityxf`] = 1,
		[`t20`] = 1,
		[`taipan`] = 1,
		[`tezeract`] = 1,
		[`torero`] = 3,
		[`turismor`] = 1,
		[`fmj`] = 1,
		[`infernus`] = 1,
		[`italigtb`] = 3,
		[`italigtb2`] = 3,
		[`nero2`] = 1,
		[`vacca`] = 3,
		[`vagner`] = 1,
		[`visione`] = 1,
		[`prototipo`] = 1,
		[`zentorno`] = 1,
		[`trophytruck`] = 0,
		[`trophytruck2`] = 0,
	},

	-- slots, maxWeight; default weight is 8000 per slot
	glovebox = {
		[0] = {10, 100},		-- Compact
		[1] = {10, 100},		-- Sedan
		[2] = {10, 100},		-- SUV
		[3] = {10, 100},		-- Coupe
		[4] = {10, 100},		-- Muscle
		[5] = {10, 100},		-- Sports Classic
		[6] = {10, 100},		-- Sports
		[7] = {10, 100},		-- Super
		[8] = {5, 100},		-- Motorcycle
		[9] = {11, 100},		-- Offroad
		[10] = {11, 100},		-- Industrial
		[11] = {11, 100},		-- Utility
		[12] = {11, 100},		-- Van
		[14] = {31, 100},	-- Boat
		[15] = {31, 100},	-- Helicopter
		[16] = {51, 100},	-- Plane
		[17] = {11, 100},		-- Service
		[18] = {11, 100},		-- Emergency
		[19] = {11, 100},		-- Military
		[20] = {11, 100},		-- Commercial (trucks)
		models = {
			[`xa21`] = {11, 100}
		}
	},

	trunk = {
		[0] = {60, 1000},		-- Compact
		[1] = {60, 1000},		-- Sedan
		[2] = {60, 1000},		-- SUV
		[3] = {60, 1000},		-- Coupe
		[4] = {60, 1000},		-- Muscle
		[5] = {60, 1000},		-- Sports Classic
		[6] = {60, 1000},		-- Sports
		[7] = {60, 1000},		-- Super
		[8] = {5, 1000},		-- Motorcycle
		[9] = {60, 1000},		-- Offroad
		[10] = {60, 1000},	-- Industrial
		[11] = {60, 1000},	-- Utility
		[12] = {60, 1000},	-- Van
		-- [14] -- Boat
		-- [15] -- Helicopter
		-- [16] -- Plane
		[17] = {60, 1000},	-- Service
		[18] = {60, 1000},	-- Emergency
		[19] = {60, 1000},	-- Military
		[20] = {61, 1000},	-- Commercial
		models = {
			[`xa21`] = {11, 1000}
		},
	}
}
