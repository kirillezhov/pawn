#define INVALID_PTD 					(PlayerText:(0xFFFF))
#define INVALID_PARAM					(-1)
#define INDEX_FRACTION					(-543)

#define INV_POS_X						(0) 
#define INV_POS_Y       				(1)
#define INV_POS_Z						(2)
#define INV_POS_ZOOM    				(3)

#define STATE_DEFAULT					(0)
#define STATE_ATTACH					(1)

#define UPDATE_ATTACH					(21)
#define UPD_I							(22)
#define UPD_U							(23)
#define UPD_B							(24)
#define UPD_C							(25)

// Действия с сохранением.
#define INV_INSERT						(0)
#define INV_UPDATE 						(1)
#define INV_DELETE						(2)

#define BUTTON_BUY						(0)
#define BUTTON_INFO						(1)

// Действия.
#define I_TO_I							(0) // Из слота в слот обычного инвентаря
#define U_TO_I							(1) // Из активного слота в обычный слот инвентаря
#define I_TO_U							(2) // Из обычного слота в активный слот инвентаря
#define U_TO_U							(3) // Из активного слота в активный слот
#define B_TO_B							(4) // Из слота сумки в слот сумки
#define B_TO_I							(5) // Из слота сумки в слот инвентаря
#define B_TO_U							(6) // Из слота сумки в активный слот
#define U_TO_B							(7) // Из активного слота в слот сумки 
#define I_TO_B							(8) // Из слота инвентаря в слот сумки
#define H_TO_I							(9) // Из дома в инвентарь
#define I_TO_H							(10) // Из инвентаря в дом
#define H_TO_B							(11) // Из слота дома в сумку
#define B_TO_H							(12) // Из сумки в слот дома 
#define H_TO_H							(13) // Из дома в дом 
#define C_TO_I							(14) // Из машины в инвентарь
#define I_TO_C							(15) // Из инвентаря в машину
#define C_TO_B							(16) // Из машины в сумку
#define B_TO_C							(17) // Из сумки в машину
#define C_TO_C							(18) // Из слота машины в слот машины
#define C_TO_U							(19) // Из машины в активный слот
#define U_TO_C							(20) // Из активного слота в машину

// Типы предметов.
#define INV_SKIN						(0)
#define INV_GUN							(1) // Крупнокалиберное оружие
#define INV_AMMO						(2)
#define INV_ATTACH						(3)
#define INV_BAG							(4)
#define INV_COLD_GUN					(5) // Холодное оружие
#define INV_FOOD						(6)
#define INV_SPECIAL						(7)
#define INV_SMALL_GUN					(8)	// Малокалиберное оружие
#define INV_PHONE						(9)	// Телефон
#define INV_ARMOUR						(10) // Бронежилет

// INV_SPECIAL
#define PARAM_CARD						(1)
#define PARAM_SHIELD					(2) //Полицейский щит
#define PARAM_RADIO						(3)
#define PARAM_MEDIC						(4) //Аптечка
#define PARAM_WHEEL						(5) //Колесо
#define PARAM_JERRYCAN					(6) //Канистра
#define PARAM_REPAIR					(7) //Ремонтный комплект
#define PARAM_CUFF						(8) //Наручники
#define PARAM_THORNS					(9) //Лента с шипами
#define PARAM_BLS						(10) //Санитарная сумка

// INV_ATTACH
#define PARAM_CAP						(0)
#define PARAM_HEADPHONES				(1)
#define PARAM_BANDANA					(2)
#define PARAM_HAT						(3)
#define PARAM_GLASSES					(4)
#define PARAM_HELMET					(5)
#define PARAM_CLOCK						(6)
#define PARAM_MASK						(7)

#define OWN_PLAYER						(1)
#define OWN_HOUSE						(2)
#define OWN_CAR							(3)

#define MAX_INV_STACK					(10)

// Тип инвентаря.
#define TYPE_INV						(0) // Обычный
#define TYPE_USE						(1) // Активные слоты
#define TYPE_BAG						(2) // Слоты сумок
#define TYPE_WARECAR 					(3) // Слоты машины
#define TYPE_WAREHOUSE 					(4) // Слоты дома
#define TYPE_DROP						(5)

/*// Подтипы TYPE_WAREHOUSE.
#define SUBTYPE_HOUSE					(0) // Дом
#define SUBTYPE_BUSINESS				(1) // ??
#define SUBTYPE_CAR						(2) // Машина
*/

// Variables
new 
	Text: invBg							[8], 
	Text: invText						[4],
	Text: buyArrow						[2],
	
	PlayerText: invSlot					[MAX_PLAYERS][MAX_INVENTORY], 
	PlayerText: invamount				[MAX_PLAYERS][MAX_INVENTORY], 
	PlayerText: invInformation			[MAX_PLAYERS], 
	PlayerText: invMass					[MAX_PLAYERS],
	PlayerText: invBagMass				[MAX_PLAYERS],
	
	PlayerText: bagName					[MAX_PLAYERS],
	PlayerText: bagSlot					[MAX_PLAYERS][MAX_INVENTORY_BAG],
	PlayerText: bagInvamount			[MAX_PLAYERS][MAX_INVENTORY_BAG],
	
	PlayerText: useSlot					[MAX_PLAYERS][MAX_INVENTORY_USE],
	
	PlayerText: warehouseSlot			[MAX_PLAYERS][MAX_INVENTORY_WAREHOUSE],
	PlayerText: warehouseInvamount		[MAX_PLAYERS][MAX_INVENTORY_WAREHOUSE],
	PlayerText: warehouseName			[MAX_PLAYERS],
	PlayerText: warehouseInformation	[MAX_PLAYERS],
	
	PlayerText: buyBox					[MAX_PLAYERS][MAX_INVENTORY_BUY],
	PlayerText: buyPrice 				[MAX_PLAYERS][MAX_INVENTORY_BUY],
	PlayerText: buyName					[MAX_PLAYERS][MAX_INVENTORY_BUY],
	PlayerText: buyButton				[2][MAX_PLAYERS][MAX_INVENTORY_BUY],
	PlayerText: buyModel				[MAX_PLAYERS][MAX_INVENTORY_BUY],
	
	PlayerText: buyPreviewModel			[MAX_PLAYERS],
	
	PlayerText: invSelect				[MAX_PLAYERS],
	
	iAttachTimer						[MAX_PLAYERS],

	g_bags								[MAX_BAGS] = { 0, ... };
	

enum e_INVENTORY_PARAM 
{
	i_id,
	i_model,
	Float: i_mass,
	i_name[64],
	i_text[256],
	Float:i_pos[4],
	i_type,
	i_param_1,
	i_param_2
}

enum e_ITEM 
{
	inv_bd,// Ид предмета в бд
	inv_id,// Ид предмета
	inv_amount,// Кол-во предметов
	inv_type,// Тип предмета
	inv_active_type, // Тип использования предмета, аттач или в руках
	inv_slot,		// Слот в инвентаре
	Float: inv_pos_x,// позиция на теле
	Float: inv_pos_y,// позиция на теле
	Float: inv_pos_z,// позиция на теле
	Float: inv_rot_x,// Угол на теле
	Float: inv_rot_y,//
	Float: inv_rot_z,//
	Float: inv_scale_x, // Размер на теле
	Float: inv_scale_y, //
	Float: inv_scale_z, //
	inv_bone,// Часть тела
	inv_param_1, // Дополнительное поле
	inv_param_2,
};

enum e_DROP_ITEM
{
	item_drop_id,
	item_id,
	item_bd_id,
	item_amount,
	item_type,
	Text3D: item_label,
	item_object,
	Float: item_pos_x,
	Float: item_pos_y,
	Float: item_pos_z,
	item_param_1,
	item_param_2
}

new 
	inventory		[ MAX_INVENTORY_ITEMS ][ e_INVENTORY_PARAM ],
	PlayerInv		[ MAX_PLAYERS ]	[ MAX_INVENTORY ]	 [ e_ITEM ],      // Данные слотов инвентаря.
	UseInv			[ MAX_PLAYERS ]	[ MAX_INVENTORY_USE ][ e_ITEM ],  // Данные активных слотов.
	BagInv			[ MAX_BAGS ]	[ MAX_INVENTORY_BAG ][ e_ITEM ],	// Данные слотов сумок
	HouseInv		[ MAX_HOUSE ]	[ MAX_INVENTORY_WAREHOUSE ][ e_ITEM ], 	// Данные слотов дома
	CarInv			[ MAX_VEHICLES ][ MAX_INVENTORY_WAREHOUSE ][ e_ITEM ],
	DropItem		[ MAX_DROP_ITEMS ][ e_DROP_ITEM ];
	

isSavedAttachObject( type, playerid, i )
{
	switch( type )
	{
		case TYPE_INV :
		{
			if( PlayerInv[playerid][i][inv_bone] != INVALID_PARAM )
				return STATUS_OK;
		}
		
		case TYPE_BAG :
		{
			if( BagInv[ getUseBagId( playerid ) ][i][inv_bone] != INVALID_PARAM )
				return STATUS_OK;
		}
		
		case TYPE_USE :
		{
			if( UseInv[playerid][i][inv_bone] != INVALID_PARAM )
				return STATUS_OK;
		}
		
		case TYPE_WARECAR, TYPE_WAREHOUSE : return STATUS_ERROR;
		
		default:
			return STATUS_DONE;
			
	}
	
	return STATUS_ERROR;
	
}
	
isnullSlot( type, playerid, i )
{
	switch( type )
	{
		case TYPE_INV :
			return ( PlayerInv[playerid][i][inv_id] == 0 ) ? STATUS_OK : STATUS_ERROR;
		
		case TYPE_BAG :
			return ( BagInv[ getUseBagId( playerid ) ][i][inv_id] == 0 ) ? STATUS_OK : STATUS_ERROR;
			
		case TYPE_USE :
			return ( UseInv[playerid][i][inv_id] == 0 ) ? STATUS_OK : STATUS_ERROR;
			
		case TYPE_WARECAR :
			return ( CarInv[ GetPVarInt( playerid, "Inv:CarId" ) ][i][inv_id] == 0 ) ? STATUS_OK : STATUS_ERROR;
	}
	
	return STATUS_ERROR;
}

isAllowStack( type_id, i, type )
{
	new
		id;
		
	switch( type )
	{
		case TYPE_INV: 
		{
			if( PlayerInv[type_id][i][inv_amount] >= MAX_INV_STACK )
				return STATUS_ERROR;
		
			id = getInventoryId( PlayerInv[type_id][i][inv_id] );
		}
		
		case TYPE_BAG: 
		{
			if( BagInv[type_id][i][inv_amount] >= MAX_INV_STACK )
				return STATUS_ERROR;
		
			id = getInventoryId( BagInv[type_id][i][inv_id] );
		}
		
		case TYPE_WARECAR: 
		{
			if( CarInv[type_id][i][inv_amount] >= MAX_INV_STACK )
				return STATUS_ERROR;
		
			id = getInventoryId( CarInv[type_id][i][inv_id] );
		}
	}
		
	switch( inventory[id][i_type] )
	{
		case INV_BAG, INV_SKIN, INV_PHONE, INV_GUN, INV_SMALL_GUN, INV_COLD_GUN, INV_ATTACH, INV_ARMOUR :
			return STATUS_ERROR;
	}
	
	
	return STATUS_DONE;
}

/*isAvaibleItem( playerid, i )
{
	new 
		id;
	
	for( new i; i < MAX_INVENTORY; i++ )
	{
		id = getInventoryId( PlayerInv[playerid][i][inv_id] );
		if( inventory[id][i_type] == INV_SPECIAL )
		{
			switch( inventory[id][i_param_1] )
			{
				case PARAM_CARD :
					return 0;
			}
		}
	}
	
	return 1;
}*/

getModelItem( type, playerid, _: i )
{
	static 
		id;
		
	if( type == TYPE_INV )
	{
		id = getInventoryId( PlayerInv[playerid][i][inv_id] );
		
		switch( inventory[id][i_type] )
		{	
			case INV_SKIN, INV_PHONE :
				return PlayerInv[playerid][i][inv_param_1];
				
			case INV_ATTACH :
			{
				switch( inventory[id][i_param_1] )
				{
					case PARAM_CAP .. PARAM_MASK :
						return PlayerInv[playerid][i][inv_param_1];
						
					case INVALID_PARAM :
						return inventory[id][i_model];
				}
			}
			
			default :
				return inventory[id][i_model];
		}
	}
	else if( type == TYPE_BAG )
	{
		new 
			bag_id = getUseBagId( playerid );
			
		id = getInventoryId( BagInv[bag_id][i][inv_id] );
		
		switch( inventory[id][i_type] )
		{
			case INV_SKIN, INV_PHONE :
				return BagInv[bag_id][i][inv_param_1];
				
			case INV_ATTACH :
			{
				switch( inventory[id][i_param_1] )
				{
					case PARAM_CAP .. PARAM_MASK :
						return BagInv[bag_id][i][inv_param_1];
					
					case INVALID_PARAM :
						return inventory[id][i_model];
				}
			}
			
			default :
				return inventory[id][i_model];
		}
	}
	else if( type == TYPE_USE )
	{
		id = getInventoryId( UseInv[playerid][i][inv_id] );
		
		switch( inventory[id][i_type] )
		{
			case INV_SKIN, INV_PHONE :
				return UseInv[playerid][i][inv_param_1];
				
			case INV_ATTACH :
			{
				switch( inventory[id][i_param_1] )
				{
					case PARAM_CAP .. PARAM_MASK :
						return UseInv[playerid][i][inv_param_1];
						
					case INVALID_PARAM :
						return inventory[id][i_model];
				}
			}
			
			default :
				return inventory[id][i_model];
		}
	}
	else if( type == TYPE_WARECAR )
	{
		new 
			car_id = GetPVarInt( playerid, "Inv:CarId" );
			
		id = getInventoryId( CarInv[car_id][i][inv_id] );
		
		switch( inventory[id][i_type] )
		{
			case INV_SKIN, INV_PHONE :
				return CarInv[car_id][i][inv_param_1];
				
			case INV_ATTACH :
			{
				switch( inventory[id][i_param_1] )
				{
					case PARAM_CAP .. PARAM_MASK :
						return CarInv[car_id][i][inv_param_1];
					
					case INVALID_PARAM :
						return inventory[id][i_model];
				}
			}
			
			default :
				return inventory[id][i_model];
		}
	}
	
	return STATUS_ERROR;
}
	
stock getItemType( type_id, i, type ) // Определяем тип инвентаря
{
	new 
		id;
	switch( type ) 
	{
		case TYPE_INV : 
			id = PlayerInv[type_id][i][inv_id];
		
		case TYPE_USE : 
			id = UseInv[type_id][i][inv_id];
		
		case TYPE_BAG : 
			id = BagInv[type_id][i][inv_id];
			
		case TYPE_WAREHOUSE :
			id = HouseInv[type_id][i][inv_id];
					
		case TYPE_WARECAR :
			id = CarInv[type_id][i][inv_id];
	}
	
	for( new idx; idx < sizeof inventory; idx++ ) 
	{
		if( inventory[idx][i_id] == id ) 
			return inventory[idx][i_type];
	}
	
	return 0;
}

stock getItem( playerid, type, params ) // Поиск предмета в инвентаре
{
	new 
		id;
		
	for( new i; i < MAX_INVENTORY; i++ ) 
	{
		id = getInventoryId( PlayerInv[playerid][i][inv_id] );
			
		if( inventory[id][i_type] == type && inventory[id][i_param_1] == params  )
		{
			return PlayerInv[playerid][i][inv_bd];
		}
	}
	
	return 0;
}

stock getUseItem( playerid, type, params, return_inv_id = 0 ) // Поиск предмета в активных слотах
{
	new 
		id;
		
	for( new i; i < MAX_INVENTORY_USE; i++ ) 
	{
		id = getInventoryId( UseInv[playerid][i][inv_id] );
			
		if( inventory[id][i_type] == type && inventory[id][i_param_1] == params  )
		{
			if( !return_inv_id )
				return id;
				
			else if( return_inv_id )
				return UseInv[playerid][i][inv_bd];
				
			else if( return_inv_id == 2 )
				return 1;
		}
	}
	
	return 0;
}

stock useSpecialItem( playerid, params, select = INVALID_PARAM ) //Использование специального предмета
{
	new 
		id;
		
	if( select == INVALID_PARAM )
	{
		for( new i; i < MAX_INVENTORY; i++ )
		{
			id = getInventoryId( PlayerInv[playerid][i][inv_id] );
					
			if( inventory[id][i_type] == INV_SPECIAL && inventory[id][i_param_1] == params  )
			{
				PlayerInv[playerid][i][inv_amount]--;
				
				if( PlayerInv[playerid][i][inv_amount] < 1 )
				{
					saveInventory( playerid, i, INV_DELETE, TYPE_INV );
					clearSlot( playerid, i, TYPE_INV );
				}
				else
				{
					saveInventory( playerid, i, INV_UPDATE, UPD_I );
					updateSelect( playerid, invSlot[playerid][i], false );
				}
					
				if( GetPVarInt( playerid, "Inv:Show" ) )
				{
					updateImages( playerid, i, TYPE_INV );
					updateAmount( playerid, i, TYPE_INV );
					
					SetPVarInt( playerid, "PlayerInv:Select", INVALID_PARAM );
				}

				break;
			}
		}
	}
	else
	{
		PlayerInv[playerid][select][inv_amount]--;
			
		if( PlayerInv[playerid][select][inv_amount] < 1 )
		{
			saveInventory( playerid, select, INV_DELETE, TYPE_INV );
			clearSlot( playerid, select, TYPE_INV );
		}
		else
		{
			saveInventory( playerid, select, INV_UPDATE, UPD_I );
			updateSelect( playerid, invSlot[playerid][select], false );
		}
	
		updateImages( playerid, select, TYPE_INV );
		updateAmount( playerid, select, TYPE_INV );
		
		SetPVarInt( playerid, "PlayerInv:Select", INVALID_PARAM );
	}
	
	updateSelect( playerid, invSelect[playerid], false );
	invSelect[playerid] = INVALID_PTD;
	
	updateMass( playerid );
	
	return 1;
}

stock getUseArmourStatus( playerid )
{
	new 
		id;
		
	for( new i; i < MAX_INVENTORY_USE; i++ )
	{
		id = getInventoryId( UseInv[playerid][i][inv_id] );
		if( inventory[id][i_type] == INV_SPECIAL && inventory[id][i_param_1] == PARAM_ARMOUR  )
			return UseInv[playerid][i][inv_param_1];
	}
	
	return 0;
}

stock getWeaponId( item )
{
	return inventory[ getInventoryId( item ) ][i_param_1];
}

stock getAmmoForWeapon( playerid, _: type, i_weapon, i_ammo )
{
	new 
		id_weapon,
		id_ammo;
		
	if( type == TYPE_INV )
	{
		id_weapon = getInventoryId( UseInv[playerid][i_weapon][inv_id] );
		id_ammo = getInventoryId( PlayerInv[playerid][i_ammo][inv_id] );
		
		if( ( inventory[id_weapon][i_type] == INV_GUN || inventory[id_weapon][i_type] == INV_SMALL_GUN ) && inventory[id_ammo][i_type] == INV_AMMO )
		{
			if( inventory[id_weapon][i_param_2] == inventory[id_ammo][i_param_1] )
			{
				return STATUS_OK;
			}
		}
	}	
	else if( type == TYPE_BAG )
	{
		id_weapon = getInventoryId( UseInv[playerid][i_weapon][inv_id] );
		id_ammo = getInventoryId( BagInv[playerid][i_ammo][inv_id] );
		
		if( ( inventory[id_weapon][i_type] == INV_GUN || inventory[id_weapon][i_type] == INV_SMALL_GUN ) && inventory[id_ammo][i_type] == INV_AMMO )
		{
			if( inventory[id_weapon][i_param_2] == inventory[id_ammo][i_param_1] )
			{
				return STATUS_OK;
			}
		}
	}
	
	return STATUS_ERROR;
}

stock giveAmmoForWeapon( playerid, _: type, i_ammo )
{
	new 
		id_ammo;
		
	if( type == TYPE_INV )
	{
		new 
			bool: count = false;
					
		for( new i; i < MAX_INVENTORY_USE; i++ )
		{
			if( !getUseGun( playerid, i ) )
				continue;
				
			if( getAmmoForWeapon( playerid, type, i, i_ammo ) )
			{
				id_ammo = getInventoryId( PlayerInv[playerid][i_ammo][inv_id] );
				
				UseInv[playerid][i][inv_param_1] += inventory[id_ammo][i_param_2];
				
				SetPlayerAmmo( 
					playerid, 
					getWeaponId( UseInv[playerid][i][inv_id] ), 
					UseInv[playerid][i][inv_param_1]
				);
				
				count = true;
				
				removeItem( playerid, i_ammo, 1, TYPE_INV );
				return STATUS_OK;
			}
			
		}
		
		if( !count )
			return STATUS_DONE;
	}
	else if( type == TYPE_BAG )
	{
		new 
			bool: count = false;
					
		for( new i; i < MAX_INVENTORY_BAG; i++ )
		{
			if( !getUseGun( playerid, i ) )
				continue;
				
			if( getAmmoForWeapon( playerid, type, i, i_ammo ) )
			{
				id_ammo = getInventoryId( BagInv[ getUseBagId( playerid ) ][i_ammo][inv_id] );
				
				UseInv[playerid][i][inv_param_1] += inventory[id_ammo][i_param_2];
				
				SetPlayerAmmo( 
					playerid, 
					getWeaponId( UseInv[playerid][i][inv_id] ), 
					UseInv[playerid][i][inv_param_1]
				);
				
				count = true;
				
				removeItem( playerid, i_ammo, 1, TYPE_BAG );
				return STATUS_OK;
			}
			
		}
		
		if( !count )
			return STATUS_DONE;
	}
	
	return STATUS_ERROR;
}

stock givePlayerSatiety( playerid, i, _: type )
{
	if( isnullSlot( type, playerid, i ) )
		return STATUS_ERROR;

	new 
		id;
		
	if( type == TYPE_INV )
	{
		id = getInventoryId( PlayerInv[playerid][i][inv_id] );
		
		if( inventory[id][i_param_2] == -1 ) //Еда
		{	
			ApplyAnimation( playerid, "FOOD", "EAT_Burger", 2.0, 0, 0, 0, 0, 5000, 1 );
		
			GetPlayerHealth( playerid, Player[playerid][uHP] );
			if( Player[playerid][uHP] + inventory[id][i_param_1] >= 100.0 )
			{
				setPlayerHealth( playerid, 100.0 );
			}
			else
			{
				setPlayerHealth( playerid, Player[playerid][uHP] + inventory[id][i_param_1] );
			}
			
			format:g_small_string( "съел%s - '%s'", SexTextEnd( playerid ), inventory[id][i_name] );
			SendRolePlayAction( playerid, g_small_string, 1 );
			
			removeItem( playerid, i, 1, type );
			return STATUS_OK;
		}
		else if( inventory[id][i_param_2] == 1 ) //Выпивка
		{
			if( GetPVarInt( playerid, "Inv:UseSmokeId" ) )
			{
				SendClient:( playerid, C_WHITE, !""gbDefault"В данный момент Вы курите. Используйте "cBLUE"/dsmoke"cWHITE", чтобы выбросить сигарету." );
				return STATUS_ERROR;
			}
			else if( GetPVarInt( playerid, "Inv:UseDrinkId" ) )
			{
				SendClient:( playerid, C_WHITE, !""gbDefault"Вы уже пьете. Используйте "cBLUE"/dbottle"cWHITE", чтобы выбросить бутылку." );
				return STATUS_ERROR;
			}
		
			SendClient:( playerid, C_WHITE, !""gbDefault"Используйте "cBLUE"/dbottle"cWHITE", чтобы выбросить бутылку." );
			
			SetPVarInt( playerid, "Inv:UseDrinkId", id );
			SetPVarInt( playerid, "Inv:UseDrinkCount", 0 );
			
			SetPlayerAttachedObject( 
				playerid, 
				5, 
				inventory[id][i_model],
				5,
				0.126999,
				0.016998,
				-0.010999,
				5.099999,
				-175.499862,
				1.399999,
				1.000000,
				1.000000,
				1.000000
			);
			
			format:g_small_string( "достал%s бутылку - '%s'", SexTextEnd( playerid ), inventory[id][i_name] );
			SendRolePlayAction( playerid, g_small_string, 1 );
			
			removeItem( playerid, i, 1, type );
			return STATUS_OK;
		}
		else if( inventory[id][i_param_2] == 2 ) //Сигареты
		{
			if( GetPVarInt( playerid, "Inv:UseDrinkId" ) )
			{
				SendClient:( playerid, C_WHITE, !""gbDefault"В данный момент Вы пьете. Используйте "cBLUE"/dbottle"cWHITE", чтобы выбросить бутылку." );
				return STATUS_ERROR;
			}
			else if( GetPVarInt( playerid, "Inv:UseSmokeId" ) )
			{
				SendClient:( playerid, C_WHITE, !""gbDefault"Вы уже курите. Используйте "cBLUE"/dsmoke"cWHITE", чтобы выбросить сигарету." );
				return STATUS_ERROR;
			}
		
			if( !IsPlayerInAnyVehicle( playerid ) )
			{
				UseAnim( playerid, "SMOKING", "M_smk_in", 3.0, 0, 0, 0, 0, 0 );
			}			
		
			SendClient:( playerid, C_WHITE, !""gbDefault"Используйте "cBLUE"/dsmoke"cWHITE", чтобы выбросить сигарету." );
		
			SetPVarInt( playerid, "Inv:UseSmokeId", id );
			SetPVarInt( playerid, "Inv:UseSmokeCount", 0 );
			
			SetPlayerAttachedObject( 
				playerid, 
				5,  
				19625, 
				6, 
				0.098999, 
				-0.003000, 
				0.020000,  
				-2.999998, 
				-24.799991, 
				45.300014, 
				1.000000, 
				1.000000, 
				1.000000 
			);
		
			format:g_small_string( "достал%s сигарету - '%s'", SexTextEnd( playerid ), inventory[id][i_name] );
			SendRolePlayAction( playerid, g_small_string, 1 );
		
			PlayerInv[playerid][i][inv_param_1]--;
			saveInventory( playerid, i, INV_UPDATE, UPD_I );
		
			if( !PlayerInv[playerid][i][inv_param_1] ) 
				removeItem( playerid, i, 1, type );
			
			return STATUS_OK;
		}
	}
	else if( type == TYPE_BAG )
	{
		new
			bag_id = getUseBagId( playerid );
		id = getInventoryId( BagInv[bag_id][i][inv_id] );
		
		if( inventory[id][i_param_2] == -1 ) //Еда
		{	
			ApplyAnimation( playerid, "FOOD", "EAT_Burger", 2.0, 0, 0, 0, 0, 5000, 1 );
		
			GetPlayerHealth( playerid, Player[playerid][uHP] );
			if( Player[playerid][uHP] + inventory[id][i_param_1] >= 100.0 )
			{
				setPlayerHealth( playerid, 100.0 );
			}
			else
			{
				setPlayerHealth( playerid, Player[playerid][uHP] + inventory[id][i_param_1] );
			}
			
			format:g_small_string( "съел%s - '%s'", SexTextEnd( playerid ), inventory[id][i_name] );
			SendRolePlayAction( playerid, g_small_string, 1 );
			
			removeItem( playerid, i, 1, type );
			return STATUS_OK;
		}
		else if( inventory[id][i_param_2] == 1 ) //Выпивка
		{
			if( GetPVarInt( playerid, "Inv:UseSmokeId" ) )
			{
				SendClient:( playerid, C_WHITE, !""gbDefault"В данный момент Вы курите. Используйте "cBLUE"/dsmoke"cWHITE", чтобы выбросить сигарету." );
				return STATUS_ERROR;
			}
			else if( GetPVarInt( playerid, "Inv:UseDrinkId" ) )
			{
				SendClient:( playerid, C_WHITE, !""gbDefault"Вы уже пьете. Используйте "cBLUE"/dbottle"cWHITE", чтобы выбросить бутылку." );
				return STATUS_ERROR;
			}
		
			SendClient:( playerid, C_WHITE, !""gbDefault"Используйте "cBLUE"/dbottle"cWHITE", чтобы выбросить бутылку." );
			
			SetPVarInt( playerid, "Inv:UseDrinkId", id );
			SetPVarInt( playerid, "Inv:UseDrinkCount", 0 );
			
			SetPlayerAttachedObject( 
				playerid, 
				5, 
				inventory[id][i_model],
				5,
				0.126999,
				0.016998,
				-0.010999,
				5.099999,
				-175.499862,
				1.399999,
				1.000000,
				1.000000,
				1.000000
			);
			
			format:g_small_string( "достал%s бутылку - '%s'", SexTextEnd( playerid ), inventory[id][i_name] );
			SendRolePlayAction( playerid, g_small_string, 1 );
			
			removeItem( playerid, i, 1, type );
			return STATUS_OK;
		}
		else if( inventory[id][i_param_2] == 2 ) //Сигареты
		{
			if( GetPVarInt( playerid, "Inv:UseDrinkId" ) )
			{
				SendClient:( playerid, C_WHITE, !""gbDefault"В данный момент Вы пьете. Используйте "cBLUE"/dbottle"cWHITE", чтобы выбросить бутылку." );
				return STATUS_ERROR;
			}
			else if( GetPVarInt( playerid, "Inv:UseSmokeId" ) )
			{
				SendClient:( playerid, C_WHITE, !""gbDefault"Вы уже курите. Используйте "cBLUE"/dsmoke"cWHITE", чтобы выбросить сигарету." );
				return STATUS_ERROR;
			}
		
			SendClient:( playerid, C_WHITE, !""gbDefault"Используйте "cBLUE"/dsmoke"cWHITE", чтобы выбросить сигарету." );
		
			SetPVarInt( playerid, "Inv:UseSmokeId", id );
			SetPVarInt( playerid, "Inv:UseSmokeCount", 0 );
			
			SetPlayerAttachedObject( 
				playerid, 
				5,  
				19625, 
				6, 
				0.098999, 
				-0.003000, 
				0.020000,  
				-2.999998, 
				-24.799991, 
				45.300014, 
				1.000000, 
				1.000000, 
				1.000000 
			);
		
			format:g_small_string( "достал%s сигарету - '%s'", SexTextEnd( playerid ), inventory[id][i_name] );
			SendRolePlayAction( playerid, g_small_string, 1 );
		
			BagInv[playerid][i][inv_param_1]--;
			saveInventory( playerid, i, INV_UPDATE, UPD_B );
		
			if( !BagInv[bag_id][i][inv_param_1] ) 
				removeItem( playerid, i, 1, type );
			
			return STATUS_OK;
		}
	}
	
	return STATUS_ERROR;
}

stock getUseGun( playerid, i )
{
	new 
		id;
	
	id = getInventoryId( UseInv[playerid][i][inv_id] );
	
	if( inventory[id][i_type] == INV_GUN || inventory[id][i_type] == INV_COLD_GUN || inventory[id][i_type] == INV_SMALL_GUN )
		return UseInv[playerid][i][inv_id];
	
	return STATUS_ERROR;
}

stock getUseGunId( playerid, i )
{
	new 
		id;
	
	id = getInventoryId( UseInv[playerid][i][inv_id] );
	
	if( inventory[id][i_type] == INV_GUN || inventory[id][i_type] == INV_COLD_GUN || inventory[id][i_type] == INV_SMALL_GUN )
		return inventory[id][i_param_1];
	
	return 0;
}

stock isUseItem( playerid, select, type = TYPE_INV ) // Определяем, используется ли типовой предмет в активном слоте
{
	new
		use_id,
		id;

	if( type == TYPE_INV )
	{
		id = getInventoryId( PlayerInv[playerid][select][inv_id] );
			
		for( new i; i < MAX_INVENTORY_USE; i++ ) 
		{
			use_id = getInventoryId( UseInv[playerid][i][inv_id] );	
			
			if( inventory[id][i_type] == INV_COLD_GUN && inventory[use_id][i_type] == INV_SMALL_GUN )
				return 1;
				
			else if( inventory[id][i_type] == INV_SMALL_GUN && inventory[use_id][i_type] == INV_COLD_GUN )
				return 1;
			
			if( inventory[use_id][i_type] == inventory[id][i_type] && inventory[id][i_type] != INV_ATTACH ) 
				return 1;
		}
	}
	else if( type == TYPE_BAG )
	{		
		id = getInventoryId( BagInv[ getUseBagId( playerid ) ][select][inv_id] );
			
		for( new i; i < MAX_INVENTORY_USE; i++ ) 
		{
			use_id = getInventoryId( UseInv[playerid][i][inv_id] );	
			
			if( inventory[id][i_type] == INV_COLD_GUN && inventory[use_id][i_type] == INV_SMALL_GUN )
				return 1;
				
			else if( inventory[id][i_type] == INV_SMALL_GUN && inventory[use_id][i_type] == INV_COLD_GUN )
				return 1;
			
			if( inventory[use_id][i_type] == inventory[id][i_type] && inventory[id][i_type] != INV_ATTACH ) 
				return 1;
		}
	}
	else if( type == TYPE_WARECAR )
	{
		id = getInventoryId( CarInv[ GetPVarInt( playerid, "Inv:CarId" ) ][select][inv_id] );
			
		for( new i; i < MAX_INVENTORY_USE; i++ ) 
		{
			use_id = getInventoryId( UseInv[playerid][i][inv_id] );	
			
			if( inventory[id][i_type] == INV_COLD_GUN && inventory[use_id][i_type] == INV_SMALL_GUN )
				return 1;
				
			else if( inventory[id][i_type] == INV_SMALL_GUN && inventory[use_id][i_type] == INV_COLD_GUN )
				return 1;
			
			if( inventory[use_id][i_type] == inventory[id][i_type] && inventory[id][i_type] != INV_ATTACH ) 
				return 1;
		}
	}
	
	return 0;
}

stock getUseBag( playerid ) // Определяем, используется ли сумка
{
	for( new i; i < MAX_INVENTORY_USE; i++ ) 
	{
		if( getItemType( playerid, i, TYPE_USE ) == INV_BAG )
		{
			return getInventoryId( UseInv[playerid][i][inv_id] );
		}
	}
	
	return 0;
}

stock getUseBagBd( playerid )
{
	for( new i; i < MAX_INVENTORY_USE; i++ ) 
	{
		if( getItemType( playerid, i, TYPE_USE ) == INV_BAG )
		{
			return UseInv[playerid][i][inv_bd];
		}
	}
	
	return 0;
}

stock addBagId( id )
{	
	for( new i; i != MAX_BAGS; i++ )
	{
		if( !g_bags[i] )
		{	
			g_bags[i] = id;
			
			return i;
		}
	}
	
	return 0;
}

stock setBagId( _: old_id, _: new_id )
{
	for( new i; i != MAX_BAGS; i++ )
	{
		if( g_bags[i] != 0 )
			continue;
			
		if( g_bags[i] == old_id )
		{
			g_bags[i] = new_id;
			
			break;
		}
	}
}

stock removeBagId( id )
{
	for( new i; i != MAX_BAGS; i++ )
	{
		if( g_bags[i] == id )
		{
			for( new j; j < MAX_INVENTORY_BAG; j++ )
			{
				clearSlot( i, j, TYPE_BAG );
			}
			
			g_bags[i] = 0;
			
			break;
		}
	}
}

stock getUseBagId( playerid )
{	
	for( new i; i < MAX_INVENTORY_USE; i++ )
	{
		if( getItemType( playerid, i, TYPE_USE ) == INV_BAG )
		{
			for( new j; j != MAX_BAGS; j++ )
			{
				if( g_bags[j] == UseInv[playerid][i][inv_bd] )
				{
					return j;
				}
			}
			
			break;
		}
	}

	return 0;
}

stock setBagIndex( old_id, new_id )
{
	for( new i; i != MAX_BAGS; i++ )
	{
		if( i == old_id )
		{
			for( new j; j < MAX_INVENTORY_BAG; j++ )
			{
				BagInv[i][j][inv_bd] = BagInv[new_id][j][inv_bd];
				BagInv[i][j][inv_id] = BagInv[new_id][j][inv_id];
				BagInv[i][j][inv_amount] = BagInv[new_id][j][inv_amount];
				BagInv[i][j][inv_type] = BagInv[new_id][j][inv_type];
				BagInv[i][j][inv_bone] = BagInv[new_id][j][inv_bone];
				BagInv[i][j][inv_active_type] = BagInv[new_id][j][inv_active_type];
				BagInv[i][j][inv_slot] = BagInv[new_id][j][inv_slot];
				
				BagInv[i][j][inv_param_1] = BagInv[new_id][j][inv_param_1];
				BagInv[i][j][inv_param_2] = BagInv[new_id][j][inv_param_2];
				
				BagInv[i][j][inv_pos_x] = BagInv[new_id][j][inv_pos_x];
				BagInv[i][j][inv_pos_y] = BagInv[new_id][j][inv_pos_y];
				BagInv[i][j][inv_pos_z] = BagInv[new_id][j][inv_pos_z];
				BagInv[i][j][inv_rot_x] = BagInv[new_id][j][inv_rot_x];
				BagInv[i][j][inv_rot_y] = BagInv[new_id][j][inv_rot_y];
				BagInv[i][j][inv_rot_z] = BagInv[new_id][j][inv_rot_z];		 	
				BagInv[i][j][inv_scale_x] = BagInv[new_id][j][inv_scale_x];
				BagInv[i][j][inv_scale_y] = BagInv[new_id][j][inv_scale_y];
				BagInv[i][j][inv_scale_z] = BagInv[new_id][j][inv_scale_z];
			}
			
			break;
		}
	}
}

stock InventoryClearBag( playerid )
{
	if( getUseBag( playerid ) != 0 )
	{
		static 
			i_bag = 0;
			
		for( i_bag = 0; i_bag < MAX_INVENTORY; i_bag++ )
		{
			if( getItemType( playerid, i_bag, TYPE_INV ) == INV_BAG )
			{
				removeBagId( PlayerInv[playerid][i_bag][inv_bd] );
				updateMass( playerid );
			}
		}
		
		for( i_bag = 0; i_bag < MAX_INVENTORY_USE; i_bag++ )
		{
			if( getItemType( playerid, i_bag, TYPE_INV ) == INV_BAG )
			{
				removeBagId( UseInv[playerid][i_bag][inv_bd] );
				updateMass( playerid );
			}
		}
	}
	
	return 1;
}

stock setUseSkin( playerid, bool: return_value = false )  // Определяем скин и устанавливаем его
{
	new
		id;
		
	for( new i; i < MAX_INVENTORY_USE; i++ ) 
	{
		id = getInventoryId( UseInv[playerid][i][inv_id] );
		if( !return_value )
		{
			if( inventory[id][i_type] == INV_SKIN ) // Если в активном слоте имеется
				return SetPlayerSkin( playerid, UseInv[playerid][i][inv_param_1] );
		}
		else
		{
			if( inventory[id][i_type] == INV_SKIN ) // Если в активном слоте имеется
				return UseInv[playerid][i][inv_param_1];
		}
	}
	
	return ( return_value ) ? resetSkin( playerid ) : SetPlayerSkin( playerid, resetSkin( playerid ) );
}

stock resetSkin( playerid ) 
{
	if( Player[playerid][uSex] == 1 ) 
	{
		if( Player[playerid][uColor] == 1 )
			return 18;
		else if( Player[playerid][uColor] == 2 )
			return 154;
			
	} 
	else if( Player[playerid][uSex] == 2 ) 
	{
		if( Player[playerid][uColor] == 1 )
			return 139;
		else if( Player[playerid][uColor] == 2 )
			return 138;
	}
	
	return 0;
}

stock checkAllowSkin( playerid, skin ) //Проверка на доступность скина
{
	if( AllowSkin[skin][0] && Player[playerid][uColor] != AllowSkin[skin][0] )
		return 0;
		
	if( AllowSkin[skin][1] != Player[playerid][uSex] )
		return 0;

	return 1;
}

stock updateAmount( playerid, i, type = TYPE_INV ) 
{
	switch( type ) 
	{
		case TYPE_INV : 
		{
			if( !PlayerInv[playerid][i][inv_amount] || PlayerInv[playerid][i][inv_amount] == 1 || !PlayerInv[playerid][i][inv_id] )
			{
				PlayerTextDrawHide( playerid, invamount[playerid][i] );
			}
			else 
			{
				format:g_small_string(  "%d", PlayerInv[playerid][i][inv_amount] );
				PlayerTextDrawSetString( playerid, invamount[playerid][i], g_small_string );
				PlayerTextDrawShow( playerid, invamount[playerid][i] );
			}	
		}
		
		case TYPE_BAG :
		{
			if( !BagInv[getUseBagId( playerid )][i][inv_amount] || BagInv[getUseBagId( playerid )][i][inv_amount] == 1 || !BagInv[getUseBagId( playerid )][i][inv_id] )
			{
				PlayerTextDrawHide( playerid, bagInvamount[playerid][i] );
			}
			else 
			{
				format:g_small_string(  "%d", BagInv[getUseBagId( playerid )][i][inv_amount] );
				PlayerTextDrawSetString( playerid, bagInvamount[playerid][i], g_small_string );
				PlayerTextDrawShow( playerid, bagInvamount[playerid][i] );
			}
		}
		
		case TYPE_WARECAR :
		{
			new
				car_id = GetPVarInt( playerid, "Inv:CarId" );
		
			if( !CarInv[car_id][i][inv_amount] || CarInv[car_id][i][inv_amount] == 1 || !CarInv[car_id][i][inv_id] )
			{
				PlayerTextDrawHide( playerid, warehouseInvamount[playerid][i] );
			}
			else 
			{
				format:g_small_string(  "%d", CarInv[car_id][i][inv_amount] );
				PlayerTextDrawSetString( playerid, warehouseInvamount[playerid][i], g_small_string );
				PlayerTextDrawShow( playerid, warehouseInvamount[playerid][i] );
			}
		}
	}
	
	return 1;
}

stock updateWareHouseamount( playerid, id, i, type )
{
	switch( type )
	{
		case SUBTYPE_HOUSE :
		{
			if( !HouseInv[id][i][inv_amount] || HouseInv[id][i][inv_amount] == 1 || !HouseInv[id][i][inv_id] )
			{
				PlayerTextDrawHide( playerid, warehouseInvamount[playerid][i] );
			}
			else 
			{
				format:g_small_string(  "%d", HouseInv[id][i][inv_amount] );
				PlayerTextDrawSetString( playerid, warehouseInvamount[playerid][i], g_small_string );
				PlayerTextDrawShow( playerid, warehouseInvamount[playerid][i] );
			}
		}
		
		case SUBTYPE_CAR :
		{
			if( !CarInv[id][i][inv_amount] || CarInv[id][i][inv_amount] == 1 || !CarInv[id][i][inv_id] )
			{
				PlayerTextDrawHide( playerid, warehouseInvamount[playerid][i] );
			}
			else 
			{
				format:g_small_string(  "%d", CarInv[id][i][inv_amount] );
				PlayerTextDrawSetString( playerid, warehouseInvamount[playerid][i], g_small_string );
				PlayerTextDrawShow( playerid, warehouseInvamount[playerid][i] );
			}
		}
	}
	
	return 1;
}

stock updateSelect( playerid, PlayerText:textdraw, selectable ) 
{
	if( selectable ) 
	{
		PlayerTextDrawHide( playerid, textdraw );
		PlayerTextDrawBackgroundColor( playerid, textdraw, 0x797C7CFF );
		PlayerTextDrawShow( playerid, textdraw );
		
		showInventoryInformation( playerid );

	}
	else 
	{
		PlayerTextDrawHide( playerid, textdraw );
		PlayerTextDrawBackgroundColor( playerid, textdraw, -1061109505 );
		PlayerTextDrawShow( playerid, textdraw );
		
		PlayerTextDrawHide( playerid, invInformation[playerid] );
		
		textdraw = INVALID_PTD;
		
		invSelect[playerid] = INVALID_PTD;
	}
	
	return 1;
}

stock updateWareHouseSelect( playerid, type_id, PlayerText:textdraw, selectable, type )
{
	if( selectable ) 
	{
		PlayerTextDrawHide( playerid, textdraw );
		PlayerTextDrawBackgroundColor( playerid, textdraw, 0x797C7CFF );
		PlayerTextDrawShow( playerid, textdraw );
		
		
		showWareHouseInformation( playerid, type_id, type );
	}
	else 
	{
		PlayerTextDrawHide( playerid, textdraw );
		PlayerTextDrawBackgroundColor( playerid, textdraw, -1061109505 );
		PlayerTextDrawShow( playerid, textdraw );
		
	
		PlayerTextDrawHide( playerid, warehouseInformation[playerid] );
	}
}

stock showWareHouseInformation( playerid, warehouseId, type )
{
	new 
		i, 
		id;
		
	if( GetPVarInt( playerid, "CarInv:Select" ) != INVALID_PARAM )
	{
		i = GetPVarInt( playerid, "CarInv:Select" );
		
		switch( type )
		{
			case TYPE_WAREHOUSE :
			{
				id = getInventoryId( HouseInv[warehouseId][i][inv_id] );
				
				format:g_small_string(  "%s (%d)", 
					inventory[id][i_name], 
					HouseInv[warehouseId][i][inv_amount] 
				); 
			}
			
			case TYPE_WARECAR :
			{
				id = getInventoryId( CarInv[warehouseId][i][inv_id] );
				
				format:g_small_string(  "%s (%d)", 
					inventory[id][i_name], 
					CarInv[warehouseId][i][inv_amount] 
				);	
			}
		}
		
		PlayerTextDrawSetString( playerid, warehouseInformation[playerid], g_small_string );
		PlayerTextDrawShow( playerid, warehouseInformation[playerid] );	
	}
	
	return 1;
}

stock showInventoryInformation( playerid ) 
{
	new 
		i, 
		id;
	
	if( GetPVarInt( playerid, "UseInv:Select" ) != INVALID_PARAM ) 
	{
		i = GetPVarInt( playerid, "UseInv:Select" );
		id = getInventoryId( UseInv[playerid][i][inv_id] );
		format:g_small_string(  "%s (%d)", 
			inventory[id][i_name], 
			UseInv[playerid][i][inv_amount] 
		); 
	} 
	
	else if( GetPVarInt( playerid, "Inv:Select" ) != INVALID_PARAM ) 
	{
		i = GetPVarInt( playerid, "Inv:Select" );
		id = getInventoryId( PlayerInv[playerid][i][inv_id] );
		format:g_small_string(  "%s (%d)", 
			inventory[id][i_name], 
			PlayerInv[playerid][i][inv_amount] 
		); 
	}
	
	else if( GetPVarInt( playerid, "BagInv:Select" ) != INVALID_PARAM ) 
	{
		i = GetPVarInt( playerid, "BagInv:Select" );
		id = getInventoryId( BagInv[getUseBagId( playerid )][i][inv_id] );
		format:g_small_string(  "%s (%d)", 
			inventory[id][i_name], 
			BagInv[getUseBagId( playerid )][i][inv_amount] 
		); 
	}
		
	PlayerTextDrawSetString( playerid, invInformation[playerid], g_small_string );
	PlayerTextDrawShow( playerid, invInformation[playerid] );
	
	return 1;
}

stock updateImages( playerid, i, type ) 
{
	new 
		id;
		
	switch( type ) 
	{
		case TYPE_INV : 
		{
			id = getInventoryId( PlayerInv[playerid][i][inv_id] );
			PlayerTextDrawHide( playerid, invSlot[playerid][i] );
			
			
			PlayerTextDrawSetPreviewModel( playerid, invSlot[playerid][i], getModelItem( type, playerid, i ) );
	
			
			PlayerTextDrawSetPreviewRot( playerid, invSlot[playerid][i], 
				inventory[id][i_pos][0], inventory[id][i_pos][1], inventory[id][i_pos][2], inventory[id][i_pos][3] );
			PlayerTextDrawShow( playerid, invSlot[playerid][i] );
		}
		
		case TYPE_USE : 
		{
			id = getInventoryId( UseInv[playerid][i][inv_id] );
			PlayerTextDrawHide( playerid, useSlot[playerid][i] );

			PlayerTextDrawSetPreviewModel( playerid, useSlot[playerid][i], getModelItem( type, playerid, i ) );
			
			PlayerTextDrawSetPreviewRot( playerid, useSlot[playerid][i], 
				inventory[id][i_pos][0], inventory[id][i_pos][1], inventory[id][i_pos][2], inventory[id][i_pos][3] );
			PlayerTextDrawShow( playerid, useSlot[playerid][i] );
		}
		
		case TYPE_BAG :
		{
			new 
				bag_id = getUseBagId( playerid );
				
			id = getInventoryId( BagInv[bag_id][i][inv_id] );
			PlayerTextDrawHide( playerid, bagSlot[playerid][i] );
			
			PlayerTextDrawSetPreviewModel( playerid, bagSlot[playerid][i], getModelItem( type, playerid, i ) );
			
			PlayerTextDrawSetPreviewRot( playerid, bagSlot[playerid][i], 
				inventory[id][i_pos][0], inventory[id][i_pos][1], inventory[id][i_pos][2], inventory[id][i_pos][3] );
			PlayerTextDrawShow( playerid, bagSlot[playerid][i] );
		
		}
		case TYPE_WARECAR :
		{
			new 
				car_id = GetPVarInt( playerid, "Inv:CarId" );
				
			id = getInventoryId( CarInv[car_id][i][inv_id] );
			PlayerTextDrawHide( playerid, warehouseSlot[playerid][i] );
			
			PlayerTextDrawSetPreviewModel( playerid, warehouseSlot[playerid][i], getModelItem( type, playerid, i ) );
			
			PlayerTextDrawSetPreviewRot( playerid, warehouseSlot[playerid][i], 
				inventory[id][i_pos][0], inventory[id][i_pos][1], inventory[id][i_pos][2], inventory[id][i_pos][3] );
			PlayerTextDrawShow( playerid, warehouseSlot[playerid][i] );
		}
	}
	
	return 1;
}

stock updateMass( playerid ) 
{
	format:g_small_string(  "%.2f/%.2f кг", checkMass( playerid ), checkMaxMass( playerid ) );
	PlayerTextDrawSetString( playerid, invMass[playerid], g_small_string );
	
	if( getUseBag( playerid ) )
	{
		format:g_small_string( "%.2f/%.2f кг", checkBagMass( playerid ), float( inventory[ getUseBag( playerid ) ][i_param_1] ) );
		PlayerTextDrawSetString( playerid, invBagMass[playerid], g_small_string );
	}
	
	return 1;
}

function Float: checkMass( playerid )
{
	new 
		Float:mass;
	
	for( new i; i < MAX_INVENTORY; i++ ) 
	{
		if( PlayerInv[playerid][i][inv_id] ) 
		{
			mass += PlayerInv[playerid][i][inv_amount] * checkInvMass( PlayerInv[playerid][i][inv_id] );
		}
	}
	
	for( new i; i < MAX_INVENTORY_USE; i++ ) 
	{
		if( UseInv[playerid][i][inv_id] ) 
		{
			mass += UseInv[playerid][i][inv_amount] * checkInvMass( UseInv[playerid][i][inv_id] );
		}
	}
	
	return mass;
}

function Float: checkBagMass( playerid )
{
	new 
		Float:mass,
		bag_id = getUseBagId( playerid );
	
	for( new i; i < MAX_INVENTORY_BAG; i++ ) 
	{
		if( BagInv[bag_id][i][inv_id] ) 
		{
			mass += BagInv[bag_id][i][inv_amount] * checkInvMass( BagInv[bag_id][i][inv_id] );
		}
	}

	return mass;
}

function Float: checkInvMass( id ) 
{
	for( new i; i < sizeof inventory; i++ ) 
	{
		if( inventory[i][i_id] == id ) 
			return inventory[i][i_mass];
	}
	
	return 0.0;
}

function Float:checkMaxMass( playerid ) 
{
	new
		Float: mass = 15.0;
		
	if( Premium[playerid][prem_mass] )
	{
		mass += float( Premium[playerid][prem_mass] );
	}
	
	return mass;
}

function Float:checkBagMaxMass( playerid )
{
	new
		id = getUseBag( playerid ),
		Float:mass;
		
	if( id != 0 )
		mass += float( inventory[id][i_param_1] );
		
	return mass;
}

stock getInventoryId( id ) 
{
	for( new i; i < sizeof inventory; i++ ) 
	{
		if( inventory[i][i_id] == id ) 
			return i;
	}
	
	return 0;
}