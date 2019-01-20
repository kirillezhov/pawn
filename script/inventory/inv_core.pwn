function Inv_OnGameModeInit() 
{
	mysql_tquery( mysql, "SELECT * FROM "DB_INVENTORY" ORDER BY `inventory_id`", "LoadInventoryData", "" );
	Inv_TextDraws();
	return 1;
}

function Inv_OnPlayerConnect( playerid ) 
{
	invSelect[playerid] = INVALID_PTD;
	
	SetPVarInt( playerid, "Inv:Select", INVALID_PARAM );
	SetPVarInt( playerid, "UseInv:Select", INVALID_PARAM );
	SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );
	SetPVarInt( playerid, "CarInv:Select", INVALID_PARAM );
	
	SetPVarInt( playerid, "Inv:UseDrinkCount", 0 );
	SetPVarInt( playerid, "Inv:UseSmokeCount", 0 );
	SetPVarInt( playerid, "Inv:UseDrinkId", 0 );
	SetPVarInt( playerid, "Inv:UseSmokeId", 0 );
	SetPVarInt( playerid, "Inv:BagId", INVALID_PARAM );
	SetPVarInt( playerid, "Inv:HouseId", INVALID_PARAM );
	SetPVarInt( playerid, "Inv:CarId", INVALID_PARAM );

	SetPVarInt( playerid, "Inv:AttachBone", INVALID_PARAM );
	SetPVarInt( playerid, "Inv:AttachSlot", INVALID_PARAM );
	SetPVarInt( playerid, "Inv:AttachSelectSlot", INVALID_PARAM );
	SetPVarInt( playerid, "Inv:AttachType", 0 );
	
	SetPVarInt( playerid, "Inv:PlayerId", INVALID_PARAM );
	SetPVarInt( playerid, "Inv:GivePlayerId", INVALID_PLAYER_ID );
	
	g_player_attach_mode{playerid} = 0;
	g_player_edit_mode{playerid} = 0;

	for( new i; i < MAX_INVENTORY; i++ ) 
	{
		if( i < MAX_INVENTORY_USE )
			clearSlot( playerid, i, TYPE_USE );
		
		clearSlot( playerid, i, TYPE_INV );
	}
	
	Inv_PlayerTextDraws( playerid );
	
	return 1;
}	

function Inv_OnPlayerDisconnect( playerid, reason )
{
	InventoryHideTextDraws( playerid );
	InventoryClearBag( playerid );
	
	return 1;
}

function Inv_OnPlayerSpawn( playerid )
{
	static 
		id;
	
	for( new i; i < MAX_INVENTORY_USE; i++ )
	{
		if( UseInv[playerid][i][inv_active_type] == STATE_DEFAULT )
		{
			id = getInventoryId( UseInv[playerid][i][inv_id] );
		
			switch( inventory[id][i_type] )
			{
				case INV_GUN, INV_COLD_GUN, INV_SMALL_GUN :
				{
					useItem( playerid, i );
				}
			}
		}
		else if( UseInv[playerid][i][inv_active_type] == STATE_ATTACH )
		{
			useItem( playerid, i, 1 );
		}
	}
		
	return 1;
}

stock saveInventory( playerid, i, _: type, _: subtype = TYPE_INV )
{
	switch( type )
	{
		case INV_INSERT :
		{
			switch( subtype )
			{
				case TYPE_INV :
				{
					clean:<g_big_string>;
					mysql_format( mysql, g_big_string, sizeof g_big_string, 
					"\
						INSERT INTO `"DB_ITEMS"`\
						(\
							`item_id`, \
							`item_type`, \
							`item_type_id`, \
							`item_amount`, \
							`item_slot`, \
							`item_active_type`, \
							`item_param_1`, \
							`item_param_2`\
						) VALUES (\
							%d,\
							%d,\
							%d,\
							%d,\
							%d,\
							%d,\
							%d,\
							%d\
						)",
						PlayerInv[playerid][i][inv_id],
						PlayerInv[playerid][i][inv_type],
						Player[playerid][uID],
						PlayerInv[playerid][i][inv_amount],
						PlayerInv[playerid][i][inv_slot],
						PlayerInv[playerid][i][inv_active_type],
						PlayerInv[playerid][i][inv_param_1],
						PlayerInv[playerid][i][inv_param_2]
					);
				}
				
				case TYPE_USE :
				{
					clean:<g_big_string>;
					mysql_format( mysql, g_big_string, sizeof g_big_string, 
					"\
						INSERT INTO `"DB_ITEMS"`\
						(\
							`item_id`, \
							`item_type`, \
							`item_type_id`, \
							`item_amount`, \
							`item_slot`, \
							`item_active_type`, \
							`item_param_1`, \
							`item_param_2`\
						) VALUES (\
							%d,\
							%d,\
							%d,\
							%d,\
							%d,\
							%d,\
							%d,\
							%d\
						)",
						UseInv[playerid][i][inv_id],
						UseInv[playerid][i][inv_type],
						Player[playerid][uID],
						UseInv[playerid][i][inv_amount],
						UseInv[playerid][i][inv_slot],
						UseInv[playerid][i][inv_active_type],
						UseInv[playerid][i][inv_param_1],
						UseInv[playerid][i][inv_param_2]
					);	
				}
				
				case TYPE_BAG :
				{
					new 
						bag_id = getUseBagId( playerid );
						
					clean:<g_big_string>;
					mysql_format( mysql, g_big_string, sizeof g_big_string, 
					"\
						INSERT INTO `"DB_ITEMS"`\
						(\
							`item_id`, \
							`item_type`, \
							`item_type_id`, \
							`item_amount`, \
							`item_slot`, \
							`item_active_type`, \
							`item_param_1`, \
							`item_param_2` \
						) VALUES (\
							%d,\
							%d,\
							%d,\
							%d,\
							%d,\
							%d,\
							%d,\
							%d\
						)",
						BagInv[bag_id][i][inv_id],
						BagInv[bag_id][i][inv_type],
						getUseBagBd( playerid ),
						BagInv[bag_id][i][inv_amount],
						BagInv[bag_id][i][inv_slot],
						BagInv[bag_id][i][inv_active_type],
						BagInv[bag_id][i][inv_param_1],
						BagInv[bag_id][i][inv_param_2]
					);	
				}
				
				case TYPE_WARECAR:
				{
					new 
						car_id = GetPVarInt( playerid, "Inv:CarId" );
						
					clean:<g_big_string>;
					mysql_format( mysql, g_big_string, sizeof g_big_string, 
					"\
						INSERT INTO `"DB_ITEMS"`\
						(\
							`item_id`, \
							`item_type`, \
							`item_type_id`, \
							`item_amount`, \
							`item_slot`, \
							`item_active_type`, \
							`item_param_1`, \
							`item_param_2` \
						) VALUES (\
							%d,\
							%d,\
							%d,\
							%d,\
							%d,\
							%d,\
							%d,\
							%d\
						)",
						CarInv[car_id][i][inv_id],
						CarInv[car_id][i][inv_type],
						Vehicle[car_id][vehicle_id],
						CarInv[car_id][i][inv_amount],
						CarInv[car_id][i][inv_slot],
						CarInv[car_id][i][inv_active_type],
						CarInv[car_id][i][inv_param_1],
						CarInv[car_id][i][inv_param_2]
					);
				}
			}
			
			return mysql_tquery( mysql, g_big_string, "OnInventoryAddItem", "ddd", playerid, i, subtype );
		}
		
		case INV_UPDATE :
		{
			switch( subtype )
			{
				case I_TO_I :
				{
					clean:<g_big_string>;
					mysql_format( mysql, g_big_string, sizeof g_big_string, 
					"\
						UPDATE `"DB_ITEMS"` \
						SET \
							`item_amount` = '%d', \
							`item_slot` = '%d', \
							`item_param_1` = '%d' \
						WHERE \
							`id` = '%d' \
					",
						PlayerInv[playerid][i][inv_amount],
						PlayerInv[playerid][i][inv_slot],
						PlayerInv[playerid][i][inv_param_1],
						PlayerInv[playerid][i][inv_bd]
					);
					
					return mysql_tquery( mysql, g_big_string );
				}
				
				case U_TO_I :
				{
					clean:<g_big_string>;
					mysql_format( mysql, g_big_string, sizeof g_big_string, 
					"\
						UPDATE `" #DB_ITEMS "` \
						SET \
							`item_type` = 0, \
							`item_amount` = '%d', \
							`item_slot` = '%d', \
							`item_param_1` = '%d', \
							`item_param_2` = '%d' \
						WHERE \
							`id` = '%d' \
					",
						PlayerInv[playerid][i][inv_amount],
						PlayerInv[playerid][i][inv_slot],
						PlayerInv[playerid][i][inv_param_1],
						PlayerInv[playerid][i][inv_param_2],
						PlayerInv[playerid][i][inv_bd]
					);
					
					return mysql_tquery( mysql, g_big_string );
				}
				
				case I_TO_U :
				{
					clean:<g_big_string>;
					
					mysql_format( mysql, g_big_string, sizeof g_big_string, 
					"\
						UPDATE `" #DB_ITEMS "` \
						SET \
							`item_type` = 1, \
							`item_slot` = '%d' \
						WHERE \
							`id` = '%d' \
					",
						UseInv[playerid][i][inv_slot],
						UseInv[playerid][i][inv_bd]
					);
					
					return mysql_tquery( mysql, g_big_string );
				}
				
				case U_TO_U : 
				{
					clean:<g_big_string>;
					mysql_format( mysql, g_big_string, sizeof g_big_string, 
					"\
						UPDATE `"DB_ITEMS"` \
						SET \
							`item_slot` = '%d' \
						WHERE \
							`id` = '%d' \
					",
						UseInv[playerid][i][inv_slot],
						UseInv[playerid][i][inv_bd]
					);
					
					return mysql_tquery( mysql, g_big_string );
				}
				
				case B_TO_B :
				{
					clean:<g_big_string>;
					mysql_format( mysql, g_big_string, sizeof g_big_string, 
					"\
						UPDATE `"DB_ITEMS"` \
						SET \
							`item_amount` = '%d', \
							`item_slot` = '%d' \
						WHERE \
							`id` = '%d'\
					",
						BagInv[getUseBagId( playerid )][i][inv_amount],
						BagInv[getUseBagId( playerid )][i][inv_slot],
						BagInv[getUseBagId( playerid )][i][inv_bd]
					);
					
					return mysql_tquery( mysql, g_big_string );
				}
				
				case B_TO_I, C_TO_I :
				{
					clean:<g_big_string>;
					mysql_format( mysql, g_big_string, sizeof g_big_string, 
					"\
						UPDATE `"DB_ITEMS"` \
						SET \
							`item_amount` = %d, \
							`item_slot` = %d, \
							`item_type_id` = %d, \
							`item_type` = 0 \
						WHERE \
							`id` = %d\
					",
						PlayerInv[playerid][i][inv_amount],
						PlayerInv[playerid][i][inv_slot],
						Player[playerid][uID],
						PlayerInv[playerid][i][inv_bd]
					);
					
					return mysql_tquery( mysql, g_big_string );
				}
				
				case B_TO_U, C_TO_U :
				{
					clean:<g_big_string>;
					mysql_format( mysql, g_big_string, sizeof g_big_string, 
					"\
						UPDATE `"DB_ITEMS"` \
						SET \
							`item_slot` = %d, \
							`item_type_id` = %d,\
							`item_type` = 1 \
						WHERE \
							`id` = %d\
					",
						UseInv[playerid][i][inv_slot],
						Player[playerid][uID],
						UseInv[playerid][i][inv_bd]
					);
					
					return mysql_tquery( mysql, g_big_string );
				}
				
				case U_TO_B :
				{
					clean:<g_big_string>;
					mysql_format( mysql, g_big_string, sizeof g_big_string, 
					"\
						UPDATE `"DB_ITEMS"` \
						SET \
							`item_amount` = %d, \
							`item_slot` = %d, \
							`item_type_id` = %d \
							`item_type` = 2 \
						WHERE \
							`id` = '%d'\
					",
						BagInv[getUseBagId( playerid )][i][inv_amount],
						BagInv[getUseBagId( playerid )][i][inv_slot],
						getUseBagBd( playerid ),
						BagInv[getUseBagId( playerid )][i][inv_bd]
					);
					
					return mysql_tquery( mysql, g_big_string );
				}
				
				case I_TO_B, C_TO_B :
				{
					clean:<g_big_string>;
					mysql_format( mysql, g_big_string, sizeof g_big_string, 
					"\
						UPDATE `"DB_ITEMS"` \
						SET \
							`item_amount` = '%d', \
							`item_slot` = '%d',\
							`item_type_id` = %d, \
							`item_type` = 2 \
						WHERE \
							`id` = '%d'\
					",
						BagInv[getUseBagId( playerid )][i][inv_amount],
						BagInv[getUseBagId( playerid )][i][inv_slot],
						getUseBagBd( playerid ),
						BagInv[getUseBagId( playerid )][i][inv_bd]
					);
					
					return mysql_tquery( mysql, g_big_string );
				}
				
				case UPDATE_ATTACH :
				{
					mysql_format:g_string( 
					"\
						UPDATE `"DB_ITEMS"` \
						SET \
							`item_active_type` = %d, \
							`item_pos_x` = %f, \
							`item_pos_y` = %f, \
							`item_pos_z` = %f, \
							`item_rot_x` = %f, \
							`item_rot_y` = %f, \
							`item_rot_z` = %f, \
							`item_scale_x` = %f, \
							`item_scale_y` = %f, \
							`item_scale_z` = %f, \
							`item_bone` = %d \
						WHERE \
							`id` = '%d'\
					",
						UseInv[playerid][i][inv_active_type],
						UseInv[playerid][i][inv_pos_x],
						UseInv[playerid][i][inv_pos_y],
						UseInv[playerid][i][inv_pos_z],
						UseInv[playerid][i][inv_rot_x],
						UseInv[playerid][i][inv_rot_y],
						UseInv[playerid][i][inv_rot_z],
						UseInv[playerid][i][inv_scale_x],
						UseInv[playerid][i][inv_scale_y],
						UseInv[playerid][i][inv_scale_z],
						UseInv[playerid][i][inv_bone],
						UseInv[playerid][i][inv_bd]
					);
					
					return mysql_tquery( mysql, g_string );
				}
				
				case UPD_I :
				{
					clean:<g_big_string>;
					mysql_format( mysql, g_big_string, sizeof g_big_string, 
					"\
						UPDATE `"DB_ITEMS"` \
						SET \
							`item_id` = %d, \
							`item_amount` = %d, \
							`item_type_id` = %d, \
							`item_param_1` = %d, \
							`item_param_2` = %d \
						WHERE \
							`id` = '%d'\
					",
						PlayerInv[playerid][i][inv_id],
						PlayerInv[playerid][i][inv_amount],
						Player[playerid][uID],
						PlayerInv[playerid][i][inv_param_1],
						PlayerInv[playerid][i][inv_param_2],
						PlayerInv[playerid][i][inv_bd]
					);
					
					return mysql_tquery( mysql, g_big_string );
				}
				
				case UPD_U :
				{
					clean:<g_big_string>;
					mysql_format( mysql, g_big_string, sizeof g_big_string, 
					"\
						UPDATE `"DB_ITEMS"` \
						SET \
							`item_id` = %d, \
							`item_amount` = %d, \
							`item_param_1` = %d, \
							`item_param_2` = %d \
						WHERE \
							`id` = '%d'\
					",
						UseInv[playerid][i][inv_id],
						UseInv[playerid][i][inv_amount],
						UseInv[playerid][i][inv_param_1],
						UseInv[playerid][i][inv_param_2],
						UseInv[playerid][i][inv_bd]
					);
					
					return mysql_tquery( mysql, g_big_string, "", "" );
				}
				
				case UPD_B :
				{
					new 
						bag_id = getUseBagId( playerid );
						
					clean:<g_big_string>;
					mysql_format( mysql, g_big_string, sizeof g_big_string, 
					"\
						UPDATE `"DB_ITEMS"` \
						SET \
							`item_id` = %d, \
							`item_amount` = %d, \
							`item_param_1` = %d, \
							`item_param_2` = %d \
						WHERE \
							`id` = '%d'\
					",
						BagInv[bag_id][i][inv_id],
						BagInv[bag_id][i][inv_amount],
						BagInv[bag_id][i][inv_param_1],
						BagInv[bag_id][i][inv_param_2],
						BagInv[bag_id][i][inv_bd]
					);
					
					return mysql_tquery( mysql, g_big_string, "", "" );
				}
				
				case U_TO_C, I_TO_C, B_TO_C :
				{
					new 
						car_id = GetPVarInt( playerid, "Inv:CarId" );
						
					clean:<g_big_string>;
					mysql_format( mysql, g_big_string, sizeof g_big_string, 
					"\
						UPDATE `"DB_ITEMS"` \
						SET \
							`item_type` = %d, \
							`item_type_id` = %d, \
							`item_amount` = %d, \
							`item_slot` = %d, \
							`item_active_type` = %d, \
							`item_pos_x` = %f, \
							`item_pos_y` = %f, \
							`item_pos_z` = %f, \
							`item_rot_x` = %f, \
							`item_rot_y` = %f, \
							`item_rot_z` = %f, \
							`item_scale_x` = %f, \
							`item_scale_y` = %f, \
							`item_scale_z` = %f, \
							`item_bone` = %d \
						WHERE \
							`id` = '%d' LIMIT 1\
					",
						CarInv[car_id][i][inv_type],
						Vehicle[car_id][vehicle_id],
						CarInv[car_id][i][inv_amount],
						CarInv[car_id][i][inv_slot],
						CarInv[car_id][i][inv_active_type],
						CarInv[car_id][i][inv_pos_x],
						CarInv[car_id][i][inv_pos_y],
						CarInv[car_id][i][inv_pos_z],
						CarInv[car_id][i][inv_rot_x],
						CarInv[car_id][i][inv_rot_y],
						CarInv[car_id][i][inv_rot_z],
						CarInv[car_id][i][inv_scale_x],
						CarInv[car_id][i][inv_scale_y],
						CarInv[car_id][i][inv_scale_z],
						CarInv[car_id][i][inv_bone],
						CarInv[car_id][i][inv_bd]
					);
					
					return mysql_tquery( mysql, g_big_string );
				}
				
				case UPD_C :
				{
					new 
						car_id = GetPVarInt( playerid, "Inv:CarId" );
						
					clean:<g_big_string>;
					mysql_format( mysql, g_big_string, sizeof g_big_string, 
					"\
						UPDATE `"DB_ITEMS"` \
						SET \
							`item_id` = %d, \
							`item_amount` = %d, \
							`item_param_1` = %d, \
							`item_param_2` = %d \
						WHERE \
							`id` = '%d'\
					",
						CarInv[car_id][i][inv_id],
						CarInv[car_id][i][inv_amount],
						CarInv[car_id][i][inv_param_1],
						CarInv[car_id][i][inv_param_2],
						CarInv[car_id][i][inv_bd]
					);
					
					return mysql_tquery( mysql, g_big_string );
				}
				
				case C_TO_C :
				{
					clean:<g_big_string>;
					mysql_format( mysql, g_big_string, sizeof g_big_string, 
					"\
						UPDATE `"DB_ITEMS"` \
						SET \
							`item_amount` = '%d', \
							`item_slot` = '%d' \
						WHERE \
							`id` = '%d'\
					",
						CarInv[GetPVarInt( playerid, "Inv:CarId" )][i][inv_amount],
						CarInv[GetPVarInt( playerid, "Inv:CarId" )][i][inv_slot],
						CarInv[GetPVarInt( playerid, "Inv:CarId" )][i][inv_bd]
					);
					
					return mysql_tquery( mysql, g_big_string );
				}
				
				/*case U_TO_C :
				{
					new
						car_id = GetPVarInt( playerid, "Inv:CarId" );
				
					clean:<g_big_string>;
					mysql_format( mysql, g_big_string, sizeof g_big_string, 
					"\
						UPDATE `"DB_ITEMS"` \
						SET \
							`item_amount` = %d, \
							`item_slot` = %d, \
							`item_type_id` = %d \
							`item_type` = 3 \
						WHERE \
							`id` = '%d'\
					",
						CarInv[car_id][i][inv_amount],
						CarInv[car_id][i][inv_slot],
						Vehicle[car_id][vehicle_id],
						CarInv[car_id][i][inv_bd]
					);
					
					return mysql_tquery( mysql, g_big_string );
				}*/
			}	
			
		}
		
		case INV_DELETE :
		{
			switch( subtype )
			{
				case TYPE_INV :
				{
					clean:<g_big_string>;
					mysql_format( mysql, g_big_string, sizeof g_big_string, 
					"\
						DELETE FROM `"DB_ITEMS"` \
						WHERE \
							`id` = %d \
					",
						PlayerInv[playerid][i][inv_bd]
					);
					
					return mysql_tquery( mysql, g_big_string );
				}
				
				case TYPE_BAG : 
				{
					clean:<g_big_string>;
					mysql_format( mysql, g_big_string, sizeof g_big_string, 
					"\
						DELETE FROM `"DB_ITEMS"` \
						WHERE \
							`id` = %d \
					",
						BagInv[ getUseBagId( playerid ) ][i][inv_bd]
					);
					
					mysql_tquery( mysql, g_big_string );
					
					clean:<g_big_string>;
					mysql_format( mysql, g_big_string, sizeof g_big_string, 
					"\
						DELETE FROM `"DB_ITEMS"` \
						WHERE \
							`item_type_id` = %d \
					",
						BagInv[ getUseBagId( playerid ) ][i][inv_bd]
					);
					
					return mysql_tquery( mysql, g_big_string );
				}
				
				case TYPE_USE :
				{
					clean:<g_big_string>;
					mysql_format( mysql, g_big_string, sizeof g_big_string, 
					"\
						DELETE FROM `"DB_ITEMS"` \
						WHERE \
							`id` = %d \
					",
						UseInv[playerid][i][inv_bd]
					);
					
					return mysql_tquery( mysql, g_big_string );
				}
				
				case TYPE_WARECAR :
				{
					clean:<g_small_string>;
					mysql_format( mysql, g_small_string, sizeof g_small_string, 
					"\
						DELETE FROM `"DB_ITEMS"` \
						WHERE \
							`id` = %d \
					",
						CarInv[ GetPVarInt( playerid, "Inv:CarId" ) ][i][inv_bd]
					);
					
					return mysql_tquery( mysql, g_small_string );
				}
			}
		}
	}
	
	return STATUS_DONE;
}

SaveAmmoForUseWeapon( playerid )
{	
	new 
		id,
		slot,
		save_weapon	[MAX_WEAPON_SLOT],
		save_ammo	[MAX_WEAPON_SLOT];
		
	for( new i; i < MAX_INVENTORY_USE; i++ )
	{
		id = getInventoryId( UseInv[playerid][i][inv_id] );
		
		if( inventory[id][i_type] == INV_GUN || inventory[id][i_type] == INV_SMALL_GUN )
		{
			slot = GetPlayerWeaponSlot( inventory[id][i_param_1] );
			GetPlayerWeaponData( playerid, slot, save_weapon[slot], save_ammo[slot] );
			
			if( save_weapon[slot] == inventory[id][i_param_1] )
				UseInv[playerid][i][inv_param_1] = save_ammo[slot];
			
			clean:<g_small_string>;
			mysql_format( mysql, g_small_string, sizeof g_small_string,
			"\
				UPDATE `"DB_ITEMS"` \
				SET \
					`item_param_1` = %d, \
					`item_slot` = %d \
				WHERE \
					`id` = %d \
			",
				UseInv[playerid][i][inv_param_1],
				UseInv[playerid][i][inv_slot],
				UseInv[playerid][i][inv_bd]
			);
			
			mysql_tquery( mysql, g_small_string );
			
			printf( "[Save]: Account - %s[%d]. Action: Save ammo (Amount: %d) for weapon( Item ID: %d ).",
					GetAccountName( playerid ),
					playerid,
					UseInv[playerid][i][inv_param_1],
					UseInv[playerid][i][inv_id]
			);
		}
	}
	
	return STATUS_OK;
}

SaveAmmoForUseWeaponSlot( playerid, select )
{	
	clean:<g_small_string>;
	mysql_format( mysql, g_small_string, sizeof g_small_string,
	"\
		UPDATE `"DB_ITEMS"` \
		SET \
			`item_param_1` = %d, \
			`item_slot` = %d \
		WHERE \
			`id` = %d \
	",
		UseInv[playerid][select][inv_param_1],
		UseInv[playerid][select][inv_slot],
		UseInv[playerid][select][inv_bd]
	);
	
	mysql_tquery( mysql, g_small_string );
		
	printf( "[Save]: Account - %d[%d]. Action: Save ammo (Amount: %d) for weapon( Item ID: %d ).",
			GetAccountName( playerid ),
			playerid,
			UseInv[playerid][select][inv_param_1],
			UseInv[playerid][select][inv_id]
	);
}

function OnInventoryAddItem( playerid, i, type )
{
	switch( type )
	{
		case TYPE_INV :
		{
			PlayerInv[playerid][i][inv_bd] = cache_insert_id(); // Получаем ID созданного предмета

			PlayerInv[playerid][i][inv_bone] = -1;
			
			PlayerInv[playerid][i][inv_pos_x] =
			PlayerInv[playerid][i][inv_pos_y] =
			PlayerInv[playerid][i][inv_pos_z] =
			PlayerInv[playerid][i][inv_rot_x] =
			PlayerInv[playerid][i][inv_rot_y] =
			PlayerInv[playerid][i][inv_rot_z] =
			PlayerInv[playerid][i][inv_scale_x] =
			PlayerInv[playerid][i][inv_scale_y] = 
			PlayerInv[playerid][i][inv_scale_z] = 0.0;
	
			if( getItemType( playerid, i, TYPE_INV ) == INV_BAG && GetPVarInt( playerid, "Inv:BagId" ) == INVALID_PARAM )
			{
				new
					bag;
					
				bag = addBagId( PlayerInv[playerid][i][inv_bd] );
				
				printf( "[LOG BAG] Add bag[%d] = %d, %s[%d]", PlayerInv[playerid][i][inv_bd], bag, Player[playerid][uName], playerid );
			}
			else if( getItemType( playerid, i, TYPE_INV ) == INV_BAG && GetPVarInt( playerid, "Inv:BagId" ) != INVALID_PARAM )
			{
				mysql_format:g_string( "UPDATE "DB_ITEMS" SET `item_type_id` = %d WHERE `item_type_id` = %d",
					PlayerInv[playerid][i][inv_bd],
					g_bags[ GetPVarInt( playerid, "Inv:BagId" ) ]
				);
				mysql_tquery( mysql, g_string );
				
				g_bags[ GetPVarInt( playerid, "Inv:BagId" ) ] = PlayerInv[playerid][i][inv_bd];
				
				printf( "[LOG BAG] g_bags[%d] = %d", GetPVarInt( playerid, "Inv:BagId" ), g_bags[ GetPVarInt( playerid, "Inv:BagId" ) ] );
				SetPVarInt( playerid, "Inv:BagId", INVALID_PARAM );
			}
		}
		
		case TYPE_USE :
		{
			UseInv[playerid][i][inv_bd] = cache_insert_id(); // Получаем ID созданного предмета
					
			UseInv[playerid][i][inv_bone] = -1;
			
			UseInv[playerid][i][inv_pos_x] =
			UseInv[playerid][i][inv_pos_y] =
			UseInv[playerid][i][inv_pos_z] =
			UseInv[playerid][i][inv_rot_x] =
			UseInv[playerid][i][inv_rot_y] =
			UseInv[playerid][i][inv_rot_z] =
			UseInv[playerid][i][inv_scale_x] =
			UseInv[playerid][i][inv_scale_y] = 
			UseInv[playerid][i][inv_scale_z] = 0.0;
			
			if( getItemType( playerid, i, TYPE_USE ) == INV_BAG )
			{
				addBagId( UseInv[playerid][i][inv_bd] );
			}
		}
		
		case TYPE_BAG :
		{
			new 
				bag_id = getUseBagId( playerid );
				
			BagInv[bag_id][i][inv_bd] = cache_insert_id(); // Получаем ID созданного предмета
					
			BagInv[bag_id][i][inv_bone] = -1;
			
			BagInv[bag_id][i][inv_pos_x] =
			BagInv[bag_id][i][inv_pos_y] =
			BagInv[bag_id][i][inv_pos_z] =
			BagInv[bag_id][i][inv_rot_x] =
			BagInv[bag_id][i][inv_rot_y] =
			BagInv[bag_id][i][inv_rot_z] =
			BagInv[bag_id][i][inv_scale_x] =
			BagInv[bag_id][i][inv_scale_y] = 
			BagInv[bag_id][i][inv_scale_z] = 0.0;
		}
		
		case TYPE_WARECAR :
		{
			new 
				car_id = GetPVarInt( playerid, "Inv:CarId" );
				
			CarInv[car_id][i][inv_bd] = cache_insert_id(); // Получаем ID созданного предмета
					
			CarInv[car_id][i][inv_bone] = -1;
			
			CarInv[car_id][i][inv_pos_x] =
			CarInv[car_id][i][inv_pos_y] =
			CarInv[car_id][i][inv_pos_z] =
			CarInv[car_id][i][inv_rot_x] =
			CarInv[car_id][i][inv_rot_y] =
			CarInv[car_id][i][inv_rot_z] =
			CarInv[car_id][i][inv_scale_x] =
			CarInv[car_id][i][inv_scale_y] = 
			CarInv[car_id][i][inv_scale_z] = 0.0;
		}
	}
	
	return 1;
}

function OnInventoryUseItem( playerid, i, select, _: type )
{
	switch( type )
	{
		case I_TO_U :
		{
			if( PlayerInv[playerid][select][inv_param_2] == INDEX_FRACTION && !Player[playerid][uMember] )
			{
				return SendClient:( playerid, C_WHITE, !NOT_MOVE_ACT_ITEM );
			}
		
			if( getItemType( playerid, select, TYPE_INV ) == INV_SKIN )
			{
				if( !checkAllowSkin( playerid, PlayerInv[playerid][select][inv_param_1] ) )
					return SendClient:( playerid, C_WHITE, !""gbError"Эта одежда не подходит для Вас." );
			}
		
			switch( getItemType( playerid, select, TYPE_INV ) ) 
			{
				case INV_SKIN, INV_PHONE, INV_ARMOUR : 
				{
					UseInv[playerid][i][inv_type] = TYPE_USE;
					UseInv[playerid][i][inv_active_type] = STATE_DEFAULT;
					UseInv[playerid][i][inv_slot] = i;
					UseInv[playerid][i][inv_pos_x] = PlayerInv[playerid][select][inv_pos_x];
					UseInv[playerid][i][inv_pos_y] = PlayerInv[playerid][select][inv_pos_y];
					UseInv[playerid][i][inv_pos_z] = PlayerInv[playerid][select][inv_pos_z];
					UseInv[playerid][i][inv_rot_x] = PlayerInv[playerid][select][inv_rot_x];
					UseInv[playerid][i][inv_rot_y] = PlayerInv[playerid][select][inv_rot_y];
					UseInv[playerid][i][inv_rot_z] = PlayerInv[playerid][select][inv_rot_z];
					UseInv[playerid][i][inv_scale_x] = PlayerInv[playerid][select][inv_scale_x];
					UseInv[playerid][i][inv_scale_y] = PlayerInv[playerid][select][inv_scale_y];
					UseInv[playerid][i][inv_scale_z] = PlayerInv[playerid][select][inv_scale_z];
					UseInv[playerid][i][inv_bone] = PlayerInv[playerid][select][inv_bone];
					UseInv[playerid][i][inv_param_1] = PlayerInv[playerid][select][inv_param_1];
					UseInv[playerid][i][inv_param_2] = PlayerInv[playerid][select][inv_param_2];
					
					UseInv[playerid][i][inv_id] = PlayerInv[playerid][select][inv_id];

					PlayerInv[playerid][select][inv_amount]--;
					
					if( getItemType( playerid, select, TYPE_INV ) == INV_PHONE )
						LoadPhoneData( playerid, UseInv[playerid][i][inv_param_2] );
					
					if( PlayerInv[playerid][select][inv_amount] < 1 ) 
					{
						UseInv[playerid][i][inv_bd] = PlayerInv[playerid][select][inv_bd];
						
						saveInventory( playerid, i, INV_UPDATE, I_TO_U );
						
						clearSlot( playerid, select, TYPE_INV );
					}
					else
					{
						saveInventory( playerid, select, INV_UPDATE, UPD_I );
						saveInventory( playerid, i, INV_INSERT, TYPE_USE );
					}
					
					UseInv[playerid][i][inv_amount] = 1;
					updateImages( playerid, select, 0 );
					updateAmount( playerid, select, 0 );
					updateSelect( playerid, invSelect[playerid], 0 );

					invSelect[playerid] = INVALID_PTD;

					updateImages( playerid, i, 1 );
					updateAmount( playerid, i, 1 );

					SetPVarInt( playerid, "Inv:Select", INVALID_PARAM );
					
					useItem( playerid, i );
				}
				
				case INV_BAG : 
				{
					if( isSavedAttachObject( TYPE_INV, playerid, select ) )
					{
						UseInv[playerid][i][inv_type] = TYPE_USE;
						UseInv[playerid][i][inv_active_type] = STATE_ATTACH;
						UseInv[playerid][i][inv_slot] = i;
						UseInv[playerid][i][inv_pos_x] = PlayerInv[playerid][select][inv_pos_x];
						UseInv[playerid][i][inv_pos_y] = PlayerInv[playerid][select][inv_pos_y];
						UseInv[playerid][i][inv_pos_z] = PlayerInv[playerid][select][inv_pos_z];
						UseInv[playerid][i][inv_rot_x] = PlayerInv[playerid][select][inv_rot_x];
						UseInv[playerid][i][inv_rot_y] = PlayerInv[playerid][select][inv_rot_y];
						UseInv[playerid][i][inv_rot_z] = PlayerInv[playerid][select][inv_rot_z];
						UseInv[playerid][i][inv_scale_x] = PlayerInv[playerid][select][inv_scale_x];
						UseInv[playerid][i][inv_scale_y] = PlayerInv[playerid][select][inv_scale_y];
						UseInv[playerid][i][inv_scale_z] = PlayerInv[playerid][select][inv_scale_z];
						UseInv[playerid][i][inv_bone] = PlayerInv[playerid][select][inv_bone];
						UseInv[playerid][i][inv_param_1] = PlayerInv[playerid][select][inv_param_1];
						UseInv[playerid][i][inv_param_2] = PlayerInv[playerid][select][inv_param_2];
						UseInv[playerid][i][inv_id] = PlayerInv[playerid][select][inv_id];
						
						PlayerInv[playerid][select][inv_amount]--;
						
						if( PlayerInv[playerid][select][inv_amount] < 1 ) 
						{
							UseInv[playerid][i][inv_bd] = PlayerInv[playerid][select][inv_bd];
							
							saveInventory( playerid, i, INV_UPDATE, I_TO_U );
							
							clearSlot( playerid, select, TYPE_INV );
						}	
						else
						{
							saveInventory( playerid, select, INV_UPDATE, UPD_I );
							saveInventory( playerid, i, INV_INSERT, TYPE_USE );
						}
						
						
						UseInv[playerid][i][inv_amount] = 1;

						updateImages( playerid, select, TYPE_INV );
						updateAmount( playerid, select, TYPE_INV );
						
						updateSelect( playerid, invSelect[playerid], 0 );

						updateImages( playerid, i, TYPE_USE );
						updateAmount( playerid, i, TYPE_USE );

						SetPVarInt( playerid, "Inv:Select", INVALID_PARAM );
						
						useItem( playerid, i, STATE_ATTACH );
						
						updateMass( playerid );						
						showBag( playerid, inventory[getInventoryId( UseInv[playerid][i][inv_id] )][i_name], true );
					}
					else
					{
						SetPVarInt( playerid, "Inv:NewSelect", select );
						SetPVarInt( playerid, "Inv:OldSelect", i );
						
						showPlayerDialog( playerid, d_inv_attach + 8, DIALOG_STYLE_LIST, " ", invcontent_bone, "Далее", "Назад" );
					}
				}
				
				case INV_GUN, INV_SMALL_GUN, INV_COLD_GUN : 
				{ 				
					showPlayerDialog( playerid, d_inv, DIALOG_STYLE_LIST, " ", 
						""gbDialog"Выберите действие с предметом:\n\
						"cBLUE"-"cWHITE" Взять в руки\n\
						"cBLUE"-"cWHITE" Закрепить на персонаже", "Выбрать", "Отмена");
						
					SetPVarInt( playerid, "Inv:NewSelect", select );
					SetPVarInt( playerid, "Inv:OldSelect", i );
					
				}
				
				case INV_ATTACH :
				{
					if( isSavedAttachObject( TYPE_INV, playerid, select ) )
					{
						UseInv[playerid][i][inv_type] = TYPE_USE;
						UseInv[playerid][i][inv_active_type] = STATE_ATTACH;
						UseInv[playerid][i][inv_slot] = i;
						UseInv[playerid][i][inv_pos_x] = PlayerInv[playerid][select][inv_pos_x];
						UseInv[playerid][i][inv_pos_y] = PlayerInv[playerid][select][inv_pos_y];
						UseInv[playerid][i][inv_pos_z] = PlayerInv[playerid][select][inv_pos_z];
						UseInv[playerid][i][inv_rot_x] = PlayerInv[playerid][select][inv_rot_x];
						UseInv[playerid][i][inv_rot_y] = PlayerInv[playerid][select][inv_rot_y];
						UseInv[playerid][i][inv_rot_z] = PlayerInv[playerid][select][inv_rot_z];
						UseInv[playerid][i][inv_scale_x] = PlayerInv[playerid][select][inv_scale_x];
						UseInv[playerid][i][inv_scale_y] = PlayerInv[playerid][select][inv_scale_y];
						UseInv[playerid][i][inv_scale_z] = PlayerInv[playerid][select][inv_scale_z];
						UseInv[playerid][i][inv_bone] = PlayerInv[playerid][select][inv_bone];
						UseInv[playerid][i][inv_param_1] = PlayerInv[playerid][select][inv_param_1];
						UseInv[playerid][i][inv_param_2] = PlayerInv[playerid][select][inv_param_2];
						UseInv[playerid][i][inv_id] = PlayerInv[playerid][select][inv_id];
						
						PlayerInv[playerid][select][inv_amount]--;
						
						if( PlayerInv[playerid][select][inv_amount] < 1 ) 
						{
							UseInv[playerid][i][inv_bd] = PlayerInv[playerid][select][inv_bd];
							
							saveInventory( playerid, i, INV_UPDATE, I_TO_U );
							
							clearSlot( playerid, select, TYPE_INV );
						}	
						else
						{
							saveInventory( playerid, select, INV_UPDATE, UPD_I );
							saveInventory( playerid, i, INV_INSERT, TYPE_USE );
						}
						
						
						UseInv[playerid][i][inv_amount] = 1;

						updateImages( playerid, select, TYPE_INV );
						updateAmount( playerid, select, TYPE_INV );
						
						updateSelect( playerid, invSelect[playerid], 0 );

						updateImages( playerid, i, TYPE_USE );
						updateAmount( playerid, i, TYPE_USE );

						SetPVarInt( playerid, "Inv:Select", INVALID_PARAM );
						
						useItem( playerid, i, STATE_ATTACH );
					}
					else
					{
						showPlayerDialog( playerid, d_inv_attach + 4, DIALOG_STYLE_LIST, " ", invcontent_bone, "Далее", "Назад" );
					
						SetPVarInt( playerid, "Inv:NewSelect", select );
						SetPVarInt( playerid, "Inv:OldSelect", i );
					}
				}
				
				default :
				{
					return SendClientMessage( playerid, C_WHITE, NOT_MOVE_ACT_ITEM );
				}
			}
		}
		
		case B_TO_U :
		{
			new 
				bag_id = getUseBagId( playerid );
		
			if( isUseItem( playerid, select, TYPE_BAG ) )
				return SendClientMessage( playerid, C_WHITE, !USE_ACTIVE_SLOT_NOW );
				
			if(	checkMass( playerid ) + checkInvMass( BagInv[bag_id][select][inv_id] ) > checkMaxMass( playerid ) )
			{
				return SendClient:( playerid, C_WHITE, !MAX_MASS );
			}
			
			if( getItemType( bag_id, select, TYPE_BAG ) == INV_SKIN )
			{
				if( !checkAllowSkin( playerid, BagInv[bag_id][select][inv_param_1] ) )
					return SendClient:( playerid, C_WHITE, !""gbError"Эта одежда не подходит для Вас." );
			}
			
			switch( getItemType( bag_id, select, TYPE_BAG ) ) 
			{
				case INV_SKIN, INV_PHONE, INV_ARMOUR : 
				{
					UseInv[playerid][i][inv_type] = TYPE_USE;
					UseInv[playerid][i][inv_active_type] = BagInv[bag_id][select][inv_active_type];
					UseInv[playerid][i][inv_slot] = i;
					UseInv[playerid][i][inv_pos_x] = BagInv[bag_id][select][inv_pos_x];
					UseInv[playerid][i][inv_pos_y] = BagInv[bag_id][select][inv_pos_y];
					UseInv[playerid][i][inv_pos_z] = BagInv[bag_id][select][inv_pos_z];
					UseInv[playerid][i][inv_rot_x] = BagInv[bag_id][select][inv_rot_x];
					UseInv[playerid][i][inv_rot_y] = BagInv[bag_id][select][inv_rot_y];
					UseInv[playerid][i][inv_rot_z] = BagInv[bag_id][select][inv_rot_z];
					UseInv[playerid][i][inv_scale_x] = BagInv[bag_id][select][inv_scale_x];
					UseInv[playerid][i][inv_scale_y] = BagInv[bag_id][select][inv_scale_y];
					UseInv[playerid][i][inv_scale_z] = BagInv[bag_id][select][inv_scale_z];
					UseInv[playerid][i][inv_bone] = BagInv[bag_id][select][inv_bone];
					UseInv[playerid][i][inv_param_1] = BagInv[bag_id][select][inv_param_1];
					UseInv[playerid][i][inv_param_2] = BagInv[bag_id][select][inv_param_2];
					
					UseInv[playerid][i][inv_id] = BagInv[bag_id][select][inv_id];

					BagInv[bag_id][select][inv_amount]--;
					
					if( getItemType( playerid, select, TYPE_INV ) == INV_PHONE )
						LoadPhoneData( playerid, UseInv[playerid][i][inv_param_2] );
					
					if( BagInv[bag_id][select][inv_amount] < 1 ) 
					{
						UseInv[playerid][i][inv_bd] = BagInv[bag_id][select][inv_bd];
						
						saveInventory( playerid, i, INV_UPDATE, B_TO_U );
						clearSlot( bag_id, select, TYPE_BAG );
					}
					else
					{
						saveInventory( playerid, select, INV_UPDATE, UPD_B );
						updateSelect( playerid, bagSlot[playerid][select], 0 );
						
						saveInventory( playerid, i, INV_INSERT, TYPE_USE );
					}
					
					UseInv[playerid][i][inv_amount] = 1;
					UseInv[playerid][i][inv_type] = TYPE_USE;
					
					updateImages( playerid, select, TYPE_BAG );
					updateAmount( playerid, select, TYPE_BAG );
					
					updateSelect( playerid, invSelect[playerid], 0 );
					invSelect[playerid] = INVALID_PTD;

					updateImages( playerid, i, TYPE_USE );
					updateAmount( playerid, i, TYPE_USE );

					SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );

					updateMass( playerid );
					
					useItem( playerid, i );
				}
				
				case INV_BAG : 
				{
					UseInv[playerid][i][inv_type] = TYPE_USE;
					UseInv[playerid][i][inv_active_type] = BagInv[bag_id][select][inv_active_type];
					UseInv[playerid][i][inv_slot] = i;
					UseInv[playerid][i][inv_pos_x] = BagInv[bag_id][select][inv_pos_x];
					UseInv[playerid][i][inv_pos_y] = BagInv[bag_id][select][inv_pos_y];
					UseInv[playerid][i][inv_pos_z] = BagInv[bag_id][select][inv_pos_z];
					UseInv[playerid][i][inv_rot_x] = BagInv[bag_id][select][inv_rot_x];
					UseInv[playerid][i][inv_rot_y] = BagInv[bag_id][select][inv_rot_y];
					UseInv[playerid][i][inv_rot_z] = BagInv[bag_id][select][inv_rot_z];
					UseInv[playerid][i][inv_scale_x] = BagInv[bag_id][select][inv_scale_x];
					UseInv[playerid][i][inv_scale_y] = BagInv[bag_id][select][inv_scale_y];
					UseInv[playerid][i][inv_scale_z] = BagInv[bag_id][select][inv_scale_z];
					UseInv[playerid][i][inv_bone] = BagInv[bag_id][select][inv_bone];	
					UseInv[playerid][i][inv_param_1] = BagInv[bag_id][select][inv_param_1];
					UseInv[playerid][i][inv_param_2] = BagInv[bag_id][select][inv_param_2];
					
					UseInv[playerid][i][inv_id] = BagInv[bag_id][select][inv_id];

					BagInv[bag_id][select][inv_amount]--;
					
					if( BagInv[bag_id][select][inv_amount] < 1 ) 
					{
						UseInv[playerid][i][inv_bd] = BagInv[bag_id][select][inv_bd];
						
						saveInventory( playerid, i, INV_UPDATE, B_TO_U );
						
						clearSlot( bag_id, select, TYPE_BAG );
					}
					else
					{
						saveInventory( playerid, select, INV_UPDATE, UPD_B );
						saveInventory( playerid, i, INV_INSERT, TYPE_USE );
					}
					
					UseInv[playerid][i][inv_amount] = 1;

					updateImages( playerid, select, TYPE_BAG );
					updateAmount( playerid, select, TYPE_BAG );
					updateSelect( playerid, invSelect[playerid], false );

					invSelect[playerid] = INVALID_PTD;

					updateImages( playerid, i, TYPE_USE );
					updateAmount( playerid, i, TYPE_USE );

					SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );

					updateMass( playerid );
					
					useItem( playerid, i );

				}
				
				case INV_GUN, INV_SMALL_GUN, INV_COLD_GUN : 
				{
					showPlayerDialog( playerid, d_inv + 1, DIALOG_STYLE_LIST, " ", 
						""gbDialog"Выберите действие с предметом:\n\
						"cBLUE"-"cWHITE" Взять в руки\n\
						"cBLUE"-"cWHITE" Закрепить на персонаже", "Выбрать", "Отмена");
					
					SetPVarInt( playerid, "Inv:NewSelect", select );
					SetPVarInt( playerid, "Inv:OldSelect", i );
				}
				
				case INV_ATTACH :
				{
					if( isSavedAttachObject( TYPE_BAG, playerid, select ) )
					{
						UseInv[playerid][i][inv_type] = TYPE_USE;
						UseInv[playerid][i][inv_active_type] = STATE_ATTACH;
						UseInv[playerid][i][inv_slot] = i;
						UseInv[playerid][i][inv_pos_x] = BagInv[bag_id][select][inv_pos_x];
						UseInv[playerid][i][inv_pos_y] = BagInv[bag_id][select][inv_pos_y];
						UseInv[playerid][i][inv_pos_z] = BagInv[bag_id][select][inv_pos_z];
						UseInv[playerid][i][inv_rot_x] = BagInv[bag_id][select][inv_rot_x];
						UseInv[playerid][i][inv_rot_y] = BagInv[bag_id][select][inv_rot_y];
						UseInv[playerid][i][inv_rot_z] = BagInv[bag_id][select][inv_rot_z];
						UseInv[playerid][i][inv_scale_x] = BagInv[bag_id][select][inv_scale_x];
						UseInv[playerid][i][inv_scale_x] = BagInv[bag_id][select][inv_scale_x];
						UseInv[playerid][i][inv_scale_x] = BagInv[bag_id][select][inv_scale_x];
						UseInv[playerid][i][inv_bone] = BagInv[bag_id][select][inv_bone];
						UseInv[playerid][i][inv_param_1] = BagInv[bag_id][select][inv_param_1];
						UseInv[playerid][i][inv_param_2] = BagInv[bag_id][select][inv_param_2];
						UseInv[playerid][i][inv_id] = BagInv[bag_id][select][inv_id];
						
						BagInv[bag_id][select][inv_amount]--;
						
						if( BagInv[bag_id][select][inv_amount] < 1 ) 
						{
							UseInv[bag_id][i][inv_bd] = BagInv[bag_id][select][inv_bd];
							
							saveInventory( playerid, i, INV_UPDATE, B_TO_U );
							
							clearSlot( playerid, select, TYPE_BAG );
						}	
						else
						{
							saveInventory( playerid, select, INV_UPDATE, UPD_B );
							saveInventory( playerid, i, INV_INSERT, TYPE_USE );
						}
						
						UseInv[playerid][i][inv_amount] = 1;
						
						updateImages( playerid, select, TYPE_BAG );
						updateAmount( playerid, select, TYPE_BAG );
						
						updateSelect( playerid, invSelect[playerid], 0 );

						updateImages( playerid, i, TYPE_USE );
						updateAmount( playerid, i, TYPE_USE );

						SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );

						updateMass( playerid );
						
						useItem( playerid, i, STATE_ATTACH );
					}
					else
					{
						showPlayerDialog( playerid, d_inv_attach + 5, DIALOG_STYLE_LIST, " ", invcontent_bone, "Далее", "Назад" );
					
						SetPVarInt( playerid, "Inv:NewSelect", select );
						SetPVarInt( playerid, "Inv:OldSelect", i );
					}
				}
				
				default :
				{
					return SendClient:( playerid, C_WHITE, !NOT_MOVE_ACT_ITEM );
				}
			}
		}
		
		case C_TO_U :
		{
			new 
				car_id = GetPVarInt( playerid, "Inv:CarId" );
			
			if( !Vehicle[car_id][vehicle_id] )
			{
				return SendClient:( playerid, C_WHITE, !INCORRECT_USE_CAR );
			}
			
			if( Vehicle[car_id][vehicle_member] != Player[playerid][uMember] && CarInv[car_id][select][inv_param_2] == INDEX_FRACTION )
			{
				return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете переместить этот фракционный предмет." );
			}
			
			if(	checkMass( playerid ) + checkInvMass( CarInv[car_id][select][inv_id] ) > checkMaxMass( playerid ) )
			{
				return SendClient:( playerid, C_WHITE, !MAX_MASS );
			}
		
			if( isUseItem( playerid, select, TYPE_WARECAR ) )
				return SendClientMessage( playerid, C_WHITE, !USE_ACTIVE_SLOT_NOW );
				
			if( getItemType( car_id, select, TYPE_WARECAR ) == INV_SKIN )
			{
				if( !checkAllowSkin( playerid, CarInv[car_id][select][inv_param_1] ) )
					return SendClient:( playerid, C_WHITE, !""gbError"Эта одежда не подходит для Вас." );
			}
			
			switch( getItemType( car_id, select, TYPE_WARECAR ) ) 
			{
				case INV_SKIN, INV_PHONE, INV_ARMOUR : 
				{
					UseInv[playerid][i][inv_type] = TYPE_USE;
					UseInv[playerid][i][inv_active_type] = CarInv[car_id][select][inv_active_type];
					UseInv[playerid][i][inv_slot] = i;
					UseInv[playerid][i][inv_pos_x] = CarInv[car_id][select][inv_pos_x];
					UseInv[playerid][i][inv_pos_y] = CarInv[car_id][select][inv_pos_y];
					UseInv[playerid][i][inv_pos_z] = CarInv[car_id][select][inv_pos_z];
					UseInv[playerid][i][inv_rot_x] = CarInv[car_id][select][inv_rot_x];
					UseInv[playerid][i][inv_rot_y] = CarInv[car_id][select][inv_rot_y];
					UseInv[playerid][i][inv_rot_z] = CarInv[car_id][select][inv_rot_z];
					UseInv[playerid][i][inv_scale_x] = CarInv[car_id][select][inv_scale_x];
					UseInv[playerid][i][inv_scale_y] = CarInv[car_id][select][inv_scale_y];
					UseInv[playerid][i][inv_scale_z] = CarInv[car_id][select][inv_scale_z];
					UseInv[playerid][i][inv_bone] = CarInv[car_id][select][inv_bone];
					UseInv[playerid][i][inv_param_1] = CarInv[car_id][select][inv_param_1];
					UseInv[playerid][i][inv_param_2] = CarInv[car_id][select][inv_param_2];
					UseInv[playerid][i][inv_id] = CarInv[car_id][select][inv_id];

					CarInv[car_id][select][inv_amount]--;
					
					if( getItemType( playerid, select, TYPE_INV ) == INV_PHONE )
						LoadPhoneData( playerid, UseInv[playerid][i][inv_param_2] );
					
					if( CarInv[car_id][select][inv_amount] < 1 ) 
					{
						UseInv[playerid][i][inv_bd] = CarInv[car_id][select][inv_bd];
						
						saveInventory( playerid, i, INV_UPDATE, C_TO_U );
						clearSlotWareHouse( car_id, select, TYPE_WARECAR );
					}
					else
					{
						saveInventory( playerid, select, INV_UPDATE, UPD_C );
						updateWareHouseSelect( playerid, car_id, warehouseSlot[playerid][select], 0, TYPE_WARECAR );
						
						saveInventory( playerid, i, INV_INSERT, TYPE_USE );
					}
					
					UseInv[playerid][i][inv_amount] = 1;
					UseInv[playerid][i][inv_type] = TYPE_USE;
					
					updateImages( playerid, select, TYPE_WARECAR );
					updateAmount( playerid, select, TYPE_WARECAR );
					updateWareHouseSelect( playerid, car_id, invSelect[playerid], 0, TYPE_WARECAR );

					invSelect[playerid] = INVALID_PTD;

					updateImages( playerid, i, TYPE_USE );
					updateAmount( playerid, i, TYPE_USE );

					SetPVarInt( playerid, "CarInv:Select", INVALID_PARAM );

					updateMass( playerid );
					
					useItem( playerid, i );
				}
				
				case INV_BAG : 
				{
					SetPVarInt( playerid, "Inv:NewSelect", select );
					SetPVarInt( playerid, "Inv:OldSelect", i );
				
					showPlayerDialog( playerid, d_inv_attach + 9, DIALOG_STYLE_LIST, " ", invcontent_bone, "Далее", "Назад" );
				}
				
				case INV_GUN, INV_SMALL_GUN, INV_COLD_GUN : 
				{
					SetPVarInt( playerid, "Inv:NewSelect", select );
					SetPVarInt( playerid, "Inv:OldSelect", i );
				
					showPlayerDialog( playerid, d_inv + 2, DIALOG_STYLE_LIST, " ", 
						""gbDialog"Выберите действие с предметом:\n\
						"cBLUE"-"cWHITE" Взять в руки\n\
						"cBLUE"-"cWHITE" Закрепить на персонаже", "Выбрать", "Отмена");
				}
				
				case INV_ATTACH :
				{
					SetPVarInt( playerid, "Inv:NewSelect", select );
					SetPVarInt( playerid, "Inv:OldSelect", i );
				
					showPlayerDialog( playerid, d_inv_attach + 10, DIALOG_STYLE_LIST, " ", invcontent_bone, "Далее", "Назад" );
				}
				
				default :
				{
					return SendClientMessage( playerid, C_WHITE, NOT_MOVE_ACT_ITEM );
				}
			}
		}
	}
	
	return 1;
}

stock unUseInvItem( playerid, select )
{
	if( UseInv[playerid][select][inv_active_type] == STATE_ATTACH ) 
	{
		RemovePlayerAttachedObject( playerid, select );		
	}
			
	switch( getItemType( playerid, select, TYPE_USE ) ) 
	{
		case INV_SKIN : 
		{
			SetPlayerSkin( playerid, resetSkin( playerid ) );
		}
		case INV_BAG : 
		{
			showBag( playerid, "", 0 );
		}
		case INV_GUN, INV_COLD_GUN, INV_SMALL_GUN : 
		{
			RemovePlayerWeapon( playerid, select, getUseGunId( playerid, select ) );
		}
		
		case INV_ARMOUR :
		{
			SetPVarInt( playerid, "Inv:unUseArmour", 1 );
			setPlayerArmour( playerid, 0.0 );
		}
	}
	return 1;
}

stock updateInventory( playerid, i, select, PlayerText: playertextid, _: type ) //Обновить данные инвентаря
{
	if( select == INVALID_PARAM )
	{
		printf( "[Log Debug] playerid = %d, i = %d, select = %d, type = %d", 
			playerid, i, select, type );
		return STATUS_ERROR;
	}

	switch( type )
	{
		case I_TO_I :
		{
			if( !PlayerInv[playerid][i][inv_id] 
				|| PlayerInv[playerid][i][inv_id] == PlayerInv[playerid][select][inv_id] 
				&& isAllowStack( playerid, i, TYPE_INV )
			  )
			{
				PlayerInv[playerid][i][inv_type] = TYPE_INV;
				PlayerInv[playerid][i][inv_active_type] = 0;
				PlayerInv[playerid][i][inv_slot] = i;
				PlayerInv[playerid][i][inv_pos_x] = PlayerInv[playerid][select][inv_pos_x];
				PlayerInv[playerid][i][inv_pos_y] = PlayerInv[playerid][select][inv_pos_y];
				PlayerInv[playerid][i][inv_pos_z] = PlayerInv[playerid][select][inv_pos_z];
				PlayerInv[playerid][i][inv_rot_x] = PlayerInv[playerid][select][inv_rot_x];
				PlayerInv[playerid][i][inv_rot_y] = PlayerInv[playerid][select][inv_rot_y];
				PlayerInv[playerid][i][inv_rot_z] = PlayerInv[playerid][select][inv_rot_z];
				PlayerInv[playerid][i][inv_scale_x] = PlayerInv[playerid][select][inv_scale_x];
				PlayerInv[playerid][i][inv_scale_y] = PlayerInv[playerid][select][inv_scale_y];
				PlayerInv[playerid][i][inv_scale_z] = PlayerInv[playerid][select][inv_scale_z];
				PlayerInv[playerid][i][inv_bone] = PlayerInv[playerid][select][inv_bone];
				PlayerInv[playerid][i][inv_param_1] = PlayerInv[playerid][select][inv_param_1];
				PlayerInv[playerid][i][inv_param_2] = PlayerInv[playerid][select][inv_param_2];
				
				PlayerInv[playerid][i][inv_id] = PlayerInv[playerid][select][inv_id];
				
				PlayerInv[playerid][i][inv_amount]++;
				PlayerInv[playerid][select][inv_amount]--;
				
				if( PlayerInv[playerid][select][inv_amount] < 1 ) 
				{
					if( PlayerInv[playerid][i][inv_amount] > 1 )
					{
						saveInventory( playerid, select, INV_DELETE, TYPE_INV );
					}
					else
					{
						PlayerInv[playerid][i][inv_bd] = PlayerInv[playerid][select][inv_bd];
					}
					
					saveInventory( playerid, i, INV_UPDATE, I_TO_I );
					clearSlot( playerid, select, TYPE_INV );
				}
				else
				{
					saveInventory( playerid, select, INV_UPDATE, UPD_I );
					updateSelect( playerid, invSlot[playerid][select], 0 );
					
					if( PlayerInv[playerid][i][inv_amount] > 1 )
					{
						saveInventory( playerid, i, INV_UPDATE, UPD_I );
					}
					else
					{
						saveInventory( playerid, i, INV_INSERT, TYPE_INV );
					}
				}
				
				updateImages( playerid, select, 0 );
				updateImages( playerid, i, 0 );
				
				updateAmount( playerid, select, 0 );
				updateAmount( playerid, i, 0 );
				
				updateSelect( playerid, playertextid, 0 );
				
				updateSelect( playerid, invSelect[playerid], 0 );
				invSelect[playerid] = INVALID_PTD;
				
				SetPVarInt( playerid, "Inv:Select", INVALID_PARAM );
			}
		}
		
		case U_TO_I :
		{	
			if( !PlayerInv[playerid][i][inv_id] 
				|| PlayerInv[playerid][i][inv_id] == UseInv[playerid][select][inv_id] 
				&& isAllowStack( playerid, i, TYPE_INV )
			  ) 
			{
				unUseInvItem( playerid, select );
				
				PlayerInv[playerid][i][inv_type] = TYPE_INV;
				PlayerInv[playerid][i][inv_active_type] = 0;
				PlayerInv[playerid][i][inv_slot] = i;
				PlayerInv[playerid][i][inv_pos_x] = UseInv[playerid][select][inv_pos_x];
				PlayerInv[playerid][i][inv_pos_y] = UseInv[playerid][select][inv_pos_y];
				PlayerInv[playerid][i][inv_pos_z] = UseInv[playerid][select][inv_pos_z];
				PlayerInv[playerid][i][inv_rot_x] = UseInv[playerid][select][inv_rot_x];
				PlayerInv[playerid][i][inv_rot_y] = UseInv[playerid][select][inv_rot_y];
				PlayerInv[playerid][i][inv_rot_z] = UseInv[playerid][select][inv_rot_z];
				PlayerInv[playerid][i][inv_scale_x] = UseInv[playerid][select][inv_scale_x];
				PlayerInv[playerid][i][inv_scale_y] = UseInv[playerid][select][inv_scale_y];
				PlayerInv[playerid][i][inv_scale_z] = UseInv[playerid][select][inv_scale_z];
				PlayerInv[playerid][i][inv_bone] = UseInv[playerid][select][inv_bone];
				PlayerInv[playerid][i][inv_param_1] = UseInv[playerid][select][inv_param_1];
				PlayerInv[playerid][i][inv_param_2] = UseInv[playerid][select][inv_param_2];
				
				PlayerInv[playerid][i][inv_id] = UseInv[playerid][select][inv_id];

				PlayerInv[playerid][i][inv_amount]++;
				UseInv[playerid][select][inv_amount]--;
				
				if( UseInv[playerid][select][inv_amount] < 1 ) 
				{
					if( PlayerInv[playerid][i][inv_amount] > 1 )
					{
						saveInventory( playerid, select, INV_DELETE, TYPE_USE );						
						saveInventory( playerid, i, INV_UPDATE, UPD_I );
					}
					else
					{
						PlayerInv[playerid][i][inv_bd] = UseInv[playerid][select][inv_bd];
						saveInventory( playerid, i, INV_UPDATE, U_TO_I );
					}
					
					clearSlot( playerid, select, TYPE_USE );
				}
				else
				{
					saveInventory( playerid, select, INV_UPDATE, UPD_U );
					updateSelect( playerid, useSlot[playerid][select], 0 );
					
					if( PlayerInv[playerid][i][inv_amount] > 1 )
					{
						saveInventory( playerid, i, INV_UPDATE, UPD_I );
					}
					else
					{
						saveInventory( playerid, i, INV_INSERT, TYPE_INV );
					}
				}

				updateImages( playerid, select, 1 );
				updateImages( playerid, i, 0 );
				
				updateAmount( playerid, select, 1 );
				updateAmount( playerid, i, 0 );
					
				updateSelect( playerid, invSelect[playerid], 0 );
				invSelect[playerid] = INVALID_PTD;
				
				if( getItemType( playerid, i, TYPE_INV ) == INV_BAG ) updateMass( playerid );
				
				SetPVarInt( playerid, "UseInv:Select", INVALID_PARAM );
			}
		}
		
		case I_TO_U :
		{
			if( !UseInv[playerid][i][inv_id] ) 
			{
				if( isUseItem( playerid, select, TYPE_INV ) )
					return SendClientMessage( playerid, C_WHITE, !USE_ACTIVE_SLOT_NOW );
			
				OnInventoryUseItem( playerid, i, select, I_TO_U );
			}
		}
		
		case U_TO_U :
		{
			if( !UseInv[playerid][i][inv_id] ) 
			{
				UseInv[playerid][i][inv_bd] = UseInv[playerid][select][inv_bd];
				UseInv[playerid][i][inv_type] = TYPE_USE;
				UseInv[playerid][i][inv_active_type] = UseInv[playerid][select][inv_active_type];
				UseInv[playerid][i][inv_slot] = i;
				UseInv[playerid][i][inv_pos_x] = UseInv[playerid][select][inv_pos_x];
				UseInv[playerid][i][inv_pos_y] = UseInv[playerid][select][inv_pos_y];
				UseInv[playerid][i][inv_pos_z] = UseInv[playerid][select][inv_pos_z];
				UseInv[playerid][i][inv_rot_x] = UseInv[playerid][select][inv_rot_x];
				UseInv[playerid][i][inv_rot_y] = UseInv[playerid][select][inv_rot_y];
				UseInv[playerid][i][inv_rot_z] = UseInv[playerid][select][inv_rot_z];
				UseInv[playerid][i][inv_scale_x] = UseInv[playerid][select][inv_scale_x];
				UseInv[playerid][i][inv_scale_y] = UseInv[playerid][select][inv_scale_y];
				UseInv[playerid][i][inv_scale_z] = UseInv[playerid][select][inv_scale_z];
				UseInv[playerid][i][inv_bone] = UseInv[playerid][select][inv_bone];
				UseInv[playerid][i][inv_param_1] = UseInv[playerid][select][inv_param_1];
				UseInv[playerid][i][inv_param_2] = UseInv[playerid][select][inv_param_2];
				
				UseInv[playerid][i][inv_id] = UseInv[playerid][select][inv_id];
				UseInv[playerid][i][inv_amount] = UseInv[playerid][select][inv_amount];
				
				saveInventory( playerid, i, INV_UPDATE, U_TO_U );
				clearSlot( playerid, select, TYPE_USE );
				
				updateImages( playerid, select, TYPE_USE );
				updateImages( playerid, i, TYPE_USE );
				
				invSelect[playerid] = INVALID_PTD;
				updateSelect( playerid, playertextid, 0 );
				
				SetPVarInt( playerid, "UseInv:Select", INVALID_PARAM );
				
				if( UseInv[playerid][i][inv_active_type] == STATE_ATTACH )
				{
					RemovePlayerAttachedObject( playerid, select );
					useItem( playerid, i, STATE_ATTACH );
				}
			}	
		}
		
		case B_TO_B :
		{
			new 
				bag_id = getUseBagId( playerid );
					
			if( !BagInv[bag_id][i][inv_id] 
				|| BagInv[bag_id][i][inv_id] == BagInv[bag_id][select][inv_id]
				&& isAllowStack( bag_id, i, TYPE_BAG )
			  ) 
			{
				BagInv[bag_id][i][inv_type] = TYPE_BAG;
				BagInv[bag_id][i][inv_active_type] = STATE_DEFAULT;
				BagInv[bag_id][i][inv_slot] = i;
				BagInv[bag_id][i][inv_pos_x] = BagInv[bag_id][select][inv_pos_x];
				BagInv[bag_id][i][inv_pos_y] = BagInv[bag_id][select][inv_pos_y];
				BagInv[bag_id][i][inv_pos_z] = BagInv[bag_id][select][inv_pos_z];
				BagInv[bag_id][i][inv_rot_x] = BagInv[bag_id][select][inv_rot_x];
				BagInv[bag_id][i][inv_rot_y] = BagInv[bag_id][select][inv_rot_y];
				BagInv[bag_id][i][inv_rot_z] = BagInv[bag_id][select][inv_rot_z];
				BagInv[bag_id][i][inv_scale_x] = BagInv[bag_id][select][inv_scale_x];
				BagInv[bag_id][i][inv_scale_y] = BagInv[bag_id][select][inv_scale_y];
				BagInv[bag_id][i][inv_scale_z] = BagInv[bag_id][select][inv_scale_z];
				BagInv[bag_id][i][inv_bone] = BagInv[bag_id][select][inv_bone];
				BagInv[bag_id][i][inv_param_1] = BagInv[bag_id][select][inv_param_1];
				BagInv[bag_id][i][inv_param_2] = BagInv[bag_id][select][inv_param_2];
				
				BagInv[bag_id][i][inv_id] = BagInv[bag_id][select][inv_id];
				
				BagInv[bag_id][i][inv_amount]++;
				BagInv[bag_id][select][inv_amount]--;
				
				if( BagInv[bag_id][select][inv_amount] < 1 ) 
				{
					if( BagInv[bag_id][i][inv_amount] > 1 )
					{
						saveInventory( playerid, select, INV_DELETE, TYPE_BAG );
					}
					else
					{
						BagInv[bag_id][i][inv_bd] = BagInv[bag_id][select][inv_bd];
					}
				
					saveInventory( playerid, i, INV_UPDATE, B_TO_B );
					clearSlot( bag_id, select, TYPE_BAG );
				}
				else
				{
					saveInventory( playerid, select, INV_UPDATE, UPD_B );
					updateSelect( playerid, bagSlot[playerid][select], 0 );
					
					if( BagInv[bag_id][i][inv_amount] > 1 )
					{
						saveInventory( playerid, i, INV_UPDATE, UPD_B );
					}
					else
					{
						saveInventory( playerid, i, INV_INSERT, TYPE_BAG );
					}					
				}
				
				updateImages( playerid, select, TYPE_BAG );
				updateImages( playerid, i, TYPE_BAG );
				
				updateAmount( playerid, select, TYPE_BAG );
				updateAmount( playerid, i, TYPE_BAG );
				
				updateSelect( playerid, playertextid, 0 );
				
				updateSelect( playerid, invSelect[playerid], 0 );
				invSelect[playerid] = INVALID_PTD;
				
				SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );
			}
		}
		
		case B_TO_I : //Из слота сумки в инветарь
		{
			new 
				bag_id = getUseBagId( playerid );
				
			if(	checkMass( playerid ) + checkInvMass( BagInv[bag_id][select][inv_id] ) > checkMaxMass( playerid ) )
			{
				return SendClient:( playerid, C_WHITE, !MAX_MASS );
			}
				
			if( !PlayerInv[playerid][i][inv_id] 
				|| PlayerInv[playerid][i][inv_id] == BagInv[bag_id][select][inv_id]
				&& isAllowStack( playerid, i, TYPE_INV )
			  ) 
			{
				PlayerInv[playerid][i][inv_type] = TYPE_INV;
				PlayerInv[playerid][i][inv_active_type] = 0;
				PlayerInv[playerid][i][inv_slot] = i;
				PlayerInv[playerid][i][inv_pos_x] = BagInv[bag_id][select][inv_pos_x];
				PlayerInv[playerid][i][inv_pos_y] = BagInv[bag_id][select][inv_pos_y];
				PlayerInv[playerid][i][inv_pos_z] = BagInv[bag_id][select][inv_pos_z];
				PlayerInv[playerid][i][inv_rot_x] = BagInv[bag_id][select][inv_rot_x];
				PlayerInv[playerid][i][inv_rot_y] = BagInv[bag_id][select][inv_rot_y];
				PlayerInv[playerid][i][inv_rot_z] = BagInv[bag_id][select][inv_rot_z];
				PlayerInv[playerid][i][inv_scale_x] = BagInv[bag_id][select][inv_scale_x];
				PlayerInv[playerid][i][inv_scale_y] = BagInv[bag_id][select][inv_scale_y];
				PlayerInv[playerid][i][inv_scale_z] = BagInv[bag_id][select][inv_scale_z];
				PlayerInv[playerid][i][inv_bone] = BagInv[bag_id][select][inv_bone];
				PlayerInv[playerid][i][inv_param_1] = BagInv[bag_id][select][inv_param_1];
				PlayerInv[playerid][i][inv_param_2] = BagInv[bag_id][select][inv_param_2];

				PlayerInv[playerid][i][inv_id] = BagInv[bag_id][select][inv_id];
				
				BagInv[bag_id][select][inv_amount]--;
				PlayerInv[playerid][i][inv_amount]++;
				
				if( BagInv[bag_id][select][inv_amount] < 1 ) 
				{
					if( PlayerInv[playerid][i][inv_amount] > 1 )
					{
						saveInventory( playerid, select, INV_DELETE, TYPE_BAG );
						saveInventory( playerid, i, INV_UPDATE, UPD_I );
					}
					else
					{
						PlayerInv[playerid][i][inv_bd] = BagInv[bag_id][select][inv_bd];
						saveInventory( playerid, i, INV_UPDATE, B_TO_I );
					}
				
					clearSlot( bag_id, select, TYPE_BAG );
				}
				else
				{
					saveInventory( playerid, select, INV_UPDATE, UPD_B );
					updateSelect( playerid, bagSlot[playerid][select], 0 );
					
					if( PlayerInv[playerid][i][inv_amount] > 1 )
					{
						saveInventory( playerid, i, INV_UPDATE, UPD_I );
					}
					else
					{
						saveInventory( playerid, i, INV_INSERT, TYPE_INV );
					}
				}
				
				updateImages( playerid, select, TYPE_BAG );
				updateImages( playerid, i, TYPE_INV );
				
				updateAmount( playerid, select, TYPE_BAG );
				updateAmount( playerid, i, TYPE_INV );
				
				updateMass( playerid );
				updateSelect( playerid, playertextid, 0 );
				
				updateSelect( playerid, invSelect[playerid], 0 );
				invSelect[playerid] = INVALID_PTD;
				
				SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );
			}
		}
		
		case B_TO_U :
		{		
			if( !UseInv[playerid][i][inv_id] ) 
			{
				if( isUseItem( playerid, select, TYPE_BAG ) )
					return SendClientMessage( playerid, C_WHITE, !USE_ACTIVE_SLOT_NOW );
							
				OnInventoryUseItem( playerid, i, select, B_TO_U );
			}
		}
		
		case U_TO_B :
		{
			new 
				bag_id = getUseBagId( playerid ),
				type_item = getItemType( playerid, select, TYPE_USE );
			
			if( UseInv[playerid][select][inv_id] == bag_id || UseInv[playerid][select][inv_param_2] == INDEX_FRACTION || type_item == INV_BAG )
			{
				return SendClient:( playerid, C_WHITE, !NOT_MOVE_ACT_ITEM );
			}
			
			if(	checkBagMass( playerid ) + checkInvMass( UseInv[playerid][select][inv_id] ) > checkBagMaxMass( playerid ) )
			{
				return SendClient:( playerid, C_WHITE, !MAX_BAG_MASS );
			}
			
			if( !BagInv[bag_id][i][inv_id] 
				|| BagInv[bag_id][i][inv_id] == UseInv[playerid][select][inv_id] 
				&& isAllowStack( bag_id, i, TYPE_BAG )
			  ) 
			{
				unUseInvItem( playerid, select );
				
				BagInv[bag_id][i][inv_type] = TYPE_BAG;
				BagInv[bag_id][i][inv_active_type] = 0;
				BagInv[bag_id][i][inv_slot] = i;
				BagInv[bag_id][i][inv_pos_x] = UseInv[playerid][select][inv_pos_x];
				BagInv[bag_id][i][inv_pos_y] = UseInv[playerid][select][inv_pos_y];
				BagInv[bag_id][i][inv_pos_z] = UseInv[playerid][select][inv_pos_z];
				BagInv[bag_id][i][inv_rot_x] = UseInv[playerid][select][inv_rot_x];
				BagInv[bag_id][i][inv_rot_y] = UseInv[playerid][select][inv_rot_y];
				BagInv[bag_id][i][inv_rot_z] = UseInv[playerid][select][inv_rot_z];
				BagInv[bag_id][i][inv_scale_x] = UseInv[playerid][select][inv_scale_x];
				BagInv[bag_id][i][inv_scale_y] = UseInv[playerid][select][inv_scale_y];
				BagInv[bag_id][i][inv_scale_z] = UseInv[playerid][select][inv_scale_z];
				BagInv[bag_id][i][inv_bone] = UseInv[playerid][select][inv_bone];
				BagInv[bag_id][i][inv_param_1] = UseInv[playerid][select][inv_param_1];
				BagInv[bag_id][i][inv_param_2] = UseInv[playerid][select][inv_param_2];
				
				BagInv[bag_id][i][inv_id] = UseInv[playerid][select][inv_id];
				BagInv[bag_id][i][inv_amount]++;
				UseInv[playerid][select][inv_amount]--;
				
				if( UseInv[playerid][select][inv_amount] < 1 ) 
				{
					if( BagInv[bag_id][i][inv_amount] > 1 )
					{
						saveInventory( playerid, select, INV_DELETE, TYPE_USE );						
						saveInventory( playerid, i, INV_UPDATE, UPD_B );
					}
					else
					{
						BagInv[bag_id][i][inv_bd] = UseInv[playerid][select][inv_bd];
						saveInventory( playerid, i, INV_UPDATE, U_TO_B );
					}

					clearSlot( playerid, select, TYPE_USE );
				}
				else 
				{
					saveInventory( playerid, select, INV_UPDATE, UPD_U );
					updateSelect( playerid, useSlot[playerid][select], 0 );
					
					if( BagInv[bag_id][i][inv_amount] > 1 )
					{
						saveInventory( playerid, i, INV_UPDATE, UPD_B );
					}
					else
					{
						saveInventory( playerid, i, INV_INSERT, TYPE_BAG );
					}
				}
				
				updateImages( playerid, select, TYPE_USE );
				updateImages( playerid, i, TYPE_BAG );
				
				updateAmount( playerid, select, TYPE_USE );
				updateAmount( playerid, i, TYPE_BAG );
				
				updateMass( playerid );
				
				updateSelect( playerid, playertextid, false );
				updateSelect( playerid, invSelect[playerid], false );
				invSelect[playerid] = INVALID_PTD;
				
				SetPVarInt( playerid, "UseInv:Select", INVALID_PARAM );
			}
		}
		
		case I_TO_B : //Из инвентаря в слот сумки
		{
			new 
				type_item = getItemType( playerid, select, TYPE_INV );
				
			if( ( type_item == INV_SPECIAL && inventory[ getInventoryId( PlayerInv[playerid][select][inv_id] ) ][i_param_1] == PARAM_CARD )
				|| type_item == INV_BAG || PlayerInv[playerid][select][inv_param_2] == INDEX_FRACTION
			  )
			{
				return SendClient:( playerid, C_WHITE, !NOT_MOVE_ACT_ITEM );
			}
			
			if(	checkBagMass( playerid ) + checkInvMass( PlayerInv[playerid][select][inv_id] ) > checkBagMaxMass( playerid ) )
			{
				return SendClient:( playerid, C_WHITE, !MAX_BAG_MASS );
			}
			
			new 
				bag_id = getUseBagId( playerid );
			
			if( !BagInv[bag_id][i][inv_id] 
				|| BagInv[bag_id][i][inv_id] == PlayerInv[playerid][select][inv_id] 
				&& isAllowStack( bag_id, i, TYPE_BAG )
			  ) 
			{
				BagInv[bag_id][i][inv_type] = TYPE_BAG;
				BagInv[bag_id][i][inv_active_type] = 0;
				BagInv[bag_id][i][inv_slot] = i;
				BagInv[bag_id][i][inv_pos_x] = PlayerInv[playerid][select][inv_pos_x];
				BagInv[bag_id][i][inv_pos_y] = PlayerInv[playerid][select][inv_pos_y];
				BagInv[bag_id][i][inv_pos_z] = PlayerInv[playerid][select][inv_pos_z];
				BagInv[bag_id][i][inv_rot_x] = PlayerInv[playerid][select][inv_rot_x];
				BagInv[bag_id][i][inv_rot_y] = PlayerInv[playerid][select][inv_rot_y];
				BagInv[bag_id][i][inv_rot_z] = PlayerInv[playerid][select][inv_rot_z];
				BagInv[bag_id][i][inv_scale_x] = PlayerInv[playerid][select][inv_scale_x];
				BagInv[bag_id][i][inv_scale_y] = PlayerInv[playerid][select][inv_scale_y];
				BagInv[bag_id][i][inv_scale_z] = PlayerInv[playerid][select][inv_scale_z];
				BagInv[bag_id][i][inv_bone] = PlayerInv[playerid][select][inv_bone];
				BagInv[bag_id][i][inv_param_1] = PlayerInv[playerid][select][inv_param_1];
				BagInv[bag_id][i][inv_param_2] = PlayerInv[playerid][select][inv_param_2];
				BagInv[bag_id][i][inv_id] = PlayerInv[playerid][select][inv_id];
				
				BagInv[bag_id][i][inv_amount]++;
				PlayerInv[playerid][select][inv_amount]--;
				
				if( PlayerInv[playerid][select][inv_amount] < 1 ) 
				{
					if( BagInv[bag_id][i][inv_amount] > 1 )
					{
						saveInventory( playerid, select, INV_DELETE, TYPE_INV );
						saveInventory( playerid, i, INV_UPDATE, UPD_B );
					}
					else
					{
						BagInv[bag_id][i][inv_bd] = PlayerInv[playerid][select][inv_bd];
						saveInventory( playerid, i, INV_UPDATE, I_TO_B );
					}
					
					clearSlot( playerid, select, TYPE_INV );
				}
				else
				{
					saveInventory( playerid, select, INV_UPDATE, UPD_I );
					updateSelect( playerid, invSlot[playerid][select], 0 );
					
					if( BagInv[bag_id][i][inv_amount] > 1 )
					{
						saveInventory( playerid, i, INV_UPDATE, UPD_B );
					}
					else
					{
						saveInventory( playerid, i, INV_INSERT, TYPE_BAG );
					}
				}
				
				updateImages( playerid, select, TYPE_INV );
				updateImages( playerid, i, TYPE_BAG );
				
				updateAmount( playerid, select, TYPE_INV );
				updateAmount( playerid, i, TYPE_BAG );
				
				updateMass( playerid );
				
				updateSelect( playerid, playertextid, 0 );
				updateSelect( playerid, invSelect[playerid], 0 );
				invSelect[playerid] = INVALID_PTD;
				
				SetPVarInt( playerid, "Inv:Select", INVALID_PARAM );
			}		
		}
		
		case I_TO_C : // Из инвентаря в машину 
		{
			new 
				type_item = getItemType( playerid, select, TYPE_INV );
				
			if( type_item == INV_SPECIAL && inventory[ getInventoryId( PlayerInv[playerid][select][inv_id] ) ][i_param_1] == PARAM_CARD )
			{
				return SendClient:( playerid, C_WHITE, !NOT_MOVE_ACT_ITEM );
			}
			
			new 
				car_id = GetPVarInt( playerid, "Inv:CarId" );
				
			if( !Vehicle[car_id][vehicle_id] )
			{
				return SendClient:( playerid, C_WHITE, !INCORRECT_USE_CAR );
			}
				
			if( Vehicle[car_id][vehicle_member] != Player[playerid][uMember] && PlayerInv[playerid][select][inv_param_2] == INDEX_FRACTION )
			{
				return SendClient:( playerid, C_WHITE, !INCORRECT_FRACTION_ITEM	);
			}
			
			if( !CarInv[car_id][i][inv_id] 
				|| CarInv[car_id][i][inv_id] == PlayerInv[playerid][select][inv_id] 
				&& isAllowStack( car_id, i, TYPE_WARECAR )
			  ) 
			{
				CarInv[car_id][i][inv_type] = TYPE_WARECAR;
				CarInv[car_id][i][inv_active_type] = 0;
				CarInv[car_id][i][inv_slot] = i;
				
				CarInv[car_id][i][inv_pos_x] = 
				CarInv[car_id][i][inv_pos_y] = 
				CarInv[car_id][i][inv_pos_z] = 
				CarInv[car_id][i][inv_rot_x] = 
				CarInv[car_id][i][inv_rot_y] = 
				CarInv[car_id][i][inv_rot_z] = 
				CarInv[car_id][i][inv_scale_x] = 
				CarInv[car_id][i][inv_scale_y] = 
				CarInv[car_id][i][inv_scale_z] = 0.0;
				
				CarInv[car_id][i][inv_bone] = INVALID_PARAM;
				
				CarInv[car_id][i][inv_param_1] = PlayerInv[playerid][select][inv_param_1];
				CarInv[car_id][i][inv_param_2] = PlayerInv[playerid][select][inv_param_2];
				
				CarInv[car_id][i][inv_id] = PlayerInv[playerid][select][inv_id];
				
				CarInv[car_id][i][inv_amount]++;
				PlayerInv[playerid][select][inv_amount]--;
				
				if( PlayerInv[playerid][select][inv_amount] < 1 ) 
				{
					if( CarInv[car_id][i][inv_amount] > 1 )
					{
						saveInventory( playerid, select, INV_DELETE, TYPE_INV );
						saveInventory( playerid, i, INV_UPDATE, UPD_C );
					}
					else
					{
						CarInv[car_id][i][inv_bd] = PlayerInv[playerid][select][inv_bd];
						saveInventory( playerid, i, INV_UPDATE, I_TO_C );
					}

					clearSlot( playerid, select, TYPE_INV );
				}
				else
				{
					saveInventory( playerid, select, INV_UPDATE, UPD_I );
					updateSelect( playerid, invSlot[playerid][select], 0 );
					
					if( CarInv[car_id][i][inv_amount] > 1 )
					{
						saveInventory( playerid, i, INV_UPDATE, UPD_C );
					}
					else
					{
						saveInventory( playerid, i, INV_INSERT, TYPE_WARECAR );
					}
				}
				
				updateImages( playerid, select, TYPE_INV );
				updateImages( playerid, i, TYPE_WARECAR );
				
				updateAmount( playerid, select, TYPE_INV );
				updateAmount( playerid, i, TYPE_WARECAR );
				
				updateMass( playerid );
				
				updateSelect( playerid, playertextid, 0 );
				
				updateSelect( playerid, invSelect[playerid], 0 );
				invSelect[playerid] = INVALID_PTD;
				
				SetPVarInt( playerid, "Inv:Select", INVALID_PARAM );
			}
		}
		
		case C_TO_I : // Из машины в инвентарь 
		{
			new 
				car_id = GetPVarInt( playerid, "Inv:CarId" );
			
			if( !Vehicle[car_id][vehicle_id] )
			{
				return SendClient:( playerid, C_WHITE, !INCORRECT_USE_CAR );
			}
			
			if( CarInv[car_id][select][inv_param_2] == INDEX_FRACTION && Vehicle[car_id][vehicle_member] != Player[playerid][uMember] )
			{
				return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете переместить этот фракционный предмет." );
			}
			
			if(	checkMass( playerid ) + checkInvMass( CarInv[car_id][select][inv_id] ) > checkMaxMass( playerid ) )
			{
				return SendClient:( playerid, C_WHITE, !MAX_MASS );
			}
			
			if( !PlayerInv[playerid][i][inv_id] 
				|| PlayerInv[playerid][i][inv_id] == CarInv[car_id][select][inv_id]
				&& isAllowStack( playerid, i, TYPE_INV )
			  ) 
			{
				PlayerInv[playerid][i][inv_type] = TYPE_INV;
				PlayerInv[playerid][i][inv_active_type] = 0;
				PlayerInv[playerid][i][inv_slot] = i;
				PlayerInv[playerid][i][inv_pos_x] = CarInv[car_id][select][inv_pos_x];
				PlayerInv[playerid][i][inv_pos_y] = CarInv[car_id][select][inv_pos_y];
				PlayerInv[playerid][i][inv_pos_z] = CarInv[car_id][select][inv_pos_z];
				PlayerInv[playerid][i][inv_rot_x] = CarInv[car_id][select][inv_rot_x];
				PlayerInv[playerid][i][inv_rot_y] = CarInv[car_id][select][inv_rot_y];
				PlayerInv[playerid][i][inv_rot_z] = CarInv[car_id][select][inv_rot_z];
				PlayerInv[playerid][i][inv_scale_x] = CarInv[car_id][select][inv_scale_x];
				PlayerInv[playerid][i][inv_scale_y] = CarInv[car_id][select][inv_scale_y];
				PlayerInv[playerid][i][inv_scale_z] = CarInv[car_id][select][inv_scale_z];
				PlayerInv[playerid][i][inv_bone] = CarInv[car_id][select][inv_bone];
				PlayerInv[playerid][i][inv_param_1] = CarInv[car_id][select][inv_param_1];
				PlayerInv[playerid][i][inv_param_2] = CarInv[car_id][select][inv_param_2];

				PlayerInv[playerid][i][inv_id] = CarInv[car_id][select][inv_id];
				
				PlayerInv[playerid][i][inv_amount]++;
				CarInv[car_id][select][inv_amount]--;
				
				if( CarInv[car_id][select][inv_amount] < 1 ) 
				{
					if( PlayerInv[playerid][i][inv_amount] > 1 )
					{
						saveInventory( playerid, select, INV_DELETE, TYPE_WARECAR );
						saveInventory( playerid, i, INV_UPDATE, UPD_I );
					}
					else
					{
						PlayerInv[playerid][i][inv_bd] = CarInv[car_id][select][inv_bd];
						saveInventory( playerid, i, INV_UPDATE, C_TO_I );
					}

					clearSlotWareHouse( car_id, select, TYPE_WARECAR );
				}
				else
				{
					saveInventory( playerid, select, INV_UPDATE, UPD_C );
					updateWareHouseSelect( playerid, car_id, warehouseSlot[playerid][select], 0, TYPE_WARECAR );
					
					if( PlayerInv[playerid][i][inv_amount] > 1 )
					{
						saveInventory( playerid, i, INV_UPDATE, UPD_I );
					}
					else
					{
						saveInventory( playerid, i, INV_INSERT, TYPE_INV );
					}
				}
				
				updateImages( playerid, select, TYPE_WARECAR );
				updateImages( playerid, i, TYPE_INV );
				
				updateAmount( playerid, select, TYPE_WARECAR );
				updateAmount( playerid, i, TYPE_INV );
				
				updateMass( playerid );
				
				updateWareHouseSelect( playerid, car_id, playertextid, 0, TYPE_WARECAR );
				
				updateWareHouseSelect( playerid, car_id, invSelect[playerid], 0, TYPE_WARECAR );
				invSelect[playerid] = INVALID_PTD;
				
				SetPVarInt( playerid, "CarInv:Select", INVALID_PARAM );
			}
		}
		
		case C_TO_C : // Из слота машины в слот машины
		{
			new 
				car_id = GetPVarInt( playerid, "Inv:CarId" );
					
			if( !Vehicle[car_id][vehicle_id] )
			{
				return SendClient:( playerid, C_WHITE, !INCORRECT_USE_CAR );
			}
					
			if( !CarInv[car_id][i][inv_id] 
				|| CarInv[car_id][i][inv_id] == CarInv[car_id][select][inv_id]
				&& isAllowStack( car_id, i, TYPE_WARECAR )
			  ) 
			{
				CarInv[car_id][i][inv_type] = TYPE_WARECAR;
				CarInv[car_id][i][inv_active_type] = STATE_DEFAULT;
				CarInv[car_id][i][inv_slot] = i;
				CarInv[car_id][i][inv_pos_x] = CarInv[car_id][select][inv_pos_x];
				CarInv[car_id][i][inv_pos_y] = CarInv[car_id][select][inv_pos_y];
				CarInv[car_id][i][inv_pos_z] = CarInv[car_id][select][inv_pos_z];
				CarInv[car_id][i][inv_rot_x] = CarInv[car_id][select][inv_rot_x];
				CarInv[car_id][i][inv_rot_y] = CarInv[car_id][select][inv_rot_y];
				CarInv[car_id][i][inv_rot_z] = CarInv[car_id][select][inv_rot_z];
				CarInv[car_id][i][inv_scale_x] = CarInv[car_id][select][inv_scale_x];
				CarInv[car_id][i][inv_scale_y] = CarInv[car_id][select][inv_scale_y];
				CarInv[car_id][i][inv_scale_z] = CarInv[car_id][select][inv_scale_z];
				CarInv[car_id][i][inv_bone] = CarInv[car_id][select][inv_bone];
				CarInv[car_id][i][inv_param_1] = CarInv[car_id][select][inv_param_1];
				CarInv[car_id][i][inv_param_2] = CarInv[car_id][select][inv_param_2];
				
				CarInv[car_id][i][inv_id] = CarInv[car_id][select][inv_id];
				
				CarInv[car_id][i][inv_amount]++;
				CarInv[car_id][select][inv_amount]--;
				
				if( CarInv[car_id][select][inv_amount] < 1 ) 
				{
					if( CarInv[car_id][i][inv_amount] > 1 )
					{
						saveInventory( playerid, select, INV_DELETE, TYPE_WARECAR );
					}
					else
					{	
						CarInv[car_id][i][inv_bd] = CarInv[car_id][select][inv_bd];
					}
				
					saveInventory( playerid, i, INV_UPDATE, C_TO_C );
					clearSlotWareHouse( car_id, select, TYPE_WARECAR );
				}
				else
				{
					saveInventory( playerid, select, INV_UPDATE, UPD_C );
					updateWareHouseSelect( playerid, car_id, warehouseSlot[playerid][select], 0, TYPE_WARECAR );
				
					if( CarInv[car_id][i][inv_amount] > 1 )
					{
						saveInventory( playerid, i, INV_UPDATE, UPD_C );
					}
					else
					{
						saveInventory( playerid, i, INV_INSERT, TYPE_WARECAR );
					}
				}
				
				updateImages( playerid, select, TYPE_WARECAR );
				updateImages( playerid, i, TYPE_WARECAR );
				
				updateAmount( playerid, select, TYPE_WARECAR );
				updateAmount( playerid, i, TYPE_WARECAR );
				
				updateWareHouseSelect( playerid, car_id, playertextid, 0, TYPE_WARECAR );
				
				updateWareHouseSelect( playerid, car_id, invSelect[playerid], 0, TYPE_WARECAR );
				invSelect[playerid] = INVALID_PTD;
				
				SetPVarInt( playerid, "CarInv:Select", INVALID_PARAM );
			}
		}
		
		case C_TO_U : //Из машины в активный слот
		{
			if( !UseInv[playerid][i][inv_id] ) 
			{
				if( isUseItem( playerid, select, TYPE_WARECAR ) )
					return SendClientMessage( playerid, C_WHITE, !USE_ACTIVE_SLOT_NOW );
							
				OnInventoryUseItem( playerid, i, select, C_TO_U );
			}
		}
		
		case U_TO_C : //Из активного слота в машину
		{
			new 
				car_id = GetPVarInt( playerid, "Inv:CarId" );
			
			if( !Vehicle[car_id][vehicle_id] )
			{
				return SendClient:( playerid, C_WHITE, !INCORRECT_USE_CAR );
			}
			
			if( UseInv[playerid][select][inv_param_2] == INDEX_FRACTION && Vehicle[car_id][vehicle_member] != Player[playerid][uMember] )
			{
				return SendClient:( playerid, C_WHITE, !INCORRECT_FRACTION_ITEM );
			}
			
			if( !CarInv[car_id][i][inv_id] 
				|| CarInv[car_id][i][inv_id] == UseInv[playerid][select][inv_id] 
				&& isAllowStack( car_id, i, TYPE_WARECAR )
			  ) 
			{
				unUseInvItem( playerid, select );
				
				CarInv[car_id][i][inv_type] = TYPE_WARECAR;
				CarInv[car_id][i][inv_active_type] = 0;
				CarInv[car_id][i][inv_slot] = i;
				
				CarInv[car_id][i][inv_pos_x] = 
				CarInv[car_id][i][inv_pos_y] = 
				CarInv[car_id][i][inv_pos_z] = 
				CarInv[car_id][i][inv_rot_x] = 
				CarInv[car_id][i][inv_rot_y] = 
				CarInv[car_id][i][inv_rot_z] = 
				CarInv[car_id][i][inv_scale_x] = 
				CarInv[car_id][i][inv_scale_y] = 
				CarInv[car_id][i][inv_scale_z] = 0.0;
				
				CarInv[car_id][i][inv_bone] = INVALID_PARAM;
				
				CarInv[car_id][i][inv_param_1] = UseInv[playerid][select][inv_param_1];
				CarInv[car_id][i][inv_param_2] = UseInv[playerid][select][inv_param_2];
				
				CarInv[car_id][i][inv_id] = UseInv[playerid][select][inv_id];
				
				CarInv[car_id][i][inv_amount]++;
				UseInv[playerid][select][inv_amount]--;
				
				if( UseInv[playerid][select][inv_amount] < 1 ) 
				{
					if( CarInv[car_id][i][inv_amount] > 1 )
					{
						saveInventory( playerid, select, INV_DELETE, TYPE_USE );						
						saveInventory( playerid, i, INV_UPDATE, UPD_C );
					}
					else
					{
						CarInv[car_id][i][inv_bd] = UseInv[playerid][select][inv_bd];
						saveInventory( playerid, i, INV_UPDATE, U_TO_C );
					}
					
					clearSlot( playerid, select, TYPE_USE );
				}
				else 
				{
					saveInventory( playerid, select, INV_UPDATE, UPD_U );
					updateSelect( playerid, useSlot[playerid][select], false );
					
					if( CarInv[car_id][i][inv_amount] > 1 )
					{
						saveInventory( playerid, i, INV_UPDATE, UPD_C );
					}
					else
					{
						saveInventory( playerid, i, INV_INSERT, TYPE_WARECAR );
					}
				}
				
				updateImages( playerid, select, TYPE_USE );
				updateImages( playerid, i, TYPE_WARECAR );
				
				updateAmount( playerid, select, TYPE_USE );
				updateAmount( playerid, i, TYPE_WARECAR );
				
				updateMass( playerid );
				
				updateSelect( playerid, playertextid, 0 );
				
				updateSelect( playerid, invSelect[playerid], false );
				invSelect[playerid] = INVALID_PTD;
				
				SetPVarInt( playerid, "UseInv:Select", INVALID_PARAM );
			}
		}
		
		case C_TO_B : // Из машины в сумку 
		{
			new 
				bag_id = getUseBagId( playerid ),
				car_id = GetPVarInt( playerid, "Inv:CarId" ),
				type_item = getItemType( playerid, select, TYPE_WARECAR );
			
			if( !Vehicle[car_id][vehicle_id] )
			{
				return SendClient:( playerid, C_WHITE, !INCORRECT_USE_CAR );
			}
			
			if( CarInv[car_id][select][inv_param_2] == INDEX_FRACTION || type_item == INV_BAG )
			{
				return SendClient:( playerid, C_WHITE, !NOT_MOVE_ACT_ITEM );
			}
			
			if(	checkBagMass( playerid ) + checkInvMass( CarInv[car_id][select][inv_id] ) > checkBagMaxMass( playerid ) )
			{
				return SendClient:( playerid, C_WHITE, !MAX_BAG_MASS );
			}
			
			if( !BagInv[bag_id][i][inv_id] 
				|| BagInv[bag_id][i][inv_id] == CarInv[car_id][select][inv_id] 
				&& isAllowStack( bag_id, i, TYPE_BAG )
			  ) 
			{
				BagInv[bag_id][i][inv_type] = TYPE_BAG;
				BagInv[bag_id][i][inv_active_type] = 0;
				BagInv[bag_id][i][inv_slot] = i;
				BagInv[bag_id][i][inv_pos_x] = CarInv[car_id][select][inv_pos_x];
				BagInv[bag_id][i][inv_pos_y] = CarInv[car_id][select][inv_pos_y];
				BagInv[bag_id][i][inv_pos_z] = CarInv[car_id][select][inv_pos_z];
				BagInv[bag_id][i][inv_rot_x] = CarInv[car_id][select][inv_rot_x];
				BagInv[bag_id][i][inv_rot_y] = CarInv[car_id][select][inv_rot_y];
				BagInv[bag_id][i][inv_rot_z] = CarInv[car_id][select][inv_rot_z];
				BagInv[bag_id][i][inv_scale_x] = CarInv[car_id][select][inv_scale_x];
				BagInv[bag_id][i][inv_scale_y] = CarInv[car_id][select][inv_scale_y];
				BagInv[bag_id][i][inv_scale_z] = CarInv[car_id][select][inv_scale_z];
				BagInv[bag_id][i][inv_bone] = CarInv[car_id][select][inv_bone];
				BagInv[bag_id][i][inv_param_1] = CarInv[car_id][select][inv_param_1];
				BagInv[bag_id][i][inv_param_2] = CarInv[car_id][select][inv_param_2];
				
				BagInv[bag_id][i][inv_id] = CarInv[car_id][select][inv_id];
				
				BagInv[bag_id][i][inv_amount]++;
				CarInv[car_id][select][inv_amount]--;
				
				if( CarInv[car_id][select][inv_amount] < 1 ) 
				{
					if( BagInv[bag_id][i][inv_amount] > 1 )
					{
						saveInventory( playerid, select, INV_DELETE, TYPE_WARECAR );
						saveInventory( playerid, i, INV_UPDATE, UPD_B );
					}
					else
					{
						BagInv[bag_id][i][inv_bd] = CarInv[car_id][select][inv_bd];
						saveInventory( playerid, i, INV_UPDATE, C_TO_B );
					}
					
					clearSlotWareHouse( car_id, select, TYPE_WARECAR );
				}
				else
				{
					saveInventory( playerid, select, INV_UPDATE, UPD_C );
					updateWareHouseSelect( playerid, car_id, warehouseSlot[playerid][select], 0, TYPE_WARECAR );
						
					if( BagInv[bag_id][i][inv_amount] > 1 )
					{
						saveInventory( playerid, i, INV_UPDATE, UPD_B );
					}
					else
					{
						saveInventory( playerid, i, INV_INSERT, TYPE_BAG );
					}
				}
				
				updateImages( playerid, select, TYPE_WARECAR );
				updateImages( playerid, i, TYPE_BAG );
				
				updateAmount( playerid, select, TYPE_WARECAR );
				updateAmount( playerid, i, TYPE_BAG );
				
				updateMass( playerid );
				
				updateWareHouseSelect( playerid, car_id, playertextid, 0, TYPE_WARECAR );
				updateWareHouseSelect( playerid, car_id, invSelect[playerid], 0, TYPE_WARECAR );
				invSelect[playerid] = INVALID_PTD;
				
				SetPVarInt( playerid, "CarInv:Select", INVALID_PARAM );
			}		
		}
		
		case B_TO_C : // Из сумки в машину 
		{
			new 
				bag_id = getUseBagId( playerid ),
				car_id = GetPVarInt( playerid, "Inv:CarId" );
				
			if( !Vehicle[car_id][vehicle_id] )
			{
				return SendClient:( playerid, C_WHITE, !INCORRECT_USE_CAR );
			}
				
			if( !CarInv[car_id][i][inv_id] 
				|| CarInv[car_id][i][inv_id] == BagInv[bag_id][select][inv_id]
				&& isAllowStack( bag_id, i, TYPE_BAG )
			  ) 
			{
				CarInv[car_id][i][inv_type] = TYPE_WARECAR;
				CarInv[car_id][i][inv_active_type] = 0;
				CarInv[car_id][i][inv_slot] = i;
				
				CarInv[car_id][i][inv_pos_x] = 
				CarInv[car_id][i][inv_pos_y] = 
				CarInv[car_id][i][inv_pos_z] = 
				CarInv[car_id][i][inv_rot_x] = 
				CarInv[car_id][i][inv_rot_y] = 
				CarInv[car_id][i][inv_rot_z] = 
				CarInv[car_id][i][inv_scale_x] = 
				CarInv[car_id][i][inv_scale_y] = 
				CarInv[car_id][i][inv_scale_z] = 0.0;
				
				CarInv[car_id][i][inv_bone] = INVALID_PARAM;
				
				CarInv[car_id][i][inv_param_1] = BagInv[bag_id][select][inv_param_1];
				CarInv[car_id][i][inv_param_2] = BagInv[bag_id][select][inv_param_2];

				CarInv[car_id][i][inv_id] = BagInv[bag_id][select][inv_id];
				
				CarInv[car_id][i][inv_amount]++;
				BagInv[bag_id][select][inv_amount]--;
				
				if( BagInv[bag_id][select][inv_amount] < 1 ) 
				{
					if( CarInv[car_id][i][inv_amount] > 1 )
					{
						saveInventory( playerid, select, INV_DELETE, TYPE_BAG );
						saveInventory( playerid, i, INV_UPDATE, UPD_C );
					}
					else
					{
						CarInv[car_id][i][inv_bd] = BagInv[bag_id][select][inv_bd];
						saveInventory( playerid, i, INV_UPDATE, B_TO_C );
					}

					clearSlot( bag_id, select, TYPE_BAG );
				}
				else
				{
					saveInventory( playerid, select, INV_UPDATE, UPD_B );
					updateSelect( playerid, bagSlot[playerid][select], 0 );
					
					if( CarInv[car_id][i][inv_amount] > 1 )
					{
						saveInventory( playerid, i, INV_UPDATE, UPD_C );
					}
					else
					{
						saveInventory( playerid, i, INV_INSERT, TYPE_WARECAR );
					}
				}
				
				updateImages( playerid, select, TYPE_BAG );
				updateImages( playerid, i, TYPE_WARECAR );
				
				updateAmount( playerid, select, TYPE_BAG );
				updateAmount( playerid, i, TYPE_WARECAR );
				
				updateMass( playerid );
				
				updateSelect( playerid, playertextid, 0 );
				
				updateSelect( playerid, invSelect[playerid], 0 );
				invSelect[playerid] = INVALID_PTD;
				
				SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );
			}
		}
		
/*		case H_TO_I:  // Из дома в инвентарь 
		{
		
		}
	
		case I_TO_H : // Из инвентаря в дом
		{
		
		}
		
		case H_TO_B : // Из слота дома в сумку 
		{
		
		}
		
		case B_TO_H : // Из сумки в слот дома 
		{
		
		}
		
		case H_TO_H : // Из дома в дом 
		{
		
		}
		*/
	}
	
	return STATUS_OK;
}

stock getSelect( playerid, _: type )
{
	switch( type )
	{
		case TYPE_INV :
		{
			if( GetPVarInt( playerid, "UseInv:Select") == INVALID_PARAM 
				&& GetPVarInt( playerid, "BagInv:Select") == INVALID_PARAM 
				&& GetPVarInt( playerid, "CarInv:Select") == INVALID_PARAM
			)
				return 1;
		}
		
		case TYPE_USE :
		{
			if( GetPVarInt( playerid, "Inv:Select") == INVALID_PARAM 
				&& GetPVarInt( playerid, "BagInv:Select") == INVALID_PARAM 
				&& GetPVarInt( playerid, "CarInv:Select") == INVALID_PARAM
			)
				return 1;
		}
		
		case TYPE_BAG :
		{
			if( GetPVarInt( playerid, "UseInv:Select") == INVALID_PARAM 
				&& GetPVarInt( playerid, "CarInv:Select") == INVALID_PARAM
				&& GetPVarInt( playerid, "Inv:Select") == INVALID_PARAM
			)
				return 1;
		}
		
		case TYPE_WARECAR :
		{
			if( GetPVarInt( playerid, "UseInv:Select") == INVALID_PARAM 
				&& GetPVarInt( playerid, "BagInv:Select") == INVALID_PARAM 
				&& GetPVarInt( playerid, "Inv:Select") == INVALID_PARAM
			 )
				return 1;
		}
	}
	
	return 0;
}
 
Inv_OnPlayerClickPlayerTextDraw( playerid, PlayerText: playertextid ) 
{
	if( GetPVarInt( playerid, "Inv:GivePlayerId" ) != INVALID_PLAYER_ID ) // Если игрок уже выбрал кого-то для передачи
	{
		new
			giveplayerid = GetPVarInt( playerid, "Inv:GivePlayerId" );
				
		if( IsLogged(giveplayerid) )
		{
			SetPVarInt( giveplayerid, "Inv:PlayerId", INVALID_PARAM );
			
			format:g_small_string( ""gbDefault"Игрок "cBLUE"%s[%d]"cWHITE" отменил передачу предмета.", Player[playerid][uName], playerid );
			showPlayerDialog( giveplayerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Закрыть", "" );
		}
				
		pformat:( ""gbDefault"Вы отменили передачу предмета игроку "cBLUE"%s[%d]"cWHITE".", Player[giveplayerid][uName], giveplayerid );
		psend:( playerid, C_WHITE );
			
		SetPVarInt( playerid, "Inv:GivePlayerId", INVALID_PLAYER_ID );
		SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
		DeletePVar( playerid, "Inv:amount");
			
		SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );
		SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );
			
		updateSelect( playerid, invSelect[playerid], 0 );
			
		return 1;
	}

	/* - Действия с инвентарём - */
	for( new i; i < MAX_INVENTORY; i++ ) 
	{
		if( playertextid == invSlot[playerid][i] ) 
		{
			if( invSelect[playerid] == playertextid && getSelect( playerid, TYPE_INV ) ) 
			{
				updateSelect( playerid, invSelect[playerid], 0 );
				invSelect[playerid] = INVALID_PTD;
				SetPVarInt( playerid, "Inv:Select", INVALID_PARAM );
			}
			
			// Перемещение из слота в другой слот.
			else if( invSelect[playerid] != INVALID_PTD && getSelect( playerid, TYPE_INV ) ) 
			{
				updateInventory( playerid, i, GetPVarInt( playerid, "Inv:Select" ), playertextid, I_TO_I );
				break;
			}
			
			// Выделение ячейки в инвентаре
			else if( invSelect[playerid] == INVALID_PTD && getSelect( playerid, TYPE_INV ) ) 
			{	
				if( PlayerInv[playerid][i][inv_id] && getSelect( playerid, TYPE_INV ) ) 
				{
					invSelect[playerid] = playertextid;
					SetPVarInt( playerid, "Inv:Select", i );
					updateSelect( playerid, invSelect[playerid], 1 );
					break;
				}
			}
			
			// Перемещение из активного слота в инвентарь
			else if( invSelect[playerid] != INVALID_PTD && getSelect( playerid, TYPE_USE ) ) 
			{	
				updateInventory( playerid, i, GetPVarInt( playerid, "UseInv:Select" ), playertextid, U_TO_I );
				break;
			}
			
			// Перемещение из сумки в инвентарь
			else if( invSelect[playerid] != INVALID_PTD && getSelect( playerid, TYPE_BAG ) )
			{	
				updateInventory( playerid, i, GetPVarInt( playerid, "BagInv:Select" ), playertextid, B_TO_I );
				break;
			}
			
			// Перемещение из машины в инвентарь
			else if( invSelect[playerid] != INVALID_PTD && getSelect( playerid, TYPE_WARECAR ) )
			{
				updateInventory( playerid, i, GetPVarInt( playerid, "CarInv:Select" ), playertextid, C_TO_I );
				break;
			}
		}
	}
	
	/* - Действия с слотами сумки - */
	
	for( new i; i < MAX_INVENTORY_BAG; i++ )
	{
		if( playertextid == bagSlot[playerid][i] )
		{
			if( invSelect[playerid] == playertextid && getSelect( playerid, TYPE_BAG ) ) 
			{
				updateSelect( playerid, invSelect[playerid], 0 );
				invSelect[playerid] = INVALID_PTD;
				SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );
			}
			
			// Перемещение из слота в другой слот.
			else if( invSelect[playerid] != INVALID_PTD && getSelect( playerid, TYPE_BAG ) ) 
			{
				updateInventory( playerid, i, GetPVarInt( playerid, "BagInv:Select" ), playertextid, B_TO_B );
				break;
			}
			
			// Выделение ячейки в инвентаре
			else if( invSelect[playerid] == INVALID_PTD && getSelect( playerid, TYPE_BAG ) ) 
			{	
				if( BagInv[getUseBagId( playerid )][i][inv_id] && getSelect( playerid, TYPE_BAG ) ) 
				{
					invSelect[playerid] = playertextid;
					SetPVarInt( playerid, "BagInv:Select", i );
					updateSelect( playerid, invSelect[playerid], 1 );
					break;
				}
			}
			
			// Перемещение из активного слота в сумку
			else if( invSelect[playerid] != INVALID_PTD && getSelect( playerid, TYPE_USE ) ) 
			{	
				updateInventory( playerid, i, GetPVarInt( playerid, "UseInv:Select" ), playertextid, U_TO_B );
				break;
			}
			
			// Перемещение из инвентаря в сумку
			else if( invSelect[playerid] != INVALID_PTD && getSelect( playerid, TYPE_INV ) )
			{	
				updateInventory( playerid, i, GetPVarInt( playerid, "Inv:Select" ), playertextid, I_TO_B );
				break;
			}
			
			// Перемещение из машины в сумку
			else if( invSelect[playerid] != INVALID_PTD && getSelect( playerid, TYPE_WARECAR ) )
			{	
				updateInventory( playerid, i, GetPVarInt( playerid, "CarInv:Select" ), playertextid, C_TO_B );
				break;
			}
		}
	}
	
	/* - Действия с активными слотами - */
	
	for( new i; i < MAX_INVENTORY_USE; i++ ) 
	{
		if( playertextid == useSlot[playerid][i] ) 
		{
		
			if( invSelect[playerid] == playertextid && getSelect( playerid, TYPE_USE ) ) 
			{
				updateSelect( playerid, invSelect[playerid], 0 );
				invSelect[playerid] = INVALID_PTD;
				SetPVarInt( playerid, "UseInv:Select", INVALID_PARAM );
			}
			
			// Перемещение из слота в другой слот.
			else if( invSelect[playerid] != INVALID_PTD && getSelect( playerid, TYPE_USE ) ) 
			{
				updateInventory( playerid, i, GetPVarInt( playerid, "UseInv:Select" ), playertextid, U_TO_U );
				break;
			}
			
			// Выделение ячейки в инвентаре
			else if( invSelect[playerid] == INVALID_PTD && getSelect( playerid, TYPE_USE ) ) 
			{	
				if( UseInv[playerid][i][inv_id] && getSelect( playerid, TYPE_USE ) ) 
				{
					invSelect[playerid] = playertextid;
					SetPVarInt( playerid, "UseInv:Select", i );
					updateSelect( playerid, invSelect[playerid], 1 );
					break;
				}
			}
			
			// Перемещение из инвентаря в активный слот
			else if( invSelect[playerid] != INVALID_PTD && getSelect( playerid, TYPE_INV ) ) 
			{	
				updateInventory( playerid, i, GetPVarInt( playerid, "Inv:Select" ), playertextid, I_TO_U );
				break;
			}
			
			// Перемещение из сумки в активный слот
			else if( invSelect[playerid] != INVALID_PTD && getSelect( playerid, TYPE_BAG ) )
			{	
				updateInventory( playerid, i, GetPVarInt( playerid, "BagInv:Select" ), playertextid, B_TO_U );
				break;
			}
			
			// Перемещение из машины в активный слот
			else if( invSelect[playerid] != INVALID_PTD && getSelect( playerid, TYPE_WARECAR ) )
			{	
				updateInventory( playerid, i, GetPVarInt( playerid, "CarInv:Select" ), playertextid, C_TO_U );
				break;
			}
			
		}
	}
	
	/* - Действия с слотами машины - */
	
	for( new i; i < MAX_INVENTORY_WAREHOUSE; i++ )
	{
		if( playertextid == warehouseSlot[playerid][i] ) 
		{
			if( invSelect[playerid] == playertextid && getSelect( playerid, TYPE_WARECAR ) ) 
			{
				updateWareHouseSelect( playerid, GetPVarInt( playerid, "Inv:CarId" ), invSelect[playerid], 0, TYPE_WARECAR );
				invSelect[playerid] = INVALID_PTD;
				SetPVarInt( playerid, "CarInv:Select", INVALID_PARAM );
			}
			
			// Перемещение из слота в другой слот.
			else if( invSelect[playerid] != INVALID_PTD && getSelect( playerid, TYPE_WARECAR ) ) 
			{
				updateInventory( playerid, i, GetPVarInt( playerid, "CarInv:Select" ), playertextid, C_TO_C );
				break;
			}
			
			// Выделение ячейки в инвентаре
			else if( invSelect[playerid] == INVALID_PTD && getSelect( playerid, TYPE_WARECAR ) ) 
			{	
				if( CarInv[GetPVarInt( playerid, "Inv:CarId" )][i][inv_id] && getSelect( playerid, TYPE_WARECAR ) ) 
				{
					invSelect[playerid] = playertextid;
					SetPVarInt( playerid, "CarInv:Select", i );
					updateWareHouseSelect( playerid, GetPVarInt( playerid, "Inv:CarId" ), invSelect[playerid], 1, TYPE_WARECAR );
					break;
				}
			}
			
			// Перемещение из активного слота в машину
			else if( invSelect[playerid] != INVALID_PTD && getSelect( playerid, TYPE_USE ) ) 
			{	
				updateInventory( playerid, i, GetPVarInt( playerid, "UseInv:Select" ), playertextid, U_TO_C );
				break;
			}
			
			// Перемещение из инвентаря в машину
			else if( invSelect[playerid] != INVALID_PTD && getSelect( playerid, TYPE_INV ) )
			{	
				updateInventory( playerid, i, GetPVarInt( playerid, "Inv:Select" ), playertextid, I_TO_C );
				break;
			}
			
			// Перемещение из сумки в машину
			else if( invSelect[playerid] != INVALID_PTD && getSelect( playerid, TYPE_BAG ) )
			{	
				updateInventory( playerid, i, GetPVarInt( playerid, "BagInv:Select" ), playertextid, B_TO_C );
				break;
			}
		}
	}
    return 1;
}

stock useItemFromButton( playerid, i, _: type )
{	
	new 
		id;
		
	if( type == TYPE_INV )
	{
		if( PlayerInv[playerid][i][inv_param_2] == INDEX_FRACTION && !Player[playerid][uMember] )
		{
			return SendClient:( playerid, C_WHITE, !""gbError"Для использования этого предмета Вы должны состоять в организации." );
		}
	
		id = getInventoryId( PlayerInv[playerid][i][inv_id] );
		switch( getItemType( playerid, i, type ) )
		{
			case INV_AMMO :
			{
				new 
					result = giveAmmoForWeapon( playerid, type, i );
					
				if( result == STATUS_DONE )
					return SendClient:( playerid, C_WHITE, !INCORRECT_AMMO );
			}
			
			case INV_FOOD :
			{
				new 
					result = givePlayerSatiety( playerid, i, _: type );
					
				if( result == STATUS_ERROR )
					return STATUS_OK;
			}
			
			case INV_SPECIAL :
			{
				switch( inventory[id][i_param_1] )
				{
					case PARAM_CUFF, PARAM_MEDIC, PARAM_BLS :
					{
						SetPVarInt( playerid, "InvSpecial:Select", i );
					
						format:g_small_string( "\
							"cWHITE"Использование предмета - "cBLUE"%s\n\n\
							"cWHITE"Для использования введите ID игрока:", inventory[id][i_name] );
					
						return showPlayerDialog( playerid, d_inv + 4, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Закрыть" );
					}
					
					case PARAM_SHIELD :
					{
						if( !Player[playerid][uMember] || !Player[playerid][uRank] )
							return SendClient:( playerid, C_WHITE, !NO_ACCESS );
							
						if( GetPVarInt( playerid, "Player:Shield" ) )
							return SendClient:( playerid, C_WHITE, !""gbDefault"Используйте "cBLUE"/shield"cWHITE", чтобы убрать полицейский щит." );
							
						//Аттачим щит в левую руку в слот 9
						SetPlayerAttachedObject( playerid, 9, 18637, 4, 0.0, 0.0, 0.0, 0.0, 180.0, 180.0 );
						
						SetPVarInt( playerid, "Player:Shield", 1 );
						setPlayerHealth( playerid, 200.0 );

						useSpecialItem( playerid, PARAM_SHIELD, i );
					}
					
					case PARAM_THORNS :
					{
						if( !Player[playerid][uMember] || !Player[playerid][uRank] )
							return SendClient:( playerid, C_WHITE, !NO_ACCESS );
							
						if( Thorn[playerid][t_status] )
							return SendClient:( playerid, C_WHITE, "Введите "cBLUE"/thorn"cWHITE", чтобы убрать ранее установленную ленту с шипами." );
							
						new 
							Float:p[4];
					
						GetPlayerPos( playerid, p[0], p[1], p[2] );
						GetPlayerFacingAngle( playerid, p[3] );
						
						Thorn[playerid][t_object] = CreateDynamicObject( 2899, p[0] + 1.0 * -floatsin( p[3], degrees ), p[1] + 1.0 * floatcos( p[3], degrees ), p[2] - 0.9, 0, 0, p[3] );
						
						format:g_small_string( "[ %d ]", playerid );
						Thorn[playerid][t_object_text] = CreateDynamic3DTextLabel( g_small_string, C_GRAY, p[0] + 1.0 * -floatsin( p[3], degrees ), p[1] + 1.0 * floatcos( p[3], degrees ), p[2] - 0.4, 3.0 );
						
						Thorn[playerid][t_status] = true;
						
						Thorn[playerid][t_pos][0] = p[0];
						Thorn[playerid][t_pos][1] = p[1];
						Thorn[playerid][t_pos][2] = p[2];
						
						ApplyAnimation( playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0, 0 );
					
						format:g_small_string( "установил%s ленту с шипами", SexTextEnd( playerid ) );
						MeAction( playerid, g_small_string, 1 );
						
						useSpecialItem( playerid, PARAM_THORNS, i );
					}
					
					case PARAM_JERRYCAN:
					{
						if( IsPlayerInAnyVehicle( playerid ) )
							return SendClient:( playerid, C_WHITE, !NO_ACCESS );
					
						SetPVarInt( playerid, "InvSpecial:Select", i );
					
						format:g_small_string( "\
							"cWHITE"Использование предмета - "cBLUE"%s\n\n\
							"cWHITE"Для использования введите ID транспорта (/dl):", inventory[id][i_name] );
					
						return showPlayerDialog( playerid, d_inv + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Закрыть" );
					}
					
					default :
						return SendClient:( playerid, C_WHITE, !INCORRECT_USE_ITEM );
				}
			}
			
			default :
				return SendClient:( playerid, C_WHITE, !INCORRECT_USE_ITEM );
		}
		
		pformat:( ""gbSuccess"Вы использовали предмет - "cBLUE"%s"cWHITE".", inventory[id][i_name] );
		psend:( playerid, C_WHITE );
		
		SetPVarInt( playerid, "Inv:Select", INVALID_PARAM );
	}
	else if( type == TYPE_BAG )
	{
		new 
			bag_id = getUseBagId( playerid );
			
		id = getInventoryId( BagInv[bag_id][i][inv_id] );
		
		switch( getItemType( playerid, i, type ) )
		{
			case INV_AMMO :
			{
				new 
					result = giveAmmoForWeapon( playerid, type, i );
					
				if( result == STATUS_DONE )
					return SendClient:( playerid, C_WHITE, !INCORRECT_AMMO );
			}
			
			case INV_FOOD :
			{
				new 
					result = givePlayerSatiety( playerid, i, _: type );
					
				if( result == STATUS_ERROR )
					return STATUS_OK;
			}
			
			case INV_SPECIAL :
				return SendClient:( playerid, C_WHITE, !""gbError"Для использования переместите этот предмет в слот инветаря." );
				
			default :
				return SendClient:( playerid, C_WHITE, !INCORRECT_USE_ITEM );
		}
		
		pformat:( ""gbSuccess"Вы использовали предмет - "cBLUE"%s"cWHITE".", inventory[id][i_name] );
		psend:( playerid, C_WHITE );
		
		SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );
	}
	
	return 0;
}

Inv_OnPlayerClickTextDraw( playerid, Text:clickedid ) 
{
	if( _:clickedid == INVALID_TEXT_DRAW ) 
	{	
		if( GetPVarInt( playerid, "Inv:Show" ) ) 
		{
			showInventory( playerid, false );
			return 1;
		}
	}
	else if( clickedid == invText[0] ) // Использовать
	{
		if( GetPVarInt( playerid, "Inv:GivePlayerId" ) != INVALID_PLAYER_ID ) // Если игрок уже выбрал кого-то для передачи
		{
			new
				giveplayerid = GetPVarInt( playerid, "Inv:GivePlayerId" );
					
			if( IsLogged(giveplayerid) )
			{
				SetPVarInt( giveplayerid, "Inv:PlayerId", INVALID_PARAM );
				
				format:g_small_string( ""gbDefault"Игрок "cBLUE"%s[%d]"cWHITE" отменил передачу предмета.", Player[playerid][uName], playerid );
				showPlayerDialog( giveplayerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Закрыть", "" );
			}
					
			pformat:( ""gbDefault"Вы отменили передачу предмета игроку "cBLUE"%s[%d]"cWHITE".", Player[giveplayerid][uName], giveplayerid );
			psend:( playerid, C_WHITE );
				
			SetPVarInt( playerid, "Inv:GivePlayerId", INVALID_PLAYER_ID );
			SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
			DeletePVar( playerid, "Inv:amount");
				
			SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );
			SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );
				
			updateSelect( playerid, invSelect[playerid], 0 );
				
			return 1;
		}
	
		if( GetPVarInt( playerid, "Inv:Select") == INVALID_PARAM && GetPVarInt( playerid, "BagInv:Select" ) != INVALID_PARAM )
		{
			useItemFromButton( playerid, GetPVarInt( playerid, "BagInv:Select"), TYPE_BAG );
		}
		else if( GetPVarInt( playerid, "Inv:Select") != INVALID_PARAM && GetPVarInt( playerid, "BagInv:Select" ) == INVALID_PARAM )
		{
			useItemFromButton( playerid, GetPVarInt( playerid, "Inv:Select"), TYPE_INV );
		}
		else if( GetPVarInt( playerid, "UseInv:Select") != INVALID_PARAM )
			return SendClientMessage( playerid, C_WHITE, !USE_ACTIVE_SLOT_ACTION );
		else if( GetPVarInt( playerid, "CarInv:Select") != INVALID_PARAM )	
			return SendClient:( playerid, C_WHITE, !INCORRECT_USE_ITEM );
		else
			return SendClientMessage( playerid, C_WHITE, NOT_CHOOSE_ITEM );
		
		return 1;
	}
	
	else if( clickedid == invText[1] ) // Выбросить
	{
		if( GetPVarInt( playerid, "Inv:GivePlayerId" ) != INVALID_PLAYER_ID ) // Если игрок уже выбрал кого-то для передачи
		{
			new
				giveplayerid = GetPVarInt( playerid, "Inv:GivePlayerId" );
					
			if( IsLogged(giveplayerid) )
			{
				SetPVarInt( giveplayerid, "Inv:PlayerId", INVALID_PARAM );
				
				format:g_small_string( ""gbDefault"Игрок "cBLUE"%s[%d]"cWHITE" отменил передачу предмета.", Player[playerid][uName], playerid );
				showPlayerDialog( giveplayerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Закрыть", "" );
			}
					
			pformat:( ""gbDefault"Вы отменили передачу предмета игроку "cBLUE"%s[%d]"cWHITE".", Player[giveplayerid][uName], giveplayerid );
			psend:( playerid, C_WHITE );
				
			SetPVarInt( playerid, "Inv:GivePlayerId", INVALID_PLAYER_ID );
			SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
			DeletePVar( playerid, "Inv:amount");
				
			SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );
			SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );
				
			updateSelect( playerid, invSelect[playerid], 0 );
				
			return 1;
		}
	
		if( IsPlayerInAnyVehicle( playerid ) )
			return SendClient:( playerid, C_WHITE, ""gbError"Вы не можете совершить данное действие, находясь в транспорте.");
		
		if( GetPVarInt( playerid, "Inv:Select") == INVALID_PARAM && GetPVarInt( playerid, "BagInv:Select" ) != INVALID_PARAM )
		{
			new 
				i = GetPVarInt( playerid, "BagInv:Select" ),
				id = getInventoryId( BagInv[getUseBagId( playerid )][i][inv_id] );
				
			if( BagInv[getUseBagId( playerid )][i][inv_param_2] == INDEX_FRACTION )
				return SendClient:( playerid, C_WHITE, !NO_ACCESS );
				
			if( getItemType( playerid, i, TYPE_INV ) == INV_SPECIAL && inventory[id][i_param_1] == PARAM_CARD )
				return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете выбросить ID-карту." );
			
			clean:<g_big_string>;
			strcat( g_big_string, ""gbDefault"Выбрасывание предмета.\n\n" );
			
			if( BagInv[getUseBagId( playerid )][i][inv_amount] > 1 )
			{
				SetPVarInt( playerid, "Inv:OldSelect", i );
				SetPVarInt( playerid, "Inv:Moreamount", true );
				format:g_small_string( "Вы действительно хотите выбросить предмет "cBLUE"%s"cWHITE"?\n\nВведите количество предмета, которое хотите выбросить:",
					inventory[id][i_name]
				);
				strcat( g_big_string, g_small_string );
				showPlayerDialog( playerid,  d_inv_settings + 3, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
	
			}
			else
			{
				SetPVarInt( playerid, "Inv:OldSelect", i );
				SetPVarInt( playerid, "Inv:Moreamount", false );
				format:g_small_string( "Вы действительно хотите выбросить предмет "cBLUE"%s"cWHITE"?",
					inventory[id][i_name]
				);
				strcat( g_big_string, g_small_string );
				showPlayerDialog( playerid,  d_inv_settings + 3, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Далее", "Закрыть" );
			}
			
			SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );
			return 1;
		}
		else if( GetPVarInt( playerid, "Inv:Select") != INVALID_PARAM && GetPVarInt( playerid, "BagInv:Select" ) == INVALID_PARAM )
		{
			new 
				i = GetPVarInt( playerid, "Inv:Select" ),
				id = getInventoryId( PlayerInv[playerid][i][inv_id] );
			
			if( PlayerInv[playerid][i][inv_param_2] == INDEX_FRACTION )
				return SendClient:( playerid, C_WHITE, !NO_ACCESS );
			
			if( getItemType( playerid, i, TYPE_INV ) == INV_SPECIAL && inventory[id][i_param_1] == PARAM_CARD )
				return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете выбросить ID-карту." );
			
			clean:<g_big_string>;
			strcat( g_big_string, ""gbDefault"Выбрасывание предмета.\n\n" );
			
			if( PlayerInv[playerid][i][inv_amount] > 1 )
			{
				SetPVarInt( playerid, "Inv:OldSelect", i );
				SetPVarInt( playerid, "Inv:Moreamount", true );
				format:g_small_string( "Вы действительно хотите выбросить предмет "cBLUE"%s"cWHITE"?\n\nВведите количество предмета, которое хотите выбросить:",
					inventory[id][i_name]
				);
				strcat( g_big_string, g_small_string );
				showPlayerDialog( playerid,  d_inv_settings + 4, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
	
			}
			else
			{
				SetPVarInt( playerid, "Inv:OldSelect", i );
				SetPVarInt( playerid, "Inv:Moreamount", false );
				format:g_small_string("Вы действительно хотите выбросить предмет "cBLUE"%s"cWHITE"?",
					inventory[id][i_name]
				);
				strcat( g_big_string, g_small_string );
				showPlayerDialog( playerid,  d_inv_settings + 4, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Далее", "Закрыть" );
			}
			
			SetPVarInt( playerid, "Inv:Select", INVALID_PARAM );
		}
		else if( GetPVarInt( playerid, "UseInv:Select") != INVALID_PARAM )
			return SendClientMessage( playerid, C_WHITE, !USE_ACTIVE_SLOT_ACTION);
		else if( GetPVarInt( playerid, "CarInv:Select") != INVALID_PARAM )	
			return SendClient:( playerid, C_WHITE, !INCORRECT_USE_ITEM );
		else
			return SendClientMessage( playerid, C_WHITE, NOT_CHOOSE_ITEM );
			
		return 1;
	}
	
	else if( clickedid == invText[2] ) // Настройки
	{
		if( GetPVarInt( playerid, "Inv:GivePlayerId" ) != INVALID_PLAYER_ID ) // Если игрок уже выбрал кого-то для передачи
		{
			new
				giveplayerid = GetPVarInt( playerid, "Inv:GivePlayerId" );
					
			if( IsLogged(giveplayerid) )
			{
				SetPVarInt( giveplayerid, "Inv:PlayerId", INVALID_PARAM );
				
				format:g_small_string( ""gbDefault"Игрок "cBLUE"%s[%d]"cWHITE" отменил передачу предмета.", Player[playerid][uName], playerid );
				showPlayerDialog( giveplayerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Закрыть", "" );
			}
					
			pformat:( ""gbDefault"Вы отменили передачу предмета игроку "cBLUE"%s[%d]"cWHITE".", Player[giveplayerid][uName], giveplayerid );
			psend:( playerid, C_WHITE );
				
			SetPVarInt( playerid, "Inv:GivePlayerId", INVALID_PLAYER_ID );
			SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
			DeletePVar( playerid, "Inv:amount");
				
			SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );
			SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );
				
			updateSelect( playerid, invSelect[playerid], 0 );
				
			return 1;
		}
	
		if( GetPVarInt( playerid, "Inv:Select" ) != INVALID_PARAM
			|| GetPVarInt( playerid, "UseInv:Select" ) != INVALID_PARAM
			|| GetPVarInt( playerid, "BagInv:Select" ) != INVALID_PARAM
			|| GetPVarInt( playerid, "CarInv:Select" ) != INVALID_PARAM
		) 
		{
			showPlayerDialog( playerid, d_inv_settings, DIALOG_STYLE_LIST, " ",
				""cBLUE"-"cWHITE" Информация\n\
				 "cBLUE"-"cWHITE" Настроить положение\n\
				 "cBLUE"-"cWHITE" Удалить предмет", 
			"Выбрать", "Закрыть" );
			
			if( getSelect( playerid, TYPE_INV ) )
			{
				SetPVarInt( playerid, "Inv:Type", TYPE_INV );
				SetPVarInt( playerid, "Inv:OldSelect", GetPVarInt( playerid, "Inv:Select") );
			}
			else if( getSelect( playerid, TYPE_BAG ) )
			{
				SetPVarInt( playerid, "Inv:Type", TYPE_BAG );
				SetPVarInt( playerid, "Inv:OldSelect", GetPVarInt( playerid, "BagInv:Select") );
			}
			else if( getSelect( playerid, TYPE_USE ) )
			{
				SetPVarInt( playerid, "Inv:Type", TYPE_USE );
				SetPVarInt( playerid, "Inv:OldSelect", GetPVarInt( playerid, "UseInv:Select") );
			}
			else if( getSelect( playerid, TYPE_WARECAR ) )
			{
				SetPVarInt( playerid, "Inv:Type", TYPE_WARECAR );
				SetPVarInt( playerid, "Inv:OldSelect", GetPVarInt( playerid, "CarInv:Select") );
			}
		} 
		else 
			return SendClientMessage( playerid, C_WHITE, NOT_CHOOSE_ITEM );
		return 1;
	}
	
	else if( clickedid == invText[3] ) // Передать
	{
		if( GetPVarInt( playerid, "Inv:GivePlayerId" ) != INVALID_PLAYER_ID ) // Если игрок уже выбрал кого-то для передачи
		{
			new
				giveplayerid = GetPVarInt( playerid, "Inv:GivePlayerId" );
					
			if( IsLogged(giveplayerid) )
			{
				SetPVarInt( giveplayerid, "Inv:PlayerId", INVALID_PARAM );
				
				format:g_small_string( ""gbDefault"Игрок "cBLUE"%s[%d]"cWHITE" отменил передачу предмета.", Player[playerid][uName], playerid );
				showPlayerDialog( giveplayerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Закрыть", "" );
			}
					
			pformat:( ""gbDefault"Вы отменили передачу предмета игроку "cBLUE"%s[%d]"cWHITE".", Player[giveplayerid][uName], giveplayerid );
			psend:( playerid, C_WHITE );
				
			SetPVarInt( playerid, "Inv:GivePlayerId", INVALID_PLAYER_ID );
			SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
			DeletePVar( playerid, "Inv:amount");
				
			SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );
			SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );
				
			updateSelect( playerid, invSelect[playerid], 0 );
				
			return 1;
		}
	
		if( GetPVarInt( playerid, "Inv:Select") == INVALID_PARAM && GetPVarInt( playerid, "BagInv:Select" ) != INVALID_PARAM )
		{
			new 
				i = GetPVarInt( playerid, "BagInv:Select" ),
				id = getInventoryId( BagInv[getUseBagId( playerid )][i][inv_id] );
			
			/*if( BagInv[getUseBagId( playerid )][i][inv_param_2] == INDEX_FRACTION )
				return SendClient:( playerid, C_WHITE, !NO_ACCESS );
			
			pformat:( "BagInv[%d][%d][inv_id] = %d", getUseBagId( playerid ), i, BagInv[getUseBagId( playerid )][i][inv_id] );
			psend:( playerid, C_WHITE );*/
			
			clean:<g_big_string>;
			strcat( g_big_string, ""cBLUE"Передача предмета\n\n" );
			
			format:g_small_string( ""cWHITE"Введите id игрока, которому Вы хотите передать предмет "cBLUE"%s"cWHITE":\n\n\
				"gbDialog"Игрок должен находиться рядом с Вами.",
				inventory[id][i_name]
			);
			strcat( g_big_string, g_small_string );
			showPlayerDialog( playerid, d_inv_settings + 5, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
			
			//SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );
			SetPVarInt( playerid, "Inv:OldSelect", i );
		}
		else if( GetPVarInt( playerid, "Inv:Select") != INVALID_PARAM && GetPVarInt( playerid, "BagInv:Select" ) == INVALID_PARAM )
		{
			new 
				i = GetPVarInt( playerid, "Inv:Select" ),
				id = getInventoryId( PlayerInv[playerid][i][inv_id] );
			
			/*if( PlayerInv[playerid][i][inv_param_2] == INDEX_FRACTION )
				return SendClient:( playerid, C_WHITE, !NO_ACCESS );*/
			
			clean:<g_big_string>;
			strcat( g_big_string, ""cBLUE"Передача предмета\n\n" );
			format:g_small_string( ""cWHITE"Введите id игрока, которому Вы хотите передать предмет "cBLUE"%s"cWHITE":\n\n\
				"gbDialog"Игрок должен находиться рядом с Вами.",
				inventory[id][i_name]
			);
			
			strcat( g_big_string, g_small_string );
			showPlayerDialog( playerid,  d_inv_settings + 8, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
			
			//SetPVarInt( playerid, "Inv:Select", INVALID_PARAM );
			SetPVarInt( playerid, "Inv:OldSelect", i );
		}		
		else if( GetPVarInt( playerid, "UseInv:Select") != INVALID_PARAM )
			return SendClient:( playerid, C_WHITE, !USE_ACTIVE_SLOT_ACTION );
		else if( GetPVarInt( playerid, "CarInv:Select") != INVALID_PARAM )	
			return SendClient:( playerid, C_WHITE, !INCORRECT_USE_ITEM );
		else
			return SendClient:( playerid, C_WHITE, NOT_CHOOSE_ITEM );
		return 1;
	}
	
	return 0;
}

stock useItem( playerid, i, type = STATE_DEFAULT ) 
{
	new
		id = getInventoryId( UseInv[playerid][i][inv_id] );
	
	switch( type ) 
	{
		case STATE_DEFAULT : 
		{
			switch( inventory[id][i_type] ) 
			{
				case INV_SKIN : 
				{
					SetPlayerSkin( playerid, UseInv[playerid][i][inv_param_1] );
				}
				case INV_BAG : 
				{
					showBag( playerid, inventory[id][i_name], 1 );
				}
				case INV_COLD_GUN : 
				{		
					givePlayerWeapon( playerid, inventory[id][i_param_1], 1 );
				}
				
				case INV_GUN, INV_SMALL_GUN :
				{
					givePlayerWeapon( playerid, inventory[id][i_param_1], UseInv[playerid][i][inv_param_1] );
				}
				
				case INV_ARMOUR :
				{
					showPlayerDialog( playerid, d_inv + 3, DIALOG_STYLE_MSGBOX, " ", "\
						"cWHITE"Вы желаете надеть "cBLUE"Бронежилет"cWHITE" поверх одежды?",
						"Да", "Нет" );
						
					SetPVarInt( playerid, "InvArmour:Select", i );
				}
			}
		}	
		
		case STATE_ATTACH : 
		{
			/*if( inventory[id][i_type] == INV_BAG )
				showBag( playerid, inventory[id][i_name], 1 );*/
			
			iAttachTimer[playerid] = SetTimerEx( "AttachItem", 500, 0, "iiiifffffffff",
					playerid, 
					i, 
					getModelItem( TYPE_USE, playerid, i ), 
					UseInv[playerid][i][inv_bone],
					UseInv[playerid][i][inv_pos_x], 
					UseInv[playerid][i][inv_pos_y], 
					UseInv[playerid][i][inv_pos_z],
					UseInv[playerid][i][inv_rot_x], 
					UseInv[playerid][i][inv_rot_y], 
					UseInv[playerid][i][inv_rot_z],
					UseInv[playerid][i][inv_scale_x],
					UseInv[playerid][i][inv_scale_y],
					UseInv[playerid][i][inv_scale_z]
			);
		}
	}
	return 1;
}

function AttachItem( playerid, i, model, bone, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:sx, Float:sy, Float:sz ) 
{
	if( IsPlayerAttachedObjectSlotUsed( playerid, i ) )
	{
		RemovePlayerAttachedObject( playerid, i );  
	}
	
	SetPlayerAttachedObject( playerid, i, model, bone, x, y, z, rx, ry, rz, sx, sy, sz );
	
	KillTimer( iAttachTimer[playerid] );
	
	return 1;
}

function UseAttachItem( playerid, i, model, bone, type )
{
	showInventory( playerid, false );
	CancelSelectTextDraw( playerid );

	g_player_attach_mode{playerid} = type;
	
	if( type != 3 )
	{
		if( IsPlayerAttachedObjectSlotUsed( playerid, i ) )
		{
			RemovePlayerAttachedObject( playerid, i );  
		}
		
		SetPlayerAttachedObject( playerid, i, model, bone );
	}
	
	EditAttachedObject( playerid, i );
	KillTimer( iAttachTimer[playerid] );
	
	SendClient:( playerid, C_WHITE, !HELP_EDITOR );
	return 1;
}

stock EndAttachedObject( playerid )
{
	showInventory( playerid, true );
	
	SetPVarInt( playerid, "Inv:AttachBone", INVALID_PARAM );
	SetPVarInt( playerid, "Inv:AttachSlot", INVALID_PARAM );
	SetPVarInt( playerid, "Inv:AttachSelectSlot", INVALID_PARAM );
	DeletePVar( playerid, "Inv:AttachType" );
	
	SetPVarInt( playerid, "CarInv:Select", INVALID_PARAM );
	SetPVarInt( playerid, "Inv:CarId", INVALID_PARAM );
	
	g_player_attach_mode{playerid} = 0;
}

function Inv_OnPlayerEditAttachedObject( playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ )
{
		
	if( g_player_attach_mode{playerid} == 1 )
	{
		if( response )
		{
			new 
				type = GetPVarInt( playerid, "Inv:AttachType" );	
				
			if( type == TYPE_INV )
			{
				new 
					i = GetPVarInt( playerid, "Inv:AttachSlot" ),
					select = GetPVarInt( playerid, "Inv:AttachSelectSlot" );
				
				UseInv[playerid][i][inv_type] = TYPE_USE;
				UseInv[playerid][i][inv_active_type] = STATE_ATTACH;
				UseInv[playerid][i][inv_slot] = i;
				UseInv[playerid][i][inv_pos_x] = fOffsetX;
				UseInv[playerid][i][inv_pos_y] = fOffsetY;
				UseInv[playerid][i][inv_pos_z] = fOffsetZ;
				UseInv[playerid][i][inv_rot_x] = fRotX;
				UseInv[playerid][i][inv_rot_y] = fRotY;
				UseInv[playerid][i][inv_rot_z] = fRotZ;
				UseInv[playerid][i][inv_scale_x] = fScaleX;
				UseInv[playerid][i][inv_scale_y] = fScaleY;
				UseInv[playerid][i][inv_scale_z] = fScaleZ;
				
				UseInv[playerid][i][inv_bone] = boneid;
				UseInv[playerid][i][inv_param_1] = PlayerInv[playerid][select][inv_param_1];
				UseInv[playerid][i][inv_param_2] = PlayerInv[playerid][select][inv_param_2];
				
				UseInv[playerid][i][inv_id] = PlayerInv[playerid][select][inv_id];
				
				PlayerInv[playerid][select][inv_amount]--;
				
				if( PlayerInv[playerid][select][inv_amount] < 1 ) 
				{
					UseInv[playerid][i][inv_bd] = PlayerInv[playerid][select][inv_bd];
					
					saveInventory( playerid, i, INV_UPDATE, I_TO_U );
					
					clearSlot( playerid, select, TYPE_INV );
				}	
				else
				{
					saveInventory( playerid, select, INV_UPDATE, UPD_I );
					saveInventory( playerid, i, INV_INSERT, TYPE_USE );
				}
				
				UseInv[playerid][i][inv_amount] = 1;

				if( GetPVarInt( playerid, "Inv:Show" ) )
				{
					updateImages( playerid, select, TYPE_INV );
					updateAmount( playerid, select, TYPE_INV );

					updateImages( playerid, i, TYPE_USE );
					updateAmount( playerid, i, TYPE_USE );
					
					updateSelect( playerid, invSelect[playerid], 0 );
				}
				
				SendClient:( playerid, C_WHITE, ""gbSuccess"Данный предмет успешно прикреплён к Вашему персонажу." );
				
				saveInventory( playerid, i, INV_UPDATE, I_TO_U );
				saveInventory( playerid, i, INV_UPDATE, UPDATE_ATTACH );
				
				EndAttachedObject( playerid );
			}
			else if( type == TYPE_BAG )
			{
				new 
					i = GetPVarInt( playerid, "Inv:AttachSlot" ),
					select = GetPVarInt( playerid, "Inv:AttachSelectSlot" ),
					bag_id = getUseBagId( playerid );
					
				UseInv[playerid][i][inv_type] = TYPE_USE;
				UseInv[playerid][i][inv_active_type] = STATE_ATTACH;
				UseInv[playerid][i][inv_slot] = i;
				UseInv[playerid][i][inv_pos_x] = fOffsetX;
				UseInv[playerid][i][inv_pos_y] = fOffsetY;
				UseInv[playerid][i][inv_pos_z] = fOffsetZ;
				UseInv[playerid][i][inv_rot_x] = fRotX;
				UseInv[playerid][i][inv_rot_y] = fRotY;
				UseInv[playerid][i][inv_rot_z] = fRotZ;
				UseInv[playerid][i][inv_scale_x] = fScaleX;
				UseInv[playerid][i][inv_scale_y] = fScaleY;
				UseInv[playerid][i][inv_scale_z] = fScaleZ;
				
				UseInv[playerid][i][inv_bone] = boneid;
				UseInv[playerid][i][inv_param_1] = BagInv[bag_id][select][inv_param_1];
				UseInv[playerid][i][inv_param_2] = BagInv[bag_id][select][inv_param_2];
				
				UseInv[playerid][i][inv_id] = BagInv[bag_id][select][inv_id];
				
				BagInv[bag_id][select][inv_amount]--;
				
				if( BagInv[bag_id][select][inv_amount] < 1 ) 
				{
					UseInv[playerid][i][inv_bd] = BagInv[bag_id][select][inv_bd];
					saveInventory( playerid, i, INV_UPDATE, B_TO_U );
					
					clearSlot( playerid, select, TYPE_BAG );
				}	
				else
				{
					saveInventory( playerid, select, INV_UPDATE, UPD_B );
					saveInventory( playerid, i, INV_INSERT, TYPE_USE );
				}	
				
				UseInv[playerid][i][inv_amount] = 1;
				
				if( GetPVarInt( playerid, "Inv:Show" ) )
				{
					updateImages( playerid, select, TYPE_BAG );
					updateAmount( playerid, select, TYPE_BAG );

					updateImages( playerid, i, TYPE_USE );
					updateAmount( playerid, i, TYPE_USE );
					
					updateSelect( playerid, invSelect[playerid], 0 );
				}
				
				SendClient:( playerid, C_WHITE, ""gbSuccess"Данный предмет успешно прикреплён к Вашему персонажу." );
				saveInventory( playerid, i, INV_UPDATE, B_TO_U );
				saveInventory( playerid, i, INV_UPDATE, UPDATE_ATTACH );
				
				EndAttachedObject( playerid );
			}
			else if( type == TYPE_WARECAR )
			{
				new 
					i = GetPVarInt( playerid, "Inv:AttachSlot" ),
					select = GetPVarInt( playerid, "Inv:AttachSelectSlot" ),
					car_id = GetPVarInt( playerid, "Inv:CarId" );
					
				UseInv[playerid][i][inv_type] = TYPE_USE;
				UseInv[playerid][i][inv_active_type] = STATE_ATTACH;
				UseInv[playerid][i][inv_slot] = i;
				UseInv[playerid][i][inv_pos_x] = fOffsetX;
				UseInv[playerid][i][inv_pos_y] = fOffsetY;
				UseInv[playerid][i][inv_pos_z] = fOffsetZ;
				UseInv[playerid][i][inv_rot_x] = fRotX;
				UseInv[playerid][i][inv_rot_y] = fRotY;
				UseInv[playerid][i][inv_rot_z] = fRotZ;
				UseInv[playerid][i][inv_scale_x] = fScaleX;
				UseInv[playerid][i][inv_scale_y] = fScaleY;
				UseInv[playerid][i][inv_scale_z] = fScaleZ;
				
				UseInv[playerid][i][inv_bone] = boneid;
				UseInv[playerid][i][inv_param_1] = CarInv[car_id][select][inv_param_1];
				UseInv[playerid][i][inv_param_2] = CarInv[car_id][select][inv_param_2];
				
				UseInv[playerid][i][inv_id] = CarInv[car_id][select][inv_id];
				
				CarInv[car_id][select][inv_amount]--;
				
				if( CarInv[car_id][select][inv_amount] < 1 ) 
				{
					if( Vehicle[car_id][vehicle_id] )
					{
						UseInv[playerid][i][inv_bd] = CarInv[car_id][select][inv_bd];
						saveInventory( playerid, i, INV_UPDATE, C_TO_U );
					}
					else
						saveInventory( playerid, i, INV_INSERT, TYPE_USE );
					
					clearSlotWareHouse( car_id, select, TYPE_WARECAR );
				}	
				else
				{
					if( Vehicle[car_id][vehicle_id] )
						saveInventory( playerid, select, INV_UPDATE, UPD_C );
					
					saveInventory( playerid, i, INV_INSERT, TYPE_USE );
				}	
				
				UseInv[playerid][i][inv_amount] = 1;
				
				if( GetPVarInt( playerid, "Inv:Show" ) )
				{
					updateImages( playerid, select, TYPE_WARECAR );
					updateAmount( playerid, select, TYPE_WARECAR );

					updateImages( playerid, i, TYPE_USE );
					updateAmount( playerid, i, TYPE_USE );
					
					updateWareHouseSelect( playerid, car_id, invSelect[playerid], 0, TYPE_WARECAR );
				}
				
				SendClient:( playerid, C_WHITE, ""gbSuccess"Данный предмет успешно прикреплён к Вашему персонажу." );
				
				saveInventory( playerid, i, INV_UPDATE, UPDATE_ATTACH );
				
				updateMass( playerid );
				
				EndAttachedObject( playerid );
			}
		}
		else
		{
			RemovePlayerAttachedObject( playerid, GetPVarInt( playerid, "Inv:AttachSlot" ) );
			
			if( GetPVarInt( playerid, "Inv:Show" ) )
			{
				updateWareHouseSelect( playerid, GetPVarInt( playerid, "Inv:CarId" ), invSelect[playerid], 0, TYPE_WARECAR );
			}
				
			SendClient:( playerid, C_WHITE, ""gbDefault"Вы отменили режим прикрепления предмета к Вашему персонажу." );
			
			EndAttachedObject( playerid );
		}
	}
	else if( g_player_attach_mode{playerid} == 2 )
	{
		if( response )
		{
			if( GetPVarInt( playerid, "Inv:AttachType" ) == TYPE_USE )
			{
				new 
					i = GetPVarInt( playerid, "Inv:AttachSlot" );
				
				UseInv[playerid][i][inv_slot] = i;
				UseInv[playerid][i][inv_pos_x] = fOffsetX;
				UseInv[playerid][i][inv_pos_y] = fOffsetY;
				UseInv[playerid][i][inv_pos_z] = fOffsetZ;
				UseInv[playerid][i][inv_rot_x] = fRotX;
				UseInv[playerid][i][inv_rot_y] = fRotY;
				UseInv[playerid][i][inv_rot_z] = fRotZ;
				UseInv[playerid][i][inv_scale_x] = fScaleX;
				UseInv[playerid][i][inv_scale_y] = fScaleY;
				UseInv[playerid][i][inv_scale_z] = fScaleZ;
				
				UseInv[playerid][i][inv_bone] = boneid;
				
				if( GetPVarInt( playerid, "Inv:Show" ) )
				{
					updateSelect( playerid, invSelect[playerid], 0 );
				}
				
				SendClient:( playerid, C_WHITE, ""gbSuccess"Данный предмет успешно отредактирован и прикреплён к Вашему персонажу." );
				saveInventory( playerid, i, INV_UPDATE, UPD_U );
				saveInventory( playerid, i, INV_UPDATE, UPDATE_ATTACH );
				
				EndAttachedObject( playerid );
			}
		}
		else
		{
			if( GetPVarInt( playerid, "Inv:Show" ) )
			{
				updateSelect( playerid, invSelect[playerid], 0 );
			}
			
			SendClient:( playerid, C_WHITE, ""gbDefault"Вы отменили режим редактирование прикрепленного предмета к Вашему персонажу." );
			
			EndAttachedObject( playerid );
		}
	}
	else if( g_player_attach_mode{playerid} == 3 )
	{
		if( response )
		{
			if( GetPVarInt( playerid, "Inv:AttachType" ) == TYPE_USE )
			{
				new 
					i = GetPVarInt( playerid, "Inv:AttachSlot" );
				
				UseInv[playerid][i][inv_slot] = i;
				UseInv[playerid][i][inv_pos_x] = fOffsetX;
				UseInv[playerid][i][inv_pos_y] = fOffsetY;
				UseInv[playerid][i][inv_pos_z] = fOffsetZ;
				UseInv[playerid][i][inv_rot_x] = fRotX;
				UseInv[playerid][i][inv_rot_y] = fRotY;
				UseInv[playerid][i][inv_rot_z] = fRotZ;
				UseInv[playerid][i][inv_scale_x] = fScaleX;
				UseInv[playerid][i][inv_scale_y] = fScaleY;
				UseInv[playerid][i][inv_scale_z] = fScaleZ;
				
				UseInv[playerid][i][inv_bone] = boneid;
				
				if( GetPVarInt( playerid, "Inv:Show" ) )
				{
					updateSelect( playerid, invSelect[playerid], 0 );
				}
				
				SendClient:( playerid, C_WHITE, ""gbSuccess"Данный предмет успешно прикреплён к Вашему персонажу." );
				saveInventory( playerid, i, INV_UPDATE, UPD_U );
				saveInventory( playerid, i, INV_UPDATE, UPDATE_ATTACH );
				
				EndAttachedObject( playerid );
			}
		}
		else
		{
			if( GetPVarInt( playerid, "Inv:Show" ) )
			{
				updateSelect( playerid, invSelect[playerid], 0 );
			}	
			
			SendClient:( playerid, C_WHITE, ""gbDefault"Вы отменили режим прикрепления предмета к Вашему персонажу." );
	
			EndAttachedObject( playerid );
		}
	}
	else if( g_player_attach_mode{playerid} == 4 )
	{
		if( response )
		{
			new 
				i = GetPVarInt( playerid, "Inv:AttachSlot" ),
				select = GetPVarInt( playerid, "Inv:AttachSelectSlot" );
			
			UseInv[playerid][i][inv_type] = TYPE_USE;
			UseInv[playerid][i][inv_active_type] = STATE_ATTACH;
			UseInv[playerid][i][inv_slot] = i;
			UseInv[playerid][i][inv_pos_x] = fOffsetX;
			UseInv[playerid][i][inv_pos_y] = fOffsetY;
			UseInv[playerid][i][inv_pos_z] = fOffsetZ;
			UseInv[playerid][i][inv_rot_x] = fRotX;
			UseInv[playerid][i][inv_rot_y] = fRotY;
			UseInv[playerid][i][inv_rot_z] = fRotZ;
			UseInv[playerid][i][inv_scale_x] = fScaleX;
			UseInv[playerid][i][inv_scale_y] = fScaleY;
			UseInv[playerid][i][inv_scale_z] = fScaleZ;
			
			UseInv[playerid][i][inv_bone] = boneid;
			UseInv[playerid][i][inv_param_1] = PlayerInv[playerid][select][inv_param_1];
			UseInv[playerid][i][inv_param_2] = PlayerInv[playerid][select][inv_param_2];
			
			UseInv[playerid][i][inv_id] = PlayerInv[playerid][select][inv_id];
			
			PlayerInv[playerid][select][inv_amount]--;
			
			if( PlayerInv[playerid][select][inv_amount] < 1 ) 
			{
				UseInv[playerid][i][inv_bd] = PlayerInv[playerid][select][inv_bd];
				
				saveInventory( playerid, i, INV_UPDATE, I_TO_U );
				
				clearSlot( playerid, select, TYPE_INV );
			}	
			else
			{
				saveInventory( playerid, select, INV_UPDATE, UPD_I );
				saveInventory( playerid, i, INV_INSERT, TYPE_USE );
			}
			
			UseInv[playerid][i][inv_amount] = 1;

			if( GetPVarInt( playerid, "Inv:Show" ) )
			{
				updateImages( playerid, select, TYPE_INV );
				updateAmount( playerid, select, TYPE_INV );

				updateImages( playerid, i, TYPE_USE );
				updateAmount( playerid, i, TYPE_USE );
				
				updateSelect( playerid, invSelect[playerid], 0 );
			}
			
			SendClient:( playerid, C_WHITE, ""gbSuccess"Данный предмет успешно прикреплён к Вашему персонажу." );
			saveInventory( playerid, i, INV_UPDATE, I_TO_U );
			saveInventory( playerid, i, INV_UPDATE, UPDATE_ATTACH );
			
			EndAttachedObject( playerid );
		}
		else
		{
			RemovePlayerAttachedObject( playerid, GetPVarInt( playerid, "Inv:AttachSlot" ) );
			
			if( GetPVarInt( playerid, "Inv:Show" ) )
			{
				updateSelect( playerid, invSelect[playerid], 0 );
			}	
			
			SendClient:( playerid, C_WHITE, ""gbDefault"Вы отменили режим прикрепления предмета к Вашему персонажу." );
			
			EndAttachedObject( playerid );
		}
	}
	else if( g_player_attach_mode{playerid} == 5 )
	{
		if( response )
		{
			new 
				i = GetPVarInt( playerid, "Inv:AttachSlot" ),
				select = GetPVarInt( playerid, "Inv:AttachSelectSlot" ),
				car_id = GetPVarInt( playerid, "Inv:CarId" );
			
			UseInv[playerid][i][inv_type] = TYPE_USE;
			UseInv[playerid][i][inv_active_type] = STATE_ATTACH;
			UseInv[playerid][i][inv_slot] = i;
			UseInv[playerid][i][inv_pos_x] = fOffsetX;
			UseInv[playerid][i][inv_pos_y] = fOffsetY;
			UseInv[playerid][i][inv_pos_z] = fOffsetZ;
			UseInv[playerid][i][inv_rot_x] = fRotX;
			UseInv[playerid][i][inv_rot_y] = fRotY;
			UseInv[playerid][i][inv_rot_z] = fRotZ;
			UseInv[playerid][i][inv_scale_x] = fScaleX;
			UseInv[playerid][i][inv_scale_y] = fScaleY;
			UseInv[playerid][i][inv_scale_z] = fScaleZ;
			
			UseInv[playerid][i][inv_bone] = boneid;
			UseInv[playerid][i][inv_param_1] = CarInv[car_id][select][inv_param_1];
			UseInv[playerid][i][inv_param_2] = CarInv[car_id][select][inv_param_2];
			
			UseInv[playerid][i][inv_id] = CarInv[car_id][select][inv_id];
			
			CarInv[car_id][select][inv_amount]--;
			UseInv[playerid][i][inv_amount] = 1;
			
			if( CarInv[car_id][select][inv_amount] < 1 ) 
			{
				if( Vehicle[car_id][vehicle_id] )
				{
					UseInv[playerid][i][inv_bd] = CarInv[car_id][select][inv_bd];
					saveInventory( playerid, i, INV_UPDATE, C_TO_U );
				}
				else
					saveInventory( playerid, i, INV_INSERT, TYPE_USE );
				
				clearSlotWareHouse( car_id, select, TYPE_WARECAR );
			}	
			else
			{
				if( Vehicle[car_id][vehicle_id] )
					saveInventory( playerid, select, INV_UPDATE, UPD_C );
					
				saveInventory( playerid, i, INV_INSERT, TYPE_USE );
			}
			
			if( GetPVarInt( playerid, "Inv:Show" ) )
			{
				updateImages( playerid, select, TYPE_WARECAR );
				updateAmount( playerid, select, TYPE_WARECAR );
				
				updateImages( playerid, i, TYPE_USE );
				updateAmount( playerid, i, TYPE_USE );
				
				updateWareHouseSelect( playerid, car_id, invSelect[playerid], 0, TYPE_WARECAR );
			}
						
			SendClient:( playerid, C_WHITE, ""gbSuccess"Данный предмет успешно прикреплён к Вашему персонажу." );
			
			//saveInventory( playerid, i, INV_UPDATE, C_TO_U );
			saveInventory( playerid, i, INV_UPDATE, UPDATE_ATTACH );
			
			updateMass( playerid );
			
			EndAttachedObject( playerid );
		}
		else
		{
			RemovePlayerAttachedObject( playerid, GetPVarInt( playerid, "Inv:AttachSlot" ) );
			
			if( GetPVarInt( playerid, "Inv:Show" ) )
			{
				updateWareHouseSelect( playerid, GetPVarInt( playerid, "Inv:CarId" ), invSelect[playerid], 0, TYPE_WARECAR );
			}	
			
			SendClient:( playerid, C_WHITE, ""gbDefault"Вы отменили режим прикрепления предмета к Вашему персонажу." );
			
			EndAttachedObject( playerid );
		}
	}
	else if( g_player_attach_mode{playerid} == 6 )
	{
		if( response )
		{
			new 
				i = GetPVarInt( playerid, "InvArmour:Select" );
			
			UseInv[playerid][i][inv_type] = TYPE_USE;
			UseInv[playerid][i][inv_slot] = i;
			UseInv[playerid][i][inv_pos_x] = fOffsetX;
			UseInv[playerid][i][inv_pos_y] = fOffsetY;
			UseInv[playerid][i][inv_pos_z] = fOffsetZ;
			UseInv[playerid][i][inv_rot_x] = fRotX;
			UseInv[playerid][i][inv_rot_y] = fRotY;
			UseInv[playerid][i][inv_rot_z] = fRotZ;
			UseInv[playerid][i][inv_scale_x] = fScaleX;
			UseInv[playerid][i][inv_scale_y] = fScaleY;
			UseInv[playerid][i][inv_scale_z] = fScaleZ;
			
			UseInv[playerid][i][inv_bone] = boneid;
			
			SendClient:( playerid, C_WHITE, ""gbSuccess"Данный предмет успешно прикреплён к Вашему персонажу." );
			saveInventory( playerid, i, INV_UPDATE, UPDATE_ATTACH );
			
			EndAttachedObject( playerid );
		}
		else
		{
			RemovePlayerAttachedObject( playerid, GetPVarInt( playerid, "InvArmour:Select" ) );
			
			if( GetPVarInt( playerid, "Inv:Show" ) )
			{
				updateSelect( playerid, invSelect[playerid], 0 );
			}	
			
			SendClient:( playerid, C_WHITE, ""gbDefault"Вы отменили режим прикрепления предмета к Вашему персонажу." );
			
			EndAttachedObject( playerid );
		}
		
		DeletePVar( playerid, "InvArmour:Select" );
	}
	else if( g_player_attach_mode{playerid} == 7 )
	{
		if( response )
		{
			new 
				i = GetPVarInt( playerid, "InvArmour:Select" );
				
			UseInv[playerid][i][inv_slot] = i;
			UseInv[playerid][i][inv_pos_x] = fOffsetX;
			UseInv[playerid][i][inv_pos_y] = fOffsetY;
			UseInv[playerid][i][inv_pos_z] = fOffsetZ;
			UseInv[playerid][i][inv_rot_x] = fRotX;
			UseInv[playerid][i][inv_rot_y] = fRotY;
			UseInv[playerid][i][inv_rot_z] = fRotZ;
			UseInv[playerid][i][inv_scale_x] = fScaleX;
			UseInv[playerid][i][inv_scale_y] = fScaleY;
			UseInv[playerid][i][inv_scale_z] = fScaleZ;
				
			UseInv[playerid][i][inv_bone] = boneid;
				
			if( GetPVarInt( playerid, "Inv:Show" ) )
			{
				updateSelect( playerid, invSelect[playerid], 0 );
			}
				
			SendClient:( playerid, C_WHITE, ""gbSuccess"Данный предмет успешно прикреплён к Вашему персонажу." );
			saveInventory( playerid, i, INV_UPDATE, UPD_U );
			saveInventory( playerid, i, INV_UPDATE, UPDATE_ATTACH );
				
			EndAttachedObject( playerid );
		}
		else
		{
			if( GetPVarInt( playerid, "Inv:Show" ) )
			{
				updateSelect( playerid, invSelect[playerid], 0 );
			}	
			
			SendClient:( playerid, C_WHITE, ""gbDefault"Вы отменили режим прикрепления предмета к Вашему персонажу." );
	
			EndAttachedObject( playerid );
		}
		
		DeletePVar( playerid, "InvArmour:Select" );
	}
	
	return 1;
}

stock giveItem( playerid, id, amount = 1, param_1 = -1, param_2 = -1 ) 
{
	new 
		bool: gave = false;
		
	for( new i; i < MAX_INVENTORY; i++ ) 
	{
		if(	checkMass( playerid ) + ( inventory[id][i_mass] * amount ) > checkMaxMass( playerid ) )
		{	
			return STATUS_ERROR;
		}
			
		if( !PlayerInv[playerid][i][inv_id] ) 
		{
			PlayerInv[playerid][i][inv_id] = id;
			PlayerInv[playerid][i][inv_amount] = amount;
			PlayerInv[playerid][i][inv_type] = TYPE_INV;
			PlayerInv[playerid][i][inv_active_type] = STATE_DEFAULT;
			PlayerInv[playerid][i][inv_slot] = i;
			
			PlayerInv[playerid][i][inv_param_1] = param_1;
			PlayerInv[playerid][i][inv_param_2] = param_2;
			
			if( inventory[id][i_id] == 68 || inventory[id][i_id] == 69 ) //Сигареты
				PlayerInv[playerid][i][inv_param_1] = 20;
			
			saveInventory( playerid, i, INV_INSERT, TYPE_INV );
			
			if( GetPVarInt( playerid, "Inv:Show" ) )
			{
				updateImages( playerid, i, TYPE_INV );
				updateAmount( playerid, i, TYPE_INV );
				
				updateMass( playerid );
			}
			
			printf("[Log]: Item %d(%d) in slot %d added to %s[%d].", 
				PlayerInv[playerid][i][inv_id],
				PlayerInv[playerid][i][inv_amount],
				i,
				GetAccountName( playerid ), 
				playerid
			);
			
			gave = true;
			
			return STATUS_OK;
		} 
		else if( PlayerInv[playerid][i][inv_id] == id && isAllowStack( playerid, i, TYPE_INV ) ) 
		{
			if( ( PlayerInv[playerid][i][inv_amount] + amount ) > MAX_INV_STACK ) 
				continue;
				
			else if( PlayerInv[playerid][i][inv_amount] + amount < 1 ) 
			{
				clearSlot( playerid, i, TYPE_INV );
				
				return STATUS_OK;
			}
			
			PlayerInv[playerid][i][inv_amount] += amount;
			
			if( inventory[id][i_id] == 68 || inventory[id][i_id] == 69 ) //Сигареты
				PlayerInv[playerid][i][inv_param_1] += 20;
			
			saveInventory( playerid, i, INV_UPDATE, I_TO_I );
			
			if(  GetPVarInt( playerid, "Inv:Show" ) )
			{
				updateImages( playerid, i, TYPE_INV );
				updateAmount( playerid, i, TYPE_INV );
				
				updateMass( playerid );
			}
			
			printf("[Log]: Item %d(%d) in slot %d added to %s[%d].", 
				PlayerInv[playerid][i][inv_id],
				PlayerInv[playerid][i][inv_amount],
				i,
				GetAccountName( playerid ), 
				playerid
			);
			
			gave = true;
			
			return STATUS_OK;
		}
	}
	
	if( !gave )
		return STATUS_ERROR;
	
	return STATUS_DONE;
}

stock clearSlot( id, const slot, _: type )
{
	switch( type )
	{
		case TYPE_INV :
		{
			PlayerInv[id][slot][inv_bd] = 
			PlayerInv[id][slot][inv_id] =
			PlayerInv[id][slot][inv_amount] =
			PlayerInv[id][slot][inv_type] =
			PlayerInv[id][slot][inv_bone] = 
			PlayerInv[id][slot][inv_active_type] =
			PlayerInv[id][slot][inv_slot] = 0;
			
			PlayerInv[id][slot][inv_param_1] =
			PlayerInv[id][slot][inv_param_2] = -1;
			
			PlayerInv[id][slot][inv_pos_x] =
			PlayerInv[id][slot][inv_pos_y] =
			PlayerInv[id][slot][inv_pos_z] =
			PlayerInv[id][slot][inv_rot_x] =
			PlayerInv[id][slot][inv_rot_y] =
			PlayerInv[id][slot][inv_rot_z] =
			PlayerInv[id][slot][inv_scale_x] =
			PlayerInv[id][slot][inv_scale_y] = 
			PlayerInv[id][slot][inv_scale_z] = 0.0;
		}
		
		case TYPE_USE :
		{
			UseInv[id][slot][inv_bd] = 
			UseInv[id][slot][inv_id] =
			UseInv[id][slot][inv_amount] =
			UseInv[id][slot][inv_type] =
			UseInv[id][slot][inv_bone] = 
			UseInv[id][slot][inv_param_1] =
			UseInv[id][slot][inv_param_2] =
			UseInv[id][slot][inv_active_type] =
			UseInv[id][slot][inv_slot] = 0;
			
			UseInv[id][slot][inv_param_1] =
			UseInv[id][slot][inv_param_2] = -1;
			
			UseInv[id][slot][inv_pos_x] =
			UseInv[id][slot][inv_pos_y] =
			UseInv[id][slot][inv_pos_z] =
			UseInv[id][slot][inv_rot_x] =
			UseInv[id][slot][inv_rot_y] =
			UseInv[id][slot][inv_rot_z] = 			
			UseInv[id][slot][inv_scale_x] =
			UseInv[id][slot][inv_scale_y] = 
			UseInv[id][slot][inv_scale_z] = 0.0;
		}
				
		case TYPE_BAG :
		{
			BagInv[id][slot][inv_bd] = 
			BagInv[id][slot][inv_id] =
			BagInv[id][slot][inv_amount] =
			BagInv[id][slot][inv_type] =
			BagInv[id][slot][inv_bone] = 
			BagInv[id][slot][inv_active_type] =
			BagInv[id][slot][inv_slot] = 0;
			
			BagInv[id][slot][inv_param_1] =
			BagInv[id][slot][inv_param_2] = -1;
			
			BagInv[id][slot][inv_pos_x] =
			BagInv[id][slot][inv_pos_y] =
			BagInv[id][slot][inv_pos_z] =
			BagInv[id][slot][inv_rot_x] =
			BagInv[id][slot][inv_rot_y] =
			BagInv[id][slot][inv_rot_z] = 			
			BagInv[id][slot][inv_scale_x] =
			BagInv[id][slot][inv_scale_y] = 
			BagInv[id][slot][inv_scale_z] = 0.0;
		}
	}
	
	return 1;
}

stock clearDropItem( id )
{
	DropItem[id][item_drop_id] =
	DropItem[id][item_id] =
	DropItem[id][item_amount] =
	DropItem[id][item_object] =
	DropItem[id][item_type] = 0;
	
	DropItem[id][item_label] = Text3D: INVALID_3DTEXT_ID;
	
	DropItem[id][item_param_1] = 
	DropItem[id][item_param_2] = 
	DropItem[id][item_bd_id] = -1;
	
	DropItem[id][item_pos_x] =
	DropItem[id][item_pos_y] =
	DropItem[id][item_pos_z] = 0.0;
	
	return 1;
}

stock clearSlotWareHouse( id, const slot, _: type )
{
	switch( type )
	{
		case TYPE_WAREHOUSE :
		{
			HouseInv[id][slot][inv_bd] = 
			HouseInv[id][slot][inv_id] =
			HouseInv[id][slot][inv_amount] =
			HouseInv[id][slot][inv_type] =
			HouseInv[id][slot][inv_bone] = 
			HouseInv[id][slot][inv_param_1] =
			HouseInv[id][slot][inv_param_2] =
			HouseInv[id][slot][inv_active_type] =
			HouseInv[id][slot][inv_slot] = 0;
			
			HouseInv[id][slot][inv_pos_x] =
			HouseInv[id][slot][inv_pos_y] =
			HouseInv[id][slot][inv_pos_z] =
			HouseInv[id][slot][inv_rot_x] =
			HouseInv[id][slot][inv_rot_y] =
			HouseInv[id][slot][inv_rot_z] = 
			HouseInv[id][slot][inv_scale_x] =
			HouseInv[id][slot][inv_scale_y] =
			HouseInv[id][slot][inv_scale_z] = 0.0;
		}
				
		case TYPE_WARECAR :
		{
			CarInv[id][slot][inv_bd] = 
			CarInv[id][slot][inv_id] =
			CarInv[id][slot][inv_amount] =
			CarInv[id][slot][inv_type] =
			CarInv[id][slot][inv_bone] = 
			CarInv[id][slot][inv_param_1] =
			CarInv[id][slot][inv_param_2] =
			CarInv[id][slot][inv_active_type] =
			CarInv[id][slot][inv_slot] = 0;
			
			CarInv[id][slot][inv_pos_x] =
			CarInv[id][slot][inv_pos_y] =
			CarInv[id][slot][inv_pos_z] =
			CarInv[id][slot][inv_rot_x] =
			CarInv[id][slot][inv_rot_y] =
			CarInv[id][slot][inv_rot_z] = 
			CarInv[id][slot][inv_scale_x] =
			CarInv[id][slot][inv_scale_y] =
			CarInv[id][slot][inv_scale_z] = 0.0;
		}
	}
	return 1;
}

stock getModelDropObject( type, id, i, playerid )
{
	if( type == TYPE_INV )
	{
		switch( inventory[id][i_type] )
		{
			case INV_SKIN :
			{
				new 
					rand = random( 2 );
					
				if( rand )
					return 2386;
				else
					return 2384;
			}
			
			case INV_PHONE :
			{
				return 
					PlayerInv[playerid][i][inv_param_1];
			}
			
			case INV_ATTACH :
			{
				switch( inventory[id][i_param_1] )
				{
					case PARAM_CAP .. PARAM_GLASSES :
						return PlayerInv[playerid][i][inv_param_1];
						
					case -1 :
						return inventory[id][i_model];
				}
			}
			
			default :
				return inventory[id][i_model];
		}
	}
	else if( type == TYPE_BAG )
	{
		switch( inventory[id][i_type] )
		{
			case INV_SKIN :
			{
				new 
					rand = random( 2 );
					
				if( rand )
					return 2386;
				else
					return 2384;
			}
			
			case INV_PHONE :
			{
				return 
					BagInv[ getUseBagId( playerid ) ][i][inv_param_1];
			}
			
			case INV_ATTACH :
			{
				switch( inventory[id][i_param_1] )
				{
					case PARAM_CAP .. PARAM_GLASSES :
						return BagInv[ getUseBagId( playerid ) ][i][inv_param_1];
						
					case -1 :
						return inventory[id][i_model];
				}
			}
			
			default :
				return inventory[id][i_model];
		}
	}
	
	return 0;
}

stock dropItem( playerid, slot, amount, _: type = TYPE_INV )
{
	new
		_: id,
		model,
		
		Float: x,
		Float: y,
		Float: z,
		
		bool: limit = true;
	
	g_player_edit_mode{playerid} = 1;
	
	if( type == TYPE_INV )
	{
		id = getInventoryId( PlayerInv[playerid][slot][inv_id] );
		model = getModelDropObject( TYPE_INV, id, slot, playerid );
		
		GetPlayerPos( playerid, x, y, z );
		
		x += 0.5;
		z -= 1.0;
			
		for( new i; i != MAX_DROP_ITEMS; i++ )
		{
			if( DropItem[i][item_id] != 0 )
				continue;
				
			DropItem[i][item_object] = CreateDynamicObject( 
				model, 
				x, 
				y, 
				z, 
				0.0, 
				0.0, 
				0.0
			);
			
			SetPVarInt( playerid, "Inv:amount", amount );
			SetPVarInt( playerid, "Inv:Id", id );
			SetPVarInt( playerid, "Inv:DropItemType", TYPE_INV );
			SetPVarInt( playerid, "Inv:DropSlot", i );
			SetPVarInt( playerid, "Inv:DropSlotInv", slot );
			SetPVarInt( playerid, "Inv:DropItemId", DropItem[i][item_object] );
			
			EditDynamicObject( playerid, DropItem[i][item_object] );
			limit = false;
			
			break;
		}	
		
		if( limit )
			return SendClient:( playerid, C_WHITE, ""gbError"Лимит на предметы исчерпан, Вы не можете совершить данное действие." );
	
		SendClient:( playerid, C_WHITE, !HELP_EDITOR );
	}
	else if( type == TYPE_BAG )
	{
		id = getInventoryId( BagInv[getUseBagId( playerid )][slot][inv_id] );
		model = getModelDropObject( TYPE_BAG, id, slot, playerid );
		
		GetPlayerPos( playerid, x, y, z );
		
		x += 0.5;
		z -= 0.8;
		
		for( new i; i != MAX_DROP_ITEMS; i++ )
		{
			if( DropItem[i][item_id] != 0 )
				continue;
				
			DropItem[i][item_object] = CreateDynamicObject( 
				model, 
				x, 
				y, 
				z, 
				0.0, 
				0.0, 
				0.0
			);
			
			SetPVarInt( playerid, "Inv:amount", amount );
			SetPVarInt( playerid, "Inv:Id", id );
			SetPVarInt( playerid, "Inv:DropItemType", TYPE_BAG );
			SetPVarInt( playerid, "Inv:DropSlotUse", slot );
			SetPVarInt( playerid, "Inv:DropSlot", i );
			SetPVarInt( playerid, "Inv:DropItemId", DropItem[i][item_object] );
			
			
			EditDynamicObject( playerid, DropItem[i][item_object] );
			
			limit = false;
			
			break;
		}
		
		if( limit )
			return SendClient:( playerid, C_WHITE, ""gbError"Лимит на предметы исчерпан, Вы не можете совершить данное действие." );
	
		SendClient:( playerid, C_WHITE, !HELP_EDITOR );
	}
	
	return 1;
}

dropPositionCorrect( playerid, objectid, Float: x, Float: y, Float: z )
{
	new
		Float: distance = GetPlayerDistanceFromPoint( playerid, x, y, z );
		
	if( distance > 2.0 )
	{
		SendClient:( playerid, C_WHITE, !""gbError"Выбрасываемый предмет должен находиться не более 2 метров от Вашего персонажа." );
		DeletePVar( playerid, "Inv:DropItemType");
		DeletePVar( playerid, "Inv:DropSlotUse" );
		DeletePVar( playerid, "Inv:DropSlotInv" );
		DeletePVar( playerid, "Inv:DropSlot" );
		
		if( IsValidDynamicObject( objectid ) ) 
			DestroyDynamicObject( GetPVarInt( playerid, "Inv:DropItemId" ) );
		
		DeletePVar( playerid, "Inv:DropItemId" );
		CancelEdit( playerid );
		
		g_player_edit_mode{playerid} = 0;
		return 1;
	}
	
	return 0;
			
}

cancelDropItem( playerid, objectid )
{
	DeletePVar( playerid, "Inv:DropItemType");
	DeletePVar( playerid, "Inv:DropSlotUse" );
	DeletePVar( playerid, "Inv:DropSlotInv" );
	DeletePVar( playerid, "Inv:DropSlot" );
	
	if( IsValidDynamicObject( objectid ) ) 
		DestroyDynamicObject( GetPVarInt( playerid, "Inv:DropItemId") );
		
	DeletePVar( playerid, "Inv:DropItemId" );
	
	g_player_edit_mode{playerid} = 0;
}

Inv_OnPlayerEditDynamicObject( playerid, objectid, response, Float: x, Float: y, Float: z, Float: rx, Float: ry, Float: rz )
{
	MoveDynamicObject( objectid, x, y, z, 10.0, rx, ry, rz );
	
	if( g_player_edit_mode{playerid} == 1 )
	{
		switch( response )
		{	
			case EDIT_RESPONSE_CANCEL :
			{
				cancelDropItem( playerid, objectid );
				SendClientMessage( playerid, C_WHITE, ""gbDefault"Вы отменили выбрасывание предмета из инвентаря." );
			}
			
			case EDIT_RESPONSE_UPDATE :
			{	
				if( !IsValidDynamicObject( objectid ) ) 
					return SendClientMessage( playerid, C_WHITE, ""gbError"Повторите ещё раз данное действие." );
					
				//if( dropPositionCorrect( playerid, objectid, x, y, z ) )
					//return 1;
			}
			
			case EDIT_RESPONSE_FINAL :
			{	
				// TODO
				if( !IsValidDynamicObject( objectid ) ) 
					return SendClientMessage(playerid, C_WHITE, ""gbError"Повторите ещё раз данное действие.");
				
				if( dropPositionCorrect( playerid, objectid, x, y, z ) )
					return 1;
				
				new
					i = GetPVarInt( playerid, "Inv:DropSlot"),
					amount = GetPVarInt( playerid, "Inv:amount" ),
					id = GetPVarInt( playerid, "Inv:Id" );
				
				if( GetPVarInt( playerid, "Inv:DropItemType" ) == TYPE_INV )
				{
					new 
						slot = GetPVarInt( playerid, "Inv:DropSlotInv" );
					
					DropItem[i][item_drop_id] = i;
					DropItem[i][item_id] = PlayerInv[playerid][slot][inv_id];
					DropItem[i][item_type] = TYPE_DROP;
					DropItem[i][item_param_1] = PlayerInv[playerid][slot][inv_param_1];
					DropItem[i][item_param_2] = PlayerInv[playerid][slot][inv_param_2];
					DropItem[i][item_bd_id] = INVALID_PARAM;
					
					if( getItemType( playerid, slot, TYPE_INV ) == INV_PHONE )
					{
						UpdateUserPhone( INVALID_PARAM, DropItem[i][item_param_2] );
						ClearPhoneNumber( playerid, DropItem[i][item_param_2] );
					}
					
					if( getItemType( playerid, slot, TYPE_INV ) == INV_BAG )
					{
						for( new j; j != MAX_BAGS; j++ )
						{
							if( PlayerInv[playerid][slot][inv_bd] == g_bags[j] )
							{
								DropItem[i][item_bd_id] = j;
								
								break;
							}
						}
					}
					
					if( PlayerInv[playerid][slot][inv_amount] < amount ) 
					{	
						DropItem[i][item_amount] = 1;
						clearSlot( playerid, slot, TYPE_INV );
						saveInventory( playerid, slot, INV_DELETE, TYPE_INV );
					} 
					else 
					{
						PlayerInv[playerid][slot][inv_amount] = PlayerInv[playerid][slot][inv_amount] - amount;
						DropItem[i][item_amount] = amount;
						if( PlayerInv[playerid][slot][inv_amount] < 1 ) 
						{
							saveInventory( playerid, slot, INV_DELETE, TYPE_INV );
							clearSlot( playerid, slot, TYPE_INV );
						}
						else
						{
							saveInventory( playerid, slot, INV_UPDATE, TYPE_INV );
						}
					}
					
					updateMass( playerid );
					SetPVarInt( playerid, "Inv:Select", INVALID_PARAM );
				}
				
				else if( GetPVarInt( playerid, "Inv:DropItemType" ) == TYPE_BAG )
				{
					new 
						slot = GetPVarInt( playerid, "Inv:DropSlotUse" ),
						bag_id = getUseBagId( playerid );
						
					DropItem[i][item_drop_id] = i;
					DropItem[i][item_id] = BagInv[bag_id][slot][inv_id];
					DropItem[i][item_type] = TYPE_DROP;
					DropItem[i][item_param_1] = BagInv[bag_id][slot][inv_param_1];
					DropItem[i][item_param_2] = BagInv[bag_id][slot][inv_param_2];
					DropItem[i][item_bd_id] = INVALID_PARAM;
					
					if( BagInv[bag_id][slot][inv_amount] < amount ) 
					{
						DropItem[i][item_amount] = 1;
						
						clearSlot( bag_id, slot, TYPE_INV );
						saveInventory( playerid, slot, INV_DELETE, TYPE_INV );
					} 
					else 
					{	
						BagInv[bag_id][slot][inv_amount] = BagInv[bag_id][slot][inv_amount] - amount;
						DropItem[i][item_amount] = amount;
						if( BagInv[bag_id][slot][inv_amount] < 1 ) 
						{
							saveInventory( playerid, slot, INV_DELETE, TYPE_BAG );
							clearSlot( bag_id, slot, TYPE_BAG );
						}
						else
						{
							saveInventory( playerid, slot, INV_UPDATE, TYPE_BAG );
						}
					}
					
					SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );
					
				}
				
				DropItem[i][item_pos_x] = x;
				DropItem[i][item_pos_y] = y;
				DropItem[i][item_pos_z] = z;
				DropItem[i][item_label] = CreateDynamic3DTextLabel(
					inventory[id][i_name], 
					0xFFFFFF50, 
					DropItem[i][item_pos_x], 
					DropItem[i][item_pos_y], 
					DropItem[i][item_pos_z], 
					2.5 
				);
				
				updateSelect( playerid, invSelect[playerid], 0 );
				
				updateMass( playerid );
				
				if( amount > 1 )
				{
				
					format:g_small_string( ""gbDefault"Вы выбросили предмет - "cBLUE"%s"cWHITE" (Количество: "cBLUE"%d"cWHITE") из инвентаря.", 
						inventory[id][i_name],
						amount
					);
				}
				else
				{
					format:g_small_string( ""gbDefault"Вы выбросили предмет - "cBLUE"%s"cWHITE" из инвентаря.", 
						inventory[id][i_name]
					);	
				}
				
				SendClientMessage( playerid, C_WHITE, g_small_string );
				g_player_edit_mode{playerid} = 0;
				CancelEdit( playerid ); 
			}
		}
	}
	
	return 1;
}

Inv_OnPlayerKeyStateChange( playerid, newkeys, oldkeys )
{
	if( PRESSED(KEY_HANDBRAKE) )
	{
		if( GetPVarInt( playerid, "Inv:UseDrinkId" ) ) //Если пьет
		{	
			if( GetPVarInt( playerid, "Inv:UseDrinkCount") == 5 )
			{
				SetPVarInt( playerid, "Inv:UseDrinkId", 0 );
				SetPVarInt( playerid, "Inv:UseDrinkCount", 0 );
				
				ClearAnimations( playerid );
				
				RemovePlayerAttachedObject( playerid, 5 );
				return 1;
			}
		
			new 
				id = GetPVarInt( playerid, "Inv:UseDrinkId" );
				
			GivePVarInt( playerid, "Inv:UseDrinkCount", 1 );
			ApplyAnimation(playerid, "VENDING", "VEND_Drink2_P", 2.0,0,0,0,0,5000,1);
			
			GetPlayerHealth( playerid, Player[playerid][uHP] );
			if( Player[playerid][uHP] + inventory[id][i_param_1] >= 100.0 )
			{
				setPlayerHealth( playerid, 100.0 );
			}
			else
			{
				setPlayerHealth( playerid, Player[playerid][uHP] + inventory[id][i_param_1] );
			}
		}
		else if( GetPVarInt( playerid, "Inv:UseSmokeId") ) //Если курит
		{
			if( GetPVarInt( playerid, "Inv:UseSmokeCount") == 10 )
			{
				SetPVarInt( playerid, "Inv:UseSmokeId", 0 );
				SetPVarInt( playerid, "Inv:UseSmokeCount", 0 );
				
				ClearAnimations( playerid );
				
				RemovePlayerAttachedObject( playerid, 5 );
				return 1;
			}
				
			GivePVarInt( playerid, "Inv:UseSmokeCount", 1 );
			UseAnim(playerid, "SMOKING","M_smk_out", 4.0, 0, 0, 0, 0, 0);
		}
	}
	else if( PRESSED( KEY_F ) )
	{	
		for( new i; i != MAX_DROP_ITEMS; i++ )
		{
			if( !IsPlayerInAnyVehicle( playerid ) && IsPlayerInRangeOfPoint( playerid, 2.0, DropItem[i][item_pos_x], DropItem[i][item_pos_y], DropItem[i][item_pos_z] ) )
			{		
				new 
					id = getInventoryId( DropItem[i][item_id] );
			
				if( DropItem[i][item_id] == 0 )
					continue;
				
				#if defined DEBUG
					#error Drop item log bags
				#endif 
				
				SetPVarInt( playerid, "Inv:BagId", DropItem[i][item_bd_id] );
				
				if( !giveItem( playerid, id, DropItem[i][item_amount], DropItem[i][item_param_1], DropItem[i][item_param_2] ) )
					return SendClient:( playerid, C_WHITE, !MAX_MASS );
				
				if( IsValidDynamicObject( DropItem[i][item_object] ) )
				{
					DestroyDynamicObject( DropItem[i][item_object] );
				}
				
				if( IsValidDynamic3DTextLabel( DropItem[i][item_label] ) )
				{
					DestroyDynamic3DTextLabel( DropItem[i][item_label] );
				}	
				
				printf("[Log]: %s[%d] has been taked item on floor %d(%d).",
					GetAccountName( playerid ), 
					playerid,
					DropItem[i][item_id],
					DropItem[i][item_amount]
				);
				
				if( inventory[id][i_type] == INV_PHONE )
					UpdateUserPhone( Player[playerid][uID], DropItem[i][item_param_2] );
					
				pformat:( ""gbSuccess"Вы подобрали предмет - "cBLUE"%s"cWHITE".", inventory[id][i_name] );
				psend:( playerid, C_WHITE );
				
				clearDropItem( i );
				
				break;
			}
		}
	}
	
	return 1;
}

stock removeItem( playerid, slot, amount, type = TYPE_INV ) 
{
	new 
		select,
		id;
		
	if( type == TYPE_INV )
	{
		select = GetPVarInt( playerid, "Inv:Select" );
			
		if( PlayerInv[playerid][slot][inv_id] != 0 ) 
		{
			id = getInventoryId( PlayerInv[playerid][slot][inv_id] );
			
			if( inventory[id][i_type] == INV_SPECIAL && inventory[id][i_param_1] == PARAM_RADIO )
			{
				Player[playerid][uRadioChannel] = 
				Player[playerid][uRadioSubChannel] = 0;
				
				UpdatePlayer( playerid, "uRadioSubChannel", 0 );
				UpdatePlayer( playerid, "uRadioChannel", 0 );
				
				ShowRadioInfo( playerid, false );
			}
		
			printf("[Log]: Item %d(%d) in slot %d removed by %s[%d]. (Type: TYPE_INV)", 
					PlayerInv[playerid][slot][inv_id],
					PlayerInv[playerid][slot][inv_amount],
					slot,
					GetAccountName( playerid ), 
					playerid
			);
			
			if( PlayerInv[playerid][slot][inv_amount] < amount ) 
			{
				if( getItemType( playerid, slot, TYPE_INV ) == INV_BAG )
				{
					removeBagId( PlayerInv[playerid][slot][inv_bd] );
				}
				else
				{
					clearSlot( playerid, slot, TYPE_INV );
					saveInventory( playerid, slot, INV_DELETE, TYPE_INV );
				}
			} 
			else 
			{
				PlayerInv[playerid][slot][inv_amount] = PlayerInv[playerid][slot][inv_amount] - amount;
				
				if( PlayerInv[playerid][slot][inv_amount] < 1 ) 
				{
					saveInventory( playerid, slot, INV_DELETE, TYPE_INV );
					clearSlot( playerid, slot, TYPE_INV );
				}
				else
				{
					saveInventory( playerid, slot, INV_UPDATE, TYPE_INV );
				}
			}
			
			if( GetPVarInt( playerid, "Inv:Show" ) )
			{
				updateImages( playerid, select, TYPE_INV );
				updateImages( playerid, slot, TYPE_INV );
				
				updateSelect( playerid, invSelect[playerid], 0 );
				invSelect[playerid] = INVALID_PTD;

				updateAmount( playerid, slot );
				updateAmount( playerid, select );
				
				SetPVarInt( playerid, "Inv:Select", INVALID_PARAM );
				
				updateMass( playerid );
			}
			
			return STATUS_OK;
		}
		else
			return STATUS_ERROR;
	} 
	else if( type == TYPE_BAG )
	{
		new 
			bag_id = getUseBagId( playerid );
			
		select = GetPVarInt( playerid, "BagInv:Select" );
		
		if( BagInv[bag_id][slot][inv_id] != 0 ) 
		{
			printf("[Log]: Item %d(%d) in slot %d removed by %s[%d]. (Type: TYPE_BAG)", 
					BagInv[bag_id][slot][inv_id],
					BagInv[bag_id][slot][inv_amount],
					slot,
					GetAccountName( playerid ), 
					playerid
			);
			
			if( BagInv[bag_id][slot][inv_amount] < amount ) 
			{
				saveInventory( playerid, slot, INV_DELETE, TYPE_BAG );
				clearSlot( bag_id, slot, TYPE_BAG );
			} 
			else 
			{
				BagInv[bag_id][slot][inv_amount] = BagInv[bag_id][slot][inv_amount] - amount;
				if( BagInv[bag_id][slot][inv_amount] < 1 ) 
				{
					saveInventory( playerid, slot, INV_DELETE, TYPE_BAG );
					clearSlot( bag_id, slot, TYPE_BAG );
				}
				else
				{
					saveInventory( playerid, slot, INV_UPDATE, TYPE_BAG );
				}
			}
			
			updateImages( playerid, select, TYPE_BAG );
			updateImages( playerid, slot, TYPE_BAG );
			
			updateAmount( playerid, slot, TYPE_BAG );
			updateAmount( playerid, select, TYPE_BAG );
			
			updateSelect( playerid, invSelect[playerid], 0 );
			invSelect[playerid] = INVALID_PTD;
			
			SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );
			
			updateMass( playerid ); 
			
			return STATUS_OK;
		}
		else
			return STATUS_ERROR;
	}
	
	return STATUS_ERROR;
}