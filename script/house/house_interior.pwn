
stock getPlayerHouseID( playerid ) 
{
	for( new h; h < sizeof HouseInfo; h++ ) 
	{
		if( HouseInfo[h][hID] == Player[playerid][uHouseEvict] ) return h;
	}
	
	return -1;
}

stock loadHouseInterior( h ) 
{
	new 
		world = HouseInfo[ h ][hID],
		interior = HouseInfo[ h ][hInterior] - 1;
		
	switch( interior ) 
	{
		case 0: //Студия 1
		{
			HTextureWall[ h ][0][0] = CreateDynamicObject(19397, -505.70001, -2800.30005, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -504.54001, -2803.10010, 1601.83997,   0.00000, 0.00000, -135.0000, world );
			CreateDynamicObject(19369, -504.54001, -2797.50000, 1601.83997,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19369, -503.43100, -2794.82202, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -498.52499, -2793.30615, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -497.50000, -2792.75610, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -497.50000, -2799.17798, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -497.50000, -2805.60010, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -498.52499, -2807.29395, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][0][1] = CreateDynamicObject(19369, -503.42999, -2805.77808, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			
			HTextureWall[ h ][1][0] = CreateDynamicObject(19396, -497.32199, -2805.60010, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, -497.32199, -2799.17798, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, -492.42001, -2800.00000, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -493.50000, -2802.36011, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][1][1] = CreateDynamicObject(19460, -492.42001, -2807.26001, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			
			HTextureFloor[ h ][0][0] = CreateDynamicObject(19379, -500.54999, -2797.40991, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][0][1] = CreateDynamicObject(19379, -500.54999, -2807.04395, 1600.00000,   0.00000, 90.00000, 0.0000, world );
		
			HTextureFloor[ h ][1][0] = CreateDynamicObject(19378, -492.16199, -2807.04395, 1600.00305,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][1][1] = CreateDynamicObject(19378, -492.16199, -2797.40991, 1600.00305,   0.00000, 90.00000, 0.0000, world );
			
			HTextureRoof[ h ][0][0] = CreateDynamicObject(19381, -500.54999, -2807.04395, 1603.67505,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][0][1] = CreateDynamicObject(19381, -500.54999, -2797.40991, 1603.67505,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][1][0] = CreateDynamicObject(19380, -492.16000, -2802.39990, 1603.66895,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][1][1] = CreateDynamicObject(19380, -492.16000, -2802.39990, 1623.66895,   0.00000, 90.00000, 0.0000, world );
		}
		
		case 1: //Студия 2
		{
			HTextureWall[ h ][0][0] = CreateDynamicObject(19397, -495.10001, -2796.50000, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -496.79001, -2794.97998, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -498.48401, -2796.49609, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -495.10001, -2799.70996, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -496.79001, -2801.40503, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -503.21201, -2801.40503, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -504.56000, -2796.50000, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -499.81021, -2791.78003, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][0][1] = CreateDynamicObject(19369, -495.10001, -2793.29004, 2001.83997,   0.00000, 0.00000, 0.0000, world );

			HTextureWall[ h ][1][0] = CreateDynamicObject(19396, -496.79001, -2801.58301, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -495.10999, -2803.27002, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, -499.98999, -2804.94995, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -500.79999, -2803.27002, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][1][1] = CreateDynamicObject(19460, -503.21201, -2801.58301, 2001.83997,   0.00000, 0.00000, 90.0000, world );

			HTextureFloor[ h ][0][0] = CreateDynamicObject(19379, -499.97000, -2796.67603, 2000.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][0][1] = CreateDynamicObject(19379, -499.97000, -2796.67603, 2020.00000,   0.00000, 90.00000, 0.0000, world );
			
			HTextureFloor[ h ][1][0] = CreateDynamicObject(19378, -499.97000, -2806.31006, 2000.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][1][1] = CreateDynamicObject(19378, -499.97000, -2806.31006, 2020.00000,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][0][0] = CreateDynamicObject(19381, -499.97000, -2796.62012, 2003.68005,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][0][1] = CreateDynamicObject(19381, -499.97000, -2796.62012, 2023.68005,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][1][0] = CreateDynamicObject(19380, -499.97000, -2806.31006, 2003.68005,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][1][1] = CreateDynamicObject(19380, -499.97000, -2806.31006, 2023.68005,   0.00000, 90.00000, 0.0000, world );
		}
		
		case 2: //Студия 3
		{
			HTextureWall[ h ][0][0] = CreateDynamicObject(19397, -496.10001, -2796.10010, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -495.25800, -2794.40503, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -501.67999, -2794.40503, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -503.37000, -2799.31006, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -503.37000, -2808.94385, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -501.00201, -2805.53003, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -494.98999, -2804.37012, 2401.84009,   0.00000, 0.00000, 135.0000, world );
			CreateDynamicObject(19369, -493.82999, -2801.57007, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][0][1] = CreateDynamicObject(19369, -494.98999, -2798.77710, 2401.84009,   0.00000, 0.00000, 45.0000, world );

			HTextureWall[ h ][1][0] = CreateDynamicObject(19396, -501.67999, -2794.22705, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -495.25800, -2794.22705, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -497.56030, -2789.37012, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, -499.57999, -2789.76001, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -504.48001, -2791.44995, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][1][1] = CreateDynamicObject(19441, -503.89001, -2793.65991, 2401.84009,   0.00000, 0.00000, 45.0000, world );
			
			HTextureFloor[ h ][0][0] = CreateDynamicObject(19379, -499.14999, -2799.13379, 2400.00195,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][0][1] = CreateDynamicObject(19379, -499.14999, -2808.76782, 2400.00195,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][1][0] = CreateDynamicObject(19378, -499.14999, -2789.50098, 2400.00195,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][1][1] = CreateDynamicObject(19378, -499.14999, -2789.50098, 2420.00195,   0.00000, 90.00000, 0.0000, world );
			
			HTextureRoof[ h ][0][0] = CreateDynamicObject(19381, -499.14999, -2799.13208, 2403.67505,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][0][1] = CreateDynamicObject(19381, -499.14999, -2808.76587, 2403.67505,   0.00000, 90.00000, 0.0000, world );
			
			HTextureRoof[ h ][1][0] = CreateDynamicObject(19380, -499.14999, -2789.49902, 2403.67505,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][1][1] = CreateDynamicObject(19380, -499.14999, -2789.49902, 2423.67505,   0.00000, 90.00000, 0.0000, world );
		}
		
		case 3: //Студия 4
		{
			HTextureWall[ h ][0][0] = CreateDynamicObject(19397, -494.20001, -2798.80005, 3001.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -495.09100, -2797.28394, 3001.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -495.98300, -2795.76709, 3001.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -495.09100, -2800.31616, 3001.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -495.98300, -2801.83252, 3001.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -500.70999, -2803.52588, 3001.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -502.31201, -2802.63501, 3001.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -503.20401, -2801.92139, 3001.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -504.09161, -2798.80005, 3001.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -503.20401, -2795.67944, 3001.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -502.31201, -2794.96606, 3001.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -504.09201, -2794.07227, 3001.84009,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][0][1] = CreateDynamicObject(19397, -497.67001, -2794.07227, 3001.84009,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][1][0] = CreateDynamicObject(19396, -497.67001, -2793.89429, 3001.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -496.00000, -2792.21997, 3001.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -496.88000, -2790.55005, 3001.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -497.59351, -2789.65796, 3001.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, -502.48001, -2788.78003, 3001.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -501.70999, -2789.01001, 3001.84009,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][1][1] = CreateDynamicObject(19460, -504.09201, -2793.89429, 3001.84009,   0.00000, 0.00000, 90.0000, world );

			HTextureFloor[ h ][0][0] = CreateDynamicObject(19379, -499.20001, -2798.80005, 3000.00195,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][0][1] = CreateDynamicObject(19379, -499.20001, -2798.80005, 3020.00195,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][1][0] = CreateDynamicObject(19378, -499.20001, -2789.16602, 3000.00195,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][1][1] = CreateDynamicObject(19378, -499.20001, -2789.16602, 3020.00195,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][0][0] = CreateDynamicObject(19381, -499.20001, -2798.80005, 3003.67993,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][0][1] = CreateDynamicObject(19381, -499.20001, -2798.80005, 3023.67993,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][1][0] = CreateDynamicObject(19380, -499.20001, -2789.16602, 3003.67993,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][1][1] = CreateDynamicObject(19380, -499.20001, -2789.16602, 3023.67993,   0.00000, 90.00000, 0.0000, world );
		}
		
		case 4: //Студия 5
		{
			HTextureWall[ h ][0][0] = CreateDynamicObject(19397, -2707.37988, -2200.35010, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2707.37988, -2202.75806, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2706.50000, -2203.63989, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2705.61938, -2205.15845, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2699.69995, -2205.96997, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2698.98657, -2205.07788, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -2698.27319, -2205.96997, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -2700.71997, -2206.85010, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -2691.08618, -2206.85010, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -2691.76001, -2206.76001, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2693.43799, -2201.86255, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -2695.54858, -2201.32104, 2201.83789,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19461, -2696.09009, -2196.00000, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -2696.07007, -2195.28003, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2700.96362, -2196.96606, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2702.47998, -2198.65991, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][0][1] = CreateDynamicObject(19397, -2705.68994, -2198.65991, 2201.83789,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][1][0] = CreateDynamicObject(19396, -2705.68994, -2198.48193, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -2708.09009, -2198.31006, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -2708.96997, -2196.64990, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, -2707.31006, -2194.95996, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -2703.28101, -2198.48193, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][1][1] = CreateDynamicObject(19460, -2702.40991, -2193.59009, 2201.83789,   0.00000, 0.00000, 0.0000, world );

			HTextureFloor[ h ][0][0] = CreateDynamicObject(19379, -2706.91797, -2203.38696, 2200.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -2696.41797, -2203.38696, 2200.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][0][1] = CreateDynamicObject(19379, -2696.41797, -2193.75391, 2200.00000,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][1][0] = CreateDynamicObject(19378, -2706.91797, -2193.75391, 2200.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][1][1] = CreateDynamicObject(19378, -2706.91797, -2213.75391, 2200.00000,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][0][0] = CreateDynamicObject(19381, -2706.91797, -2203.38696, 2203.67505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -2696.41797, -2203.38696, 2203.67505,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][0][1] = CreateDynamicObject(19381, -2696.41797, -2193.75391, 2203.67505,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][1][0] = CreateDynamicObject(19380, -2706.91797, -2193.75391, 2203.67505,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][1][1] = CreateDynamicObject(19380, -2706.91797, -2193.75391, 2223.67505,   0.00000, 90.00000, 0.0000, world );
		}
		
		case 5: // Студия 6
		{
			HTextureWall[ h ][0][0] = CreateDynamicObject(19397, -1707.09998, -1496.30005, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -1706.20996, -1497.98999, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1707.09998, -1493.89197, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -1702.20996, -1493.01001, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -1692.57703, -1493.01001, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -1695.59998, -1497.91003, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -1696.48999, -1497.98999, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1697.38147, -1499.50647, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -1697.20996, -1501.18005, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1702.10754, -1499.50647, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][0][1] = CreateDynamicObject(19397, -1703.80200, -1497.98999, 2101.83789,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][1][0] = CreateDynamicObject(19396, -1703.80200, -1498.16797, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -1706.20996, -1498.16797, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -1707.08997, -1503.06006, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, -1707.02502, -1501.76001, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][1][1] = CreateDynamicObject(19460, -1702.12000, -1503.06006, 2101.83789,   0.00000, 0.00000, 0.0000, world );

			HTextureFloor[ h ][0][0] = CreateDynamicObject(19379, -1696.80005, -1493.26196, 2100.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][0][1] = CreateDynamicObject(19379, -1707.30005, -1493.26196, 2100.00000,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][1][0] = CreateDynamicObject(19376, -1696.80005, -1502.89600, 2100.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][1][1] = CreateDynamicObject(19376, -1696.80005, -1502.89600, 2120.00000,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][2][0] = CreateDynamicObject(19378, -1707.30005, -1502.89600, 2100.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][2][1] = CreateDynamicObject(19378, -1707.30005, -1502.89600, 2120.00000,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][0][0] = CreateDynamicObject(19381, -1707.30005, -1493.26196, 2103.67407,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -1696.80005, -1493.26196, 2103.67407,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][0][1] = CreateDynamicObject(19381, -1696.80005, -1502.89600, 2103.67407,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][1][0] = CreateDynamicObject(19380, -1707.30005, -1502.89600, 2103.67407,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][1][1] = CreateDynamicObject(19380, -1707.30005, -1502.89600, 2123.67407,   0.00000, 90.00000, 0.0000, world );
		}
		
		case 6: // Однокомнатная 1
		{
			HTextureWall[ h ][0][0] = CreateDynamicObject(19397, 2.00000, -2799.00000, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, 2.00000, -2792.57813, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -2.90600, -2793.75000, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -7.63400, -2795.62622, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -6.11770, -2800.53247, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -4.42400, -2805.26001, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2.73000, -2803.73999, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -1.03600, -2802.22510, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][0][1] = CreateDynamicObject(19369, 0.48000, -2800.53003, 1601.83997,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][1][0] = CreateDynamicObject(19395, -6.11770, -2800.71094, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19459, -7.81200, -2795.98291, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19367, -9.50600, -2797.19995, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19459, -11.18000, -2802.04395, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, -9.33500, -2806.94995, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][1][1] = CreateDynamicObject(19459, -4.43000, -2805.61499, 1601.83997,   0.00000, 0.00000, 0.0000, world );

			HTextureWall[ h ][2][0] = CreateDynamicObject(19396, -0.85800, -2802.22510, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -0.85800, -2805.43506, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, 0.49000, -2800.53394, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, 2.18000, -2805.21191, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][2][1] = CreateDynamicObject(19368, 0.65800, -2806.95190, 1601.83997,   0.00000, 0.00000, 90.0000, world );

			HTextureFloor[ h ][0][0] = CreateDynamicObject(19379, -2.73000, -2798.40991, 1600.00000,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor[ h ][0][1] = CreateDynamicObject(19379, -2.73000, -2798.40991, 1620.00000,   0.00000, 90.00000, -90.0000, world );

			HTextureFloor[ h ][1][0] = CreateDynamicObject(19376, -9.33500, -2805.87207, 1600.00305,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor[ h ][1][1] = CreateDynamicObject(19376, -12.54700, -2795.37207, 1600.00195,   0.00000, 90.00000, -90.0000, world );

			HTextureFloor[ h ][2][0] = CreateDynamicObject(19378, 3.86900, -2805.87012, 1600.00305,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor[ h ][2][1] = CreateDynamicObject(19378, 3.86900, -2805.87012, 1620.00305,   0.00000, 90.00000, -90.0000, world );

			HTextureRoof[ h ][0][0] = CreateDynamicObject(19381, -2.95000, -2800.50000, 1603.67700,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][0][1] = CreateDynamicObject(19381, -2.95000, -2790.86621, 1603.67700,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][1][0] = CreateDynamicObject(19377, -9.33500, -2805.87207, 1603.67297,   0.00000, 90.00000, -90.0000, world );
			HTextureRoof[ h ][1][1] = CreateDynamicObject(19377, -12.54700, -2795.37207, 1603.67297,   0.00000, 90.00000, -90.0000, world );

			HTextureRoof[ h ][2][0] = CreateDynamicObject(19380, 4.46000, -2805.40991, 1603.67297,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][2][1] = CreateDynamicObject(19380, 4.46000, -2805.40991, 1623.67297,   0.00000, 90.00000, 0.0000, world );
		}
		
		case 7: // Однокомнатная 2
		{
			HTextureWall[ h ][0][0] = CreateDynamicObject(19397, -3.40000, -2799.60010, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -3.40000, -2793.17798, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -1.71000, -2794.87207, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -0.19200, -2796.56812, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, 0.70000, -2798.08398, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, 1.59000, -2799.60010, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -0.10200, -2801.28003, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][0][1] = CreateDynamicObject(19442, -2.51000, -2801.28003, 2001.83997,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][1][0] = CreateDynamicObject(19395, -0.10200, -2801.45801, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19440, -2.51000, -2801.45801, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19459, -3.38000, -2806.36011, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, -3.33000, -2809.53003, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][1][1] = CreateDynamicObject(19459, 1.57000, -2806.36011, 2001.83997,   0.00000, 0.00000, 0.0000, world );

			HTextureWall[ h ][2][0] = CreateDynamicObject(19394, 1.76800, -2799.60010, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19438, 1.05450, -2797.90601, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19365, 0.17000, -2796.23999, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, 5.05000, -2794.83008, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, 7.00000, -2799.50000, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, 6.65000, -2804.44995, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][2][1] = CreateDynamicObject(19457, 1.76800, -2806.02197, 2001.83997,   0.00000, 0.00000, 0.0000, world );

			HTextureWall[ h ][3][0] = CreateDynamicObject(19396, -1.71000, -2794.69409, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -3.39000, -2789.79004, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, 1.51000, -2790.00000, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, 2.60000, -2789.79004, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][3][1] = CreateDynamicObject(19368, 1.50000, -2794.69409, 2001.83997,   0.00000, 0.00000, 90.0000, world );

			HTextureFloor[ h ][0][0] = CreateDynamicObject(19379, 1.76000, -2799.60010, 2000.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][0][1] = CreateDynamicObject(19379, 1.76000, -2799.60010, 2020.00000,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][1][0] = CreateDynamicObject(19376, -3.76000, -2806.18579, 2000.00305,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][1][1] = CreateDynamicObject(19376, -3.76000, -2806.18579, 2020.00305,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][2][0] = CreateDynamicObject(19462, 6.49400, -2799.58008, 2000.00305,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19462, 6.49400, -2803.07813, 2000.00305,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor[ h ][2][1] = CreateDynamicObject(19462, 4.86000, -2796.08008, 2000.00305,   0.00000, 90.00000, -90.0000, world );

			HTextureFloor[ h ][3][0] = CreateDynamicObject(19378, 1.76000, -2789.96777, 2000.00598,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][3][1] = CreateDynamicObject(19378, 1.76000, -2789.96777, 2020.00598,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][0][0] = CreateDynamicObject(19381, 1.76000, -2799.60010, 2003.67004,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][0][1] = CreateDynamicObject(19381, 1.76000, -2799.60010, 2023.67004,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][1][0] = CreateDynamicObject(19377, -3.76000, -2806.18579, 2003.66602,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][1][1] = CreateDynamicObject(19377, -3.76000, -2806.18579, 2023.66602,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][2][0] = CreateDynamicObject(19380, 1.76000, -2789.96582, 2003.67004,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][2][1] = CreateDynamicObject(19380, 1.76000, -2789.96582, 2023.67004,   0.00000, 90.00000, 0.0000, world );
		}
		
		case 8: // Однокомнатная 3
		{
			HTextureWall[ h ][0][0] = CreateDynamicObject(19397, -5.50000, -2799.10010, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -6.04170, -2801.21045, 2401.84009,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19442, -6.63000, -2802.62988, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -6.04170, -2804.05005, 2401.84009,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19461, -5.24000, -2804.63989, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -0.33500, -2805.51807, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, 1.36000, -2800.79004, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, 2.86180, -2799.10010, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, 1.18150, -2797.43091, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -0.33500, -2795.73608, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -0.33500, -2792.52588, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -5.24000, -2793.56006, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -6.04160, -2794.14990, 2401.84009,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19442, -6.63000, -2795.57007, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][0][1] = CreateDynamicObject(19442, -6.04160, -2796.98999, 2401.84009,   0.00000, 0.00000, 45.0000, world );

			HTextureWall[ h ][1][0] = CreateDynamicObject(19395, -0.15700, -2795.73608, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19367, -0.15700, -2792.52588, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, 4.75000, -2791.01001, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19459, 7.15000, -2792.51489, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][1][1] = CreateDynamicObject(19459, 4.74800, -2797.41992, 2401.84009,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][2][0] = CreateDynamicObject(19396, 1.36000, -2800.96802, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, 4.57000, -2800.96802, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, 6.10000, -2802.65991, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, 4.58000, -2804.35010, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][2][1] = CreateDynamicObject(19460, -0.32000, -2805.86011, 2401.84009,   0.00000, 0.00000, 0.0000, world );

			HTextureFloor[ h ][0][0] = CreateDynamicObject(19379, -5.11200, -2806.12988, 2400.00000,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor[ h ][0][1] = CreateDynamicObject(19379, -1.90000, -2795.63013, 2400.00000,   0.00000, 90.00000, -90.0000, world );

			HTextureFloor[ h ][1][0] = CreateDynamicObject(19376, 4.57000, -2792.13989, 2400.00195,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor[ h ][1][1] = CreateDynamicObject(19376, 4.57000, -2792.13989, 2420.00195,   0.00000, 90.00000, -90.0000, world );

			HTextureFloor[ h ][2][0] = CreateDynamicObject(19378, 4.50000, -2806.12720, 2400.00000,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor[ h ][2][1] = CreateDynamicObject(19378, 4.50000, -2806.12720, 2420.00000,   0.00000, 90.00000, -90.0000, world );

			HTextureRoof[ h ][0][0] = CreateDynamicObject(19381, 4.40000, -2795.80005, 2403.67749,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19381, -5.23400, -2795.80005, 2403.67749,   0.00000, 90.00000, -90.0000, world );
			HTextureRoof[ h ][0][1] = CreateDynamicObject(19381, -5.23400, -2806.30005, 2403.67749,   0.00000, 90.00000, -90.0000, world );

			HTextureRoof[ h ][1][0] = CreateDynamicObject(19377, 4.72000, -2792.08008, 2403.67334,   0.00000, 90.00000, -90.0000, world );
			HTextureRoof[ h ][1][1] = CreateDynamicObject(19377, 4.72000, -2792.08008, 2423.67334,   0.00000, 90.00000, -90.0000, world );

			HTextureRoof[ h ][2][0] = CreateDynamicObject(19380, 4.40000, -2806.30005, 2403.67749,   0.00000, 90.00000, -90.0000, world );
			HTextureRoof[ h ][2][1] = CreateDynamicObject(19380, 4.40000, -2806.30005, 2423.67749,   0.00000, 90.00000, -90.0000, world );
		}
		
		case 9:  // Однокомнатная 4
		{
			HTextureWall[ h ][0][0] = CreateDynamicObject(19397, -2705.00000, -1506.00000, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -2705.17798, -1509.20996, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -2703.48999, -1510.89001, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -2701.80005, -1514.00000, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -2700.10620, -1509.27197, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2696.89600, -1509.27197, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -2695.21997, -1504.37000, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][0][1] = CreateDynamicObject(19461, -2700.12012, -1504.31995, 1601.83801,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][1][0] = CreateDynamicObject(19394, -2705.35596, -1509.20996, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, -2705.35596, -1515.63196, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19438, -2706.23511, -1514.32214, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, -2711.85205, -1514.50000, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, -2711.89990, -1512.43005, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][1][1] = CreateDynamicObject(19457, -2710.25000, -1507.53003, 1601.83801,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][2][0] = CreateDynamicObject(19396, -2700.10620, -1509.44995, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -2701.79492, -1514.34998, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, -2696.89990, -1514.50000, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -2695.21997, -1514.34998, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][2][1] = CreateDynamicObject(19368, -2696.89600, -1509.44995, 1601.83801,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][3][0] = CreateDynamicObject(19395, -2703.48999, -1511.06799, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19459, -2701.81006, -1515.96997, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19367, -2703.48999, -1515.59998, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][3][1] = CreateDynamicObject(19459, -2705.17505, -1515.96997, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			
			HTextureFloor[ h ][0][0] = CreateDynamicObject(19379, -2700.01807, -1509.19995, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][0][1] = CreateDynamicObject(19379, -2700.01807, -1509.19995, 1620.00000,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][1][0] = CreateDynamicObject(19378, -2710.51807, -1512.41199, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][1][1] = CreateDynamicObject(19378, -2710.51807, -1512.41199, 1620.00000,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][2][0] = CreateDynamicObject(19376, -2696.61597, -1514.17603, 1600.00305,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][2][1] = CreateDynamicObject(19376, -2696.61597, -1514.17603, 1620.00305,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][3][0] = CreateDynamicObject(19462, -2703.48999, -1515.79602, 1600.00305,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][3][1] = CreateDynamicObject(19462, -2703.48999, -1515.79602, 1620.00305,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][0][0] = CreateDynamicObject(19381, -2700.01807, -1509.19995, 1603.67505,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][0][1] = CreateDynamicObject(19381, -2700.01807, -1509.19995, 1623.67505,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][1][0] = CreateDynamicObject(19380, -2710.51807, -1512.41199, 1603.67505,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][1][1] = CreateDynamicObject(19380, -2710.51807, -1512.41199, 1623.67505,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][2][0] = CreateDynamicObject(19377, -2696.61597, -1514.17603, 1603.67102,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][2][1] = CreateDynamicObject(19377, -2696.61597, -1514.17603, 1623.67102,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][3][0] = CreateDynamicObject(19454, -2703.48999, -1515.79602, 1603.67102,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][3][1] = CreateDynamicObject(19454, -2703.48999, -1515.79602, 1623.67102,   0.00000, 90.00000, 0.0000, world );
		}
		
		case 10:  // Однокомнатная 5
		{
			HTextureWall[ h ][0][0] = CreateDynamicObject(19397, -2204.07007, -1496.59998, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2204.78345, -1498.29504, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2202.37988, -1494.92004, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2200.69995, -1496.59998, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -2205.66992, -1503.18994, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -2207.51392, -1506.31995, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -2197.87988, -1506.31995, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -2193.00000, -1504.63196, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2193.00000, -1501.42212, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -2193.00000, -1498.21204, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2193.00000, -1495.80505, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -2194.37012, -1494.92004, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2199.27295, -1496.59998, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][0][1] = CreateDynamicObject(19442, -2199.98657, -1498.29504, 1601.83801,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][1][0] = CreateDynamicObject(19396, -2192.82202, -1504.63196, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -2192.82202, -1501.42212, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, -2187.91992, -1499.84802, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -2186.84009, -1504.75000, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][1][1] = CreateDynamicObject(19460, -2187.92993, -1506.31006, 1601.83801,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][2][0] = CreateDynamicObject(19395, -2192.82202, -1498.21204, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19440, -2192.82202, -1495.80505, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19367, -2191.13013, -1494.92505, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19440, -2189.43994, -1495.81006, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19440, -2188.72656, -1496.70203, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19459, -2187.83691, -1494.92004, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][2][1] = CreateDynamicObject(19459, -2187.91992, -1499.82605, 1601.83801,   0.00000, 0.00000, 90.0000, world );

			HTextureFloor[ h ][0][0] = CreateDynamicObject(19379, -2206.03784, -1493.56604, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -2195.53784, -1503.19995, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][0][1] = CreateDynamicObject(19379, -2195.53784, -1493.56604, 1600.00000,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][1][0] = CreateDynamicObject(19378, -2206.03784, -1503.19995, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][1][1] = CreateDynamicObject(19378, -2206.03784, -1503.19995, 1620.00000,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][2][0] = CreateDynamicObject(19376, -2187.66089, -1504.70996, 1600.00305,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][2][1] = CreateDynamicObject(19376, -2187.66089, -1504.70996, 1620.00305,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][3][0] = CreateDynamicObject(19375, -2187.66089, -1494.94995, 1600.00305,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][3][1] = CreateDynamicObject(19375, -2187.66089, -1494.94995, 1620.00305,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][0][0] = CreateDynamicObject(19381, -2206.03784, -1493.56604, 1603.67505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -2195.53784, -1493.56604, 1603.67505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -2206.03784, -1503.19995, 1603.67505,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][0][1] = CreateDynamicObject(19381, -2195.53784, -1503.19995, 1603.67505,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][1][0] = CreateDynamicObject(19380, -2187.66089, -1504.70996, 1603.67102,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][1][1] = CreateDynamicObject(19380, -2187.66089, -1504.70996, 1623.67102,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][2][0] = CreateDynamicObject(19377, -2187.66089, -1494.94995, 1603.67102,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][2][1] = CreateDynamicObject(19377, -2187.66089, -1494.94995, 1623.67102,   0.00000, 90.00000, 0.0000, world );
		}
		
		case 11: // Однокомнатная 6
		{
			HTextureWall[ h ][0][0] = CreateDynamicObject(19397, -2207.19995, -1496.30005, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2205.51001, -1494.60999, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -2203.83008, -1495.50000, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2202.93799, -1496.21375, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -2202.05005, -1501.10999, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2203.73511, -1506.00000, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -2205.42920, -1506.71350, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -2207.12012, -1507.59998, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -2208.81006, -1505.91003, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -2213.53760, -1504.21497, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -2213.58008, -1499.31006, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][0][1] = CreateDynamicObject(19461, -2211.92798, -1497.99500, 2101.83789,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][1][0] = CreateDynamicObject(19396, -2208.98779, -1505.91003, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -2209.87012, -1507.59998, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -2210.58398, -1509.29504, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, -2215.47998, -1510.96997, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -2216.50000, -1509.13000, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][1][1] = CreateDynamicObject(19460, -2213.87988, -1504.22998, 2101.83789,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][2][0] = CreateDynamicObject(19395, -2207.12012, -1507.77795, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19367, -2203.91016, -1507.77795, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19367, -2202.22998, -1509.45996, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, -2203.91016, -1511.13000, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][2][1] = CreateDynamicObject(19367, -2208.81006, -1509.45996, 2101.83789,   0.00000, 0.00000, 0.0000, world );

			HTextureFloor[ h ][0][0] = CreateDynamicObject(19379, -2207.14990, -1499.30005, 2100.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -2217.64990, -1499.30005, 2100.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -2217.64990, -1508.93396, 2100.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][0][1] = CreateDynamicObject(19379, -2207.14990, -1508.93396, 2100.00000,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][1][0] = CreateDynamicObject(19378, -2214.14795, -1509.12000, 2100.00293,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][1][1] = CreateDynamicObject(19378, -2214.14795, -1509.12000, 2120.00293,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][2][0] = CreateDynamicObject(19376, -2203.49512, -1512.50598, 2100.00293,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][2][1] = CreateDynamicObject(19376, -2203.49512, -1512.50598, 2120.00293,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][0][0] = CreateDynamicObject(19381, -2217.64990, -1499.30005, 2103.67505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -2217.64990, -1508.93396, 2103.67505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -2207.14990, -1508.93396, 2103.67505,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][0][1] = CreateDynamicObject(19381, -2207.14990, -1499.30005, 2103.67505,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][1][0] = CreateDynamicObject(19377, -2203.49512, -1512.50598, 2103.67090,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][1][1] = CreateDynamicObject(19377, -2203.49512, -1512.50598, 2123.67090,   0.00000, 90.00000, 0.0000, world );
		}
		
		case 12: // Однокомнатная 7
		{
			HTextureWall[ h ][0][0] = CreateDynamicObject(19397, -1707.59998, -1502.97998, 2701.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -1707.90210, -1501.30005, 2701.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -1701.48010, -1501.30005, 2701.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1699.78601, -1500.58655, 2701.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1698.09399, -1499.69995, 2701.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -1696.40796, -1501.36011, 2701.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -1696.40796, -1503.76794, 2701.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1699.78601, -1506.35486, 2701.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -1700.50000, -1504.66003, 2701.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -1706.84998, -1509.56006, 2701.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1705.92004, -1504.66003, 2701.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1705.96802, -1511.50000, 2701.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1704.66003, -1512.04150, 2701.83789,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19369, -1702.43005, -1512.63000, 2701.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1700.19995, -1512.04150, 2701.83789,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19369, -1698.08997, -1511.50000, 2701.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1695.98010, -1512.04150, 2701.83789,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19369, -1693.75000, -1512.63000, 2701.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -1692.06006, -1507.81006, 2701.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][0][1] = CreateDynamicObject(19461, -1691.68005, -1504.66003, 2701.83789,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][1][0] = CreateDynamicObject(19396, -1696.22998, -1501.36011, 2701.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, -1691.32996, -1503.05005, 2701.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -1696.22998, -1498.15002, 2701.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, -1691.32996, -1496.46997, 2701.83789,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][1][1] = CreateDynamicObject(19460, -1691.34998, -1498.15002, 2701.83789,   0.00000, 0.00000, 0.0000, world );

			HTextureWall[ h ][2][0] = CreateDynamicObject(19395, -1701.48010, -1501.12195, 2701.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19440, -1703.88794, -1501.12195, 2701.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19367, -1704.77502, -1499.43994, 2701.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19440, -1704.18799, -1497.21997, 2701.83789,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19459, -1704.69995, -1496.63000, 2701.83789,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][2][1] = CreateDynamicObject(19459, -1699.80005, -1496.21997, 2701.83789,   0.00000, 0.00000, 0.0000, world );

			HTextureFloor[ h ][0][0] = CreateDynamicObject(19379, -1702.65002, -1504.55005, 2700.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -1702.65002, -1514.18396, 2700.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -1692.14990, -1514.18396, 2700.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][0][1] = CreateDynamicObject(19379, -1692.14990, -1504.55005, 2700.00000,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][1][0] = CreateDynamicObject(19378, -1691.50195, -1497.72754, 2700.00293,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor[ h ][1][1] = CreateDynamicObject(19378, -1691.50195, -1497.72754, 2720.00293,   0.00000, 90.00000, -90.0000, world );

			HTextureFloor[ h ][2][0] = CreateDynamicObject(19376, -1704.69995, -1495.96204, 2700.00293,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor[ h ][2][1] = CreateDynamicObject(19376, -1704.69995, -1495.96204, 2720.00293,   0.00000, 90.00000, -90.0000, world );

			HTextureRoof[ h ][0][0] = CreateDynamicObject(19381, -1702.65002, -1504.55005, 2703.67505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -1702.65002, -1514.18396, 2703.67505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -1692.14990, -1514.18396, 2703.67505,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][0][1] = CreateDynamicObject(19381, -1692.14990, -1504.55005, 2703.67505,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][1][0] = CreateDynamicObject(19380, -1691.50195, -1497.72754, 2703.67090,   0.00000, 90.00000, -90.0000, world );
			HTextureRoof[ h ][1][1] = CreateDynamicObject(19380, -1691.50195, -1497.72754, 2723.67090,   0.00000, 90.00000, -90.0000, world );

			HTextureRoof[ h ][2][0] = CreateDynamicObject(19377, -1704.69995, -1495.96204, 2703.67090,   0.00000, 90.00000, -90.0000, world );
			HTextureRoof[ h ][2][1] = CreateDynamicObject(19377, -1704.69995, -1495.96204, 2723.67090,   0.00000, 90.00000, -90.0000, world );
		}
		
		case 13: // Однокомнатная 8
		{
			HTextureWall[ h ][0][0] = CreateDynamicObject(19397, -2697.60010, -1503.50000, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2698.48999, -1501.81006, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2699.20361, -1500.11597, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -2700.88989, -1498.43005, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2702.58398, -1496.91296, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -2707.47998, -1495.43994, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2711.21997, -1496.69995, 2601.83789,   0.00000, 0.00000, -40.0000, world );
			CreateDynamicObject(19369, -2711.01489, -1499.07495, 2601.83789,   0.00000, 0.00000, 50.0000, world );
			CreateDynamicObject(19442, -2708.92944, -1500.12634, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -2708.03735, -1504.85413, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -2707.31201, -1505.18005, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -2700.88989, -1505.18005, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][0][1] = CreateDynamicObject(19442, -2698.48193, -1505.18005, 2601.83789,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][1][0] = CreateDynamicObject(19396, -2700.88989, -1505.35815, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -2698.48193, -1505.35815, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -2697.60010, -1510.26001, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, -2702.44995, -1511.30005, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -2707.30005, -1510.26001, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][1][1] = CreateDynamicObject(19460, -2707.31201, -1505.35815, 2601.83789,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][2][0] = CreateDynamicObject(19395, -2700.88989, -1498.25220, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19440, -2698.48193, -1498.25220, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19459, -2697.60010, -1493.34998, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, -2696.53003, -1493.82996, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19440, -2701.96997, -1494.42004, 2601.83789,   0.00000, 0.00000, 135.0000, world );
			HTextureWall[ h ][2][1] = CreateDynamicObject(19459, -2702.56006, -1493.34998, 2601.83789,   0.00000, 0.00000, 0.0000, world );

			HTextureFloor[ h ][0][0] = CreateDynamicObject(19379, -2702.44995, -1500.44788, 2600.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -2712.94995, -1500.44788, 2600.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -2702.44995, -1490.81494, 2600.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][0][1] = CreateDynamicObject(19379, -2712.94995, -1490.81494, 2600.00000,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][1][0] = CreateDynamicObject(19378, -2702.44995, -1510.08203, 2600.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][1][1] = CreateDynamicObject(19378, -2702.44995, -1510.08203, 2620.00000,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][2][0] = CreateDynamicObject(19376, -2697.64990, -1493.09253, 2600.00293,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor[ h ][2][1] = CreateDynamicObject(19376, -2697.64990, -1493.09253, 2620.00293,   0.00000, 90.00000, 90.0000, world );

			HTextureRoof[ h ][0][0] = CreateDynamicObject(19381, -2702.44995, -1500.31384, 2603.67407,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][0][1] = CreateDynamicObject(19381, -2712.94995, -1500.31384, 2603.67407,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][1][0] = CreateDynamicObject(19380, -2702.44995, -1510.08203, 2603.67407,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][1][1] = CreateDynamicObject(19380, -2702.44995, -1510.08203, 2623.67407,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][2][0] = CreateDynamicObject(19377, -2697.64990, -1493.09045, 2603.67017,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof[ h ][2][1] = CreateDynamicObject(19377, -2697.64990, -1493.09045, 2623.67017,   0.00000, 90.00000, 90.0000, world );
		}
		
		case 14: // Двухкомнатная 1
		{
			HTextureWall[ h ][0][0] = CreateDynamicObject(19397, 503.75000, -2802.50000, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, 503.75000, -2804.90796, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, 502.23499, -2805.80005, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, 500.71899, -2807.49512, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, 500.71899, -2810.70605, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, 499.20270, -2812.39990, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, 497.51001, -2815.52197, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, 497.51001, -2809.10010, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, 497.51001, -2806.69189, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, 492.78201, -2805.80005, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, 496.00000, -2804.10498, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, 496.00000, -2797.68188, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, 500.89999, -2798.00000, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][0][1] = CreateDynamicObject(19369, 503.75000, -2799.29004, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			
			HTextureWall[ h ][1][0] = CreateDynamicObject(19395, 495.82199, -2804.10498, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, 490.92001, -2805.79004, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19459, 490.85999, -2800.89502, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, 490.92001, -2800.35010, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][1][1] = CreateDynamicObject(19459, 495.82199, -2797.68188, 1601.83997,   0.00000, 0.00000, 0.0000, world );

			HTextureWall[ h ][2][0] = CreateDynamicObject(19394, 497.33200, -2809.10010, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, 497.33200, -2815.52197, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, 492.42999, -2812.39990, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, 490.50000, -2810.71997, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, 492.42999, -2805.82007, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][2][1] = CreateDynamicObject(19438, 497.33200, -2806.69189, 1601.83997,   0.00000, 0.00000, 0.0000, world );

			HTextureWall[ h ][3][0] = CreateDynamicObject(19396, 499.20270, -2812.57788, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, 500.89600, -2811.06152, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, 502.41650, -2810.65625, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, 503.91940, -2810.58325, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, 502.41501, -2815.43994, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][3][1] = CreateDynamicObject(19460, 497.53000, -2817.47998, 1601.83997,   0.00000, 0.00000, 0.0000, world );

			HTextureFloor[ h ][0][0] = CreateDynamicObject(19379, 501.16000, -2801.03589, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][0][1] = CreateDynamicObject(19379, 501.16000, -2810.66992, 1600.00000,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][1][0] = CreateDynamicObject(19378, 490.66199, -2801.03589, 1600.00195,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][1][1] = CreateDynamicObject(19378, 490.66199, -2801.03589, 1620.00195,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][2][0] = CreateDynamicObject(19375, 492.17200, -2810.66992, 1600.00305,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][2][1] = CreateDynamicObject(19375, 492.17200, -2810.66992, 1620.00305,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][3][0] = CreateDynamicObject(19376, 495.70001, -2817.30420, 1600.00195,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][3][1] = CreateDynamicObject(19376, 506.20001, -2814.09229, 1600.00195,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][0][0] = CreateDynamicObject(19381, 501.16000, -2801.03589, 1603.67505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, 501.16000, -2810.66992, 1603.67505,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][0][1] = CreateDynamicObject(19381, 490.66000, -2810.66992, 1603.67505,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][1][0] = CreateDynamicObject(19377, 490.66000, -2801.03589, 1603.67505,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][1][1] = CreateDynamicObject(19377, 490.66000, -2801.03589, 1623.67505,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][2][0] = CreateDynamicObject(19454, 495.67200, -2810.66992, 1603.67004,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][2][1] = CreateDynamicObject(19454, 492.17200, -2810.66992, 1603.67004,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][3][0] = CreateDynamicObject(19380, 506.20001, -2814.09619, 1603.67004,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][3][1] = CreateDynamicObject(19380, 495.70001, -2817.30811, 1603.67004,   0.00000, 90.00000, 0.0000, world );
		}
		
		case 15: // Двухкомнатная 2
		{
			HTextureWall[ h ][0][0] = CreateDynamicObject(19397, 504.20001, -2805.94995, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, 497.39999, -2807.64502, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, 507.03400, -2807.64502, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, 492.50000, -2805.73608, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, 492.50000, -2799.31494, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, 497.39999, -2797.65503, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, 500.89999, -2804.42993, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, 503.31000, -2804.42993, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, 498.49399, -2804.42993, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, 497.78049, -2802.73608, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, 502.50851, -2801.04102, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, 503.45001, -2799.34595, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][0][1] = CreateDynamicObject(19461, 507.03400, -2797.65503, 2001.83997,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][1][0] = CreateDynamicObject(19395, 492.32199, -2799.31494, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, 492.32199, -2805.73608, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, 487.42999, -2807.44995, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19395, 490.62500, -2804.35010, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19367, 487.41400, -2804.35010, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19459, 485.79999, -2802.56006, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][1][1] = CreateDynamicObject(19459, 487.42999, -2797.65503, 2001.83997,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][2][0] = CreateDynamicObject(19441, 503.31000, -2804.25195, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, 504.20001, -2802.73608, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, 502.69299, -2801.05005, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, 497.79001, -2802.73608, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, 498.49799, -2804.25391, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][2][1] = CreateDynamicObject(19396, 500.89999, -2804.25195, 2001.83997,   0.00000, 0.00000, 90.0000, world );

			HTextureFloor[ h ][0][0] = CreateDynamicObject(19379, 499.48001, -2802.31006, 2000.00000,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor[ h ][0][1] = CreateDynamicObject(19379, 489.84601, -2802.31006, 2000.00000,   0.00000, 90.00000, 90.0000, world );

			HTextureFloor[ h ][1][0] = CreateDynamicObject(19378, 487.59500, -2802.31006, 2000.00305,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor[ h ][1][1] = CreateDynamicObject(19378, 487.59500, -2802.31006, 2020.00305,   0.00000, 90.00000, 90.0000, world );

			HTextureFloor[ h ][2][0] = CreateDynamicObject(19366, 499.62000, -2802.73608, 2000.00195,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][2][1] = CreateDynamicObject(19366, 503.12000, -2802.73608, 2000.00195,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][0][0] = CreateDynamicObject(19381, 499.48001, -2802.31006, 2003.67505,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof[ h ][0][1] = CreateDynamicObject(19381, 489.84601, -2802.31006, 2003.67505,   0.00000, 90.00000, 90.0000, world );

			HTextureRoof[ h ][1][0] = CreateDynamicObject(19380, 487.42999, -2802.97998, 2003.67102,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof[ h ][1][1] = CreateDynamicObject(19380, 487.42999, -2802.97998, 2023.67102,   0.00000, 90.00000, 90.0000, world );

			HTextureRoof[ h ][2][0] = CreateDynamicObject(19372, 499.62000, -2802.73608, 2003.67004,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][2][1] = CreateDynamicObject(19372, 503.12000, -2802.73608, 2003.67004,   0.00000, 90.00000, 0.0000, world );
		}
		
		case 16: // Двухкомнатная 3
		{
			HTextureWall[ h ][0][0] = CreateDynamicObject(19397, 505.39999, -2796.60010, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, 504.51001, -2795.08496, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, 504.51001, -2797.94531, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, 500.82700, -2801.28003, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, 495.92700, -2802.16992, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, 494.00000, -2799.98999, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, 495.68201, -2795.08496, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, 498.89200, -2795.08496, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][0][1] = CreateDynamicObject(19397, 502.10199, -2795.08496, 2401.84009,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][1][0] = CreateDynamicObject(19438, 504.51401, -2797.94922, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, 505.39001, -2802.84912, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, 505.72699, -2802.16992, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][1][1] = CreateDynamicObject(19438, 500.83099, -2801.28394, 2401.84009,   0.00000, 0.00000, 0.0000, world );

			HTextureWall[ h ][2][0] = CreateDynamicObject(19395, 495.68201, -2794.90698, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19459, 494.00000, -2790.00195, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, 495.59048, -2788.48047, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19459, 500.48999, -2790.00195, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][2][1] = CreateDynamicObject(19367, 498.89200, -2794.90698, 2401.84009,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][3][0] = CreateDynamicObject(19396, 502.10199, -2794.90698, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, 504.51001, -2794.90698, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, 505.39999, -2793.21997, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, 505.39999, -2791.55005, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][3][1] = CreateDynamicObject(19460, 500.50000, -2790.00195, 2401.84009,   0.00000, 0.00000, 0.0000, world );

			HTextureFloor[ h ][0][0] = CreateDynamicObject(19379, 500.67999, -2796.83618, 2400.00000,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor[ h ][0][1] = CreateDynamicObject(19379, 491.04599, -2796.83008, 2400.00000,   0.00000, 90.00000, 90.0000, world );

			HTextureFloor[ h ][1][0] = CreateDynamicObject(19376, 505.73001, -2803.28003, 2400.00195,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor[ h ][1][1] = CreateDynamicObject(19376, 505.73001, -2803.28003, 2420.00195,   0.00000, 90.00000, 90.0000, world );

			HTextureFloor[ h ][2][0] = CreateDynamicObject(19375, 495.20001, -2790.18188, 2400.00195,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][2][1] = CreateDynamicObject(19375, 495.20001, -2790.18188, 2420.00195,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][3][0] = CreateDynamicObject(19378, 505.35001, -2789.75000, 2400.00195,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor[ h ][3][1] = CreateDynamicObject(19378, 505.35001, -2789.75000, 2420.00195,   0.00000, 90.00000, 90.0000, world );

			HTextureRoof[ h ][0][0] = CreateDynamicObject(19381, 500.67999, -2796.83618, 2403.67505,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof[ h ][0][1] = CreateDynamicObject(19381, 491.04599, -2796.83008, 2403.67505,   0.00000, 90.00000, 90.0000, world );

			HTextureRoof[ h ][1][0] = CreateDynamicObject(19377, 495.20001, -2790.17993, 2403.66992,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][1][1] = CreateDynamicObject(19377, 495.20001, -2790.17993, 2423.66992,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][2][0] = CreateDynamicObject(19380, 505.35001, -2789.75000, 2403.66992,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof[ h ][2][1] = CreateDynamicObject(19380, 505.35001, -2789.75000, 2423.66992,   0.00000, 90.00000, 90.0000, world );
		}
		
		case 17: // Двухкомнатная 4
		{
			HTextureWall[ h ][0][0] = CreateDynamicObject(19397, -2707.00000, -1498.00000, 2001.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2706.11011, -1499.68994, 2001.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -2702.02539, -1497.19800, 2001.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2701.31201, -1498.08997, 2001.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -2700.59839, -1497.19800, 2001.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -2702.10010, -1496.31006, 2001.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -2692.46582, -1496.31006, 2001.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -2695.00537, -1497.19800, 2001.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2694.29199, -1498.08997, 2001.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -2693.39990, -1499.74597, 2001.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -2693.39990, -1509.38000, 2001.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -2697.30005, -1514.28003, 2001.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -2702.19995, -1512.59204, 2001.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2701.30908, -1507.88000, 2001.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2702.19995, -1509.38000, 2001.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2700.41992, -1506.18604, 2001.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2700.41992, -1502.97595, 2001.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2701.31201, -1501.45996, 2001.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -2703.71997, -1501.45996, 2001.83801,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][0][1] = CreateDynamicObject(19442, -2705.39697, -1500.58191, 2001.83801,   0.00000, 0.00000, 0.0000, world );

			HTextureWall[ h ][1][0] = CreateDynamicObject(19395, -2702.37793, -1512.59204, 2001.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, -2707.28003, -1514.28003, 2001.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19459, -2710.21997, -1512.90002, 2001.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19395, -2708.55591, -1508.03394, 2001.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19440, -2706.14795, -1508.03394, 2001.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19395, -2703.73999, -1508.03394, 2001.83801,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][1][1] = CreateDynamicObject(19367, -2702.37793, -1509.38000, 2001.83801,   0.00000, 0.00000, 0.0000, world );

			HTextureWall[ h ][2][0] = CreateDynamicObject(19396, -2703.71997, -1501.63794, 2001.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -2701.31201, -1501.63794, 2001.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -2700.42993, -1503.09998, 2001.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -2700.42993, -1505.50806, 2001.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -2701.32007, -1506.25195, 2001.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -2702.21240, -1506.96545, 2001.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19396, -2703.73999, -1507.85596, 2001.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -2706.14795, -1507.85596, 2001.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -2706.80005, -1506.35010, 2001.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -2706.80005, -1503.14014, 2001.83801,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][2][1] = CreateDynamicObject(19441, -2706.12793, -1501.63794, 2001.83801,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][3][0] = CreateDynamicObject(19394, -2708.55591, -1507.85596, 2001.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19365, -2706.87012, -1506.16602, 2001.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19365, -2706.87012, -1502.95605, 2001.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, -2710.21997, -1503.00000, 2001.83801,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][3][1] = CreateDynamicObject(19365, -2708.55591, -1501.28003, 2001.83801,   0.00000, 0.00000, 90.0000, world );

			HTextureFloor[ h ][0][0] = CreateDynamicObject(19379, -2707.54004, -1499.96594, 2000.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -2697.04004, -1499.96594, 2000.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][0][1] = CreateDynamicObject(19379, -2697.04004, -1509.59998, 2000.00000,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][1][0] = CreateDynamicObject(19378, -2707.53809, -1509.59998, 2000.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][1][1] = CreateDynamicObject(19378, -2707.53809, -1509.59998, 2020.00000,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][2][0] = CreateDynamicObject(19370, -2705.76001, -1506.34436, 2000.00305,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19370, -2705.76001, -1503.13306, 2000.00305,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19370, -2702.26001, -1503.13306, 2000.00305,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][2][1] = CreateDynamicObject(19370, -2702.26001, -1506.34436, 2000.00305,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][3][0] = CreateDynamicObject(19366, -2708.55591, -1506.19800, 2000.00598,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor[ h ][3][1] = CreateDynamicObject(19366, -2708.55591, -1502.69995, 2000.00598,   0.00000, 90.00000, -90.0000, world );

			HTextureRoof[ h ][0][0] = CreateDynamicObject(19381, -2707.54004, -1499.96594, 2003.67395,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -2697.04004, -1499.96594, 2003.67395,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][0][1] = CreateDynamicObject(19381, -2697.04004, -1509.59998, 2003.67395,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][1][0] = CreateDynamicObject(19380, -2707.54004, -1509.59998, 2003.67395,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][1][1] = CreateDynamicObject(19380, -2707.54004, -1509.59998, 2023.67395,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][2][0] = CreateDynamicObject(19362, -2705.76001, -1506.34436, 2003.67004,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19362, -2702.26001, -1506.34436, 2003.67004,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19362, -2705.76001, -1503.13306, 2003.67004,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][2][1] = CreateDynamicObject(19362, -2702.26001, -1503.13306, 2003.67004,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][3][0] = CreateDynamicObject(19371, -2708.55591, -1506.19800, 2003.66602,   0.00000, 90.00000, -90.0000, world );
			HTextureRoof[ h ][3][1] = CreateDynamicObject(19371, -2708.55591, -1502.69995, 2003.66602,   0.00000, 90.00000, -90.0000, world );
		}
		
		case 18: // Двухкомнатная 5
		{
			HTextureWall[ h ][0][0] = CreateDynamicObject(19442, -2204.00000, -1498.59204, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2202.30493, -1497.87500, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2199.08203, 2601.83789, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -2203.99609, -1501.00000, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -2202.30493, -1502.69006, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -2199.89697, -1502.69006, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2199.00610, -1504.20654, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -2199.00610, -1507.41699, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -2194.11011, -1509.10999, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -2192.00000, -1504.20496, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -2192.50391, -1499.30151, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -2197.40991, -1498.58801, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -2197.40991, -1496.18005, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2199.10010, -1494.51001, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][0][1] = CreateDynamicObject(19397, -2200.78857, -1496.18005, 2601.83789,   0.00000, 0.00000, 0.0000, world );

			HTextureWall[ h ][1][0] = CreateDynamicObject(19459, -2191.00000, -1492.95996, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, -2192.33057, -1497.85474, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19395, -2197.23193, -1496.18005, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19395, -2197.23193, -1492.96997, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, -2195.85181, -1491.28003, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19367, -2200.57788, -1492.96997, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][1][1] = CreateDynamicObject(19367, -2198.90820, -1494.47998, 2601.83789,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][2][0] = CreateDynamicObject(19394, -2202.30493, -1502.86804, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, -2203.99609, -1507.77051, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, -2204.08008, -1509.10999, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19394, -2199.18408, -1507.41699, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19365, -2199.18408, -1504.21106, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][2][1] = CreateDynamicObject(19438, -2199.89697, -1502.86804, 2601.83789,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][3][0] = CreateDynamicObject(19396, -2200.96655, -1496.18005, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -2202.64990, -1497.84998, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -2204.32007, -1492.94995, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -2202.64990, -1491.30005, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][3][1] = CreateDynamicObject(19368, -2200.96655, -1492.96802, 2601.83789,   0.00000, 0.00000, 0.0000, world );

			HTextureFloor[ h ][0][0] = CreateDynamicObject(19379, -2199.30005, -1504.30005, 2600.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -2188.80005, -1504.30005, 2600.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -2199.30005, -1494.66602, 2600.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][0][1] = CreateDynamicObject(19379, -2188.80005, -1494.66602, 2600.00000,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][1][0] = CreateDynamicObject(19376, -2192.07251, -1492.97998, 2600.00293,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][1][1] = CreateDynamicObject(19376, -2202.57324, -1489.76953, 2600.00293,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][2][0] = CreateDynamicObject(19378, -2204.34497, -1507.59387, 2600.00293,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][2][1] = CreateDynamicObject(19378, -2204.34497, -1507.59387, 2620.00293,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][3][0] = CreateDynamicObject(19462, -2202.62598, -1492.96497, 2600.00610,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][3][1] = CreateDynamicObject(19462, -2202.62598, -1492.96497, 2620.00610,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][0][0] = CreateDynamicObject(19381, -2199.30005, -1494.66602, 2603.67505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -2188.80005, -1504.30005, 2603.67505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -2199.30005, -1504.30005, 2603.67505,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][0][1] = CreateDynamicObject(19381, -2188.80005, -1494.66602, 2603.67505,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][1][0] = CreateDynamicObject(19377, -2192.07056, -1492.97998, 2603.67090,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][1][1] = CreateDynamicObject(19377, -2202.57129, -1489.76953, 2603.67090,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][2][0] = CreateDynamicObject(19380, -2204.34497, -1507.59595, 2603.67090,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][2][1] = CreateDynamicObject(19380, -2204.34497, -1507.59595, 2623.67090,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][3][0] = CreateDynamicObject(19454, -2202.62598, -1492.96497, 2603.66699,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][3][1] = CreateDynamicObject(19454, -2202.62598, -1492.96497, 2623.66699,   0.00000, 90.00000, 0.0000, world );
		}
		
		case 19: // Двухкомнатная 6
		{
			HTextureWall[ h ][0][0] = CreateDynamicObject(19397, -1702.26001, -1500.55005, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -1701.40002, -1502.22998, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -1698.99194, -1502.22998, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -1697.36047, -1498.85559, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1692.63245, -1497.16199, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -1691.11499, -1495.46802, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -1689.43005, -1497.16199, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -1688.88843, -1499.27246, 1601.83801,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19461, -1683.56665, -1499.81384, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -1685.90002, -1504.69995, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -1690.80005, -1507.44995, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1689.43005, -1506.56006, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -1695.69995, -1507.30005, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -1694.97998, -1503.65747, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1694.08801, -1502.94397, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][0][1] = CreateDynamicObject(19369, -1695.78198, -1502.22998, 1601.83801,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][1][0] = CreateDynamicObject(19396, -1698.99194, -1502.40796, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -1696.58411, -1502.40796, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -1695.75000, -1507.30005, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, -1700.65002, -1508.44995, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -1702.28003, -1507.31006, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			HTextureWall[ h ][1][1] = CreateDynamicObject(19441, -1701.40002, -1502.40796, 1601.83801,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][2][0] = CreateDynamicObject(19395, -1689.25208, -1497.16199, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19367, -1689.25208, -1493.95203, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, -1684.38000, -1492.30005, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19440, -1683.32996, -1492.89001, 1601.83801,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19459, -1682.73999, -1492.81995, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19440, -1683.32996, -1498.26001, 1601.83801,   0.00000, 0.00000, -45.0000, world );
			HTextureWall[ h ][2][1] = CreateDynamicObject(19459, -1684.35999, -1498.84998, 1601.83801,   0.00000, 0.00000, 90.0000, world );

			HTextureWall[ h ][3][0] = CreateDynamicObject(19394, -1691.11499, -1495.29004, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19365, -1692.81006, -1496.80603, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19365, -1694.50000, -1498.47998, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, -1696.18005, -1493.59998, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19438, -1695.29004, -1493.54004, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19438, -1694.39795, -1492.82654, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, -1694.32996, -1491.94995, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			HTextureWall[ h ][3][1] = CreateDynamicObject(19365, -1689.43005, -1493.60999, 1601.83801,   0.00000, 0.00000, 0.0000, world );

			HTextureFloor[ h ][0][0] = CreateDynamicObject(19379, -1697.50000, -1503.50000, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -1687.00000, -1503.50000, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -1687.00000, -1493.86597, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][0][1] = CreateDynamicObject(19379, -1697.50000, -1493.86597, 1600.00000,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][1][0] = CreateDynamicObject(19378, -1700.94995, -1507.13196, 1600.00305,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][1][1] = CreateDynamicObject(19378, -1700.94995, -1507.13196, 1620.00305,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][2][0] = CreateDynamicObject(19376, -1684.09497, -1493.95996, 1600.00305,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][2][1] = CreateDynamicObject(19376, -1684.09497, -1493.95996, 1620.00305,   0.00000, 90.00000, 0.0000, world );

			HTextureFloor[ h ][3][0] = CreateDynamicObject(19462, -1691.14795, -1490.58472, 1600.00305,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor[ h ][3][1] = CreateDynamicObject(19462, -1694.64795, -1493.79504, 1600.00305,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][0][0] = CreateDynamicObject(19381, -1697.50000, -1493.86597, 1603.67004,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -1697.50000, -1503.50000, 1603.67004,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -1687.00000, -1503.50000, 1603.67004,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][0][1] = CreateDynamicObject(19381, -1687.00000, -1493.86597, 1603.67004,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][1][0] = CreateDynamicObject(19380, -1700.94995, -1507.13196, 1603.66602,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][1][1] = CreateDynamicObject(19380, -1700.94995, -1507.13196, 1623.66602,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][2][0] = CreateDynamicObject(19377, -1684.09497, -1493.95996, 1603.66602,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][2][1] = CreateDynamicObject(19377, -1684.09497, -1493.95996, 1623.66602,   0.00000, 90.00000, 0.0000, world );

			HTextureRoof[ h ][3][0] = CreateDynamicObject(19454, -1691.14795, -1490.58472, 1603.66602,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof[ h ][3][1] = CreateDynamicObject(19454, -1694.64795, -1493.79504, 1603.66602,   0.00000, 90.00000, 0.0000, world );
		}
		
		case 20: // Трехкомнатная 1
		{
			HTextureWall [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19397, 1001.90002, -2801.81006, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, 1001.90002, -2804.21802, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, 1000.20599, -2804.93091, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, 998.69000, -2804.21802, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, 998.69000, -2801.81006, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, 998.69000, -2798.59814, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, 998.69000, -2795.38794, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, 1001.90002, -2798.59814, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, 1001.90002, -2795.38794, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, 1001.90002, -2792.17798, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, 1000.21002, -2790.50000, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, 997.80200, -2790.50000, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, 996.90997, -2792.17798, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19461, 993.96198, -2793.69312, 1601.83997,   0.00000, 0.00000, 90.0000, world ); 
			 
			HTextureWall [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19396, 998.51202, -2801.81006, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, 998.51202, -2804.21802, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, 993.60999, -2804.93091, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, 991.68011, -2805.11011, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19460, 993.60999, -2800.20996, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19393, 998.51202, -2798.59814, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19364, 998.51202, -2795.38794, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19456, 993.60999, -2793.70996, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19456, 991.45007, -2797.61499, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19456, 993.60999, -2800.19995, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19394, 996.73199, -2792.17798, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, 991.83002, -2793.67993, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, 991.53998, -2788.78003, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, 991.83002, -2787.47998, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19365, 996.73199, -2788.96777, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19390, 1002.07819, -2792.17798, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19453, 1006.94000, -2788.00000, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19453, 1010.56000, -2788.96997, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19361, 1002.07800, -2788.96802, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19453, 1006.94000, -2793.86011, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19395, 1000.21002, -2790.32202, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19440, 997.80200, -2790.32202, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19367, 996.92499, -2788.62988, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, 1001.81000, -2787.00000, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19367, 1001.89502, -2788.63989, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19379, 996.73401, -2800.05005, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19379, 996.73401, -2790.41602, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19378, 993.35199, -2805.11011, 1600.00305,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19378, 993.35199, -2805.11011, 1620.00305,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19375, 991.57202, -2788.77002, 1600.00598,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19375, 991.57202, -2788.77002, 1620.00598,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19462, 1003.73401, -2790.41602, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19462, 1007.23401, -2790.41602, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19462, 1010.73401, -2790.41602, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19376, 996.56000, -2785.59595, 1600.00305,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19376, 996.56000, -2785.59595, 1620.00305,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19381, 996.66998, -2800.05005, 1603.67505,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19381, 996.66998, -2790.41602, 1603.67505,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19380, 993.34998, -2805.11011, 1603.67004,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19380, 993.34998, -2805.11011, 1623.67004,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19377, 1007.16998, -2790.41602, 1603.66895,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19377, 1007.16998, -2790.41602, 1623.66895,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19362, 998.62000, -2788.50000, 1603.67200,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19362, 1000.20001, -2788.50000, 1603.67004,   0.00000, 90.00000, 90.0000, world );
		}
		
		case 21: // Трехкомнатная 2
		{
			HTextureWall [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19397, 994.04999, -2799.75000, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, 994.91498, -2798.07007, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, 995.62848, -2797.17798, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, 997.29999, -2796.30005, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, 1000.51001, -2796.30005, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, 1002.02600, -2797.81592, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, 1001.13397, -2799.33203, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, 1000.42072, -2801.02612, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, 1003.67798, -2802.71997, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, 998.95001, -2804.41504, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, 994.04999, -2806.10010, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, 990.90002, -2801.30005, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19461, 990.70001, -2806.19995, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19393, 997.29999, -2796.12207, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19364, 994.09003, -2796.12207, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19456, 992.85999, -2791.21997, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19456, 993.98999, -2789.50000, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19456, 998.89600, -2791.21606, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19395, 1000.51001, -2796.12207, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19367, 1003.71997, -2796.12207, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19459, 1004.25000, -2791.21997, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, 1003.79999, -2792.25000, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19459, 998.90002, -2791.21606, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19394, 1000.59839, -2801.02612, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, 1005.50000, -2802.70996, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, 1007.90002, -2797.80493, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, 1007.28497, -2796.30005, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19365, 1002.38202, -2797.82422, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19438, 1001.48999, -2799.34009, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19396, 999.12799, -2804.41504, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, 999.12799, -2807.62500, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, 1000.15002, -2809.30005, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, 1005.04999, -2807.62988, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19460, 1004.02002, -2802.72998, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19379, 993.78900, -2797.99390, 2000.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, 1004.28998, -2797.99390, 2000.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19379, 993.78900, -2807.62793, 2000.00000,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19375, 993.56000, -2791.39575, 2000.00195,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19375, 993.56000, -2791.39575, 2020.00195,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19376, 1004.23999, -2791.39404, 2000.00598,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19376, 1004.23999, -2791.39404, 2020.00598,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19462, 1007.21252, -2797.56030, 2000.00305,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19462, 1005.32611, -2801.06006, 2000.00305,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19378, 1004.28998, -2807.63501, 2000.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19378, 1004.28998, -2807.63501, 2020.00000,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19381, 993.78900, -2807.62793, 2003.67505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, 993.78900, -2797.99390, 2003.67505,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19381, 1004.28998, -2797.99390, 2003.67505,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19454, 993.56000, -2791.39380, 2003.67297,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19454, 997.06000, -2791.39380, 2003.67297,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19377, 1004.23999, -2791.21997, 2003.66895,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19377, 1004.23999, -2791.21997, 2023.66895,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19463, 1005.32611, -2801.06006, 2003.67102,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19463, 1007.21252, -2797.56030, 2003.67102,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19380, 1004.28998, -2807.63501, 2003.67505,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19380, 1004.28998, -2807.63501, 2023.67505,   0.00000, 90.00000, 0.0000, world );
		}
		
		case 22: // Трехкомнатная 3
		{
			HTextureWall [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19397, 996.16998, -2799.31006, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, 996.16998, -2805.73193, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, 997.85498, -2805.19043, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, 999.96503, -2805.73193, 2401.84009,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19369, 1002.20001, -2806.32495, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, 1004.42999, -2805.73193, 2401.84009,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19461, 1009.75153, -2805.19043, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, 1003.89008, -2799.30493, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, 1003.89008, -2796.89697, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, 1008.79498, -2796.10010, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, 1011.90997, -2801.00488, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, 1003.89008, -2788.06812, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, 1010.21997, -2802.80005, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, 1008.53302, -2805.90601, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, 1007.01599, -2801.00000, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, 1004.60797, -2801.00000, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, 995.77802, -2797.61499, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, 1000.50549, -2796.72290, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, 1000.50549, -2794.31494, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, 1002.20001, -2792.62500, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19397, 1003.89008, -2794.48999, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19394, 1000.32800, -2794.31494, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19438, 1000.32800, -2791.90796, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, 995.42499, -2791.18994, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, 993.56427, -2792.73706, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, 995.42499, -2797.59058, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19438, 1000.32800, -2796.72290, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19396, 1004.06812, -2794.48999, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, 1004.06812, -2788.06812, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, 1008.96997, -2788.50000, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, 1009.65997, -2791.18506, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19460, 1008.96997, -2796.09009, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19395, 1002.20001, -2792.44702, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19459, 1003.88000, -2787.55005, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, 998.97498, -2787.69995, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19367, 998.54999, -2789.15186, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19367, 998.81799, -2790.84619, 2401.84009,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19440, 1000.51202, -2791.56006, 2401.84009,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19379, 999.15997, -2801.37012, 2400.00000,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19379, 1008.79401, -2801.37012, 2400.00000,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19379, 999.15997, -2790.87012, 2400.00000,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19376, 995.17700, -2792.76880, 2400.00293,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19376, 995.17700, -2792.76880, 2420.00293,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19378, 1008.79401, -2790.87012, 2400.00000,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19378, 1008.79401, -2790.87012, 2420.00000,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19360, 1002.19000, -2790.79004, 2400.00610,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19360, 998.97998, -2789.52002, 2400.00610,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19360, 1002.19000, -2787.29004, 2400.00610,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19381, 999.15997, -2790.87012, 2403.67505,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19381, 999.15997, -2801.37012, 2403.67505,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19381, 1008.79401, -2801.37012, 2403.67505,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19377, 995.17700, -2792.76880, 2403.67310,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19377, 995.17700, -2792.76880, 2423.67310,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19380, 1008.79401, -2790.87012, 2403.67505,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19380, 1008.79401, -2790.87012, 2423.67505,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19373, 1002.19000, -2790.79004, 2403.66992,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19373, 1002.19000, -2787.29004, 2403.66992,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19373, 998.97998, -2789.52002, 2403.66992,   0.00000, 90.00000, 90.0000, world );
		}
		
		case 23: // Трехкомнатная 4
		{
			HTextureWall [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19397, -2709.50000, -2800.50000, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2707.80908, -2802.18896, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -2705.40186, -2802.18896, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -2702.99390, -2802.18896, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -2701.30005, -2806.91699, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2699.61011, -2810.00000, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2696.40991, -2810.16992, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2693.20996, -2810.00000, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -2691.52002, -2807.08008, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -2693.00000, -2802.18896, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -2695.05396, -2800.50000, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2695.77002, -2798.81006, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -2698.17798, -2798.81006, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -2700.58618, -2798.81006, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2702.99390, -2798.81006, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -2706.20410, -2798.81006, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19442, -2708.61182, -2798.81006, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19459, -2707.87988, -2793.72998, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, -2707.82007, -2792.03003, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19440, -2702.91406, -2792.74390, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19440, -2702.20044, -2793.63599, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19459, -2701.31006, -2793.72998, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19367, -2702.99390, -2798.63208, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19395, -2706.20410, -2798.63208, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19396, -2702.99390, -2802.36694, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -2704.67993, -2803.25000, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, -2709.58594, -2803.96338, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -2708.02002, -2804.85010, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -2708.91187, -2805.56396, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -2709.80005, -2810.44995, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -2708.91187, -2810.57202, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -2708.02002, -2811.28540, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, -2701.33008, -2807.27197, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19460, -2706.22998, -2812.16992, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19393, -2698.17798, -2798.63208, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19456, -2699.86011, -2793.72998, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19456, -2694.95508, -2790.44995, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19456, -2691.51001, -2790.53491, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19393, -2693.19995, -2795.43384, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19437, -2695.60791, -2795.43384, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19364, -2696.50000, -2796.94995, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19434, -2695.60742, -2795.61182, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19361, -2696.48511, -2797.28491, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19453, -2691.59009, -2798.80005, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19361, -2689.90991, -2797.29004, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19390, -2693.19995, -2795.61182, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19434, -2690.79199, -2795.61182, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19394, -2694.87598, -2800.50000, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19457, -2689.97998, -2802.17749, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, -2689.97998, -2798.81006, 2601.83789,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19365, -2690.19995, -2800.50000, 2601.83789,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19379, -2705.10010, -2803.53687, 2600.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -2694.60010, -2803.53687, 2600.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -2694.60010, -2813.16992, 2600.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19379, -2705.10010, -2813.16992, 2600.00000,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19376, -2705.10010, -2793.90381, 2600.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19376, -2705.10010, -2793.90381, 2620.00000,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19378, -2706.22998, -2807.52612, 2600.00293,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19378, -2706.22998, -2807.52612, 2620.00293,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19375, -2694.60010, -2793.90381, 2600.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19375, -2694.60010, -2793.90381, 2620.00000,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19370, -2691.19995, -2797.12793, 2600.00293,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19370, -2694.69995, -2797.12793, 2600.00293,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19366, -2693.21704, -2800.50000, 2600.00293,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19366, -2689.71704, -2800.50000, 2600.00293,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19381, -2705.10010, -2803.53687, 2603.67505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -2705.10010, -2813.16992, 2603.67505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -2694.60010, -2803.53687, 2603.67505,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19381, -2694.60010, -2813.16992, 2603.67505,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19377, -2705.10010, -2793.90381, 2603.67090,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19377, -2705.10010, -2793.90381, 2623.67090,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19380, -2706.22998, -2807.52808, 2603.67090,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19380, -2706.22998, -2807.52808, 2623.67090,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19454, -2698.10010, -2793.90381, 2603.67505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19454, -2694.60010, -2793.90381, 2603.67505,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19454, -2691.10010, -2793.90381, 2603.67505,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19371, -2691.19995, -2797.12793, 2603.67090,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19371, -2694.69995, -2797.12793, 2603.67090,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19373, -2693.21704, -2800.50000, 2603.67090,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19373, -2689.71704, -2800.50000, 2603.67090,   0.00000, 90.00000, 0.0000, world );
		}
		
		case 24: // Трехкомнатная 5
		{
			HTextureWall [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19397, -2706.50000, -2201.30005, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2705.62012, -2202.98999, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -2704.72803, -2203.70361, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2705.62012, -2204.41699, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2706.50000, -2206.10010, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -2704.82202, -2207.79004, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -2698.39990, -2207.96802, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -2691.97803, -2207.96802, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -2692.41992, -2204.51001, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -2695.18188, -2199.61011, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2704.81006, -2199.61011, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -2699.90991, -2197.91602, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2701.60010, -2196.22998, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19397, -2703.29395, -2197.91602, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19395, -2699.73193, -2197.91602, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19440, -2698.85010, -2196.22998, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19367, -2698.13696, -2194.53589, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, -2693.23999, -2192.86011, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19459, -2693.10010, -2194.69995, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19459, -2694.83008, -2199.60010, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19396, -2703.47192, -2197.91602, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -2705.15991, -2199.60010, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -2706.85010, -2194.69995, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -2705.15991, -2193.03003, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19368, -2703.47192, -2194.70605, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19457, -2691.97803, -2208.14600, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19394, -2698.39990, -2208.14600, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, -2693.50000, -2213.05005, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, -2695.19995, -2216.33008, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19394, -2700.08008, -2214.64795, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19394, -2700.08008, -2211.43799, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19438, -2700.08008, -2209.03003, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19393, -2700.25806, -2211.43799, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19456, -2705.16016, -2212.92993, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19456, -2705.10010, -2213.06006, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19456, -2705.16016, -2208.15991, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19437, -2700.25806, -2209.03003, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19390, -2700.25806, -2214.64795, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19361, -2701.94995, -2212.95996, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19361, -2703.62988, -2214.64795, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19361, -2701.94995, -2216.33008, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19379, -2701.69995, -2203.24194, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -2691.20142, -2203.26196, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19379, -2701.69995, -2193.60815, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19378, -2694.57202, -2194.67993, 1600.00305,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19378, -2694.57202, -2194.67993, 1620.00305,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19375, -2708.19800, -2194.30005, 1600.00305,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19375, -2708.19800, -2194.30005, 1620.00305,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19376, -2695.35205, -2213.30908, 1600.00000,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19376, -2695.35205, -2213.30908, 1620.00000,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureFloor [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19462, -2704.98511, -2209.73999, 1600.00000,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19462, -2704.98511, -2213.23999, 1600.00000,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureFloor [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19458, -2704.98315, -2214.64795, 1600.00305,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19458, -2704.98315, -2214.64795, 1620.00305,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureRoof [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19381, -2701.69995, -2203.24194, 1603.67200,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -2701.69995, -2193.60815, 1603.67200,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19381, -2691.20142, -2203.26196, 1603.67200,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19380, -2694.57202, -2194.67993, 1603.66797,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19380, -2694.57202, -2194.67993, 1623.66797,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19454, -2705.15991, -2194.69995, 1603.66797,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19454, -2705.15991, -2194.69995, 1623.66797,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19377, -2695.35205, -2213.30908, 1603.67200,   0.00000, 90.00000, -90.0000, world );
			HTextureRoof [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19377, -2695.35205, -2213.30908, 1623.67200,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureRoof [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19463, -2704.98511, -2209.73999, 1603.67200,   0.00000, 90.00000, -90.0000, world );
			HTextureRoof [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19463, -2704.98511, -2213.23999, 1603.67200,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureRoof [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19373, -2701.94995, -2214.64795, 1603.66797,   0.00000, 90.00000, -90.0000, world );
			HTextureRoof [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19373, -2701.94995, -2214.64795, 1623.66797,   0.00000, 90.00000, -90.0000, world );
		}
		
		case 25: // Четырехкомнатная 1
		{
			HTextureWall [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19397, 1497.21997, -2799.52002, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, 1497.21997, -2802.72998, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, 1498.57007, -2802.85010, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, 1500.80103, -2802.26001, 1601.83997,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19442, 1502.10815, -2801.71851, 1601.83997,   0.00000, 0.00000, -90.0000, world );
			CreateDynamicObject(19442, 1503.00000, -2802.43188, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, 1503.00000, -2804.84009, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, 1503.00000, -2808.05005, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, 1504.68994, -2809.73999, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, 1506.38000, -2808.05005, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, 1506.38000, -2804.84009, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, 1506.38000, -2801.63013, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, 1511.10803, -2799.93579, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, 1508.96997, -2795.03003, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, 1504.06995, -2793.10010, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, 1503.00000, -2793.98999, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, 1494.43604, -2793.10010, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, 1497.21997, -2793.09790, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19442, 1498.10999, -2797.83008, 1601.83997,   0.00000, 0.00000, -90.0000, world );
			 
			HTextureWall [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19394, 1506.55798, -2804.84009, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19365, 1506.55798, -2801.63013, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, 1511.45801, -2799.94165, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, 1512.96997, -2804.84497, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19457, 1511.45996, -2806.43970, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19393, 1506.55798, -2808.05005, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19456, 1511.45996, -2806.44385, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19456, 1511.93005, -2811.34009, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19456, 1511.45996, -2814.00000, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19456, 1506.55798, -2814.47192, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19395, 1504.68994, -2809.91797, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19459, 1498.26794, -2809.91797, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19459, 1499.98999, -2814.82007, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, 1501.46997, -2815.50000, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19459, 1506.37000, -2814.82007, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19396, 1502.82202, -2804.84009, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, 1501.13000, -2803.14990, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, 1499.61499, -2808.05493, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, 1501.13000, -2809.72998, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19368, 1502.82202, -2808.05005, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19379, 1497.83606, -2802.73389, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, 1508.33606, -2793.10010, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, 1508.33606, -2802.73389, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19379, 1508.33606, -2812.36792, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19378, 1497.83606, -2793.10010, 1600.00195,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19378, 1497.83606, -2793.10010, 1620.00195,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19376, 1511.71704, -2804.80005, 1600.00305,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19376, 1511.71704, -2804.80005, 1620.00305,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19458, 1508.21204, -2811.33008, 1600.00598,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19458, 1511.71204, -2811.33008, 1600.00598,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19375, 1501.03003, -2814.64380, 1600.00195,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19375, 1501.03003, -2814.64380, 1620.00195,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19370, 1501.16309, -2804.84009, 1600.00195,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19370, 1501.18311, -2808.04932, 1600.00195,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19381, 1501.23999, -2807.53394, 1603.67505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, 1501.23999, -2797.89990, 1603.67505,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19381, 1511.73987, -2797.89990, 1603.67505,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19377, 1511.71899, -2804.80005, 1603.67102,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19377, 1511.71899, -2804.80005, 1623.67102,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19463, 1508.21204, -2811.33008, 1603.66699,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19463, 1511.71204, -2811.33008, 1603.66699,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19380, 1501.03003, -2814.64990, 1603.67004,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19380, 1501.03003, -2814.64990, 1623.67004,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19362, 1501.15906, -2804.84009, 1603.67004,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19362, 1501.15906, -2808.05005, 1603.67004,   0.00000, 90.00000, 0.0000, world );
		}
		
		case 26: // Четырехкомнатная 2
		{
			HTextureWall [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19397, 1496.85999, -2793.84009, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, 1498.37598, -2792.14795, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, 1496.85999, -2797.05005, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, 1498.55396, -2798.56641, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, 1503.28198, -2800.26196, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, 1500.06995, -2800.26001, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, 1503.28198, -2803.47192, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, 1501.76501, -2805.15991, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, 1498.55396, -2805.15991, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, 1496.90002, -2803.64380, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, 1498.55396, -2801.95410, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, 1500.06995, -2790.63013, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, 1504.97595, -2789.11206, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, 1506.66003, -2793.65991, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, 1504.97595, -2798.56006, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, 1503.28198, -2797.05103, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, 1501.76501, -2795.35620, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19397, 1500.06995, -2793.84009, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19396, 1503.45996, -2800.26196, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, 1505.15002, -2798.57007, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, 1506.70801, -2803.46997, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, 1505.15002, -2805.14990, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19368, 1503.45996, -2803.47192, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19395, 1499.89197, -2800.26001, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, 1494.98596, -2801.94507, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19459, 1493.30200, -2797.04004, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19367, 1494.81995, -2795.37012, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19367, 1496.50403, -2797.05859, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19367, 1498.19995, -2798.57495, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19393, 1501.76501, -2805.33789, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19364, 1504.97595, -2805.33789, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19456, 1506.66003, -2810.23999, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19456, 1505.06006, -2811.00000, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19456, 1500.16003, -2810.23999, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19457, 1500.15002, -2810.23999, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, 1495.25000, -2810.25000, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, 1492.00000, -2807.05005, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, 1491.95996, -2802.14990, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19365, 1496.85901, -2803.82007, 2001.83997,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19394, 1498.55396, -2805.33789, 2001.83997,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19379, 1502.02002, -2797.02002, 2000.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, 1502.02002, -2787.38599, 2000.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, 1502.02002, -2806.65405, 2000.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19379, 1491.51990, -2806.65405, 2000.00000,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19366, 1505.11987, -2800.26196, 2000.00403,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19366, 1505.11987, -2803.47192, 2000.00403,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19370, 1498.23206, -2800.26001, 2000.00403,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19462, 1494.73303, -2797.04810, 2000.00403,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19378, 1505.50000, -2810.06396, 2000.00403,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19378, 1505.50000, -2810.06396, 2020.00403,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19381, 1491.51990, -2806.65405, 2003.67505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, 1502.02002, -2787.38599, 2003.67505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, 1502.02002, -2806.65405, 2003.67505,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19381, 1502.02002, -2797.02002, 2003.67505,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19371, 1505.12195, -2800.26196, 2003.66199,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19371, 1505.12195, -2803.47192, 2003.66199,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19362, 1498.22998, -2800.26001, 2003.66199,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19362, 1498.22998, -2800.26001, 2023.66199,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19454, 1494.73096, -2797.04810, 2003.66199,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19454, 1494.73096, -2797.04810, 2023.66199,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19380, 1505.50000, -2810.07007, 2003.66199,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19380, 1505.50000, -2810.07007, 2023.66199,   0.00000, 90.00000, 0.0000, world );
		}
		
		case 27: // Четырехкомнатная 3
		{
			HTextureWall [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19397, 1492.19995, -2797.05005, 2501.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, 1493.89001, -2798.73999, 2501.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, 1495.40601, -2800.43408, 2501.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, 1497.09998, -2801.95996, 2501.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, 1498.79395, -2800.43408, 2501.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, 1498.79395, -2802.84180, 2501.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, 1493.89001, -2801.95996, 2501.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, 1492.19995, -2806.85010, 2501.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, 1493.23206, -2811.18896, 2501.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, 1495.34204, -2811.72998, 2501.84009,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19442, 1496.77002, -2812.32202, 2501.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, 1498.20203, -2811.72998, 2501.84009,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19369, 1498.79163, -2809.50000, 2501.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, 1493.88794, -2795.35693, 2501.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, 1498.79395, -2794.64355, 2501.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, 1502.49805, -2797.58789, 2501.84009,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19369, 1500.31006, -2798.73901, 2501.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, 1503.65796, -2794.79004, 2501.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, 1503.65796, -2791.58008, 2501.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, 1502.14001, -2789.88501, 2501.84009,   0.00000, 0.00000, -90.0000, world );
			CreateDynamicObject(19461, 1493.88794, -2793.92993, 2501.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, 1494.96997, -2793.04004, 2501.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, 1496.12915, -2791.04492, 2501.84009,   0.00000, 0.00000, -45.0000, world );
			HTextureWall [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19397, 1498.93005, -2789.88501, 2501.84009,   0.00000, 0.00000, -90.0000, world );
			 
			HTextureWall [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19396, 1498.97192, -2800.43408, 2501.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, 1498.97192, -2802.84180, 2501.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, 1500.66504, -2798.77002, 2501.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, 1503.74487, -2803.66992, 2501.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, 1503.87598, -2798.77002, 2501.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, 1502.58411, -2806.82495, 2501.84009,   0.00000, 0.00000, 135.0000, world );
			HTextureWall [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19368, 1500.48596, -2807.98389, 2501.84009,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19440, 1503.83606, -2797.19800, 2501.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19440, 1504.55005, -2797.48999, 2501.84009,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19395, 1503.83606, -2794.79004, 2501.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19440, 1505.85706, -2796.94849, 2501.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19440, 1507.16418, -2797.48999, 2501.84009,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19367, 1507.70569, -2799.60010, 2501.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19367, 1509.39001, -2801.28003, 2501.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19459, 1511.06006, -2796.38989, 2501.84009,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19459, 1508.72998, -2793.10010, 2501.84009,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19394, 1502.14001, -2789.70703, 2501.84009,   0.00000, 0.00000, -90.0000, world );
			CreateDynamicObject(19365, 1503.83496, -2791.22339, 2501.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19365, 1505.52002, -2792.89990, 2501.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, 1507.19995, -2788.01001, 2501.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, 1505.44995, -2783.29004, 2501.84009,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19457, 1500.55005, -2784.80005, 2501.84009,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19393, 1498.93005, -2789.70703, 2501.84009,   0.00000, 0.00000, -90.0000, world );
			CreateDynamicObject(19456, 1494.87500, -2785.52002, 2501.84009,   0.00000, 0.00000, 30.0000, world );
			CreateDynamicObject(19364, 1495.50000, -2783.39990, 2501.84009,   0.00000, 0.00000, 135.0000, world );
			CreateDynamicObject(19456, 1501.48999, -2782.25000, 2501.84009,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19456, 1500.50000, -2784.80005, 2501.84009,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19390, 1496.00403, -2790.91992, 2501.84009,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19434, 1494.89502, -2792.79492, 2501.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19453, 1490.00000, -2793.67993, 2501.84009,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19453, 1489.98999, -2788.77490, 2501.84009,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19453, 1488.93994, -2783.88989, 2501.84009,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19453, 1494.75000, -2785.53003, 2501.84009,   0.00000, 0.00000, 30.0000, world );
			 
			HTextureFloor [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19379, 1497.19995, -2794.00000, 2500.00195,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, 1497.19995, -2803.63379, 2500.00195,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, 1497.19995, -2813.26611, 2500.00195,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, 1486.69995, -2794.00000, 2500.00195,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, 1486.69995, -2784.36621, 2500.00195,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, 1507.70203, -2794.00000, 2500.00195,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19379, 1497.19995, -2784.36621, 2500.00195,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19378, 1504.13000, -2803.64990, 2500.00488,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19378, 1504.13000, -2803.64990, 2520.00488,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19376, 1508.99500, -2797.98999, 2500.00806,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19376, 1508.99500, -2797.98999, 2520.00806,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19462, 1502.17004, -2784.98096, 2500.00488,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19462, 1505.66797, -2788.19189, 2500.00488,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19381, 1497.19995, -2803.63379, 2503.67505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, 1486.69995, -2784.36621, 2503.67505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, 1497.19995, -2784.36621, 2503.67505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, 1486.69995, -2794.00000, 2503.67505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, 1497.19995, -2794.00000, 2503.67505,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19381, 1507.70203, -2794.00000, 2503.67505,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19377, 1493.80005, -2806.82007, 2503.67090,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19377, 1493.80005, -2816.45410, 2503.67090,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19377, 1504.30005, -2803.62012, 2503.67090,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19380, 1508.99927, -2798.00952, 2503.66699,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19380, 1508.99927, -2798.00952, 2523.66699,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19454, 1502.17004, -2784.98096, 2503.67090,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19454, 1505.66797, -2788.19189, 2503.67090,   0.00000, 90.00000, 0.0000, world );
		}
		
		case 28: // Двухэтажный 1
		{
			HTextureWall [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19397, -1012.00000, -2790.48999, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1010.31000, -2793.62012, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1008.61499, -2792.90649, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1012.00000, -2787.28003, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -1008.70599, -2785.59204, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -1003.89001, -2788.80005, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1002.20001, -2789.51318, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1000.68347, -2790.40405, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -998.27600, -2790.40405, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1011.63000, -2798.56006, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -1012.00000, -2796.91211, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -1009.40002, -2797.96997, 2801.83789,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19369, -1007.28979, -2797.42847, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1005.17950, -2797.96997, 2801.83789,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19369, -1002.95001, -2798.56006, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1000.72998, -2797.96997, 2801.83789,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19369, -998.61951, -2797.42847, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -996.50897, -2797.96973, 2801.83789,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19442, -995.08002, -2798.56006, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -994.20001, -2795.13062, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -994.20001, -2786.33618, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -994.20001, -2783.92798, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -994.20001, -2780.71802, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -997.56250, -2788.71191, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -997.56250, -2785.50195, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -992.50598, -2787.05005, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -989.29401, -2787.05005, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -986.88599, -2787.05005, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -986.00000, -2788.71191, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -987.69000, -2790.40259, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -990.09802, -2790.40259, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -992.50598, -2790.40259, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -999.09998, -2780.90015, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1000.68347, -2783.80811, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19442, -998.27600, -2783.80811, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19460, -999.09998, -2780.90015, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -1000.68347, -2783.80811, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -998.27600, -2783.80811, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -997.74298, -2782.12012, 2805.33691,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -1002.20001, -2784.69995, 2805.33691,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -1002.20001, -2787.10620, 2805.33691,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -1003.88599, -2788.80005, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -1007.09601, -2788.80005, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -1008.41699, -2787.19995, 2805.33691,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -1005.49548, -2785.59204, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -1007.90002, -2785.59106, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -1003.97900, -2784.69995, 2805.33691,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -1005.49548, -2783.80811, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -1007.90399, -2783.80811, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -1008.73401, -2780.90015, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -1012.15997, -2781.60205, 2805.33691,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -1012.70117, -2782.90991, 2805.33691,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19441, -1013.28998, -2784.32983, 2805.33691,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -1012.70117, -2785.75488, 2805.33691,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19368, -1008.61749, -2785.50195, 2805.33691,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -1008.61749, -2788.71191, 2805.33691,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -1012.28497, -2787.18506, 2805.33691,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -1012.70117, -2788.61499, 2805.33691,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19441, -1013.28998, -2790.04004, 2805.33691,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -1012.70117, -2791.46997, 2805.33691,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19441, -1012.15997, -2792.77783, 2805.33691,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, -1007.27002, -2793.43799, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -1003.89001, -2790.40601, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19396, -1000.85999, -2793.60791, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -994.43799, -2793.43799, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -995.96002, -2791.91797, 2805.33691,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19396, -997.47198, -2790.23999, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19395, -989.29401, -2786.87207, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19440, -986.88599, -2786.87207, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19459, -986.01001, -2781.97998, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19440, -986.59998, -2780.10010, 2801.83789,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19459, -987.98999, -2779.51001, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19440, -993.42999, -2780.10010, 2801.83789,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19367, -994.02197, -2780.71802, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19395, -994.02197, -2783.92798, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19440, -994.02252, -2786.33228, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19367, -992.50598, -2786.87207, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19457, -987.69000, -2794.62012, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19438, -993.13000, -2794.03003, 2801.83789,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19438, -993.72302, -2792.60010, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19438, -993.13000, -2791.16992, 2801.83789,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19365, -990.90100, -2790.58057, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19394, -987.69000, -2790.58057, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19457, -986.00000, -2795.46997, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19364, -999.16199, -2788.36987, 2805.33691,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19364, -997.47198, -2786.67798, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19456, -995.77753, -2781.95044, 2805.33691,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19456, -990.87201, -2781.98804, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19456, -990.82202, -2785.17798, 2805.33691,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19456, -991.05103, -2790.06201, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19393, -997.47198, -2790.06201, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19390, -1000.85999, -2793.78589, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19453, -994.43799, -2793.78589, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19453, -993.78998, -2798.67798, 2805.33691,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19434, -994.67242, -2800.37646, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19434, -995.97998, -2800.91797, 2805.33691,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19361, -998.21002, -2801.50806, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19434, -1000.44000, -2800.91797, 2805.33691,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19434, -1001.74701, -2800.37671, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19390, -1002.53003, -2798.68799, 2805.33691,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19361, -1002.53003, -2795.47803, 2805.33691,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 6 ] [ 0 ] = CreateDynamicObject(19389, -1002.70801, -2798.68799, 2805.33691,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19451, -1007.57001, -2800.37939, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19451, -1007.54999, -2798.71802, 2805.33691,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19451, -1007.57001, -2793.81787, 2805.33691,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 6 ] [ 1 ] = CreateDynamicObject(19359, -1002.70801, -2795.47803, 2805.33691,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19379, -1007.00000, -2784.36694, 2800.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -1007.00000, -2794.00000, 2800.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -996.50000, -2794.00000, 2800.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -996.50000, -2784.36694, 2800.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -986.00012, -2794.00000, 2800.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19379, -986.00012, -2784.36694, 2800.00000,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19443, -1003.09003, -2786.96997, 2803.50195,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19443, -1003.09003, -2783.46997, 2803.50195,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19443, -1003.09003, -2779.96997, 2803.50000,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19378, -1009.14203, -2778.91187, 2803.50195,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19378, -1013.95099, -2788.54590, 2803.50195,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19378, -1003.45001, -2794.96802, 2803.50195,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19378, -992.95001, -2794.96826, 2803.50195,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19376, -988.86267, -2782.14551, 2800.00293,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19376, -988.86267, -2782.14551, 2820.00293,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19458, -988.91998, -2792.23901, 2800.00293,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19458, -988.91998, -2795.73804, 2800.00293,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19452, -994.29999, -2788.40088, 2803.50195,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19452, -991.08899, -2784.90137, 2803.50195,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19452, -991.08899, -2781.40186, 2803.50195,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19375, -997.37201, -2798.51001, 2803.50391,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 6 ] [ 0 ] = CreateDynamicObject(19448, -1004.37201, -2798.51001, 2803.50391,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 6 ] [ 1 ] = CreateDynamicObject(19448, -1007.87000, -2798.51001, 2803.50391,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19381, -1013.58099, -2793.69067, 2803.49805,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -1003.08002, -2793.69067, 2803.49805,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -1013.58099, -2784.05811, 2803.49805,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -992.58002, -2793.69067, 2803.49805,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -992.58002, -2784.05811, 2803.49805,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -982.08002, -2784.05811, 2803.49805,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -982.08002, -2793.69067, 2803.49805,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -997.79999, -2785.49512, 2807.16992,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -997.79999, -2795.12793, 2807.16992,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -1008.29999, -2795.12793, 2807.16992,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19381, -1008.29999, -2785.49512, 2807.16992,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19380, -988.71997, -2781.97998, 2803.49390,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19380, -988.71997, -2781.97998, 2823.49390,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19454, -988.91998, -2792.23901, 2803.49390,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19454, -988.91998, -2795.73804, 2823.49390,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19463, -994.29999, -2788.40088, 2807.16602,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19463, -991.08899, -2784.90137, 2807.16602,   0.00000, 90.00000, -90.0000, world );
			HTextureRoof [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19463, -991.08899, -2781.40186, 2807.16602,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureRoof [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19377, -997.20001, -2798.66992, 2807.16602,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19377, -997.20001, -2798.66992, 2827.16602,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19373, -1004.37201, -2798.71997, 2807.16602,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19373, -1007.87000, -2798.71997, 2807.16602,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19373, -1004.37201, -2795.51001, 2807.16602,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19373, -1007.87000, -2795.51001, 2807.16602,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureStairs [ h ] [ 0 ] = CreateDynamicObject(14409, -1005.71490, -2786.73682, 2800.39990,   0.00000, 0.00000, 90.0000, world );
			HTextureStairs [ h ] [ 1 ] = CreateDynamicObject(14409, -1000.46552, -2782.12012, 2800.39990,   0.00000, 0.00000, -90.0000, world );
		}
		
		case 29: // Двухэтажный 2
		{
			HTextureWall [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19397, -1501.19995, -2794.11011, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1503.42505, -2794.70020, 1601.83801,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19442, -1504.01501, -2796.12012, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -1503.42505, -2797.54004, 1601.83801,   0.00000, 0.00000, -135.0000, world );
			CreateDynamicObject(19442, -1502.88354, -2798.84741, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -1502.88354, -2801.25488, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1502.88354, -2804.46411, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -1502.29504, -2806.68994, 1601.83801,   0.00000, 0.00000, -135.0000, world );
			CreateDynamicObject(19397, -1501.75354, -2808.80005, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -1501.75354, -2811.20801, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -1502.79004, -2811.98999, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1497.93005, -2810.30811, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -1497.93005, -2807.09814, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -1497.93005, -2804.68994, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -1494.80200, -2803.80396, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1499.53003, -2802.11011, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1499.53003, -2798.89990, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1497.98999, -2794.11011, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19461, -1496.30005, -2797.31006, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19460, -1496.30005, -2797.31006, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -1495.41003, -2802.03809, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -1495.40002, -2803.14990, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19396, -1497.04004, -2808.04004, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -1500.25000, -2808.04004, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19396, -1501.93994, -2806.36987, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -1501.93994, -2803.15991, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19396, -1501.93994, -2799.94995, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -1501.93994, -2796.73999, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -1501.34998, -2794.52002, 1605.33801,   0.00000, 0.00000, 135.0000, world );
			CreateDynamicObject(19368, -1499.12000, -2793.92993, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19441, -1496.89001, -2794.52002, 1605.33801,   0.00000, 0.00000, 45.0000, world );
			 
			HTextureWall [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19395, -1503.06152, -2801.25488, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19440, -1503.06152, -2798.84741, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19440, -1503.65002, -2797.41992, 1601.83801,   0.00000, 0.00000, -135.0000, world );
			CreateDynamicObject(19367, -1505.87500, -2796.83008, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19440, -1508.09998, -2797.41992, 1601.83801,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19459, -1508.68994, -2802.85010, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, -1507.95996, -2806.13989, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19367, -1503.06152, -2804.46411, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19394, -1497.75208, -2807.09814, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19365, -1497.75208, -2810.30811, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, -1492.85999, -2811.95996, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, -1492.25000, -2808.72998, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, -1492.85999, -2803.83008, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19438, -1497.75208, -2804.68994, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19393, -1501.93152, -2808.80005, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19456, -1506.82996, -2807.11011, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19456, -1505.30005, -2812.00000, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19456, -1506.82996, -2811.95996, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19437, -1501.93152, -2811.20801, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19361, -1498.72998, -2809.87988, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19453, -1493.84998, -2811.56006, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19453, -1491.97998, -2809.89990, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19361, -1493.66003, -2805.00000, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19453, -1495.34595, -2803.48999, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19390, -1497.04004, -2808.21802, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 6 ] [ 0 ] = CreateDynamicObject(19389, -1502.11804, -2806.36987, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19451, -1507.02002, -2804.67993, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19451, -1507.03003, -2809.58008, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19451, -1505.40002, -2811.39990, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19359, -1500.51001, -2809.75000, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 6 ] [ 1 ] = CreateDynamicObject(19359, -1500.60205, -2808.06494, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 7 ] [ 0 ] = CreateDynamicObject(19388, -1502.11804, -2799.94995, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19358, -1502.11804, -2796.73999, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19450, -1507.02002, -2795.53003, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19431, -1508.02844, -2796.41284, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19431, -1508.56995, -2797.71997, 1605.33801,   0.00000, 0.00000, 135.0000, world );
			CreateDynamicObject(19358, -1509.16003, -2799.94995, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19431, -1508.56995, -2802.17993, 1605.33801,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19431, -1508.02844, -2803.48755, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19450, -1507.02002, -2804.37500, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 7 ] [ 1 ] = CreateDynamicObject(19358, -1502.11804, -2803.15991, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19379, -1501.09998, -2799.10010, 1600.00000,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19379, -1510.73401, -2799.10010, 1600.00000,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19379, -1510.73401, -2809.60010, 1600.00000,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19379, -1501.09998, -2809.60010, 1600.00000,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19378, -1494.62866, -2807.35400, 1603.50000,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19378, -1504.26208, -2807.37402, 1603.50000,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19378, -1504.26208, -2796.87402, 1603.50000,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19378, -1494.62805, -2790.39990, 1603.50000,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureFloor [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19376, -1492.59204, -2808.72998, 1600.00305,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19376, -1492.59204, -2808.72998, 1620.00305,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19462, -1503.59204, -2812.01001, 1600.00305,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19462, -1503.59204, -2812.01001, 1620.00305,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19452, -1497.04004, -2812.94507, 1603.50305,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19452, -1493.54004, -2809.73389, 1603.50305,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19458, -1506.84399, -2806.36987, 1603.50305,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19458, -1503.63196, -2809.86816, 1603.50305,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureFloor [ h ] [ 6 ] [ 0 ] = CreateDynamicObject(19375, -1506.84595, -2799.04004, 1603.50305,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor [ h ] [ 6 ] [ 1 ] = CreateDynamicObject(19375, -1506.84595, -2799.04004, 1623.50305,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureRoof [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19381, -1504.26611, -2796.87402, 1603.49597,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19381, -1494.63220, -2790.39575, 1603.49597,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19381, -1504.26611, -2807.37402, 1603.49597,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19381, -1494.63416, -2807.37402, 1603.49597,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19381, -1494.62805, -2807.37402, 1607.17200,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19381, -1504.26208, -2807.37402, 1607.17200,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19381, -1504.26208, -2796.87402, 1607.17200,   0.00000, 90.00000, -90.0000, world );
			HTextureRoof [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19381, -1494.62805, -2796.87402, 1607.17200,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureRoof [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19380, -1492.59204, -2808.72998, 1603.49194,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19380, -1492.59204, -2808.72998, 1623.49194,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19454, -1503.59204, -2812.01001, 1603.49194,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19454, -1503.59204, -2812.01001, 1623.49194,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19373, -1497.04004, -2809.89990, 1607.16797,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19373, -1493.54004, -2809.89990, 1607.16797,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19373, -1493.54004, -2806.68994, 1607.16797,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19463, -1506.84998, -2806.36987, 1607.16797,   0.00000, 90.00000, -90.0000, world );
			HTextureRoof [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19463, -1503.63794, -2809.86816, 1607.16797,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureRoof [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19377, -1506.84595, -2799.04004, 1607.16797,   0.00000, 90.00000, -90.0000, world );
			HTextureRoof [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19377, -1506.84595, -2799.04004, 1627.16797,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureStairs [ h ] [ 0 ] = CreateDynamicObject(14409, -1497.40002, -2800.30005, 1600.40002,   0.00000, 0.00000, 0.0000, world );
			HTextureStairs [ h ] [ 1 ] = CreateDynamicObject(14409, -1497.40002, -2800.30005, 1620.40002,   0.00000, 0.00000, 0.0000, world );
		}
		
		case 30: // Двухэтажный 3
		{
			HTextureWall [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19397, -1501.69995, -2792.27002, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1504.91003, -2792.27002, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -1505.66003, -2797.16992, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -1505.66003, -2802.79004, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -1503.97595, -2802.50000, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1500.76416, -2799.31641, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1502.28003, -2797.62207, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1498.92004, -2793.41992, 2201.83789,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19369, -1496.65002, -2795.68994, 2201.83789,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19369, -1501.11804, -2797.21558, 2201.83789,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19442, -1499.41602, -2798.91797, 2201.83789,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19397, -1495.49500, -2798.46997, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1495.49500, -2801.67993, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -1495.49500, -2804.08789, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -1495.49500, -2806.49512, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -1497.18506, -2808.18506, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1498.87451, -2803.43604, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1498.87451, -2801.02808, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -1499.41602, -2804.74341, 2201.83789,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19442, -1500.00500, -2806.16992, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19442, -1499.41602, -2807.59497, 2201.83789,   0.00000, 0.00000, 45.0000, world );
			 
			HTextureWall [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19460, -1507.18005, -2792.27002, 2205.33813,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -1505.66003, -2797.16992, 2205.33813,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -1505.66003, -2802.79004, 2205.33813,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, -1503.97595, -2802.50000, 2205.33813,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -1497.55396, -2802.50000, 2205.33813,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19396, -1494.34399, -2802.50000, 2205.33813,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -1487.92200, -2802.50000, 2205.33813,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -1489.10999, -2801.39990, 2205.33813,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19396, -1490.45996, -2798.93994, 2205.33813,   0.00000, 0.00000, 55.0000, world );
			CreateDynamicObject(19368, -1494.34399, -2799.31641, 2205.33813,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19396, -1497.55396, -2799.31641, 2205.33813,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -1500.76416, -2799.31641, 2205.33813,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -1502.28003, -2794.40991, 2205.33813,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19441, -1492.35095, -2798.69653, 2205.33813,   0.00000, 0.00000, -35.0000, world );
			 
			HTextureWall [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19395, -1495.31702, -2798.46997, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19367, -1495.31702, -2795.26001, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19440, -1494.44995, -2793.58008, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19440, -1493.14197, -2793.03906, 2201.83789,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19367, -1490.91504, -2792.44995, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19440, -1488.69995, -2793.03906, 2201.83789,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19440, -1487.39197, -2793.58008, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19459, -1486.51001, -2798.47998, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19459, -1490.42004, -2800.07007, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19394, -1495.31702, -2806.49512, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19438, -1495.31702, -2804.08789, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19365, -1495.31702, -2801.67993, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, -1490.42004, -2800.09009, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, -1489.00000, -2804.98999, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19457, -1490.43005, -2808.10010, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19364, -1493.97400, -2808.36304, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19364, -1493.22998, -2810.04004, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19437, -1493.81995, -2812.26001, 2201.83789,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19364, -1496.05005, -2812.85205, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19437, -1498.28003, -2812.26001, 2201.83789,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19364, -1498.87000, -2810.04004, 2201.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19393, -1497.18506, -2808.36304, 2201.83789,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19390, -1497.55396, -2799.13843, 2205.33813,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19453, -1495.87000, -2794.27002, 2205.33813,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19453, -1497.09998, -2793.04004, 2205.33813,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19453, -1501.96997, -2793.11011, 2205.33813,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19434, -1501.38000, -2798.55005, 2205.33813,   0.00000, 0.00000, 45.0000, world );
			HTextureWall [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19434, -1499.95996, -2799.13843, 2205.33813,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 6 ] [ 0 ] = CreateDynamicObject(19389, -1490.35815, -2798.79443, 2205.33813,   0.00000, 0.00000, 55.0000, world );
			CreateDynamicObject(19359, -1487.72864, -2800.63599, 2205.33813,   0.00000, 0.00000, 55.0000, world );
			CreateDynamicObject(19451, -1483.55005, -2797.60010, 2205.33813,   0.00000, 0.00000, -35.0000, world );
			CreateDynamicObject(19451, -1487.50000, -2794.70996, 2205.33813,   0.00000, 0.00000, 55.0000, world );
			CreateDynamicObject(19451, -1491.56006, -2791.97998, 2205.33813,   0.00000, 0.00000, -35.0000, world );
			HTextureWall [ h ] [ 6 ] [ 1 ] = CreateDynamicObject(19359, -1492.98804, -2796.95313, 2205.33813,   0.00000, 0.00000, 55.0000, world );
			 
			HTextureWall [ h ] [ 7 ] [ 0 ] = CreateDynamicObject(19358, -1497.55396, -2802.67798, 2205.33813,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19431, -1499.78003, -2803.27002, 2205.33813,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19358, -1500.37000, -2805.50000, 2205.33813,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19431, -1499.78003, -2807.72998, 2205.33813,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19450, -1494.34399, -2808.32007, 2205.33813,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19431, -1488.91003, -2807.72998, 2205.33813,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19358, -1488.31995, -2805.50000, 2205.33813,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19431, -1488.91003, -2803.27002, 2205.33813,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19358, -1491.13403, -2802.67798, 2205.33813,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 7 ] [ 1 ] = CreateDynamicObject(19388, -1494.34399, -2802.67798, 2205.33813,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19379, -1500.92004, -2797.32007, 2200.00000,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19379, -1491.28601, -2797.32007, 2200.00000,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19379, -1491.28601, -2807.82007, 2200.00000,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19379, -1500.92004, -2807.82007, 2200.00000,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureFloor [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19363, -1504.09998, -2800.82690, 2201.60010,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19363, -1504.09998, -2800.82690, 2221.60010,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19378, -1494.55701, -2804.04492, 2203.50293,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19378, -1494.55701, -2794.41187, 2203.50293,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19378, -1484.05603, -2804.04492, 2203.50293,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19376, -1490.15601, -2795.16504, 2200.00293,   0.00000, 90.00000, -180.0000, world );
			HTextureFloor [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19376, -1490.15601, -2795.16504, 2220.00293,   0.00000, 90.00000, -180.0000, world );
			 
			HTextureFloor [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19375, -1490.15601, -2804.98999, 2200.00293,   0.00000, 90.00000, -180.0000, world );
			HTextureFloor [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19375, -1490.15601, -2804.98999, 2210.00293,   0.00000, 90.00000, -180.0000, world );
			 
			HTextureFloor [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19462, -1494.00000, -2810.02197, 2200.00610,   0.00000, 90.00000, -270.0000, world );
			HTextureFloor [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19462, -1494.00000, -2813.52197, 2200.00610,   0.00000, 90.00000, -270.0000, world );
			 
			HTextureFloor [ h ] [ 6 ] [ 0 ] = CreateDynamicObject(19458, -1496.70007, -2794.41089, 2203.50610,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 6 ] [ 1 ] = CreateDynamicObject(19458, -1500.19995, -2794.41089, 2203.50610,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 7 ] [ 0 ] = CreateDynamicObject(19452, -1489.41699, -2797.42896, 2203.50610,   0.00000, 90.00000, 55.0000, world );
			HTextureFloor [ h ] [ 7 ] [ 1 ] = CreateDynamicObject(19452, -1487.41016, -2794.56299, 2203.50610,   0.00000, 90.00000, 55.0000, world );
			 
			HTextureFloor [ h ] [ 8 ] [ 0 ] = CreateDynamicObject(19448, -1494.34399, -2807.40381, 2203.50610,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19448, -1497.84399, -2807.40381, 2203.50610,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19448, -1501.34204, -2807.40381, 2203.50610,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19448, -1490.84387, -2807.40381, 2203.50610,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 8 ] [ 1 ] = CreateDynamicObject(19448, -1487.34595, -2807.40381, 2203.50610,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19381, -1497.11597, -2794.58008, 2203.49878,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -1494.51599, -2804.21411, 2203.49878,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -1484.01599, -2804.21411, 2203.49878,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -1500.59998, -2796.60010, 2207.17505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -1486.61597, -2794.58008, 2203.49878,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -1500.59998, -2806.23389, 2207.17505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -1490.09998, -2806.23389, 2207.17505,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19381, -1490.09998, -2796.60010, 2207.17505,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19380, -1490.15601, -2795.16504, 2203.49609,   0.00000, 90.00000, -180.0000, world );
			HTextureRoof [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19380, -1490.15601, -2795.16504, 2223.49609,   0.00000, 90.00000, -180.0000, world );
			 
			HTextureRoof [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19454, -1494.00000, -2810.02197, 2203.49609,   0.00000, 90.00000, -270.0000, world );
			HTextureRoof [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19454, -1494.00000, -2813.52197, 2203.49609,   0.00000, 90.00000, -270.0000, world );
			 
			HTextureRoof [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19463, -1489.41699, -2797.42896, 2207.17090,   0.00000, 90.00000, 55.0000, world );
			HTextureRoof [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19463, -1487.41016, -2794.56299, 2207.17090,   0.00000, 90.00000, 55.0000, world );
			 
			HTextureRoof [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19377, -1500.59998, -2807.50000, 2207.17090,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19377, -1490.09998, -2807.50000, 2207.17090,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureStairs [ h ] [ 0 ] = CreateDynamicObject(14409, -1501.63000, -2801.28003, 2200.39990,   0.00000, 0.00000, 90.0000, world );
			HTextureStairs [ h ] [ 1 ] = CreateDynamicObject(14409, -1504.40002, -2797.39990, 2198.50000,   0.00000, 0.00000, 0.0000, world );
		}
		
		case 31: // Двухэтажный 4
		{
			HTextureWall [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19397, -1498.00000, -2795.89990, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1500.04004, -2801.60010, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1500.04004, -2804.81006, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1495.94592, -2801.60010, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1495.94592, -2804.81006, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -1500.25598, -2795.51001, 2801.83789,   0.00000, 0.00000, 60.0000, world );
			CreateDynamicObject(19369, -1502.59595, -2795.09985, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1495.74402, -2795.51001, 2801.83789,   0.00000, 0.00000, -60.0000, world );
			CreateDynamicObject(19369, -1493.40503, -2795.09985, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1492.59998, -2795.98193, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -1492.60010, -2798.38989, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1492.59998, -2801.60010, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -1492.59998, -2804.81006, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1492.59998, -2808.02002, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1494.20996, -2809.70508, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1496.46594, -2810.09497, 2801.83789,   0.00000, 0.00000, -60.0000, world );
			CreateDynamicObject(19442, -1498.00000, -2810.50708, 2801.83789,   0.00000, 0.00000, -90.0000, world );
			CreateDynamicObject(19442, -1499.53015, -2810.09497, 2801.83789,   0.00000, 0.00000, 60.0000, world );
			CreateDynamicObject(19369, -1501.78699, -2809.70581, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1503.40002, -2808.02002, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -1503.40002, -2804.81006, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1503.40002, -2801.60010, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -1503.40002, -2798.38989, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -1503.40002, -2795.98193, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -1499.45605, -2806.86353, 2801.83789,   0.00000, 0.00000, 50.0000, world );
			CreateDynamicObject(19442, -1498.00000, -2807.22388, 2801.83789,   0.00000, 0.00000, -90.0000, world );
			HTextureWall [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19442, -1496.52893, -2806.86401, 2801.83789,   0.00000, 0.00000, -50.0000, world );
			 
			HTextureWall [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19368, -1498.00000, -2795.89990, 2805.33789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -1500.25598, -2795.51001, 2805.33789,   0.00000, 0.00000, 60.0000, world );
			CreateDynamicObject(19441, -1495.74402, -2795.51001, 2805.33789,   0.00000, 0.00000, -60.0000, world );
			CreateDynamicObject(19368, -1493.40503, -2795.09985, 2805.33789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -1502.59595, -2795.09985, 2805.33789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -1503.40002, -2795.17798, 2805.33789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19396, -1503.40002, -2801.60010, 2805.33789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -1503.40002, -2804.81006, 2805.33789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -1503.40002, -2808.02002, 2805.33789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19396, -1501.78699, -2809.70581, 2805.33789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -1499.45300, -2809.29492, 2805.33789,   0.00000, 0.00000, -60.0000, world );
			CreateDynamicObject(19441, -1498.00000, -2808.90601, 2805.33789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -1496.54700, -2809.29492, 2805.33789,   0.00000, 0.00000, 60.0000, world );
			CreateDynamicObject(19396, -1494.20996, -2809.70508, 2805.33789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -1492.59998, -2808.02002, 2805.33789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -1492.59998, -2804.81006, 2805.33789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19396, -1492.59998, -2801.60010, 2805.33789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19460, -1492.59998, -2795.17798, 2805.33789,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19393, -1492.42200, -2798.38989, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19364, -1492.42200, -2801.60010, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19393, -1492.42200, -2804.81006, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19456, -1487.52002, -2806.50000, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19456, -1486.00000, -2801.60010, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19456, -1487.52002, -2796.69995, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19440, -1504.40002, -2795.52002, 2801.83789,   0.00000, 0.00000, -60.0000, world );
			CreateDynamicObject(19367, -1506.65649, -2795.90942, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19440, -1508.91296, -2795.52002, 2801.83789,   0.00000, 0.00000, 60.0000, world );
			CreateDynamicObject(19459, -1509.71997, -2800.00000, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19367, -1509.71997, -2806.42188, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19440, -1508.91296, -2807.67993, 2801.83789,   0.00000, 0.00000, -60.0000, world );
			CreateDynamicObject(19395, -1506.65649, -2807.29077, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19440, -1504.40002, -2807.67993, 2801.83789,   0.00000, 0.00000, 60.0000, world );
			CreateDynamicObject(19440, -1503.57800, -2807.21802, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19367, -1503.57800, -2801.60010, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19440, -1503.57800, -2795.98193, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19395, -1503.57800, -2798.38989, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19395, -1503.57800, -2804.81006, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19394, -1506.65649, -2807.46875, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19438, -1504.96497, -2808.35498, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19438, -1504.31445, -2809.48169, 2801.83789,   0.00000, 0.00000, 60.0000, world );
			CreateDynamicObject(19365, -1503.58997, -2811.53979, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, -1508.48999, -2813.22021, 2801.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19365, -1509.71997, -2811.53979, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19438, -1508.99402, -2809.48169, 2801.83789,   0.00000, 0.00000, -60.0000, world );
			HTextureWall [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19438, -1508.34302, -2808.35498, 2801.83789,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19389, -1501.78699, -2809.88379, 2805.33789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19432, -1499.53101, -2809.49390, 2805.33789,   0.00000, 0.00000, -60.0000, world );
			CreateDynamicObject(19432, -1498.00000, -2809.08008, 2805.33789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19432, -1496.46594, -2809.49390, 2805.33789,   0.00000, 0.00000, 60.0000, world );
			CreateDynamicObject(19389, -1494.20996, -2809.88379, 2805.33789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19451, -1492.52002, -2814.76831, 2805.33789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19451, -1493.19995, -2814.87012, 2805.33789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19451, -1502.83398, -2814.87012, 2805.33789,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19451, -1503.45996, -2814.77002, 2805.33789,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 6 ] [ 0 ] = CreateDynamicObject(19453, -1492.42200, -2795.17798, 2805.33789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19453, -1487.52002, -2796.69995, 2805.33789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19453, -1486.00000, -2801.60010, 2805.33789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19453, -1487.52002, -2806.50000, 2805.33789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19453, -1492.42200, -2808.02197, 2805.33789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 6 ] [ 1 ] = CreateDynamicObject(19390, -1492.42200, -2801.60010, 2805.33789,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 7 ] [ 0 ] = CreateDynamicObject(19450, -1503.57800, -2808.02197, 2805.33789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19450, -1508.47998, -2806.50000, 2805.33789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19450, -1510.09998, -2801.60010, 2805.33789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19450, -1508.47998, -2796.69995, 2805.33789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19450, -1503.57800, -2795.17798, 2805.33789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 7 ] [ 1 ] = CreateDynamicObject(19388, -1503.57800, -2801.60010, 2805.33789,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19379, -1498.00000, -2800.39990, 2800.00000,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19379, -1507.63403, -2800.39990, 2800.00000,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19379, -1488.36597, -2800.39990, 2800.00000,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19379, -1488.36597, -2810.89990, 2800.00000,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19379, -1498.00000, -2810.89990, 2800.00000,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19379, -1507.63403, -2810.89990, 2800.00000,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureFloor [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19378, -1490.78003, -2799.96997, 2803.50098,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19378, -1498.20996, -2819.23804, 2803.50098,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19378, -1487.71790, -2819.23804, 2803.50098,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19378, -1487.71790, -2809.60400, 2803.50098,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19378, -1498.21753, -2809.60400, 2803.50098,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19378, -1505.20898, -2799.96997, 2803.50098,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19376, -1487.69495, -2801.60010, 2800.00293,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19376, -1487.69495, -2801.60010, 2820.00293,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureFloor [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19375, -1508.30005, -2800.44995, 2800.00293,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19375, -1508.30005, -2810.94995, 2800.00293,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureFloor [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19370, -1506.65649, -2809.12793, 2800.00488,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19370, -1506.65649, -2812.62793, 2800.00488,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19370, -1509.86694, -2814.34399, 2800.00488,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19370, -1509.86694, -2810.84497, 2800.00488,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19443, -1504.24805, -2810.84497, 2800.00488,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19443, -1504.24805, -2814.34399, 2800.00488,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19458, -1490.76196, -2801.60010, 2803.50391,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19458, -1487.26404, -2801.60010, 2803.50391,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 6 ] [ 0 ] = CreateDynamicObject(19452, -1505.23804, -2801.60010, 2803.50391,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 6 ] [ 1 ] = CreateDynamicObject(19452, -1508.73804, -2801.60010, 2803.50391,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19381, -1505.20605, -2799.96997, 2803.49609,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -1498.21753, -2809.60400, 2803.49609,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -1487.71790, -2809.60400, 2803.49609,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -1490.78296, -2799.96997, 2803.49609,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -1507.63306, -2799.69995, 2807.17505,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19381, -1498.00000, -2799.69995, 2807.17505,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19381, -1488.36584, -2799.69995, 2807.17505,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19381, -1488.36584, -2810.19995, 2807.17505,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19381, -1498.00000, -2810.19995, 2807.17505,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19381, -1507.63306, -2810.19995, 2807.17505,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19377, -1487.69495, -2801.60010, 2803.49219,   0.00000, 90.00000, -90.0000, world );
			HTextureRoof [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19377, -1487.69495, -2801.60010, 2823.49219,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureRoof [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19380, -1508.30005, -2800.44995, 2803.49219,   0.00000, 90.00000, -90.0000, world );
			HTextureRoof [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19380, -1508.30005, -2810.94995, 2803.49219,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureRoof [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19362, -1506.65649, -2809.12793, 2803.48828,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19362, -1506.65649, -2812.62793, 2803.48828,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19435, -1504.24805, -2810.84497, 2803.48828,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19435, -1504.24805, -2814.34399, 2803.48828,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19362, -1509.86694, -2810.84497, 2803.48828,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19362, -1509.86694, -2814.34399, 2803.48828,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19463, -1490.76196, -2801.60010, 2807.17090,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19463, -1487.26404, -2801.60010, 2807.17090,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19463, -1505.23804, -2801.60010, 2807.17090,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19463, -1508.73804, -2801.60010, 2807.17090,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureStairs [ h ] [ 0 ] = CreateDynamicObject(14409, -1498.00000, -2802.96387, 2800.40088,   0.00000, 0.00000, 0.0000, world );
			HTextureStairs [ h ] [ 1 ] = CreateDynamicObject(14409, -1498.00000, -2802.96387, 2820.40088,   0.00000, 0.00000, 0.0000, world );
		}
		
		case 32: // Двухэтажный 5
		{
			HTextureWall [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19397, -2098.91992, -2796.60010, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -2101.02881, -2796.05811, 1601.83801,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19442, -2102.45508, -2795.47021, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -2103.87988, -2796.05811, 1601.83801,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19442, -2096.80957, -2796.05811, 1601.83801,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19442, -2093.96997, -2796.05811, 1601.83801,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19442, -2095.38501, -2795.47021, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -2104.46997, -2798.28003, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2102.77490, -2799.79590, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -2101.25806, -2800.68799, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -2101.25806, -2803.09595, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -2101.25806, -2809.51611, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -2098.11987, -2809.77197, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -2093.22998, -2808.08691, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2094.74634, -2806.39404, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -2096.94531, -2805.83203, 1601.83801, 0.00000, 0.00000, 56.68000, world );
			CreateDynamicObject(19442, -2097.67651, -2804.71021, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2097.67017, -2802.29004, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2097.02002, -2800.36011, 1601.83801,   0.00000, 0.00000, -60.0000, world );
			CreateDynamicObject(19397, -2093.37988, -2798.28003, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2093.37988, -2801.48999, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2093.37988, -2804.69995, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2096.28101, -2804.69995, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19369, -2096.28101, -2801.48804, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19441, -2095.38501, -2795.47021, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -2100.50000, -2796.04810, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -2096.80957, -2796.05811, 1605.33801,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19441, -2093.96997, -2796.05811, 1605.33801,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19368, -2098.91992, -2796.60010, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19396, -2100.50000, -2798.45581, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -2100.50000, -2801.66602, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19396, -2100.50000, -2804.87622, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -2100.50000, -2808.08691, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, -2093.30005, -2809.77197, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -2102.93384, -2809.77197, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -2088.39990, -2808.08691, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -2089.27808, -2806.39771, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19396, -2091.68506, -2806.39771, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -2093.37988, -2801.66992, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19460, -2093.37988, -2792.03613, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19440, -2092.33008, -2799.96997, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19367, -2091.61646, -2801.66431, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19440, -2091.04004, -2803.87988, 1601.83801,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19459, -2085.62012, -2804.44995, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19440, -2086.55005, -2803.87988, 1601.83801,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19459, -2085.95996, -2801.48999, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19440, -2086.55005, -2796.05005, 1601.83801,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19459, -2087.17993, -2795.45996, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19440, -2092.61011, -2796.05005, 1601.83801,   0.00000, 0.00000, -45.0000, world );
			HTextureWall [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19395, -2093.20190, -2798.28003, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19456, -2109.55005, -2796.60010, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19456, -2109.64990, -2801.50000, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19456, -2106.33008, -2804.77002, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19393, -2101.43604, -2803.09595, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19437, -2101.43604, -2800.68799, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19364, -2103.13062, -2799.97510, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19393, -2104.64697, -2798.28003, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19394, -2093.05200, -2808.08691, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19438, -2092.16992, -2806.41211, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19438, -2091.45703, -2805.52100, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19365, -2089.77002, -2804.64209, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, -2088.08984, -2809.53198, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19457, -2088.15991, -2809.77197, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19361, -2088.47485, -2806.21973, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19453, -2086.80005, -2801.33008, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19453, -2088.46997, -2799.80005, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19453, -2093.37012, -2801.33008, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19390, -2091.68506, -2806.21973, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 6 ] [ 0 ] = CreateDynamicObject(19389, -2100.67798, -2804.87622, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19359, -2100.67798, -2801.66602, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19451, -2105.57495, -2800.91992, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19359, -2105.13989, -2802.08008, 1605.33801,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19359, -2106.30005, -2804.87622, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19359, -2105.13989, -2807.66992, 1605.33801,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19451, -2105.57495, -2808.83008, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 6 ] [ 1 ] = CreateDynamicObject(19359, -2100.67798, -2808.08691, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 7 ] [ 0 ] = CreateDynamicObject(19388, -2100.67798, -2798.45581, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19431, -2100.67798, -2796.04810, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19450, -2105.57495, -2795.19995, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19450, -2105.95093, -2796.18164, 1605.33801,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 7 ] [ 1 ] = CreateDynamicObject(19450, -2105.57495, -2800.14014, 1605.33801,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19379, -2096.52979, -2800.50000, 1600.00000,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19379, -2106.16382, -2800.50000, 1600.00000,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19379, -2096.52979, -2811.00195, 1600.00000,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19378, -2091.37793, -2809.97510, 1603.50195,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19378, -2101.01221, -2809.97510, 1603.50195,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19378, -2101.01221, -2799.47388, 1603.50195,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19376, -2088.04199, -2799.55005, 1600.00305,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19376, -2088.04199, -2799.55005, 1620.00305,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19462, -2106.16309, -2801.81079, 1600.00305,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19462, -2106.16309, -2805.31006, 1600.00305,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19462, -2109.37622, -2798.31006, 1600.00305,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19458, -2088.32495, -2806.46997, 1600.00305,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19458, -2088.32495, -2809.96802, 1600.00305,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19375, -2088.03491, -2801.49292, 1603.50598,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19375, -2088.03491, -2801.49292, 1623.50598,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 6 ] [ 0 ] = CreateDynamicObject(19452, -2102.33813, -2804.87622, 1603.50598,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 6 ] [ 1 ] = CreateDynamicObject(19452, -2105.83813, -2804.87622, 1603.50598,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 7 ] [ 0 ] = CreateDynamicObject(19448, -2102.33813, -2795.23999, 1603.50598,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 7 ] [ 1 ] = CreateDynamicObject(19448, -2105.83813, -2795.23999, 1603.50598,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19381, -2101.01025, -2799.47412, 1603.49805,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19381, -2100.99829, -2809.97510, 1603.49805,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19381, -2091.36401, -2809.97510, 1603.49805,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19381, -2110.64380, -2799.47388, 1603.49805,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19381, -2091.50000, -2810.41992, 1607.17200,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19381, -2101.13379, -2810.41992, 1607.17200,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19381, -2101.13379, -2799.91992, 1607.17200,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19381, -2091.50000, -2799.91992, 1607.17200,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19377, -2088.04004, -2799.55005, 1603.49402,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19377, -2088.04004, -2799.55005, 1623.49402,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19454, -2088.32495, -2806.46997, 1603.49402,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19454, -2088.32495, -2809.96802, 1603.49402,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19463, -2102.33813, -2804.87622, 1607.16797,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19463, -2105.83813, -2804.87622, 1607.16797,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureStairs [ h ] [ 0 ] = CreateDynamicObject(14409, -2094.19995, -2802.89990, 1600.40198,   0.00000, 0.00000, 0.0000, world );
			HTextureStairs [ h ] [ 1 ] = CreateDynamicObject(14409, -2094.19995, -2802.89990, 1620.40198,   0.00000, 0.00000, 0.0000, world );
		}
		
		case 33: // Особняк 1
		{
			HTextureWall [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19397, -2107.94995, -2801.52808, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2106.39990, -2803.16479, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -2104.70605, -2803.87842, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2103.85107, -2804.60815, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -2103.13794, -2805.50000, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -2101.44507, -2806.25000, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2099.75195, -2804.57007, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2103.85205, -2796.80005, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2106.26001, -2796.80005, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2107.94995, -2798.31812, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2104.73999, -2792.70190, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2104.73999, -2795.11011, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2103.85205, -2791.82007, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2103.13794, -2790.12598, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2103.13794, -2786.91602, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2103.13794, -2784.50806, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -2103.13794, -2782.10010, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -2101.44507, -2780.58496, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -2099.75195, -2782.10010, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2099.75195, -2785.31006, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -2099.75195, -2788.52002, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -2099.75195, -2791.72998, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2099.75195, -2794.93994, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -2099.75195, -2798.14990, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19369, -2099.75195, -2801.36011, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19388, -2101.44507, -2806.42798, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19358, -2103.13794, -2808.12012, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19431, -2104.03003, -2809.63647, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19450, -2108.03003, -2806.42798, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19450, -2107.94995, -2811.32007, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19450, -2107.88379, -2816.19995, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19450, -2098.25000, -2816.19995, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19358, -2093.35156, -2814.51660, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19358, -2091.57007, -2811.32007, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19431, -2092.45996, -2813.00000, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19358, -2093.24194, -2809.63647, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19388, -2096.45190, -2809.63647, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19431, -2098.86011, -2809.63647, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19358, -2099.75195, -2808.12012, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19387, -2096.45190, -2809.45850, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19357, -2094.77002, -2807.77002, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19357, -2094.77002, -2804.56006, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19449, -2094.83008, -2803.50610, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19357, -2099.72998, -2804.56006, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19357, -2099.72998, -2807.77002, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19430, -2098.86011, -2809.45850, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19389, -2099.57397, -2798.14990, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19451, -2094.69995, -2796.55786, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19451, -2094.75000, -2801.45801, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19451, -2094.69995, -2803.04004, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19359, -2099.57397, -2801.36011, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19390, -2099.57397, -2791.72998, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19361, -2099.57397, -2794.93994, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19453, -2094.69995, -2796.52783, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19434, -2094.75000, -2795.63989, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19434, -2094.54492, -2794.08594, 2101.83789,   0.00000, 0.00000, -15.0000, world );
			CreateDynamicObject(19434, -2094.54541, -2792.57422, 2101.83789,   0.00000, 0.00000, 15.0000, world );
			CreateDynamicObject(19434, -2094.75000, -2791.02002, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19453, -2094.69995, -2790.12988, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19393, -2099.57397, -2788.52002, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19364, -2099.57397, -2785.31006, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19456, -2094.69995, -2783.75000, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19437, -2094.75000, -2784.56396, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19437, -2094.54541, -2786.11816, 2101.83789,   0.00000, 0.00000, 15.0000, world );
			CreateDynamicObject(19437, -2094.54492, -2787.70996, 2101.83789,   0.00000, 0.00000, -15.0000, world );
			CreateDynamicObject(19437, -2094.75000, -2789.26416, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19456, -2094.69995, -2790.08008, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 6 ] [ 0 ] = CreateDynamicObject(19394, -2099.57397, -2782.10010, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19438, -2098.68994, -2780.58496, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, -2097.97607, -2775.67993, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, -2093.08008, -2777.25000, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, -2093.14990, -2778.81006, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 6 ] [ 1 ] = CreateDynamicObject(19457, -2094.69995, -2783.70996, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 7 ] [ 0 ] = CreateDynamicObject(19395, -2101.44507, -2780.40698, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19440, -2103.85400, -2780.40698, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19367, -2104.70996, -2778.72998, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, -2099.82007, -2777.05005, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19367, -2098.14990, -2778.72998, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 7 ] [ 1 ] = CreateDynamicObject(19440, -2099.03809, -2780.40698, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 8 ] [ 0 ] = CreateDynamicObject(19396, -2103.31592, -2782.10010, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -2103.31592, -2785.31104, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, -2108.19995, -2787.00000, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -2109.35010, -2782.10010, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, -2109.81006, -2777.19995, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -2104.91382, -2778.73511, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 8 ] [ 1 ] = CreateDynamicObject(19441, -2104.19995, -2780.42993, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19379, -2104.45996, -2801.08887, 2100.00000,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19379, -2104.47998, -2790.59009, 2100.00000,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19379, -2104.47998, -2780.09009, 2100.00000,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19378, -2104.47998, -2811.59009, 2100.00000,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19378, -2094.84619, -2811.59009, 2100.00000,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19462, -2094.85010, -2807.80005, 2100.00293,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19462, -2094.85010, -2804.30005, 2100.00293,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19458, -2094.84790, -2801.82422, 2100.00610,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19458, -2094.84790, -2798.32495, 2100.00610,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19376, -2094.84814, -2791.19995, 2100.00000,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19376, -2094.84814, -2780.69995, 2100.00000,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19452, -2094.84790, -2782.07007, 2100.00293,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19452, -2094.84790, -2778.57007, 2100.00293,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 6 ] [ 0 ] = CreateDynamicObject(19356, -2103.05420, -2778.74707, 2100.00610,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor [ h ] [ 6 ] [ 1 ] = CreateDynamicObject(19356, -2099.84302, -2778.74707, 2100.00610,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureFloor [ h ] [7 ] [ 0 ] = CreateDynamicObject(19375, -2108.04004, -2781.66992, 2100.00293,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [7 ] [ 1 ] = CreateDynamicObject(19375, -2108.04004, -2781.66992, 2120.00293,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19381, -2104.45996, -2801.08887, 2103.67407,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19381, -2104.47998, -2790.59009, 2103.67407,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19381, -2104.47998, -2780.09009, 2103.67407,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19377, -2104.47998, -2811.59009, 2103.67407,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19377, -2094.84619, -2811.59009, 2103.67407,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19454, -2094.85010, -2807.80005, 2103.66992,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19454, -2094.85010, -2804.30005, 2103.66992,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19463, -2094.84595, -2801.82422, 2103.66602,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19463, -2094.84595, -2798.32495, 2103.66602,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19380, -2094.84619, -2791.19995, 2103.67407,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19380, -2094.84619, -2780.69995, 2103.67407,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19373, -2099.84302, -2778.74512, 2103.66992,   0.00000, 90.00000, -90.0000, world );
			HTextureRoof [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19373, -2103.05420, -2778.74512, 2103.66992,   0.00000, 90.00000, -90.0000, world );
		}
		
		case 34: // Особняк 2
		{
			HTextureWall [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19397, -2707.85010, -2800.35010, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2708.56396, -2798.65601, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -2709.44995, -2793.76001, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -2701.28809, -2792.64380, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2700.57495, -2797.55005, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -2699.86182, -2792.64380, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -2694.96191, -2789.37988, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -2689.52002, -2789.96997, 1601.83801,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19369, -2688.92993, -2792.18994, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2689.52002, -2794.39990, 1601.83801,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19442, -2690.06152, -2795.70752, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2689.52002, -2797.01489, 1601.83801,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19369, -2688.92993, -2799.24512, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2689.52002, -2801.47778, 1601.83801,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19369, -2690.13794, -2802.04004, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -2696.56006, -2802.04004, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -2699.68506, -2803.72998, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2700.57495, -2805.38989, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2701.28809, -2807.08496, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -2702.97998, -2808.63013, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -2704.65381, -2807.74805, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -2704.65381, -2805.34009, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2704.65381, -2802.93188, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2706.16992, -2802.04004, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -2709.38208, -2793.67993, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -2704.65381, -2791.98608, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2704.65381, -2788.77588, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19397, -2702.97998, -2788.69995, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19396, -2704.83179, -2791.98608, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -2704.83179, -2788.77588, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, -2709.71094, -2787.10010, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -2709.42505, -2788.78003, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19460, -2709.72998, -2793.65991, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19395, -2702.97998, -2788.52197, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19440, -2701.30005, -2787.63501, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19367, -2699.60620, -2786.92090, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19367, -2697.91992, -2785.25000, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, -2699.73999, -2783.56006, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19459, -2704.63989, -2783.62012, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19394, -2704.83179, -2805.34009, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19365, -2704.83179, -2808.55005, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19438, -2704.83179, -2802.93188, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, -2709.72998, -2802.06006, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, -2709.60010, -2806.95996, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19438, -2708.75806, -2810.24194, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19394, -2706.35010, -2810.24194, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19393, -2706.35010, -2810.41992, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19437, -2708.75806, -2810.41992, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19456, -2709.58008, -2815.32007, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19456, -2709.71997, -2815.48999, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19456, -2704.83179, -2815.32007, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19390, -2702.97998, -2808.80811, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19434, -2701.29004, -2809.68994, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19453, -2696.38403, -2810.40356, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19453, -2697.89990, -2815.30005, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19453, -2699.77002, -2815.30005, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19453, -2704.66992, -2813.70996, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 6 ] [ 0 ] = CreateDynamicObject(19388, -2699.50708, -2803.72998, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19450, -2694.60498, -2802.05005, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19450, -2691.65991, -2806.94995, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19450, -2694.62988, -2808.61011, 1601.83801,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 6 ] [ 1 ] = CreateDynamicObject(19358, -2699.50708, -2806.93994, 1601.83801,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19379, -2704.11011, -2806.79419, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -2704.11011, -2797.15991, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -2704.11011, -2787.52588, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -2693.61011, -2787.52588, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19379, -2693.61011, -2797.15991, 1600.00000,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19356, -2694.98999, -2794.69995, 1600.05005,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19356, -2694.98999, -2791.19995, 1600.05005,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19356, -2698.19995, -2791.19995, 1600.05005,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19356, -2698.19995, -2794.69995, 1600.05005,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19378, -2709.98999, -2788.78003, 1600.00403,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19378, -2709.98999, -2788.78003, 1620.00403,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19462, -2702.97998, -2783.79492, 1600.00403,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19462, -2699.47998, -2783.79492, 1600.00403,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19375, -2709.55786, -2807.35010, 1600.00403,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19375, -2709.55786, -2807.35010, 1620.00403,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureFloor [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19452, -2709.64990, -2812.08105, 1600.00806,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19452, -2709.64990, -2815.58008, 1600.00806,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 6 ] [ 0 ] = CreateDynamicObject(19376, -2699.80493, -2813.96802, 1600.00403,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor [ h ] [ 6 ] [ 1 ] = CreateDynamicObject(19376, -2699.80493, -2813.96802, 1620.00403,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureFloor [ h ] [ 7 ] [ 0 ] = CreateDynamicObject(19458, -2694.78003, -2803.72998, 1600.00403,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 7 ] [ 1 ] = CreateDynamicObject(19458, -2694.78003, -2807.22803, 1600.00403,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19381, -2704.11011, -2797.15991, 1603.67004,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -2704.11011, -2787.52588, 1603.67004,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -2693.61011, -2797.15991, 1603.67004,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -2693.61011, -2787.52588, 1603.67004,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19381, -2704.11011, -2806.79419, 1603.67004,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19380, -2709.98999, -2788.78003, 1603.66602,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19380, -2709.98999, -2788.78003, 1623.66602,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19372, -2702.97998, -2786.83008, 1603.66296,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19372, -2702.97998, -2783.61890, 1603.66296,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19372, -2699.47998, -2786.83008, 1603.66296,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19372, -2699.47998, -2783.61890, 1603.66296,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19377, -2709.55786, -2807.35010, 1603.66602,   0.00000, 90.00000, -90.0000, world );
			HTextureRoof [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19377, -2709.55786, -2807.35010, 1623.66602,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureRoof [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19373, -2706.43994, -2812.08496, 1603.66296,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19373, -2709.64990, -2812.08496, 1603.66296,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19373, -2709.64990, -2815.58398, 1603.66296,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19373, -2706.43994, -2815.58398, 1603.66296,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19454, -2699.80493, -2814.10010, 1603.66602,   0.00000, 90.00000, -90.0000, world );
			HTextureRoof [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19454, -2699.80493, -2810.60010, 1603.66602,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureRoof [ h ] [ 6 ] [ 0 ] = CreateDynamicObject(19463, -2694.78003, -2803.72998, 1603.66296,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 6 ] [ 1 ] = CreateDynamicObject(19463, -2694.78003, -2807.22803, 1603.66296,   0.00000, 90.00000, 90.0000, world );
		}
		
		case 35: // Особняк 3
		{
			HTextureWall [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19397, -2706.27002, -2801.28003, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2704.58081, -2802.94995, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -2701.37012, -2802.94995, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -2706.27002, -2798.87183, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -2704.58081, -2797.97998, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2701.37012, -2797.97998, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -2699.68994, -2798.87183, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -2697.99609, -2799.58496, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -2691.57397, -2799.58496, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -2685.15210, -2799.58496, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -2681.94189, -2799.58496, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2678.73193, -2799.58496, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2677.77002, -2801.28003, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -2679.45190, -2802.94995, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -2681.14697, -2807.67798, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -2686.05005, -2809.20996, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2686.12256, -2807.84912, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2686.83618, -2806.15503, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -2687.55005, -2807.04590, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -2688.97998, -2808.38989, 2101.83789,   0.00000, 0.00000, -60.0000, world );
			CreateDynamicObject(19369, -2692.01001, -2809.20386, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2695.04004, -2808.38989, 2101.83789,   0.00000, 0.00000, 60.0000, world );
			CreateDynamicObject(19442, -2696.46655, -2807.04712, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -2697.17993, -2806.15503, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -2698.07007, -2804.46655, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19442, -2698.96191, -2802.94995, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19395, -2701.37012, -2803.12793, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19440, -2698.96191, -2803.12793, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19367, -2698.08008, -2804.80005, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19440, -2698.96997, -2806.32007, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19395, -2699.68359, -2808.01392, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19367, -2699.68359, -2811.22510, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19367, -2701.35010, -2812.89990, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19440, -2702.86597, -2813.79199, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19367, -2704.54004, -2814.67993, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19367, -2706.27002, -2814.45117, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, -2706.27002, -2808.03003, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19367, -2704.58081, -2803.12793, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19389, -2699.50562, -2808.01392, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19359, -2698.00000, -2806.36011, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19451, -2696.50000, -2811.25000, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19359, -2698.00000, -2812.88843, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19359, -2699.50562, -2811.22510, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19396, -2704.58081, -2797.80200, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -2701.37012, -2797.80200, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -2699.69995, -2796.90991, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -2698.98608, -2796.01807, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -2698.19019, -2791.12988, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, -2698.33618, -2791.02002, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -2703.06396, -2792.71411, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -2704.58008, -2794.40991, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19368, -2706.12695, -2796.10938, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19388, -2697.99609, -2799.40698, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19431, -2695.58789, -2799.40698, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19358, -2694.69995, -2797.71997, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19358, -2696.38184, -2796.03491, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19431, -2698.79004, -2796.03491, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19358, -2699.67993, -2797.71997, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19394, -2685.15210, -2799.40698, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19365, -2691.57227, -2799.40698, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19365, -2693.26001, -2797.71997, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19365, -2688.36206, -2799.40698, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19365, -2694.77661, -2796.02490, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, -2695.96997, -2791.12988, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, -2693.42993, -2791.10010, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, -2688.53198, -2791.32202, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19394, -2686.83813, -2796.05005, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19438, -2684.42993, -2796.05005, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 6 ] [ 0 ] = CreateDynamicObject(19387, -2686.83813, -2795.87207, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19430, -2684.42993, -2795.87207, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19449, -2688.46509, -2790.97998, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19387, -2680.27197, -2795.87207, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19430, -2682.67993, -2795.87207, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19449, -2683.56006, -2790.97998, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19449, -2683.56006, -2791.00000, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 6 ] [ 1 ] = CreateDynamicObject(19449, -2678.65698, -2790.97998, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 7 ] [ 0 ] = CreateDynamicObject(19394, -2681.94189, -2799.40698, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19365, -2683.56006, -2797.71997, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19438, -2682.67993, -2796.05005, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19394, -2680.27197, -2796.05005, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, -2678.57788, -2791.32202, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, -2673.67505, -2791.50000, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19365, -2672.70996, -2792.65991, 2101.83789,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19365, -2671.55005, -2795.44995, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19365, -2672.70996, -2798.25000, 2101.83789,   0.00000, 0.00000, -45.0000, world );
			HTextureWall [ h ] [ 7 ] [ 1 ] = CreateDynamicObject(19457, -2675.52002, -2799.40698, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 8 ] [ 0 ] = CreateDynamicObject(19393, -2679.45190, -2803.12793, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19456, -2681.13013, -2808.03003, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19437, -2677.76001, -2804.01001, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19393, -2676.06494, -2804.72412, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19364, -2672.85400, -2804.72412, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19456, -2671.19995, -2809.62012, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19456, -2679.44800, -2809.68042, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19437, -2674.54297, -2810.39404, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 8 ] [ 1 ] = CreateDynamicObject(19364, -2672.87012, -2811.26001, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 9 ] [ 0 ] = CreateDynamicObject(19384, -2676.06494, -2804.54712, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19354, -2677.75000, -2802.86011, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19446, -2672.86011, -2801.16992, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19354, -2671.19995, -2802.86011, 2101.83789,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 9 ] [ 1 ] = CreateDynamicObject(19354, -2672.85400, -2804.54712, 2101.83789,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19379, -2701.14990, -2794.67578, 2100.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -2701.14990, -2804.31006, 2100.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -2690.65015, -2804.31006, 2100.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19379, -2680.14990, -2804.31006, 2100.00000,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19376, -2702.97510, -2808.28809, 2100.00244,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19376, -2702.97510, -2818.78809, 2100.00293,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureFloor [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19366, -2698.00000, -2808.19995, 2100.00562,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19366, -2698.00000, -2811.69995, 2100.00562,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19370, -2698.00610, -2797.74805, 2100.00391,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19370, -2694.80005, -2797.74805, 2100.00391,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19378, -2690.65015, -2794.67578, 2100.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19378, -2680.14990, -2794.67578, 2100.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19378, -2669.64819, -2794.67578, 2100.00000,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19452, -2683.56006, -2794.21411, 2100.00391,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19452, -2683.56006, -2790.71411, 2100.00391,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 6] [ 0 ] = CreateDynamicObject(19375, -2675.85010, -2807.85596, 2100.00439,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 6] [ 1 ] = CreateDynamicObject(19375, -2675.85010, -2807.85596, 2120.00439,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 7 ] [ 0 ] = CreateDynamicObject(19448, -2672.86011, -2802.88696, 2100.00757,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 7 ] [ 1 ] = CreateDynamicObject(19448, -2672.86011, -2802.88696, 2120.00757,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19381, -2701.14990, -2804.31006, 2103.66992,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -2690.65015, -2804.31006, 2103.66992,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -2701.14990, -2794.67578, 2103.66992,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -2701.14990, -2813.94409, 2103.66992,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -2680.14990, -2804.31006, 2103.66992,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -2669.64990, -2804.31006, 2103.66992,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19381, -2680.14990, -2813.94409, 2103.66992,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19381, -2669.64990, -2813.94409, 2103.66992,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19373, -2698.00000, -2811.69995, 2103.66504,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19373, -2698.00000, -2808.19995, 2103.66504,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19372, -2694.80005, -2797.74805, 2103.66504,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19372, -2698.00610, -2797.74805, 2103.66504,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19380, -2690.65015, -2794.67578, 2103.66992,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19380, -2680.14990, -2794.67578, 2103.66992,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19380, -2669.64819, -2794.67578, 2103.66992,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19454, -2683.56006, -2794.20996, 2103.66504,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19454, -2683.56006, -2790.70996, 2103.66504,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19463, -2672.86011, -2802.88501, 2103.66504,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19463, -2672.86011, -2802.88501, 2123.66504,   0.00000, 90.00000, 90.0000, world );
		}
		
		case 36: // Особняк 4
		{
			HTextureWall [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19397, -1014.79999, -2800.10010, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -1014.79999, -2797.69189, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -1015.34198, -2796.38403, 1601.83997,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19369, -1015.93500, -2794.14990, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -1015.34198, -2791.92993, 1601.83997,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19442, -1014.80103, -2790.62305, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -1009.90948, -2789.91992, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -1000.27802, -2789.91992, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -996.58197, -2791.60205, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -996.58197, -2809.90796, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -998.27399, -2808.21191, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1001.48401, -2808.21191, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1004.69397, -2808.21191, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1006.21002, -2809.10400, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -1007.89301, -2809.98999, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1010.29999, -2809.98999, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1011.18201, -2809.10400, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -1011.18201, -2806.69507, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -1015.90997, -2805.00000, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1014.79999, -2803.31006, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1008.90851, -2802.58398, 1601.83997,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19442, -1010.00000, -2797.69189, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1008.48401, -2796.80005, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1005.27301, -2796.80005, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1002.86499, -2796.80005, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1001.97400, -2798.31689, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1001.97400, -2801.52808, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -1001.97400, -2803.93604, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -1002.68799, -2804.82813, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1005.09601, -2804.82813, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1007.20599, -2804.28662, 1601.83997,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19369, -1008.48401, -2798.58398, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1005.69000, -2799.73999, 1601.83997,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19369, -1004.52991, -2802.53003, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1006.80798, -2802.93896, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19369, -1008.50201, -2801.42236, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19440, -995.69012, -2796.33008, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19440, -994.27002, -2796.91992, 1601.83997,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19367, -993.67999, -2799.14990, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19367, -993.67999, -2802.36011, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19440, -994.27002, -2804.59009, 1601.83997,   0.00000, 0.00000, 135.0000, world );
			HTextureWall [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19440, -995.69012, -2805.17993, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19441, -1003.63800, -2804.04639, 1605.33997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -1010.00000, -2800.27808, 1605.33997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -1008.48401, -2798.58398, 1605.33997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -1008.50201, -2801.42236, 1605.33997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -1005.69000, -2799.73999, 1605.33997,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19368, -1004.52991, -2802.53003, 1605.33997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -1006.80798, -2802.93896, 1605.33997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19396, -1007.15997, -2806.14990, 1605.33997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -1007.15997, -2808.55811, 1605.33997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19396, -1005.47198, -2809.43994, 1605.33997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -1003.06403, -2809.43994, 1605.33997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -1002.74597, -2799.31812, 1605.33997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -1002.18500, -2796.70508, 1605.33997,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19441, -1000.75500, -2796.11206, 1605.33997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -999.32501, -2796.70508, 1605.33997,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19441, -998.77197, -2798.08765, 1605.33997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -998.05847, -2798.97803, 1605.33997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -997.34497, -2798.08765, 1605.33997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -995.65002, -2797.19995, 1605.33997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -993.95648, -2798.08765, 1605.33997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -993.41498, -2799.39502, 1605.33997,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19368, -992.83002, -2801.62207, 1605.33997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -993.41498, -2803.83984, 1605.33997,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19441, -993.95648, -2805.14697, 1605.33997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -995.65002, -2806.03003, 1605.33997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -997.34497, -2805.14697, 1605.33997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -998.05847, -2804.25610, 1605.33997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -998.77197, -2805.14697, 1605.33997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19396, -999.93201, -2807.14600, 1605.33997,   0.00000, 0.00000, 135.0000, world );
			CreateDynamicObject(19441, -1001.63397, -2808.84814, 1605.33997,   0.00000, 0.00000, -45.0000, world );
			HTextureWall [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19441, -1006.98602, -2803.74194, 1605.33997,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19457, -1016.23999, -2805.01001, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19438, -1016.12000, -2805.59009, 1601.83997,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19365, -1016.71002, -2807.82007, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19438, -1016.12000, -2809.27002, 1601.83997,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19457, -1016.08002, -2809.86011, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19394, -1011.35999, -2806.69507, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19438, -1011.35999, -2809.10400, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19393, -1007.89301, -2810.16797, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19364, -1011.10400, -2810.16797, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19364, -1012.28998, -2811.86011, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19456, -1011.09998, -2813.55005, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19364, -1006.20001, -2811.86011, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19390, -998.27399, -2808.38989, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19361, -1001.48401, -2808.38989, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19453, -1003.15002, -2813.29004, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19453, -1001.48999, -2814.38989, 1601.83997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19453, -996.59003, -2813.29004, 1601.83997,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 6 ] [ 0 ] = CreateDynamicObject(19389, -1007.33801, -2806.14990, 1605.33997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19432, -1007.33801, -2803.74194, 1605.33997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19451, -1012.23199, -2802.85010, 1605.33997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19451, -1013.25000, -2807.75488, 1605.33997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19451, -1012.24200, -2809.43994, 1605.33997,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 6 ] [ 1 ] = CreateDynamicObject(19432, -1007.33801, -2808.55811, 1605.33997,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 7 ] [ 0 ] = CreateDynamicObject(19393, -1005.47198, -2809.61792, 1605.33997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19364, -1003.78198, -2811.30981, 1605.33997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19456, -1008.51001, -2813.00195, 1605.33997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19364, -1010.35199, -2811.30981, 1605.33997,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 7 ] [ 1 ] = CreateDynamicObject(19456, -1011.89398, -2809.61792, 1605.33997,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 8 ] [ 0 ] = CreateDynamicObject(19388, -999.80798, -2807.27222, 1605.33997,   0.00000, 0.00000, 135.0000, world );
			CreateDynamicObject(19358, -997.02399, -2806.12012, 1605.33997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19450, -995.35400, -2811.02002, 1605.33997,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19450, -997.20398, -2812.88989, 1605.33997,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19358, -1002.10199, -2811.20605, 1605.33997,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 8 ] [ 1 ] = CreateDynamicObject(19431, -1001.51099, -2808.97510, 1605.33997,   0.00000, 0.00000, -45.0000, world );
			 
			HTextureFloor [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19379, -1010.74402, -2800.76001, 1600.00195,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -1010.74402, -2810.39380, 1600.00195,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -1000.24402, -2800.76001, 1600.00195,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -1000.24402, -2810.39380, 1600.00195,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -991.24298, -2800.76001, 1600.09998,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -1000.24402, -2791.12622, 1600.00195,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19379, -1010.74402, -2791.12622, 1600.00195,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19378, -1007.90997, -2808.70410, 1603.64001,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19378, -997.40997, -2799.07007, 1603.64001,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19378, -997.40997, -2808.70410, 1603.64001,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19376, -1016.51880, -2809.89990, 1600.00500,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19376, -1016.51880, -2809.89990, 1620.00500,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19462, -1011.09998, -2811.82813, 1600.00806,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19462, -1011.09998, -2811.82813, 1620.00806,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19375, -1000.24402, -2813.11694, 1600.00500,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19375, -1000.24402, -2813.11694, 1620.00500,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19458, -1008.99597, -2807.75000, 1603.64294,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19458, -1012.49597, -2807.75000, 1603.64294,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 6 ] [ 0 ] = CreateDynamicObject(19462, -1008.67999, -2811.27808, 1603.64600,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 6 ] [ 1 ] = CreateDynamicObject(19462, -1008.67999, -2811.27808, 1623.64600,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 7 ] [ 0 ] = CreateDynamicObject(19363, -1005.28247, -2799.73999, 1601.73999,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 7 ] [ 1 ] = CreateDynamicObject(19363, -1005.28247, -2799.73999, 1621.73999,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19381, -1011.54199, -2806.76001, 1603.63794,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19381, -1001.90802, -2810.14990, 1603.63794,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19381, -992.27399, -2810.14990, 1603.63794,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19381, -997.07397, -2799.66553, 1603.63599,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19381, -1005.09601, -2791.46997, 1603.63794,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19381, -997.07397, -2789.16504, 1603.63599,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19381, -1014.72998, -2785.76001, 1603.63794,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19381, -1014.72998, -2796.26001, 1603.63794,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19380, -1007.90997, -2799.07007, 1607.17700,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19380, -1007.90997, -2808.70410, 1607.17700,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19380, -997.40997, -2808.70410, 1607.17700,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19380, -997.40997, -2799.07007, 1607.17700,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19377, -1016.69800, -2809.89990, 1603.63501,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19377, -1016.69800, -2809.89990, 1623.63501,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19454, -1011.09998, -2811.82813, 1603.63196,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19454, -1008.67999, -2811.27808, 1607.17505,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19463, -998.28003, -2810.21997, 1603.63196,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19463, -998.28003, -2813.71997, 1603.63196,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19373, -1009.17499, -2807.75000, 1607.17505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19373, -1009.17499, -2804.54004, 1607.17505,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19373, -1012.67401, -2807.75000, 1607.17505,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19373, -1012.67401, -2804.54004, 1607.17505,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureStairs [ h ] [ 0 ] = CreateDynamicObject(14387, -1008.15002, -2799.09009, 1600.83643,   0.00000, 0.00000, -180.0000, world );
			HTextureStairs [ h ] [ 1 ] = CreateDynamicObject(14387, -1004.35602, -2802.77197, 1602.73535,   0.00000, 0.00000, -270.0000, world );
		}
		
		case 37: // Особняк 5
		{
			HTextureWall [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19397, -1003.64001, -2803.83594, 2001.83704,   0.00000, 0.00000, -90.0000, world );
			CreateDynamicObject(19442, -1001.40997, -2803.24609, 2001.83704,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19442, -1005.87000, -2803.24609, 2001.83704,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19461, -1011.19153, -2802.70459, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19461, -1011.95001, -2804.11621, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -1003.64001, -2792.50000, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1012.49200, -2798.79419, 2001.83704,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19369, -1013.08600, -2796.56006, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -1014.78003, -2795.04395, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1017.99103, -2795.04395, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1019.00000, 6800.00000, -2793.00000,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19397, -1017.99103, -2791.65601, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1014.78003, -2791.65601, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1013.08600, -2790.13989, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1011.92499, -2787.34009, 2001.83704,   0.00000, 0.00000, 135.0000, world );
			CreateDynamicObject(19369, -1009.13000, -2786.17993, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1007.43500, -2785.46606, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -999.86499, -2785.46606, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -998.16998, -2786.17993, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -995.37402, -2787.34009, 2001.83704,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19369, -994.21503, -2790.13989, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -992.52002, -2791.65601, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -989.31000, -2791.65601, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -987.62000, -2793.35010, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -988.50702, -2795.04395, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19397, -990.91498, -2795.04395, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -993.32300, -2795.04395, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -994.21503, -2796.56006, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -994.80847, -2798.79419, 2001.83704,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19461, -995.34998, -2804.11621, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -996.08801, -2802.70410, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1000.22052, -2798.66040, 2001.83704,   0.00000, 0.00000, 63.5000, world );
			CreateDynamicObject(19369, -1007.06000, -2798.65991, 2001.83704,   0.00000, 0.00000, -63.5000, world );
			CreateDynamicObject(19442, -1008.54602, -2798.65381, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19461, -1003.64001, -2797.93994, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -998.73419, -2798.65381, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -998.19598, -2794.78198, 2001.83704,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19369, -1000.42902, -2795.19995, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -1006.85101, -2795.19995, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19369, -997.65399, -2792.67212, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19442, -998.19598, -2790.56201, 2001.83704,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19461, -1003.64001, -2790.14502, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19442, -1009.08447, -2790.56201, 2001.83704,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19369, -1009.62598, -2792.67212, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19369, -1019.22601, -2793.34985, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19442, -1009.08398, -2794.78198, 2001.83704,   0.00000, 0.00000, 45.0000, world );
			 
			HTextureWall [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19367, -998.34802, -2784.57397, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19367, -996.65503, -2784.63989, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19395, -996.65503, -2781.42993, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19459, -996.27197, -2779.73999, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19459, -1005.90503, -2779.73999, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19459, -1010.81000, -2779.85010, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19367, -1008.95203, -2784.57397, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19368, -1000.49988, -2801.74609, 2005.33606,   0.00000, 0.00000, 110.0000, world );
			CreateDynamicObject(19368, -997.41602, -2801.20190, 2005.33606,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -995.72998, -2800.27197, 2005.33606,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -1003.64001, -2802.30005, 2005.33606,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -1006.78003, -2801.74609, 2005.33606,   0.00000, 0.00000, 70.0000, world );
			CreateDynamicObject(19368, -1009.86401, -2801.20264, 2005.33606,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19460, -1011.54797, -2800.27197, 2005.33606,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19396, -1011.54797, -2793.85010, 2005.33606,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -1011.54797, -2790.63989, 2005.33606,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19396, -1010.39001, -2787.84009, 2005.33606,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19368, -1007.79797, -2785.97510, 2005.33606,   0.00000, 0.00000, -63.5000, world );
			CreateDynamicObject(19441, -1006.41101, -2784.53491, 2005.33606,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -1012.09229, -2789.54248, 2005.33606,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19368, -1007.92749, -2783.64307, 2005.33606,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -1009.62000, -2781.95508, 2005.33606,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -1008.46002, -2779.15991, 2005.33606,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19460, -1003.64001, -2778.00000, 2005.33606,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -998.83002, -2779.15991, 2005.33606,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19368, -997.66998, -2781.95508, 2005.33606,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -999.35602, -2783.64307, 2005.33606,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -1000.87201, -2784.53491, 2005.33606,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -999.48401, -2785.97412, 2005.33606,   0.00000, 0.00000, 63.5000, world );
			CreateDynamicObject(19396, -996.89001, -2787.84009, 2005.33606,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19368, -995.73199, -2790.63989, 2005.33606,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19396, -995.73199, -2793.85010, 2005.33606,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19368, -1000.22021, -2791.77954, 2005.33606,   0.00000, 0.00000, -63.5000, world );
			CreateDynamicObject(19460, -1003.64001, -2792.39990, 2005.33606,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19368, -1007.06000, -2791.77954, 2005.33606,   0.00000, 0.00000, 63.5000, world );
			CreateDynamicObject(19441, -998.73401, -2791.78589, 2005.33606,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19460, -1003.64001, -2792.50000, 2005.33606,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19441, -1008.54602, -2791.78589, 2005.33606,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19441, -1008.68781, -2786.13794, 2005.33606,   0.00000, 0.00000, -45.0000, world );
			CreateDynamicObject(19460, -1011.51648, -2782.05396, 2005.33606,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19460, -1015.03998, -2785.44995, 2005.33606,   0.00000, 0.00000, 135.0000, world );
			CreateDynamicObject(19460, -1016.18518, -2786.69751, 2005.33606,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19441, -995.18842, -2789.54199, 2005.33606,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19460, -991.10010, -2786.70508, 2005.33606,   0.00000, 0.00000, 135.0000, world );
			CreateDynamicObject(19460, -992.09998, -2785.32007, 2005.33606,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19460, -995.75177, -2782.04126, 2005.33606,   0.00000, 0.00000, 135.0000, world );
			HTextureWall [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19441, -998.59253, -2786.13794, 2005.33606,   0.00000, 0.00000, 45.0000, world );
			 
			HTextureWall [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19390, -990.91498, -2795.22192, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19434, -993.32300, -2795.22192, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19453, -994.20001, -2800.12500, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19453, -989.29999, -2801.60010, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19453, -987.62000, -2800.12500, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19434, -988.50702, -2795.22192, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19389, -989.31000, -2791.47803, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19451, -987.62000, -2786.57422, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19451, -986.60999, -2782.82983, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19359, -991.50800, -2784.50366, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19389, -993.20203, -2786.02002, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19432, -995.60999, -2786.02002, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19359, -995.31000, -2787.12207, 2001.83704,   0.00000, 0.00000, 45.0000, world );
			CreateDynamicObject(19359, -994.20001, -2789.80005, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19359, -992.52002, -2791.47803, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureWall [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19388, -993.20203, -2785.84204, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19431, -995.60999, -2785.84204, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19358, -996.47699, -2784.63989, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19388, -996.47699, -2781.42993, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19450, -991.58002, -2779.74194, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19450, -991.67072, -2780.93701, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 6 ] [ 0 ] = CreateDynamicObject(19394, -1014.78003, -2795.22192, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19365, -1017.99103, -2795.22192, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19457, -1019.67999, -2800.12500, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19457, -1018.00598, -2801.60010, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 6 ] [ 1 ] = CreateDynamicObject(19457, -1013.09998, -2800.12500, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 7 ] [ 0 ] = CreateDynamicObject(19393, -1017.99103, -2791.47803, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19364, -1014.78003, -2791.47803, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19456, -1013.09998, -2786.57422, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19364, -1014.78003, -2784.72412, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19364, -1016.47400, -2786.41602, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19364, -1017.99103, -2788.11011, 2001.83704,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 7 ] [ 1 ] = CreateDynamicObject(19364, -1019.67999, -2789.80005, 2001.83704,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 8 ] [ 0 ] = CreateDynamicObject(19384, -1011.72601, -2793.85010, 2005.33606,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19427, -1011.72601, -2791.44189, 2005.33606,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19446, -1016.63000, -2790.56006, 2005.33606,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19446, -1018.32001, -2795.45996, 2005.33606,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19446, -1016.63000, -2797.13989, 2005.33606,   0.00000, 0.00000, 90.0000, world );
			HTextureWall [ h ] [ 8 ] [ 1 ] = CreateDynamicObject(19427, -1011.72601, -2796.25806, 2005.33606,   0.00000, 0.00000, 0.0000, world );
			 
			HTextureWall [ h ] [ 9 ] [ 0 ] = CreateDynamicObject(19385, -995.55402, -2793.85010, 2005.33606,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19447, -995.55402, -2800.27197, 2005.33606,   0.00000, 0.00000, 0.0000, world );
			CreateDynamicObject(19447, -990.65002, -2801.95996, 2005.33606,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(19447, -988.95001, -2797.06006, 2005.33606,   0.00000, 0.00000, 0.0000, world );
			HTextureWall [ h ] [ 9 ] [ 1 ] = CreateDynamicObject(19447, -990.65002, -2792.16211, 2005.33606,   0.00000, 0.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19379, -1003.39001, -2799.11597, 2000.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -1013.89001, -2799.11597, 2000.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -1013.89001, -2789.48218, 2000.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -992.89001, -2789.48218, 2000.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -986.17999, -2779.85010, 2000.00195,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19379, -992.89001, -2799.11597, 2000.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19379, -1003.39001, -2789.48218, 2000.00000,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19376, -1003.39001, -2779.84814, 2000.00000,   0.00000, 90.00000, 0.0000, world );
			CreateDynamicObject(19376, -992.89001, -2779.84814, 2000.00000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19376, -1013.89001, -2779.84814, 2000.00000,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19378, -1003.64398, -2803.10498, 2003.51001,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19378, -1013.27301, -2797.60498, 2003.51001,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19378, -1003.64398, -2787.10498, 2003.51001,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19378, -994.01398, -2797.60498, 2003.51001,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19378, -1003.64398, -2776.60498, 2003.51001,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19378, -994.01398, -2787.10498, 2003.51001,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19378, -994.01398, -2776.60498, 2003.51001,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19378, -1013.27301, -2776.60498, 2003.51001,   0.00000, 90.00000, -90.0000, world );
			HTextureFloor [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19378, -1013.27301, -2787.10498, 2003.51001,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureFloor [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19455, -1018.43201, -2799.94604, 2000.00305,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19455, -1014.93201, -2799.94604, 2000.00305,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 4 ] [ 0 ] = CreateDynamicObject(19458, -1018.42999, -2786.75000, 2000.00403,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 4 ] [ 1 ] = CreateDynamicObject(19458, -1014.92999, -2786.75000, 2000.00403,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 5 ] [ 0 ] = CreateDynamicObject(19375, -988.89001, -2799.94800, 2000.00403,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 5 ] [ 1 ] = CreateDynamicObject(19375, -988.89001, -2799.94800, 2020.00403,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 6 ] [ 0 ] = CreateDynamicObject(19439, -992.55402, -2784.18188, 2000.00403,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19366, -994.96198, -2780.68188, 2000.00403,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19366, -994.96198, -2784.18188, 2000.00403,   0.00000, 90.00000, 90.0000, world );
			HTextureFloor [ h ] [ 6 ] [ 1 ] = CreateDynamicObject(19439, -992.55402, -2780.68188, 2000.00403,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureFloor [ h ] [ 7 ] [ 0 ] = CreateDynamicObject(19448, -1016.88397, -2795.45996, 2003.51404,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 7 ] [ 1 ] = CreateDynamicObject(19448, -1013.38397, -2795.45996, 2003.51404,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 8 ] [ 0 ] = CreateDynamicObject(19452, -993.89600, -2797.04004, 2003.51404,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 8 ] [ 1 ] = CreateDynamicObject(19452, -990.39600, -2797.04004, 2003.51404,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureFloor [ h ] [ 9 ] [ 0 ] = CreateDynamicObject(19370, -1003.64001, -2793.06006, 2001.25000,   0.00000, 90.00000, 0.0000, world );
			HTextureFloor [ h ] [ 9 ] [ 1 ] = CreateDynamicObject(19370, -1003.64001, -2796.27002, 2001.25000,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureRoof [ h ] [ 0 ] [ 0 ] = CreateDynamicObject(19381, -1003.64398, -2803.12695, 2003.50195,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19381, -1013.27698, -2797.60498, 2003.50195,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19381, -1022.90601, -2787.10498, 2003.50195,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19381, -1022.91101, -2797.60498, 2003.50195,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19381, -1003.64001, -2787.10498, 2003.50195,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19381, -1013.27301, -2787.10498, 2003.50195,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19381, -1013.27301, -2776.60498, 2003.50195,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19381, -1003.64001, -2776.60498, 2003.50195,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19381, -994.00598, -2776.60498, 2003.50195,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19381, -994.01001, -2797.60498, 2003.50195,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19381, -984.37598, -2797.60498, 2003.50195,   0.00000, 90.00000, -90.0000, world );
			CreateDynamicObject(19381, -994.00598, -2787.10498, 2003.50195,   0.00000, 90.00000, -90.0000, world );
			HTextureRoof [ h ] [ 0 ] [ 1 ] = CreateDynamicObject(19381, -984.37201, -2787.10498, 2003.50195,   0.00000, 90.00000, -90.0000, world );
			 
			HTextureRoof [ h ] [ 1 ] [ 0 ] = CreateDynamicObject(19380, -1014.14001, -2797.55005, 2007.17004,   0.00000, 90.00000, -180.0000, world );
			CreateDynamicObject(19380, -1014.14001, -2787.91602, 2007.17004,   0.00000, 90.00000, -180.0000, world );
			CreateDynamicObject(19380, -1014.14001, -2778.28198, 2007.17004,   0.00000, 90.00000, -180.0000, world );
			CreateDynamicObject(19380, -1003.64001, -2778.28198, 2007.17004,   0.00000, 90.00000, -180.0000, world );
			CreateDynamicObject(19380, -993.13800, -2778.28198, 2007.17004,   0.00000, 90.00000, -180.0000, world );
			CreateDynamicObject(19380, -1003.64001, -2787.91602, 2007.17004,   0.00000, 90.00000, -180.0000, world );
			CreateDynamicObject(19380, -1003.64001, -2797.55005, 2007.17004,   0.00000, 90.00000, -180.0000, world );
			CreateDynamicObject(19380, -993.13800, -2797.55005, 2007.17004,   0.00000, 90.00000, -180.0000, world );
			HTextureRoof [ h ] [ 1 ] [ 1 ] = CreateDynamicObject(19380, -993.13800, -2787.91602, 2007.17004,   0.00000, 90.00000, -180.0000, world );
			 
			HTextureRoof [ h ] [ 2 ] [ 0 ] = CreateDynamicObject(19362, -994.78198, -2784.17993, 2003.50000,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19435, -992.37402, -2784.17993, 2003.50000,   0.00000, 90.00000, 90.0000, world );
			CreateDynamicObject(19362, -994.78198, -2780.67993, 2003.50000,   0.00000, 90.00000, 90.0000, world );
			HTextureRoof [ h ] [ 2 ] [ 1 ] = CreateDynamicObject(19435, -992.37402, -2780.67993, 2003.50000,   0.00000, 90.00000, 90.0000, world );
			 
			HTextureRoof [ h ] [ 3 ] [ 0 ] = CreateDynamicObject(19377, -1018.37000, -2786.58813, 2003.49805,   0.00000, 90.00000, 0.0000, world );
			HTextureRoof [ h ] [ 3 ] [ 1 ] = CreateDynamicObject(19377, -1018.37000, -2786.58813, 2003.49805,   0.00000, 90.00000, 0.0000, world );
			 
			HTextureStairs [ h ] [ 0 ] = CreateDynamicObject(14409, -1006.63501, -2793.05298, 2000.40112,   0.00000, 0.00000, -90.0000, world );
			CreateDynamicObject(14409, -1000.65698, -2793.07104, 2000.40112,   0.00000, 0.00000, 90.0000, world );
			CreateDynamicObject(14409, -1000.06799, -2795.82007, 1998.15100,   0.00000, 0.00000, -90.0000, world );
			HTextureStairs [ h ] [ 1 ] = CreateDynamicObject(14409, -1007.21198, -2795.82007, 1998.15100,   0.00000, 0.00000, 90.0000, world );
		}
	}
	
	for( new i; i < MAX_HOUSE_WALL; i++ )
	{
		SetHouseTexture( h, HouseInfo[h][hWall][i], 0, i );
	}
	
	for( new i; i < MAX_HOUSE_FLOOR; i++ )
	{
		SetHouseTexture( h, HouseInfo[h][hFloor][i], 1, i );
	}
	
	for( new i; i < MAX_HOUSE_ROOF; i++ )
	{
		SetHouseTexture( h, HouseInfo[h][hRoof][i], 2, i );
	}
	
	SetHouseTexture( h, HouseInfo[h][hStairs], 3, INVALID_PARAM );
	
	return true;
}
/*
CMD:sss( playerid, params[] ) {
	//SendMes( playerid, -1, "%d", Streamer_CountVisibleItems( playerid, STREAMER_TYPE_OBJECT ) );//Streamer_CountItems(  STREAMER_TYPE_OBJECT ) );
	return true;
}

CMD:sss1( playerid, params[] ) {
	//SendMes( playerid, -1, "%d", Streamer_GetVisibleItems( STREAMER_TYPE_OBJECT ) );
	return true;
}

CMD:sss2( playerid, params[] ) {
	if( sscanf( params, "i", params[0] ) ) return true;
	Streamer_SetVisibleItems( STREAMER_TYPE_OBJECT, params[0] );
	//SendMes( playerid, -1, "NEW LIMIT: %d",  Streamer_GetVisibleItems( STREAMER_TYPE_OBJECT ) );
	return true;
}

CMD:sss3( playerid, params[] ) {
	if( sscanf( params, "d", params[0] ) ) return true;
	Streamer_ToggleErrorCallback( params[0] ); 
	return true;
}*/

function HInterior_OnGameModeInit() 
{
	new
		tmpobjid;
 
	house_object_interior[0] = CreateObject(6959, -500.00000, -2801.00000, 1600.10999,   0.00000, 0.00000, 0.00000); // Студия #1
	CreateObject(6959, -500.00000, -2800.00000, 2000.09998,   0.00000, 0.00000, 0.00000); // Студия #2
	CreateObject(6959, -499.00000, -2799.00000, 2400.10010,   0.00000, 0.00000, 0.00000); // Студия #3
	CreateObject(6959, -499.50000, -2794.50000, 3000.10010,   0.00000, 0.00000, 0.00000); // Студия #4
	CreateObject(6959, -2701.48755, -2199.51563, 2200.10010,   0.00000, 0.00000, 0.00000); // Студия #5
	CreateObject(6959, -1701.50000, -1498.50000, 2100.10010,   0.00000, 0.00000, 0.00000); // Студия #6
	CreateObject(6959, -3.50000, -2799.64990, 1600.10000,   0.00000, 0.00000, 0.00000); // 1 Комната #1
	CreateObject(6959, 0.00000, -2798.00000, 2000.10000,   0.00000, 0.00000, 0.00000); // 1 Комната #2
	CreateObject(6959, 0.00000, -2800.00000, 2400.10010,   0.00000, 0.00000, 0.00000); // 1 Комната #3
	CreateObject(6959, -2701.00000, -1511.00000, 1600.09998,   0.00000, 0.00000, 0.00000); // 1 Комната #4
	CreateObject(6959, -2197.00000, -1500.00000, 1600.10001,   0.00000, 0.00000, 0.00000); // 1 Комната #5
	CreateObject(6959, -2211.00000, -1505.00000, 2100.10010,   0.00000, 0.00000, 0.00000); // 1 Комната #6
	CreateObject(6959, -1700.00000, -1505.00000, 2700.10010,   0.00000, 0.00000, 0.00000); // 1 Комната #7
	CreateObject(6959, -2705.00000, -1500.00000, 2600.10010,   0.00000, 0.00000, 0.00000); // 1 Комната #8
	CreateObject(6959, 498.00000, -2807.00000, 1600.09998,   0.00000, 0.00000, 0.00000); // 2 Комнаты #1
	CreateObject(6959, 495.00000, -2803.00000, 2000.09998,   0.00000, 0.00000, 0.00000); // 2 Комнаты #2
	CreateObject(6959, 500.00000, -2798.00000, 2400.10010,   0.00000, 0.00000, 0.00000);  // 2 Комнаты #3
	CreateObject(6959, -2702.00000, -1505.00000, 2000.09998,   0.00000, 0.00000, 0.00000); // 2 Комнаты #4
	CreateObject(6959, -2197.50000, -1499.50000, 2600.10010,   0.00000, 0.00000, 0.00000); // 2 Комнаты #5
	CreateObject(6959, -1693.00000, -1499.50000, 1600.09998,   0.00000, 0.00000, 0.00000); // 2 Комнаты #6
	CreateObject(6959, 999.00000, -2795.00000, 1600.09998,   0.00000, 0.00000, 0.00000); // 3 Комнаты #1
	CreateObject(6959, 1000.00000, -2800.00000, 2000.09998,   0.00000, 0.00000, 0.00000); // 3 Комнаты #2
	CreateObject(6959, 1002.50000, -2796.50000, 2400.10010,   0.00000, 0.00000, 0.00000); // 3 Комнаты #3
	CreateObject(6959, -2699.50000, -2801.50000, 2600.10010,   0.00000, 0.00000, 0.00000); // 3 Комнаты #4
	CreateObject(6959, -2698.50000, -2202.50000, 1600.09998,   0.00000, 0.00000, 0.00000); // 3 Комнаты #5
	CreateObject(6959, 1503.50000, -2803.50000, 1600.09998,   0.00000, 0.00000, 0.00000); // 4 Комнаты #1
	CreateObject(6959, 1500.00000, -2800.00000, 2000.09998,   0.00000, 0.00000, 0.00000); // 4 Комнаты #2
	CreateObject(6959, 1498.00000, -2795.50000, 2500.10010,   0.00000, 0.00000, 0.00000); // 4 Комнаты #3
	CreateObject(6959, -997.00000, -2790.00000, 2800.10010,   0.00000, 0.00000, 0.00000); // 2 Этажа 3 Комнаты #1
	CreateObject(6959, -997.00000, -2808.88989, 2803.61816,   0.00000, 0.00000, 0.00000); // 2 Этажа 3 Комнаты #1
	CreateObject(6959, -1500.16199, -2800.94287, 1600.09998,   0.00000, 0.00000, 0.00000); // 2 Этажа 3 Комнаты #2
	CreateObject(6959, -1520.15979, -2802.34595, 1603.60901,   0.00000, 0.00000, 0.00000); // 2 Этажа 3 Комнаты #2
	CreateObject(6959, -1494.00000, -2800.00000, 2200.10010,   0.00000, 0.00000, 0.00000); // 2 Этажа 4 Комнаты #1
	CreateObject(6959, -1479.10498, -2800.50146, 2203.60278,   0.00000, 0.00000, 0.00000); // 2 Этажа 4 Комнаты #1
	CreateObject(6959, -1498.01965, -2804.78223, 2800.10010,   0.00000, 0.00000, 0.00000); // 2 Этажа 4 Комнаты #2
	CreateObject(6959, -1497.34424, -2824.97510, 2803.60498,   0.00000, 0.00000, 0.00000); // 2 Этажа 4 Комнаты #2
	CreateObject(6959, -2098.00000, -2802.00000, 1600.09998,   0.00000, 0.00000, 0.00000); // 2 Этажа 4 Комнаты #3
	CreateObject(6959, -2116.91992, -2807.05005, 1603.60999,   0.00000, 0.00000, 0.00000); // 2 Этажа 4 Комнаты #3
	CreateObject(6959, -2098.63330, -2796.42505, 2100.10010,   0.00000, 0.00000, 0.00000); // Особняк I класса #1
	CreateObject(6959, -2700.85010, -2798.75000, 1600.09998,   0.00000, 0.00000, 0.00000); // Особняк I класса #2
	CreateObject(6959, -2688.00000, -2801.64990, 2100.10010,   0.00000, 0.00000, 0.00000); // Особняк I класса #3
	CreateObject(6959, -1022.42157, -2823.93457, 1603.75500,   0.00000, 0.00000, 0.00000); // Особняк II класса #1
	CreateObject(6959, -983.94708, -2803.04663, 1603.75500,   0.00000, 0.00000, 0.00000); // Особняк II класса #1
	CreateObject(6959, -1005.22913, -2800.38306, 1600.09998,   0.00000, 0.00000, 0.00000); // Особняк II класса #1
	CreateObject(6959, -1003.00000, -2794.00000, 2000.09998,   0.00000, 0.00000, 0.00000); // Особняк II класса #2
	CreateObject(6959, -1029.15613, -2791.32764, 2003.60828,   0.00000, 0.00000, 0.00000); // Особняк II класса #2
	house_object_interior[1] = CreateObject(6959, -978.15240, -2792.00220, 2003.60828,   0.00000, 0.00000, 0.00000); // Особняк II класса #2

	tmpobjid = CreateDynamicObject(19353, -505.87799, -2800.30005, 1601.83997,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // Студия #1
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -494.91870, -2796.50000, 2001.83997,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // Студия #2
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -495.91931, -2796.10010, 2401.84009,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // Студия #3
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -494.02200, -2798.80005, 3001.84009,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // Студия #4
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -2707.55811, -2200.35010, 2201.83789,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00);  // Студия #5
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -1707.27795, -1496.30005, 2101.83789,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // Студия #6
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, 2.17000, -2799.00000, 1601.83997,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // 1 Комната #1
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -3.57800, -2799.60010, 2001.83997,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // 1 Комната #2
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -5.67900, -2799.10010, 2401.84009,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // 1 Комната #3
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -2705.17798, -1506.00000, 1601.83801,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // 1 Комната #4
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -2204.24805, -1496.59998, 1601.83801,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // 1 Комната #5
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -2207.37793, -1496.30005, 2101.83789,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // 1 Комната #6
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -1707.77795, -1502.97998, 2701.83789,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // 1 Комната #7
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -2697.42188, -1503.50000, 2601.83789,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // 1 Комната #8
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, 503.92801, -2802.50000, 1601.83997,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // 2 Комнаты #1
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, 504.37799, -2805.94995, 2001.83997,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // 2 Комнаты #2
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, 505.57800, -2796.60010, 2401.84009,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // 2 Комнаты #3
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -2707.17798, -1498.00000, 2001.83801,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // 2 Комнаты #4
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -2204.17407, -1501.00000, 2601.83789,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // 2 Комнаты #5
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -1702.43799, -1500.55005, 1601.83801,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // 2 Комнаты #6
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, 1002.07202, -2801.81006, 1601.83997,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // 3 Комнаты #1
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, 993.87201, -2799.75000, 2001.83997,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // 3 Комнаты #2
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, 995.99200, -2799.31006, 2401.84009,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // 3 Комнаты #3
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -2709.67798, -2800.50000, 2601.83789,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // 3 Комнаты #4
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -2706.67798, -2201.30005, 1601.83801,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // 3 Комнаты #5
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, 1497.04199, -2799.52002, 1601.83997,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // 4 Комнаты #1
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, 1496.68799, -2793.84009, 2001.83997,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // 4 Комнаты #2
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, 1492.02197, -2797.05005, 2501.84009,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // 4 Комнаты #3
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -1012.21759, -2790.30371, 2801.83789,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // 2 Этажа 3 Комнаты #1
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -1501.19995, -2793.93188, 1601.83801,   0.00000, 0.00000, 90.00000, -1, -1, -1, 300.00, 300.00); // 2 Этажа 3 Комнаты #2
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -1501.69995, -2792.09204, 2201.83789,   0.00000, 0.00000, 90.00000, -1, -1, -1, 300.00, 300.00); // 2 Этажа 4 Комнаты #1
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -1498.00000, -2795.72192, 2801.83789,   0.00000, 0.00000, 90.00000, -1, -1, -1, 300.00, 300.00); // 2 Этажа 4 Комнаты #2
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -2098.91992, -2796.42188, 1601.83801,   0.00000, 0.00000, 90.00000, -1, -1, -1, 300.00, 300.00); // 2 Этажа 4 Комнаты #3
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -2108.12817, -2801.52808, 2101.83789,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // Особняк I класса #1
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -2708.02808, -2800.35010, 1601.83801,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // Особняк I класса #2
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -2706.44800, -2801.28003, 2101.83789,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // Особняк I класса #3
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -1014.96997, -2800.10010, 1601.83997,   0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00); // Особняк II класса #1
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, -1003.64001, -2804.01221, 2001.83704,   0.00000, 0.00000, 90.00000, -1, -1, -1, 300.00, 300.00); // Особняк II класса #2
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	
	return 1;
}