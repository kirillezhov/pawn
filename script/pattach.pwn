enum pa_attach_info 
{
	pa_name[64],
	pa_object,
	pa_bone,
	
}

new const
	pa_attach[][pa_attach_info] = {
	{ "Байкерский котелок розовый", 19112, 2 },
	{ "Байкерский котелок чёрный", 19115, 2 },
	{ "Мотошлем сине-белый", 18976, 2 },
	{ "Мотошлем красный", 18977, 2 },
	{ "Шляпа ведьмы", 19528, 2},
	{ "Электрогитара [спина]", 19319, 1},
	{ "Электрогитара [правая рука]", 19319, 6 },
	{ "Электрогитара [левая рука]", 19319, 5 },
	{ "Лом [правая рука]", 18634, 6 },
	{ "Лом [левая рука]", 18634, 5 },
	{ "Лом [пояс]", 18634, 7 },
	{ "Молоток [правая рука]", 18635, 6 },
	{ "Молоток [левая рука]", 18635, 5 },
	{ "Молоток [пояс]", 18635, 7 },
	{ "Грабли [правая рука]", 18890, 6 },
	{ "Грабли [левая рука]", 18890, 5 },
	{ "Электрошокер [правая рука]", 18642, 6 },
	{ "Электрошокер [левая рука]", 18642, 5 },
	{ "Электрошокер [пояс]", 18642, 7 },
	{ "Отвёртка [правая рука]", 18644, 6 },
	{ "Отвёртка [левая рука]", 18644, 5 },
	{ "Отвёртка [пояс]", 18644, 7 },
	{ "Шляпа еврея", 19136, 2 },
	{ "Трость [правая рука]", 19348, 6 },
	{ "Трость [левая рука]", 19348, 5},
	{ "Респиратор", 19472, 2},
	{ "Усы 1", 19350, 2 },
	{ "Усы 2", 19351, 2 },
	{ "Соломенная шляпа", 19553, 2 },
	{ "Походный рюкзак", 19559, 1 },
	{ "Корзина из супермаркета [правая рука]", 19592, 6 },
	{ "Корзина из супермаркета [левая рука]", 19592, 5 },
	{ "Микрофон [правая рука]", 19610, 6 },
	{ "Микрофон [левая рука]", 19610, 5 },
	{ "Маслёнка [правая рука]", 19621, 6 },
	{ "Маслёнка [левая рука]", 19621, 5 },
	{ "Гаечный ключ [правая рука]", 19627, 6 },
	{ "Гаечный ключ [левая рука]", 19627, 5 },
	{ "Гаечный ключ [пояс]", 19627, 7 },
	{ "Чемодан [правая рука]", 19624, 6 },
	{ "Чемодан [левая рука]", 19624, 5 },
	{ "Балаклава", 19801, 2 },
	{ "Повязка на один глаз", 19085, 2 }
};


/*CMD:pattach( playerid, params[] ) 
{
	if( Player[playerid][uPremium] ) 
	{
		new slot;
		for( new i; i < sizeof pa_attach; i++ ) 
		{
			format:g_big_string( "%s%d. %s\n", g_big_string, slot + 1, pa_attach[i][pa_name] );
			slot++;
		}
		format:g_small_string(  "%d. Очистить объекты", slot + 1 ), strcat( g_big_string, g_small_string );
		showPlayerDialog( playerid, 3001, DIALOG_STYLE_LIST, "Список объектов", g_big_string, "Выбрать", "Отмена");
	}
	return 1;
}*/

Pattach_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	#pragma unused inputtext
	
	switch( dialogid ) {
		case 3001: {
			if(!response) return 1;
			if( listitem == sizeof( pa_attach ) ) {
				RemovePlayerAttachedObject( playerid, 5 ), RemovePlayerAttachedObject( playerid, 6 );
	            return SendClient:( playerid, -1, ""gbDefault"Вы очистили список объектов!" );
			}
			if( IsPlayerAttachedObjectSlotUsed( playerid, 5 ) 
				&& IsPlayerAttachedObjectSlotUsed( playerid, 6 ) ) return SendClient:(playerid, -1, ""gbError"Все слоты заняты, очистите их в меню!");
	        if( !IsPlayerAttachedObjectSlotUsed( playerid, 5 )) {
	            SetPlayerAttachedObject( playerid, 5, pa_attach[listitem][pa_object], pa_attach[listitem][pa_bone] );
    			return EditAttachedObject( playerid, 5 );
	        }
	        else if( IsPlayerAttachedObjectSlotUsed( playerid, 5 )) {
	            SetPlayerAttachedObject( playerid, 6, pa_attach[listitem][pa_object], pa_attach[listitem][pa_bone] );
    			return EditAttachedObject( playerid, 6 );
	        }
	    }
	}
	return 1;
}