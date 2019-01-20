const
	MAX_OVERPASS = 16;

new Float:Overpass[][][] =
{
	{
		{ 2507.294, -1518.663, 21.226, -90.000 },
		{ 2507.294, -1518.663, 21.500, -90.000 },
		{ 2507.294, -1518.663, 22.000, -90.000 },
		{ 2507.294, -1518.663, 22.500, -90.000 },
		{ 2507.294, -1518.663, 23.000, -90.000 },
		{ 2506.494, -1521.115, 22.993, 0.000 }
	},
	{
		{ 2507.294, -1527.049, 21.226, -90.000 },
		{ 2507.294, -1527.049, 21.500, -90.000 },
		{ 2507.294, -1527.049, 22.000, -90.000 },
		{ 2507.294, -1527.049, 22.500, -90.000 },
		{ 2507.294, -1527.049, 23.000, -90.000 },
		{ 2504.548, -1529.103, 22.993, 0.000 }
	},
	{
		{ 979.500, -1369.300, 10.760, 0.000 },
		{ 979.500, -1369.300, 11.000, 0.000 },
		{ 979.500, -1369.300, 11.500, 0.000 },
		{ 979.500, -1369.300, 12.000, 0.000 },
		{ 979.500, -1369.300, 12.350, 0.000 },
		{ 982.312, -1366.652, 12.517, 0.000 }
	},
	{
		{ 975.599, -1369.300, 10.760, 0.000 },
		{ 975.599, -1369.300, 11.000, 0.000 },
		{ 975.599, -1369.300, 11.500, 0.000 },
		{ 975.599, -1369.300, 12.000, 0.000 },
		{ 975.599, -1369.300, 12.350, 0.000 },
		{ 972.890, -1370.904, 12.517, 0.000 }
	},
	{
		{ 966.700, -1371.500, 10.760, 0.000 },
		{ 966.700, -1371.500, 11.000, 0.000 },
		{ 966.700, -1371.500, 11.500, 0.000 },
		{ 966.700, -1371.500, 12.000, 0.000 },
		{ 966.700, -1371.500, 12.350, 0.000 },
		{ 969.421, -1368.893, 12.517, 0.000 }
	},
	{
		{ 962.400, -1371.500, 10.760, 0.000 },
		{ 962.400, -1371.500, 11.000, 0.000 },
		{ 962.400, -1371.500, 11.500, 0.000 },
		{ 962.400, -1371.500, 12.000, 0.000 },
		{ 962.400, -1371.500, 12.350, 0.000 },
		{ 964.403, -1374.567, 12.517, 0.000 }
	},
	{
		{ 1367.984, 196.872, 16.780, -23.819 },
		{ 1367.984, 196.872, 17.030, -23.819 },
		{ 1367.984, 196.872, 17.500, -23.819 },
		{ 1367.984, 196.872, 18.000, -23.819 },
		{ 1367.984, 196.872, 18.330, -23.819 },
		{ 1366.471, 199.991, 18.516, 0.000 }
	},
	{
		{ 1354.671, 201.387, 16.780, -23.819 },
		{ 1354.671, 201.387, 17.030, -23.819 },
		{ 1354.671, 201.387, 17.500, -23.819 },
		{ 1354.671, 201.387, 18.000, -23.819 },
		{ 1354.671, 201.387, 18.330, -23.819 },
		{ 1358.322, 203.018, 18.516, 0.000 }
	},
	{
		{ 2791.885742, -2434.262939, 10.8907, 90.0 },
		{ 2791.885742, -2434.262939, 11.15, 90.0 },
		{ 2791.885742, -2434.262939, 11.6, 90.0 },
		{ 2791.885742, -2434.262939, 12.1, 90.0 }, 
		{ 2791.885742, -2434.262939, 12.55, 90.0 },
		{ 2792.3262, -2436.6230, 12.8, 0.0 }
	},
	{
		{ 2791.544189, -2443.019531, 10.8907, 90.0 },
		{ 2791.544189, -2443.019531, 11.15, 90.0 },
		{ 2791.544189, -2443.019531, 11.6, 90.0 },
		{ 2791.544189, -2443.019531, 12.1, 90.0 },
		{ 2791.544189, -2443.019531, 12.55, 90.0 },
		{ 2792.1511, -2445.5559, 12.8, 0.0 }
	},
	{
		{ 2789.260742, -2461.669433, 10.8907, 0.0 },
		{ 2789.260742, -2461.669433, 11.15, 0.0 },
		{ 2789.260742, -2461.669433, 11.6, 0.0 },
		{ 2789.260742, -2461.669433, 12.1, 0.0 },
		{ 2789.260742, -2461.669433, 12.55, 0.0 },
		{ 2787.2368, -2457.9651, 12.8, 0.0 }
	},
	{
		{ 2799.527099, -2461.497314, 10.8907, 0.0 },
		{ 2799.527099, -2461.497314, 11.15, 0.0 },
		{ 2799.527099, -2461.497314, 11.6, 0.0 },
		{ 2799.527099, -2461.497314, 12.1, 0.0 },
		{ 2799.527099, -2461.497314, 12.55, 0.0 },
		{ 2796.5051, -2461.4187, 12.8, 0.0 }
	},
	{
		{ 2798.888671, -2478.118408, 10.8907, 0.0 },
		{ 2798.888671, -2478.118408, 11.15, 0.0 },
		{ 2798.888671, -2478.118408, 11.6, 0.0 },
		{ 2798.888671, -2478.118408, 12.1, 0.0 },
		{ 2798.888671, -2478.118408, 12.55, 0.0 },
		{ 2796.2458, -2476.7615, 12.8, 0.0 }
	},
	{
		{ 2787.905517, -2478.070312, 10.8907, 0.0 },
		{ 2787.905517, -2478.070312, 11.15, 0.0 },
		{ 2787.905517, -2478.070312, 11.6, 0.0 },
		{ 2787.905517, -2478.070312, 12.1, 0.0 },
		{ 2787.905517, -2478.070312, 12.55, 0.0 },
		{ 2785.4836, -2479.2659, 12.8, 0.0 }
	},
	{
		{ 2724.1, -2370.584228, 16.674501, -90.0 },
		{ 2726.5, -2370.584228, 16.674501, -90.0 },
		{ 2728.3, -2370.584228, 16.674501, -90.0 },
		{ 2730.2, -2370.584228, 16.674501, -90.0 },
		{ 2732.8, -2370.584228, 16.674501, -90.0 },
		{ 2723.9338, -2363.6824, 12.8, 0.0 }
	},
	{
		{ 2737.152343, -2589.8, 6.209868, 0.0 },
		{ 2737.152343, -2587.2, 6.209868, 0.0 },
		{ 2737.152343, -2585.5, 6.209868, 0.0 },
		{ 2737.152343, -2584.9, 6.209868, 0.0 },
		{ 2737.152343, -2582.3, 6.209868, 0.0 },
		{ 2743.9307,-2591.3240, 2.4, 0.0 }
	}
};

new
	o_overpass_id				[ MAX_OVERPASS ],
	o_overpass_status			[ MAX_OVERPASS ];