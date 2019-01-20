
enum c_tex {
	c_ids,
	c_tex1[32],
	c_tex2[32]
}

new caravan_texture[][c_tex] = {
	{ 16093, "a51_ext", "ws_corr_2_plain"  },
	{ 3095, "a51jdrx", "sam_camo" }, 
	{ 16640, "a51", "a51_vent1" }, 
	{ 16093, "a51_ext", "ws_corr_2_plain" }, 
	{ 3095, "a51jdrx", "sam_camo" }, 
	{ 16640, "a51", "a51_vent1"  },
	{ 16640, "a51", "des_factower" }, 
	{ 18757, "vcinteriors", "dts_elevator_ceiling" }, 
	{ 18064, "ab_sfammuunits", "gun_blackbox" }, 
	{ 14652, "ab_trukstpa", "bbar_wall1" }, 
	{ 18065, "ab_sfammumain", "mp_gun_wall" }, 
	{ 14651, "ab_trukstpd", "Bow_bar_tabletop_wood" }, 
	{ 4552, "ammu_lan2", "sunsetammu2" }, 
	{ 17550, "eastbeach09_lae2", "sprunkwall1_LAe2"  },
	{ 4552, "ammu_lan2", "sunsetammu1" }, 
	{ 17550, "eastbeach09_lae2", "sprunkwall2_LAe2" }, 
	{ 3437, "ballypillar01", "ballywall01_64" }, 
	{ 14789, "ab_sfgymmain", "gym_floor6" }, 
	{ 4835, "airoads_las", "tardor2" }, 
	{ 3853, "gay_xref", "ws_gayflag1" }, 
	{ 3853, "gay_xref", "ws_gayflag2" }, 
	{ 14876, "gf4", "mp_diner_sawdust" }, 
	{ 18028, "cj_bar2", "CJ_nastybar_D4" }, 
	{ 17566, "contachou1_lae2", "ws_peeling2" }, 
	{ 5444, "chicano10_lae", "g_256" }, 
	{ 4835, "airoads_las", "tardor2" }, 
	{ 3437, "ballypillar01", "ballywall01_64" }, 
	{ 3474, "freightcrane", "bluecab3_256" }, 
	{ 3474, "freightcrane", "bluecab4_256" }, 
	{ 14603, "bikeskool", "artish1"  },
	{ 3922, "bistro", "StainedGlass"  },
	{ 14654, "ab_trukstpe", "bbar_signs1"  },
	{ 14654, "ab_trukstpe", "bbar_plates2" }, 
	{ 4830, "airport2", "sw_shedwall02" },
	{ 14654, "ab_trukstpe", "bbar_stuff9" }
};

new 
	caravan[7], 
	caravan_object[7];

Caravan_OnGameModeInit() 
{
	caravan[0] = CreateVehicle(607, -101.5940, -1572.1860, 2.6646, 173.7000, -1, -1, -1 ); 
	caravan[1] = CreateVehicle(607, -64.5683, -1560.6216, 2.6646, 236.3400, -1, -1, -1 ); 
	caravan[2] = CreateVehicle(607, -78.1005, -1552.5129, 2.6646, 81.7800, -1, -1, -1 );  
	caravan[3] = CreateVehicle(607, -86.0389, -1578.9473, 2.6646, -24.3600, -1, -1, -1 ); 
	caravan[4] = CreateVehicle(607, -80.8433, -1600.7274, 2.6646, -43.0200, -1, -1, -1 );  
	caravan[5] = CreateVehicle(607, -62.0987, -1580.3186, 2.6646, 168.2999, -1, -1, -1 ); 
	caravan[6] = CreateVehicle(607, -86.7823, -1561.0109, 2.6646, 203.8799, -1, -1, -1 ); 
	
	for( new i; i < 7; i++ )
	{
		caravan_object[i] = CreateObject( 3171,0,0,0,0,0,0 );
		AttachObjectToVehicle( caravan_object[i], caravan[i], 0.0,-1.7,-1.15 ,0.0,0.0, 180.0 );
	}
	
	CreateObject(6959, -261.10333, 1934.92517, 1500.09998,   0.00000, 0.00000, 0.00000);
	CreateObject(19379, -261.58139, 1935.00537, 1500.00000,   0.00000, 90.00000, 90.00000);
	CreateObject(19461, -256.89999, 1939.81995, 1501.83997,   0.00000, 0.00000, 0.00000);
	CreateObject(19397, -258.59000, 1937.09998, 1501.83997,   0.00000, 0.00000, 90.00000);
	CreateObject(19461, -261.50000, 1935.00000, 1501.83997,   0.00000, 0.00000, 0.00000);
	CreateObject(19461, -265.01199, 1937.09998, 1501.83997,   0.00000, 0.00000, 90.00000);
	CreateObject(19461, -261.63000, 1939.90002, 1501.83997,   0.00000, 0.00000, 90.00000);
	CreateObject(19461, -261.63000, 1930.09399, 1501.83997,   0.00000, 0.00000, 90.00000);
	CreateObject(19397, -256.89999, 1933.40002, 1501.83997,   0.00000, 0.00000, 0.00000);
	CreateObject(19461, -256.89999, 1926.97803, 1501.83997,   0.00000, 0.00000, 0.00000);
	CreateObject(19461, -256.72433, 1933.81970, 1501.83997,   0.00000, 0.00000, 0.00000);
	CreateObject(1501, -256.91431, 1934.17700, 1500.07764,   0.00000, 0.00000, -90.00000);
	CreateObject(19377, -261.58139, 1935.00537, 1502.9301,   0.00000, 90.00000, 90.00000);
	return 1;
}

CMD:caravan( playerid, params[] ) 
{
	if( sscanf( params, "d", params[0] ) ) return true;
	
	new 
		car = GetPlayerVehicleID( playerid );
	
	if( IsTrailerAttachedToVehicle( car ) )
	{ 	
		DetachTrailerFromVehicle( car );
		return 1;
	}
	
	AttachTrailerToVehicle( caravan[params[0]], car );
	
	return 1;
}

CMD:caravan_texture( playerid, params[] ) {
	if( sscanf( params, "iii", params[0], params[1], params[2] ) ) return true;
	if( params[1] < 0 || params[1] > sizeof caravan_texture ) return SendClient:( playerid, -1, "LIMIT" );
	//new rand = random( sizeof caravan_texture );
	SetObjectMaterial( caravan_object[params[2]], params[0], caravan_texture[ params[1] ][c_ids], 
		caravan_texture[ params[1] ][c_tex1], caravan_texture[ params[1] ][c_tex2], 0x00000000 ); 
	
	//SetObjectMaterial( caravan_object, 2, caravan_texture[rand][c_ids2], 
		//caravan_texture[rand][c_tex3], caravan_texture[rand][c_tex4], 0x00000000 );
	return 1;
}
	