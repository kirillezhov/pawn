function LoadInventoryData() 
{
	new 
		rows = cache_get_row_count();
		
	
	if( !rows )
		return print("[Load]: Inventory - Null rows in "DB_INVENTORY".");

	COUNT_INVENTORY_ITEMS = 0x0;

	for( new i = 0; i < rows; i++ ) 
	{
		inventory[i][i_id] = cache_get_field_content_int( i, "inventory_id", mysql );
		inventory[i][i_model] = cache_get_field_content_int( i, "inventory_model", mysql );
		inventory[i][i_mass] = cache_get_field_content_float( i, "inventory_mass", mysql );
		
		cache_get_field_content( i, "inventory_name", inventory[i][i_name], mysql, 64 );
		
		clean:<g_small_string>;
		cache_get_field_content( i, "inventory_text", g_small_string, mysql, 256 );
		strmid( inventory[i][i_text], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
		
        inventory[i][i_pos][INV_POS_X] = cache_get_field_content_float( i, "inventory_pos_x", mysql );
		inventory[i][i_pos][INV_POS_Y] = cache_get_field_content_float( i, "inventory_pos_y", mysql );
		inventory[i][i_pos][INV_POS_Z] = cache_get_field_content_float( i, "inventory_pos_z", mysql );
		inventory[i][i_pos][INV_POS_ZOOM] = cache_get_field_content_float( i, "inventory_pos_zoom", mysql );
		inventory[i][i_type] = cache_get_field_content_int( i, "inventory_type", mysql );
		inventory[i][i_param_1] = cache_get_field_content_int( i, "inventory_param_1", mysql );
		inventory[i][i_param_2] = cache_get_field_content_int( i, "inventory_param_2", mysql );
		
		COUNT_INVENTORY_ITEMS++;
	}
	
	printf( "[Load]: Inventory items - Loaded. All - %d", COUNT_INVENTORY_ITEMS );
	return 1;
}

function LoadPlayerBag( playerid, bag_id )
{
	new 
		rows = cache_get_row_count();
	
	if( !rows )
		return 1;
	
	new 
		slot;
	
	for( new i; i != rows; i++ )
	{		
		slot = cache_get_field_content_int( i, "item_slot", mysql );
		
		BagInv[bag_id][slot][inv_bd] = cache_get_field_content_int(i, "id", mysql);
		BagInv[bag_id][slot][inv_id] = cache_get_field_content_int(i, "item_id", mysql );
		BagInv[bag_id][slot][inv_amount] = cache_get_field_content_int(i, "item_amount", mysql );
		BagInv[bag_id][slot][inv_pos_x] = cache_get_field_content_float(i, "item_pos_x", mysql );
		BagInv[bag_id][slot][inv_pos_y] = cache_get_field_content_float(i, "item_pos_y", mysql );
		BagInv[bag_id][slot][inv_rot_x] = cache_get_field_content_float(i, "item_rot_x", mysql );
		BagInv[bag_id][slot][inv_rot_y] = cache_get_field_content_float(i, "item_rot_y", mysql );
		BagInv[bag_id][slot][inv_rot_z] = cache_get_field_content_float(i, "item_rot_z", mysql );
		BagInv[bag_id][slot][inv_bone] = cache_get_field_content_int(i, "item_bone", mysql );
		BagInv[bag_id][slot][inv_slot] = slot;
		BagInv[bag_id][slot][inv_active_type] = cache_get_field_content_int( i, "item_active_type", mysql );
		BagInv[bag_id][slot][inv_type] = cache_get_field_content_int(i, "item_type", mysql );
		BagInv[bag_id][slot][inv_scale_x] = cache_get_field_content_float(i, "item_scale_x", mysql );
		BagInv[bag_id][slot][inv_scale_y] = cache_get_field_content_float(i, "item_scale_y", mysql );
		BagInv[bag_id][slot][inv_scale_z] = cache_get_field_content_float(i, "item_scale_z", mysql );
		
		BagInv[bag_id][slot][inv_param_1] = cache_get_field_content_int( i, "item_param_1", mysql );
		BagInv[bag_id][slot][inv_param_2] = cache_get_field_content_int( i, "item_param_2", mysql );
	}
	
	printf( "[Load]: Bag %s[%d] has been loaded. All items - %d", GetAccountName( playerid ), playerid, rows );
	return 1;
}

function LoadCarBag( vehicleid, bag_id )
{
	new 
		rows = cache_get_row_count();
	
	if( !rows )
		return 1;
	
	new 
		slot;
	
	for( new i; i != rows; i++ )
	{		
		slot = cache_get_field_content_int( i, "item_slot", mysql );
		
		BagInv[bag_id][slot][inv_bd] = cache_get_field_content_int(i, "id", mysql);
		BagInv[bag_id][slot][inv_id] = cache_get_field_content_int(i, "item_id", mysql );
		BagInv[bag_id][slot][inv_amount] = cache_get_field_content_int(i, "item_amount", mysql );
		BagInv[bag_id][slot][inv_pos_x] = cache_get_field_content_float(i, "item_pos_x", mysql );
		BagInv[bag_id][slot][inv_pos_y] = cache_get_field_content_float(i, "item_pos_y", mysql );
		BagInv[bag_id][slot][inv_rot_x] = cache_get_field_content_float(i, "item_rot_x", mysql );
		BagInv[bag_id][slot][inv_rot_y] = cache_get_field_content_float(i, "item_rot_y", mysql );
		BagInv[bag_id][slot][inv_rot_z] = cache_get_field_content_float(i, "item_rot_z", mysql );
		BagInv[bag_id][slot][inv_bone] = cache_get_field_content_int(i, "item_bone", mysql );
		BagInv[bag_id][slot][inv_slot] = slot;
		BagInv[bag_id][slot][inv_active_type] = cache_get_field_content_int( i, "item_active_type", mysql );
		BagInv[bag_id][slot][inv_type] = cache_get_field_content_int(i, "item_type", mysql );
		BagInv[bag_id][slot][inv_scale_x] = cache_get_field_content_float(i, "item_scale_x", mysql );
		BagInv[bag_id][slot][inv_scale_y] = cache_get_field_content_float(i, "item_scale_y", mysql );
		BagInv[bag_id][slot][inv_scale_z] = cache_get_field_content_float(i, "item_scale_z", mysql );
		
		BagInv[bag_id][slot][inv_param_1] = cache_get_field_content_int( i, "item_param_1", mysql );
		BagInv[bag_id][slot][inv_param_2] = cache_get_field_content_int( i, "item_param_2", mysql );
	}
	
	printf( "[Load]: Bag vehicle[%d] %s[%d] has been loaded. All items - %d", 
		Vehicle[vehicleid][vehicle_id],
		GetVehicleModelName( Vehicle[vehicleid][vehicle_model] ), 
		vehicleid, 
		rows 
	);
	
	return 1;
}

function LoadPlayerInventory( playerid ) 
{
	new 
		rows = cache_get_row_count();
	
    if( !rows )
		return 1;

	new
		type,
		slot,
		bag_id,
		id;
	
	for( new i; i != rows; i++ ) 
	{
		type = cache_get_field_content_int( i, "item_type", mysql ),
		slot = cache_get_field_content_int( i, "item_slot", mysql );
		
		switch( type )
		{
			case TYPE_INV :
			{	
				PlayerInv[playerid][slot][inv_bd] = cache_get_field_content_int(i, "id", mysql);
				PlayerInv[playerid][slot][inv_id] = cache_get_field_content_int(i, "item_id", mysql );
				PlayerInv[playerid][slot][inv_amount] = cache_get_field_content_int(i, "item_amount", mysql );
				PlayerInv[playerid][slot][inv_pos_x] = cache_get_field_content_float(i, "item_pos_x", mysql );
				PlayerInv[playerid][slot][inv_pos_y] = cache_get_field_content_float(i, "item_pos_y", mysql );
				PlayerInv[playerid][slot][inv_pos_z] = cache_get_field_content_float(i, "item_pos_z", mysql );
				PlayerInv[playerid][slot][inv_rot_x] = cache_get_field_content_float(i, "item_rot_x", mysql );
				PlayerInv[playerid][slot][inv_rot_y] = cache_get_field_content_float(i, "item_rot_y", mysql );
				PlayerInv[playerid][slot][inv_rot_z] = cache_get_field_content_float(i, "item_rot_z", mysql );
				PlayerInv[playerid][slot][inv_bone] = cache_get_field_content_int(i, "item_bone", mysql );
				PlayerInv[playerid][slot][inv_slot] = slot;
				PlayerInv[playerid][slot][inv_active_type] = cache_get_field_content_int(i, "item_active_type", mysql );
				PlayerInv[playerid][slot][inv_type] = cache_get_field_content_int(i, "item_type", mysql );
				PlayerInv[playerid][slot][inv_scale_x] = cache_get_field_content_float(i, "item_scale_x", mysql );
				PlayerInv[playerid][slot][inv_scale_y] = cache_get_field_content_float(i, "item_scale_y", mysql );
				PlayerInv[playerid][slot][inv_scale_z] = cache_get_field_content_float(i, "item_scale_z", mysql );
				
				PlayerInv[playerid][slot][inv_param_1] = cache_get_field_content_int( i, "item_param_1", mysql );
				PlayerInv[playerid][slot][inv_param_2] = cache_get_field_content_int( i, "item_param_2", mysql );
			}
			
			case TYPE_USE :
			{	
				UseInv[playerid][slot][inv_bd] = cache_get_field_content_int( i, "id", mysql );
				UseInv[playerid][slot][inv_id] = cache_get_field_content_int( i, "item_id", mysql );
				UseInv[playerid][slot][inv_amount] = cache_get_field_content_int( i, "item_amount", mysql );
				UseInv[playerid][slot][inv_pos_x] = cache_get_field_content_float( i, "item_pos_x", mysql );
				UseInv[playerid][slot][inv_pos_y] = cache_get_field_content_float( i, "item_pos_y", mysql );
				UseInv[playerid][slot][inv_pos_z] = cache_get_field_content_float( i, "item_pos_z", mysql );
				UseInv[playerid][slot][inv_rot_x] = cache_get_field_content_float( i, "item_rot_x", mysql );
				UseInv[playerid][slot][inv_rot_y] = cache_get_field_content_float( i, "item_rot_y", mysql );
				UseInv[playerid][slot][inv_rot_z] = cache_get_field_content_float( i, "item_rot_z", mysql );
				UseInv[playerid][slot][inv_bone] = cache_get_field_content_int(i, "item_bone", mysql );
				UseInv[playerid][slot][inv_slot] = slot;
				UseInv[playerid][slot][inv_active_type] = cache_get_field_content_int( i, "item_active_type", mysql );
				UseInv[playerid][slot][inv_type] = cache_get_field_content_int(i, "item_type", mysql );
				UseInv[playerid][slot][inv_scale_x] = cache_get_field_content_float(i, "item_scale_x", mysql );
				UseInv[playerid][slot][inv_scale_y] = cache_get_field_content_float(i, "item_scale_y", mysql );
				UseInv[playerid][slot][inv_scale_z] = cache_get_field_content_float(i, "item_scale_z", mysql );
				
				UseInv[playerid][slot][inv_param_1] = cache_get_field_content_int( i, "item_param_1", mysql );
				UseInv[playerid][slot][inv_param_2] = cache_get_field_content_int( i, "item_param_2", mysql );
				
				if( UseInv[playerid][slot][inv_active_type] == 0 )
				{
					id = getInventoryId( UseInv[playerid][slot][inv_id] );
					
					switch( inventory[id][i_type] )
					{
						case INV_BAG, INV_GUN, INV_COLD_GUN, INV_SMALL_GUN :
							continue;
							
						default:
							useItem( playerid, slot, STATE_DEFAULT );
					}
				}
				else if( UseInv[playerid][slot][inv_active_type] == 1 )
				{
					id = getInventoryId( UseInv[playerid][slot][inv_id] );
					switch( inventory[id][i_type] )
					{
						case INV_GUN, INV_COLD_GUN, INV_SMALL_GUN :
							continue;
							
						default:
							useItem( playerid, slot, STATE_ATTACH );
					}
				}
			}
		}
	}
	
	for( new j; j < MAX_INVENTORY; j++ )
	{
		if( getItemType( playerid, j, TYPE_INV ) == INV_BAG )
		{
			bag_id = addBagId( PlayerInv[playerid][j][inv_bd] );
			
			mysql_format:g_string( "SELECT * FROM " #DB_ITEMS " WHERE item_type = 2 AND item_type_id = %d", PlayerInv[playerid][j][inv_bd] );
			mysql_tquery( mysql, g_string, "LoadPlayerBag", "ii", playerid, bag_id );
		}
	}

	for( new k; k < MAX_INVENTORY_USE; k++ )
	{
		if( getItemType( playerid, k, TYPE_USE ) == INV_BAG )
		{
			bag_id = addBagId( UseInv[playerid][k][inv_bd] );
			
			mysql_format:g_string( "SELECT * FROM " #DB_ITEMS " WHERE item_type = 2 AND item_type_id = %d", UseInv[playerid][k][inv_bd] );
			mysql_tquery( mysql, g_string, "LoadPlayerBag", "ii", playerid, bag_id );
		}
	}
	
	updateMass( playerid );
	printf( "[Load]: Inventory %s[%d] has been loaded. All items - %d", GetAccountName( playerid ), playerid, rows );
	
	return 1;
}

function LoadVehicleInventory( vehicleid ) 
{
	new 
		rows = cache_get_row_count();
	
    if( !rows )
		return 1;

	new
		slot,
		bag_id;
		
	for( new i; i != rows; i++ ) 
	{
		slot = cache_get_field_content_int( i, "item_slot", mysql );
		
		CarInv[vehicleid][slot][inv_bd] = cache_get_field_content_int(i, "id", mysql);
		CarInv[vehicleid][slot][inv_id] = cache_get_field_content_int(i, "item_id", mysql );
		CarInv[vehicleid][slot][inv_amount] = cache_get_field_content_int(i, "item_amount", mysql );
		CarInv[vehicleid][slot][inv_pos_x] = cache_get_field_content_float(i, "item_pos_x", mysql );
		CarInv[vehicleid][slot][inv_pos_y] = cache_get_field_content_float(i, "item_pos_y", mysql );
		CarInv[vehicleid][slot][inv_pos_z] = cache_get_field_content_float(i, "item_pos_z", mysql );
		CarInv[vehicleid][slot][inv_rot_x] = cache_get_field_content_float(i, "item_rot_x", mysql );
		CarInv[vehicleid][slot][inv_rot_y] = cache_get_field_content_float(i, "item_rot_y", mysql );
		CarInv[vehicleid][slot][inv_rot_z] = cache_get_field_content_float(i, "item_rot_z", mysql );
		CarInv[vehicleid][slot][inv_bone] = cache_get_field_content_int(i, "item_bone", mysql );
		CarInv[vehicleid][slot][inv_slot] = slot;
		CarInv[vehicleid][slot][inv_active_type] = cache_get_field_content_int(i, "item_active_type", mysql );
		CarInv[vehicleid][slot][inv_scale_x] = cache_get_field_content_float(i, "item_scale_x", mysql );
		CarInv[vehicleid][slot][inv_scale_y] = cache_get_field_content_float(i, "item_scale_y", mysql );
		CarInv[vehicleid][slot][inv_scale_z] = cache_get_field_content_float(i, "item_scale_z", mysql );
				
		CarInv[vehicleid][slot][inv_param_1] = cache_get_field_content_int( i, "item_param_1", mysql );
		CarInv[vehicleid][slot][inv_param_2] = cache_get_field_content_int( i, "item_param_2", mysql );
		
		CarInv[vehicleid][slot][inv_type] = TYPE_WARECAR;
	}
	
	for( new j; j < MAX_INVENTORY_WAREHOUSE; j++ )
	{
		if( getItemType( vehicleid, j, TYPE_WARECAR ) == INV_BAG )
		{
			bag_id = addBagId( CarInv[vehicleid][j][inv_bd] );
			
			mysql_format:g_string( "SELECT * FROM " #DB_ITEMS " WHERE item_type = 2 AND item_type_id = %d", CarInv[vehicleid][j][inv_bd] );
			mysql_tquery( mysql, g_string, "LoadCarBag", "ii", vehicleid, bag_id );
		}
	}
	
	printf( "[Load]: Inventory vehicle[%d] %s[%d] has been loaded. All items - %d", 
		Vehicle[vehicleid][vehicle_id],
		GetVehicleModelName( Vehicle[vehicleid][vehicle_model] ), 
		vehicleid, 
		rows 
	);

	return 1;
}