Inv_TextDraws() 
{
	// Основной инвентарь
	invBg[0] = TextDrawCreate( 464.129516, 268.833465, "box");
	TextDrawLetterSize( invBg[0], 0.000000, 8.117645), TextDrawTextSize( invBg[0], 630.000000, 0.000000);
	TextDrawAlignment( invBg[0], 1), TextDrawColor( invBg[0], -1), TextDrawUseBox( invBg[0], 1);
	TextDrawBoxColor( invBg[0], td_cBLUE), TextDrawSetShadow( invBg[0], 0), TextDrawSetOutline( invBg[0], 0);
	TextDrawBackgroundColor( invBg[0], 255), TextDrawFont( invBg[0], 1), TextDrawSetProportional( invBg[0], 1);
	TextDrawSetShadow( invBg[0], 0);
	// Колонка с выбором действия
	invBg[1]= TextDrawCreate( 464.129211, 235.117370, "box");
	TextDrawLetterSize( invBg[1], 0.000000, 2.941173), TextDrawTextSize( invBg[1], 630.000000, 0.000000);
	TextDrawAlignment( invBg[1], 1), TextDrawColor( invBg[1], -1), TextDrawUseBox( invBg[1], 1);
	TextDrawBoxColor( invBg[1], td_cBLUE), TextDrawSetShadow( invBg[1], 0), TextDrawSetOutline( invBg[1], 0);
	TextDrawBackgroundColor( invBg[1], 255), TextDrawFont( invBg[1], 1);
	TextDrawSetProportional( invBg[1], 1), TextDrawSetShadow( invBg[1], 0);
	// Сумка фон 3
	invBg[2] = TextDrawCreate( 464.129211, 170.298034, "box");
	TextDrawLetterSize( invBg[2], 0.000000, 4.211745), TextDrawTextSize( invBg[2], 631.000000, 0.000000);
	TextDrawAlignment( invBg[2], 1), TextDrawColor( invBg[2], -1), TextDrawUseBox( invBg[2], 1);
	TextDrawBoxColor( invBg[2], td_cBLUE), TextDrawSetShadow( invBg[2], 0), TextDrawSetOutline( invBg[2], 0);
	TextDrawBackgroundColor( invBg[2], 255), TextDrawFont( invBg[2], 1), TextDrawSetProportional( invBg[2], 1);
	TextDrawSetShadow( invBg[2], 0);
	// Сумка надпись фон 4
	invBg[3] = TextDrawCreate( 518.011474, 213.833282, "box");
	TextDrawLetterSize( invBg[3], 0.000000, 0.870585), TextDrawTextSize( invBg[3], 631.000000, 0.000000);
	TextDrawAlignment( invBg[3], 1), TextDrawColor( invBg[3], -1), TextDrawUseBox( invBg[3], 1);
	TextDrawBoxColor( invBg[3], td_cBLUE), TextDrawSetShadow( invBg[3], 0), TextDrawSetOutline( invBg[3], 0);
	TextDrawBackgroundColor( invBg[3], 255), TextDrawFont( invBg[3], 1), TextDrawSetProportional( invBg[3], 1);
	TextDrawSetShadow( invBg[3], 0);
	// Используемые слоты, фон 5
	invBg[4] = TextDrawCreate( 464.129211, 388.298034, "box");
	TextDrawLetterSize( invBg[4], 0.000000, 4.211745), TextDrawTextSize( invBg[4], 631.000000, 0.000000);
	TextDrawAlignment( invBg[4], 1), TextDrawColor( invBg[4], -1), TextDrawUseBox( invBg[4], 1);
	TextDrawBoxColor( invBg[4], td_cBLUE), TextDrawSetShadow( invBg[4], 0), TextDrawSetOutline( invBg[4], 0);
	TextDrawBackgroundColor( invBg[4], 255), TextDrawFont( invBg[4], 1), TextDrawSetProportional( invBg[4], 1);
	TextDrawSetShadow( invBg[4], 0);	
	
	// Дополнительные слоты, фон 6
	invBg[5] = TextDrawCreate(11.011766, 281.567016, "box");
	TextDrawLetterSize(invBg[5], 0.000000, 16.043806);
	TextDrawTextSize(invBg[5], 174.999877, 0.000000);
	TextDrawAlignment(invBg[5], 1);
	TextDrawColor(invBg[5], 16777215);
	TextDrawUseBox(invBg[5], 1);
	TextDrawBoxColor(invBg[5], td_cBLUE);
	TextDrawSetShadow(invBg[5], 0);
	TextDrawSetOutline(invBg[5], 0);
	TextDrawBackgroundColor(invBg[5], 255);
	TextDrawFont(invBg[5], 1);
	TextDrawSetProportional(invBg[5], 1);
	TextDrawSetShadow(invBg[5], 0);
	
	// Дополнительные слоты, заголовок фон 7
	invBg[6] = TextDrawCreate(11.132352, 264.650299, "box");
	TextDrawLetterSize(invBg[6], 0.000000, 1.079098);
	TextDrawTextSize(invBg[6], 174.699981, 0.000000);
	TextDrawAlignment(invBg[6], 1);
	TextDrawColor(invBg[6], 16777215);
	TextDrawUseBox(invBg[6], 1);
	TextDrawBoxColor(invBg[6], td_cBLUE);
	TextDrawSetShadow(invBg[6], 0);
	TextDrawSetOutline(invBg[6], 0);
	TextDrawBackgroundColor(invBg[6], 255);
	TextDrawFont(invBg[6], 1);
	TextDrawSetProportional(invBg[6], 1);
	TextDrawSetShadow(invBg[6], 0);
	
	// Фон покупки 8
	invBg[7] = TextDrawCreate(11.482356, 205.844177, "box");
	TextDrawLetterSize(invBg[7], 0.000000, 24.490522);
	TextDrawTextSize(invBg[7], 147.000000, 0.000000);
	TextDrawAlignment(invBg[7], 1);
	TextDrawColor(invBg[7], 16777215);
	TextDrawUseBox(invBg[7], 1);
	TextDrawBoxColor(invBg[7], td_cBLUE);
	TextDrawSetShadow(invBg[7], 0);
	TextDrawSetOutline(invBg[7], 0);
	TextDrawBackgroundColor(invBg[7], 255);
	TextDrawFont(invBg[7], 1);
	TextDrawSetProportional(invBg[7], 1);
	TextDrawSetShadow(invBg[7], 0);
	
	// Стрелочки при покупке
	buyArrow[0] = TextDrawCreate(95.847015, 412.566772, ">>");
	TextDrawLetterSize(buyArrow[0], 0.205175, 0.934998);
	TextDrawTextSize(buyArrow[0], 7.000000, 20.000000);
	TextDrawAlignment(buyArrow[0], 2);
	TextDrawColor(buyArrow[0], -1);
	TextDrawUseBox(buyArrow[0], 1);
	TextDrawBoxColor(buyArrow[0], 146);
	TextDrawSetShadow(buyArrow[0], 0);
	TextDrawSetOutline(buyArrow[0], 0);
	TextDrawBackgroundColor(buyArrow[0], 255);
	TextDrawFont(buyArrow[0], 2);
	TextDrawSetProportional(buyArrow[0], 1);
	TextDrawSetShadow(buyArrow[0], 0);
	TextDrawSetSelectable(buyArrow[0], true);

	buyArrow[1] = TextDrawCreate( 62.505950, 412.450042, "<<" );
	TextDrawLetterSize( buyArrow[1], 0.205175, 0.934998 );
	TextDrawTextSize( buyArrow[1], 7.000000, 20.000000 );
	TextDrawAlignment( buyArrow[1], 2 );
	TextDrawColor( buyArrow[1], -1 );
	TextDrawUseBox( buyArrow[1], 1 );
	TextDrawBoxColor( buyArrow[1], 146 );
	TextDrawSetShadow( buyArrow[1], 0 );
	TextDrawSetOutline( buyArrow[1], 0 );
	TextDrawBackgroundColor( buyArrow[1], 255 );
	TextDrawFont( buyArrow[1], 2 );
	TextDrawSetProportional( buyArrow[1], 1 );
	TextDrawSetShadow( buyArrow[1], 0 );
	TextDrawSetSelectable( buyArrow[1], true );
	
	// Тексты
	invText[0] = TextDrawCreate( 465.764709, 237.083312, "Использовать");
	TextDrawTextSize( invText[0], 535.1, 10.0 );
	TextDrawLetterSize( invText[0], 0.213645, 1.104164), TextDrawAlignment( invText[0], 0), TextDrawColor( invText[0], -1);
	TextDrawSetShadow( invText[0], 0), TextDrawSetOutline( invText[0], 0);
	TextDrawBackgroundColor( invText[0], 255), TextDrawFont( invText[0], 2), TextDrawSetProportional( invText[0], 1);
	TextDrawSetShadow( invText[0], 0), TextDrawSetSelectable( invText[0], true);
	
	invText[1] = TextDrawCreate( 465.764709, 250.083312, "Выбросить");
	TextDrawTextSize( invText[1], 518.1, 10.0 );
	TextDrawLetterSize( invText[1], 0.213645, 1.104164), TextDrawAlignment( invText[1], 0), TextDrawColor( invText[1], -1);
	TextDrawSetShadow( invText[1], 0), TextDrawSetOutline( invText[1], 0);
	TextDrawBackgroundColor( invText[1], 255), TextDrawFont( invText[1], 2), TextDrawSetProportional( invText[1], 1);
	TextDrawSetShadow( invText[1], 0), TextDrawSetSelectable( invText[1], true);
	
	invText[2] = TextDrawCreate( 550.764709, 237.083312, "Настроить");
	TextDrawTextSize( invText[2], 605.1, 10.0 );
	//TextDrawUseBox( invText[2], 1 );
	TextDrawLetterSize( invText[2], 0.213645, 1.104164), TextDrawAlignment( invText[2], 0), TextDrawColor( invText[2], -1);
	TextDrawSetShadow( invText[2], 0), TextDrawSetOutline( invText[2], 0);
	TextDrawBackgroundColor( invText[2], 255), TextDrawFont( invText[2], 2), TextDrawSetProportional( invText[2], 1);
	TextDrawSetShadow( invText[2], 0), TextDrawSetSelectable( invText[2], true);
	
	invText[3] = TextDrawCreate( 550.764709, 250.083312, "Передать");
	TextDrawTextSize( invText[3], 605.1, 10.0 );
	TextDrawLetterSize( invText[3], 0.213645, 1.104164), TextDrawAlignment( invText[3], 0), TextDrawColor( invText[3], -1);
	TextDrawSetShadow( invText[3], 0), TextDrawSetOutline( invText[3], 0);
	TextDrawBackgroundColor( invText[3], 255), TextDrawFont( invText[3], 2), TextDrawSetProportional( invText[3], 1);
	TextDrawSetShadow( invText[3], 0), TextDrawSetSelectable( invText[3], true );

	return 1;
}

InventoryHideTextDraws( playerid ) 
{
	for( new i; i < sizeof invBg; i++ ) 
	{
		TextDrawHideForPlayer( playerid, invBg[i] );
	}
	
	for( new i; i < sizeof invText; i++ ) 
	{
		TextDrawHideForPlayer( playerid, invText[i] );
	}
	
	for( new i; i < MAX_INVENTORY; i++ ) 
	{
		PlayerTextDrawHide( playerid, invSlot[playerid][i] );
		PlayerTextDrawDestroy( playerid, invSlot[playerid][i] );
		
		PlayerTextDrawHide( playerid, invamount[playerid][i] );
		PlayerTextDrawDestroy( playerid, invamount[playerid][i] );
	}
	
	for( new i; i < MAX_INVENTORY_BAG; i++ ) 
	{
		PlayerTextDrawHide( playerid, bagSlot[playerid][i] );
		PlayerTextDrawDestroy( playerid, bagSlot[playerid][i] );
		
		PlayerTextDrawHide( playerid, bagInvamount[playerid][i] );
		PlayerTextDrawDestroy( playerid, bagInvamount[playerid][i] );
	}
	
	for( new i; i < MAX_INVENTORY_USE; i++ ) 
	{
		PlayerTextDrawHide( playerid, useSlot[playerid][i] );
		PlayerTextDrawDestroy( playerid, useSlot[playerid][i] );
	}
	
	for( new i; i < MAX_INVENTORY_WAREHOUSE; i++ ) 
	{
		PlayerTextDrawHide( playerid, warehouseSlot[playerid][i] );
		PlayerTextDrawDestroy( playerid, warehouseSlot[playerid][i] );
	}
	
	PlayerTextDrawHide( playerid, bagName[playerid] );
	PlayerTextDrawDestroy( playerid, bagName[playerid] );
	
	PlayerTextDrawHide( playerid, invInformation[playerid] );
	PlayerTextDrawDestroy( playerid, invInformation[playerid] );
	
	PlayerTextDrawHide( playerid, invMass[playerid] );
	PlayerTextDrawDestroy( playerid, invMass[playerid] );
	
	PlayerTextDrawHide( playerid, invBagMass[playerid] );
	PlayerTextDrawDestroy( playerid, invBagMass[playerid] );
	
	return 1;
}

Inv_PlayerTextDraws( playerid ) 
{
	invMass[playerid] = CreatePlayerTextDraw( playerid, 600.764709, 346.083312, "5.5/15 кг.");
	PlayerTextDrawBackgroundColor(playerid,invMass[playerid], 255);
	PlayerTextDrawAlignment(playerid, invMass[playerid], 2);
	PlayerTextDrawFont(playerid,invMass[playerid], 2);
	PlayerTextDrawLetterSize(playerid,invMass[playerid], 0.210000, 1.000000);
	PlayerTextDrawColor(playerid,invMass[playerid], -1);
	PlayerTextDrawSetOutline(playerid,invMass[playerid], 0);
	PlayerTextDrawSetProportional(playerid,invMass[playerid], 1);
	PlayerTextDrawSetShadow(playerid,invMass[playerid], 0);
	PlayerTextDrawSetSelectable(playerid,invMass[playerid], 0);
	
	invBagMass[playerid] = CreatePlayerTextDraw( playerid, 600.764709, 356.083312, "5.5/20 кг.");
	PlayerTextDrawBackgroundColor(playerid,invBagMass[playerid], 255);
	PlayerTextDrawAlignment(playerid, invBagMass[playerid], 2);
	PlayerTextDrawFont(playerid,invBagMass[playerid], 2);
	PlayerTextDrawLetterSize(playerid,invBagMass[playerid], 0.210000, 1.000000);
	PlayerTextDrawColor(playerid,invBagMass[playerid], td_cGREEN);
	PlayerTextDrawSetOutline(playerid,invBagMass[playerid], 0);
	PlayerTextDrawSetProportional(playerid,invBagMass[playerid], 1);
	PlayerTextDrawSetShadow(playerid,invBagMass[playerid], 0);
	PlayerTextDrawSetSelectable(playerid,invBagMass[playerid], 0);
	
	invInformation[playerid] = CreatePlayerTextDraw(playerid, 464.000000, 346.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,invInformation[playerid], 255);
	PlayerTextDrawFont(playerid,invInformation[playerid], 2);
	PlayerTextDrawLetterSize(playerid,invInformation[playerid], 0.210000, 1.000000);
	PlayerTextDrawColor(playerid,invInformation[playerid], -1);
	PlayerTextDrawSetOutline(playerid,invInformation[playerid], 0);
	PlayerTextDrawSetProportional(playerid,invInformation[playerid], 1);
	PlayerTextDrawSetShadow(playerid,invInformation[playerid], 0);
	PlayerTextDrawSetSelectable(playerid,invInformation[playerid], 0);
	
	bagName[playerid] = CreatePlayerTextDraw(playerid, 574.5, 212.083312, rus( "Чемодан" ) );
	PlayerTextDrawLetterSize(playerid, bagName[playerid], 0.213645, 1.104164 );
	PlayerTextDrawAlignment(playerid, bagName[playerid], 2);
	PlayerTextDrawColor(playerid, bagName[playerid], -1);
	PlayerTextDrawSetShadow(playerid, bagName[playerid], 0);
	PlayerTextDrawSetOutline(playerid, bagName[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, bagName[playerid], 0xFFFFFFAA );
	PlayerTextDrawFont(playerid, bagName[playerid], 2);
	PlayerTextDrawSetProportional(playerid, bagName[playerid], 1);
	PlayerTextDrawSetShadow(playerid, bagName[playerid], 0);
	
	warehouseName[playerid] = CreatePlayerTextDraw( playerid, 92.864479, 265.599945, rus("Дом") );
	PlayerTextDrawLetterSize( playerid, warehouseName[playerid], 0.174587, 0.882498 );
	PlayerTextDrawTextSize( playerid, warehouseName[playerid], 0.000000, 160.900115 );
	PlayerTextDrawAlignment( playerid, warehouseName[playerid], 2 );
	PlayerTextDrawColor( playerid, warehouseName[playerid], -1 );
	PlayerTextDrawBoxColor( playerid, warehouseName[playerid], 78 );
	PlayerTextDrawSetShadow( playerid, warehouseName[playerid], 0 );
	PlayerTextDrawSetOutline( playerid, warehouseName[playerid], 0 );
	PlayerTextDrawBackgroundColor( playerid, warehouseName[playerid], 0xFFFFFFAA );
	PlayerTextDrawFont( playerid, warehouseName[playerid], 2 );
	PlayerTextDrawSetProportional( playerid, warehouseName[playerid], 1 );
	PlayerTextDrawSetShadow( playerid, warehouseName[playerid], 0 );
	
	warehouseInformation[playerid] = CreatePlayerTextDraw( playerid, 11.194140, 249.699310, "_" );
	PlayerTextDrawLetterSize( playerid, warehouseInformation[playerid], 0.204235, 1.121665 );
	PlayerTextDrawAlignment( playerid, warehouseInformation[playerid], 1 );
	PlayerTextDrawColor( playerid, warehouseInformation[playerid], td_cWHITE );
	PlayerTextDrawSetShadow( playerid, warehouseInformation[playerid], 0 );
	PlayerTextDrawSetOutline( playerid, warehouseInformation[playerid], 0 );
	PlayerTextDrawBackgroundColor( playerid, warehouseInformation[playerid], 23 );
	PlayerTextDrawFont( playerid, warehouseInformation[playerid], 2 );
	PlayerTextDrawSetProportional( playerid, warehouseInformation[playerid], 1 );
	PlayerTextDrawSetShadow( playerid, warehouseInformation[playerid], 0 );

	new 
		Float: x = 0.0, 
		Float: pos_x = 432.12, 
		Float: y = 0.0,
		Float: pos_y = 0.0;

	for( new i; i < MAX_INVENTORY; i++ ) 
	{
		if( i < 5 )
		{
			x += 33.2;
		}
		else 
		{
			if( i == 5 ) 
				y += 36.0, x = 0.0;
			
			x += 33.2;
		}
		invSlot[playerid][i] = CreatePlayerTextDraw(playerid, pos_x + x, 270.167007 + y, "");
		PlayerTextDrawLetterSize(playerid, invSlot[playerid][i], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, invSlot[playerid][i], 31.000000, 34.000000);
		PlayerTextDrawAlignment(playerid, invSlot[playerid][i], 1);
		PlayerTextDrawColor(playerid, invSlot[playerid][i], -1);
		PlayerTextDrawSetShadow(playerid, invSlot[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, invSlot[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, invSlot[playerid][i], -1061109505);
		PlayerTextDrawFont(playerid, invSlot[playerid][i], 5);
		PlayerTextDrawSetProportional(playerid, invSlot[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, invSlot[playerid][i], 0);
		PlayerTextDrawSetSelectable(playerid, invSlot[playerid][i], true);
		PlayerTextDrawSetPreviewModel(playerid, invSlot[playerid][i], 19464);
		PlayerTextDrawSetPreviewRot(playerid, invSlot[playerid][i], 0.000000, 0.000000, 90.000000, 0.1000000);
		
		invamount[playerid][i] = CreatePlayerTextDraw(playerid, pos_x + x + 29, 270.167007 + y + 25, "64");
		PlayerTextDrawBackgroundColor(playerid,invamount[playerid][i], 255);
		PlayerTextDrawAlignment(playerid, invamount[playerid][i], 3 );
		PlayerTextDrawFont(playerid,invamount[playerid][i], 2);
		PlayerTextDrawLetterSize(playerid,invamount[playerid][i], 0.220000, 0.899999);
		PlayerTextDrawColor(playerid,invamount[playerid][i], 659854079);
		PlayerTextDrawSetOutline(playerid,invamount[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid,invamount[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid,invamount[playerid][i], 0);
		PlayerTextDrawSetSelectable(playerid,invamount[playerid][i], 0);

	}

	x = 0.0;
	pos_x = 432.12;
	
	for( new i; i < MAX_INVENTORY_BAG; i++ ) 
	{
		x += 33.2;
		bagSlot[playerid][i] = CreatePlayerTextDraw(playerid, pos_x + x, 172.367007, "");
		PlayerTextDrawLetterSize(playerid, bagSlot[playerid][i], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, bagSlot[playerid][i], 31.000000, 34.000000);
		PlayerTextDrawAlignment(playerid, bagSlot[playerid][i], 1);
		PlayerTextDrawColor(playerid, bagSlot[playerid][i], -1);
		PlayerTextDrawSetShadow(playerid, bagSlot[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, bagSlot[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, bagSlot[playerid][i], -1061109505);
		PlayerTextDrawFont(playerid, bagSlot[playerid][i], 5);
		PlayerTextDrawSetProportional(playerid, bagSlot[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, bagSlot[playerid][i], 0);
		PlayerTextDrawSetSelectable(playerid, bagSlot[playerid][i], true);
		PlayerTextDrawSetPreviewModel(playerid, bagSlot[playerid][i], 19464);
		PlayerTextDrawSetPreviewRot(playerid, bagSlot[playerid][i], 0.000000, 0.000000, 90.000000, 0.1000000);
		
		bagInvamount[playerid][i] = CreatePlayerTextDraw(playerid, pos_x + x + 29, 152.367007 + y + 10, "64");
		PlayerTextDrawBackgroundColor(playerid, bagInvamount[playerid][i], 255);
		PlayerTextDrawAlignment(playerid, bagInvamount[playerid][i], 3 );
		PlayerTextDrawFont(playerid, bagInvamount[playerid][i], 2);
		PlayerTextDrawLetterSize(playerid, bagInvamount[playerid][i], 0.220000, 0.899999);
		PlayerTextDrawColor(playerid, bagInvamount[playerid][i], 659854079);
		PlayerTextDrawSetOutline(playerid, bagInvamount[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, bagInvamount[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, bagInvamount[playerid][i], 0);
		PlayerTextDrawSetSelectable(playerid, bagInvamount[playerid][i], 0);
	}
	
	x = 0.0;
	pos_x = 432.12;
	
	for( new i; i < MAX_INVENTORY_USE; i++ ) 
	{
		x += 33.2;
		useSlot[playerid][i] = CreatePlayerTextDraw(playerid, pos_x + x, 390.367007, "");
		PlayerTextDrawLetterSize(playerid, useSlot[playerid][i], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, useSlot[playerid][i], 31.000000, 34.000000);
		PlayerTextDrawAlignment(playerid, useSlot[playerid][i], 1);
		PlayerTextDrawColor(playerid, useSlot[playerid][i], -1);
		PlayerTextDrawSetShadow(playerid, useSlot[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, useSlot[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, useSlot[playerid][i], -1061109505);
		PlayerTextDrawFont(playerid, useSlot[playerid][i], 5);
		PlayerTextDrawSetProportional(playerid, useSlot[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, useSlot[playerid][i], 0);
		PlayerTextDrawSetSelectable(playerid, useSlot[playerid][i], true);
		PlayerTextDrawSetPreviewModel(playerid, useSlot[playerid][i], 19464);
		PlayerTextDrawSetPreviewRot(playerid, useSlot[playerid][i], 0.000000, 0.000000, 90.000000, 0.100000);
	}
	
	x = 0.0;
	y = 0.0;
	pos_x = -20.976406;
	
	for( new i; i < MAX_INVENTORY_WAREHOUSE; i++ )
	{
		if( i == 5 || i == 10 || i == 15 || i == 20)
		{
			y += 36.133728;
			x = 0.0;
		}
		
		x += 32.799972;
		
		warehouseSlot[playerid][i] = CreatePlayerTextDraw( playerid, pos_x + x, 282.865905 + y, "" );
		PlayerTextDrawLetterSize( playerid, warehouseSlot[playerid][i], 0.000000, 0.000000 );
		PlayerTextDrawTextSize( playerid, warehouseSlot[playerid][i], 31.000045, 34.000839 );
		PlayerTextDrawAlignment( playerid, warehouseSlot[playerid][i], 1 );
		PlayerTextDrawColor( playerid, warehouseSlot[playerid][i], -1 );
		PlayerTextDrawSetShadow( playerid, warehouseSlot[playerid][i], 0 );
		PlayerTextDrawSetOutline( playerid, warehouseSlot[playerid][i], 0 );
		PlayerTextDrawBackgroundColor( playerid, warehouseSlot[playerid][i], -1061109505 );
		PlayerTextDrawFont( playerid, warehouseSlot[playerid][i], 5 );
		PlayerTextDrawSetProportional( playerid, warehouseSlot[playerid][i], 0 );
		PlayerTextDrawSetShadow( playerid, warehouseSlot[playerid][i], 0 );
		PlayerTextDrawSetSelectable( playerid, warehouseSlot[playerid][i], true );
		PlayerTextDrawSetPreviewModel( playerid, warehouseSlot[playerid][i], 19464 );
		PlayerTextDrawSetPreviewRot( playerid, warehouseSlot[playerid][i], 0.000000, 0.000000, 90.000000, 0.100000 );
		
		warehouseInvamount[playerid][i] = CreatePlayerTextDraw(playerid, pos_x + x + 29, 282.865905 + y + 25, "64");
		PlayerTextDrawBackgroundColor(playerid, warehouseInvamount[playerid][i], 255);
		PlayerTextDrawAlignment(playerid, warehouseInvamount[playerid][i], 3 );
		PlayerTextDrawFont(playerid, warehouseInvamount[playerid][i], 2);
		PlayerTextDrawLetterSize(playerid, warehouseInvamount[playerid][i], 0.220000, 0.899999);
		PlayerTextDrawColor(playerid, warehouseInvamount[playerid][i], 659854079);
		PlayerTextDrawSetOutline(playerid, warehouseInvamount[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, warehouseInvamount[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, warehouseInvamount[playerid][i], 0);
		PlayerTextDrawSetSelectable(playerid, warehouseInvamount[playerid][i], 0);
	}
	
	pos_y = 169.933166;
	y = 0.0;
	
	for( new i; i < MAX_INVENTORY_BUY; i++ )
	{
		y += 40.217636;
		
		buyBox[playerid][i] = CreatePlayerTextDraw( playerid, 14.882553, pos_y + y, "box" );
		PlayerTextDrawLetterSize( playerid, buyBox[playerid][i], 0.000000, 3.657046);
		PlayerTextDrawTextSize( playerid, buyBox[playerid][i], 144.000000, 0.000000);
		PlayerTextDrawAlignment( playerid, buyBox[playerid][i], 1);
		PlayerTextDrawColor( playerid, buyBox[playerid][i], -1);
		PlayerTextDrawUseBox( playerid, buyBox[playerid][i], 1);
		PlayerTextDrawBoxColor( playerid, buyBox[playerid][i], 100);
		PlayerTextDrawSetShadow( playerid, buyBox[playerid][i], 0);
		PlayerTextDrawSetOutline( playerid, buyBox[playerid][i], 0);
		PlayerTextDrawBackgroundColor( playerid, buyBox[playerid][i], 255);
		PlayerTextDrawFont( playerid, buyBox[playerid][i], 1);
		PlayerTextDrawSetProportional( playerid, buyBox[playerid][i], 1);
		PlayerTextDrawSetShadow( playerid, buyBox[playerid][i], 0);
		
		buyButton[BUTTON_BUY][playerid][i] = CreatePlayerTextDraw( playerid, 88.923439, pos_y + y + 23.835175, rus("Купить") );
		PlayerTextDrawLetterSize( playerid, buyButton[BUTTON_BUY][playerid][i], 0.132175, 0.579165 );
		PlayerTextDrawTextSize( playerid, buyButton[BUTTON_BUY][playerid][i], 7.000000, 20.000000 );
		PlayerTextDrawAlignment( playerid, buyButton[BUTTON_BUY][playerid][i], 2 );
		PlayerTextDrawColor( playerid, buyButton[BUTTON_BUY][playerid][i], -1 );
		PlayerTextDrawUseBox( playerid, buyButton[BUTTON_BUY][playerid][i], 1 );
		PlayerTextDrawBoxColor( playerid, buyButton[BUTTON_BUY][playerid][i], td_cGREEN );
		PlayerTextDrawSetShadow( playerid, buyButton[BUTTON_BUY][playerid][i], 0 );
		PlayerTextDrawSetOutline( playerid, buyButton[BUTTON_BUY][playerid][i], 0 );
		PlayerTextDrawBackgroundColor( playerid, buyButton[BUTTON_BUY][playerid][i], 255 );
		PlayerTextDrawFont( playerid, buyButton[BUTTON_BUY][playerid][i], 2 );
		PlayerTextDrawSetProportional( playerid, buyButton[BUTTON_BUY][playerid][i], 1 );
		PlayerTextDrawSetShadow( playerid, buyButton[BUTTON_BUY][playerid][i], 0 );
		PlayerTextDrawSetSelectable( playerid, buyButton[BUTTON_BUY][playerid][i], true );
		
		buyButton[BUTTON_INFO][playerid][i] = CreatePlayerTextDraw( playerid, 122.470596, pos_y + y + 23.835175, rus("Информация") );
		PlayerTextDrawLetterSize( playerid, buyButton[BUTTON_INFO][playerid][i], 0.132175, 0.579165 );
		PlayerTextDrawTextSize( playerid, buyButton[BUTTON_INFO][playerid][i], 7.000000, 35.749988 );
		PlayerTextDrawAlignment( playerid, buyButton[BUTTON_INFO][playerid][i], 2 );
		PlayerTextDrawColor( playerid, buyButton[BUTTON_INFO][playerid][i], -1 );
		PlayerTextDrawUseBox( playerid, buyButton[BUTTON_INFO][playerid][i], 1 );
		PlayerTextDrawBoxColor( playerid, buyButton[BUTTON_INFO][playerid][i], 1082431743 );
		PlayerTextDrawSetShadow( playerid, buyButton[BUTTON_INFO][playerid][i], 0 );
		PlayerTextDrawSetOutline( playerid, buyButton[BUTTON_INFO][playerid][i], 0 );
		PlayerTextDrawBackgroundColor( playerid, buyButton[BUTTON_INFO][playerid][i], 255 );
		PlayerTextDrawFont( playerid, buyButton[BUTTON_INFO][playerid][i], 2 );
		PlayerTextDrawSetProportional( playerid, buyButton[BUTTON_INFO][playerid][i], 1 );
		PlayerTextDrawSetShadow( playerid, buyButton[BUTTON_INFO][playerid][i], 0 );
		PlayerTextDrawSetSelectable( playerid, buyButton[BUTTON_INFO][playerid][i], true );
		
		buyPrice[playerid][i] = CreatePlayerTextDraw( playerid, 46.064689, pos_y + y + 22.335068, "$1000000" );
		PlayerTextDrawLetterSize( playerid, buyPrice[playerid][i], 0.131293, 0.841665 );
		PlayerTextDrawAlignment( playerid, buyPrice[playerid][i], 1 );
		PlayerTextDrawColor( playerid, buyPrice[playerid][i], 1940543999 );
		PlayerTextDrawSetShadow( playerid, buyPrice[playerid][i], 0 );
		PlayerTextDrawSetOutline( playerid, buyPrice[playerid][i], 0 );
		PlayerTextDrawBackgroundColor( playerid, buyPrice[playerid][i], 255 );
		PlayerTextDrawFont( playerid, buyPrice[playerid][i], 2 );
		PlayerTextDrawSetProportional( playerid, buyPrice[playerid][i], 1 );
		PlayerTextDrawSetShadow( playerid, buyPrice[playerid][i], 0 );
	
		buyName[playerid][i] = CreatePlayerTextDraw( playerid, 46.464633, pos_y + y + 1.951614, rus("Предмет на покупку") );
		PlayerTextDrawLetterSize( playerid, buyName[playerid][i], 0.123764, 0.835833 );
		PlayerTextDrawTextSize( playerid, buyName[playerid][i], 140.549972, 0.000000 );
		PlayerTextDrawAlignment( playerid, buyName[playerid][i], 1 );
		PlayerTextDrawColor( playerid, buyName[playerid][i], -1 );
		PlayerTextDrawUseBox( playerid, buyName[playerid][i], 1 );
		PlayerTextDrawBoxColor( playerid, buyName[playerid][i], 963217919 );
		PlayerTextDrawSetShadow( playerid, buyName[playerid][i], 0 );
		PlayerTextDrawSetOutline( playerid, buyName[playerid][i], 0 );
		PlayerTextDrawBackgroundColor( playerid, buyName[playerid][i], 255 );
		PlayerTextDrawFont( playerid, buyName[playerid][i], 2 );
		PlayerTextDrawSetProportional( playerid, buyName[playerid][i], 1 );
		PlayerTextDrawSetShadow( playerid, buyName[playerid][i], 0 );
		PlayerTextDrawSetSelectable( playerid, buyName[playerid][i], true );
		
		buyModel[playerid][i] = CreatePlayerTextDraw(playerid, 15.017684, pos_y + y + 0.466614, "");
		PlayerTextDrawLetterSize(playerid, buyModel[playerid][i], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, buyModel[playerid][i], 28.000000, 32.000000);
		PlayerTextDrawAlignment(playerid, buyModel[playerid][i], 1);
		PlayerTextDrawColor(playerid, buyModel[playerid][i], -1);
		PlayerTextDrawSetShadow(playerid, buyModel[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, buyModel[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, buyModel[playerid][i], -1061109505);
		PlayerTextDrawFont(playerid, buyModel[playerid][i], 5);
		PlayerTextDrawSetProportional(playerid, buyModel[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, buyModel[playerid][i], 0);
		PlayerTextDrawSetPreviewModel(playerid, buyModel[playerid][i], 0);
		PlayerTextDrawSetPreviewRot(playerid, buyModel[playerid][i], 0.000000, 0.000000, 0.000000, 1.000000);
		
	}

	buyPreviewModel[playerid] = CreatePlayerTextDraw( playerid, 272.423492, 281.616485, "" );
	PlayerTextDrawLetterSize( playerid, buyPreviewModel[playerid], 0.000000, 0.000000 );
	PlayerTextDrawTextSize( playerid, buyPreviewModel[playerid], 98.000000, 115.000000 );
	PlayerTextDrawAlignment( playerid, buyPreviewModel[playerid], 1 );
	PlayerTextDrawColor( playerid, buyPreviewModel[playerid], -1 );
	PlayerTextDrawSetShadow( playerid, buyPreviewModel[playerid], 0 );
	PlayerTextDrawSetOutline( playerid, buyPreviewModel[playerid], 0 );
	PlayerTextDrawBackgroundColor( playerid, buyPreviewModel[playerid], td_cBLUE );
	PlayerTextDrawFont( playerid, buyPreviewModel[playerid], 5 );
	PlayerTextDrawSetProportional( playerid, buyPreviewModel[playerid], 0 );
	PlayerTextDrawSetShadow( playerid, buyPreviewModel[playerid], 0 );
	PlayerTextDrawSetPreviewModel( playerid, buyPreviewModel[playerid], 0 );
	PlayerTextDrawSetPreviewRot( playerid, buyPreviewModel[playerid], 0.000000, 0.000000, 0.000000, 1.000000 );
	
	return 1;
}