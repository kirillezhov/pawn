new 
	mysql;

new 
	g_small_string					[ 256 ],
	g_string						[ 1024 ], 
	g_big_string					[ 2048 ];
	
new
	COUNT_INVENTORY_ITEMS,
	COUNT_PERMISSIONS,
	COUNT_ADMIN_VEHICLES,
	COUNT_KILL_LOG,
	COUNT_DISCONNECT_LOG,
	COUNT_ADVERTS,
	COUNT_FRACTIONS,
	COUNT_CRIMES,
	COUNT_GUNDEALERS,
	COUNT_ENTERS,
	COUNT_ENTERS_INSIDE,
	COUNT_HOUSES;
	
new 
	stop_time						[MAX_PLAYERS],
	user_update_weather				[MAX_PLAYERS],
	server_update_weather,
	server_weather,
	server_weather_type,
	server_weather_time = -1,
	
	server_restart = -1;

new
	ghour,
	gminute,
	gsecond;

new 
	Connection[ e_MYSQL ][ 30 ];

new
	g_dialog_select	[ MAX_PLAYERS ][ 100 ];
	

stock clean_array() g_small_string[0] = g_string[0] = g_big_string[0] = 0;

new const 
	server_weather_list[] = 
	{ 
		0, 3, 5, 6, 14, 17, 1, 8, 11, 18, 0, 0, 1, 3, 2, 
		17, 18, 13, 3, 5, 9, 10, 1, 2, 6, 17, 18, 13, 14, 
		8, 14, 17, 2, 5, 6, 0, 0, 1, 2, 3, 19, 3, 5, 6, 1, 
		8, 6, 14, 17, 18, 2, 10, 11, 5, 6, 6, 6, 9, 8, 11, 
		13, 14, 17, 18, 18, 18, 11, 11, 4, 3, 3, 3, 3, 5, 
		6, 13, 17, 18, 13, 11
	},
	
	Float:server_green_zone[][] = 
	{
		{ 1504.5408, -1174.6127, 24.0781 },
		{ -495.5312, -100.8251, 62.5053 }
	};