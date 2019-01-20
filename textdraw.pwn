new
	Text: logo				[ 3 ],
	Text: chooseSkin		[ 4 ],
	PlayerText: radio		[ 3 ][ MAX_PLAYERS ],
	Text: blind_background;
	
TextDraws_OnGameModeInit() 
{
	// New
	/* - TD: Логотип - */
	/*logo[0] = TextDrawCreate(549.235107, 8.499971, "LD_BEAT:chit");
	TextDrawLetterSize(logo[0], 0.000000, 0.000000);
	TextDrawTextSize(logo[0], 15.000000, 15.000000);
	TextDrawAlignment(logo[0], 1);
	TextDrawColor(logo[0], td_cBLUE);
	TextDrawSetShadow(logo[0], 0);
	TextDrawSetOutline(logo[0], 0);
	TextDrawBackgroundColor(logo[0], 255);
	TextDrawFont(logo[0], 4);
	TextDrawSetProportional(logo[0], 0);
	TextDrawSetShadow(logo[0], 0);

	logo[1] = TextDrawCreate(554.482385, 11.499990, "G");
	TextDrawLetterSize(logo[1], 0.189412, 0.883165);
	TextDrawAlignment(logo[1], 1);
	TextDrawColor(logo[1], -1);
	TextDrawSetShadow(logo[1], 0);
	TextDrawSetOutline(logo[1], 0);
	TextDrawBackgroundColor(logo[1], 255);
	TextDrawFont(logo[1], 2);
	TextDrawSetProportional(logo[1], 1);
	TextDrawSetShadow(logo[1], 0);

	logo[2] = TextDrawCreate(562.705932, 11.499991, "-GAME.NET");
	TextDrawLetterSize(logo[2], 0.189412, 0.883165);
	TextDrawAlignment(logo[2], 1);
	TextDrawColor(logo[2], -1);
	TextDrawSetShadow(logo[2], 0);
	TextDrawSetOutline(logo[2], 0);
	TextDrawBackgroundColor(logo[2], 255);
	TextDrawFont(logo[2], 2);
	TextDrawSetProportional(logo[2], 1);
	TextDrawSetShadow(logo[2], 0);*/
	
	logo[0] = TextDrawCreate(554.482385, 11.499990, "REEFLANDRP.RU");
	TextDrawLetterSize(logo[0], 0.189412, 0.883165);
	TextDrawAlignment(logo[0], 1);
	TextDrawColor(logo[0], -1);
	TextDrawSetShadow(logo[0], 0);
	TextDrawSetOutline(logo[0], 0);
	TextDrawBackgroundColor(logo[0], 255);
	TextDrawFont(logo[0], 2);
	TextDrawSetProportional(logo[0], 1);
	TextDrawSetShadow(logo[0], 0);
	
	/* - TD: Логотип - End */
	
	// Old
	
	SpeedFon[0] = TextDrawCreate(259.600891, 377.149902, "box");
	TextDrawLetterSize(SpeedFon[0], 0.000000, 4.682346);
	TextDrawTextSize(SpeedFon[0], 375.000000, 0.000000);
	TextDrawAlignment(SpeedFon[0], 1);
	TextDrawColor(SpeedFon[0], -1);
	TextDrawUseBox(SpeedFon[0], 1);
	//TextDrawBoxColor(SpeedFon[0], 0x4A86B650);
	TextDrawBoxColor(SpeedFon[0], 0x1E999930 );
	TextDrawSetShadow(SpeedFon[0], 0);
	TextDrawSetOutline(SpeedFon[0], 0);
	TextDrawBackgroundColor(SpeedFon[0], 95);
	TextDrawFont(SpeedFon[0], 1);
	TextDrawSetProportional(SpeedFon[0], 1);
	
	//Фон таксиметра
	TaxiBackground = TextDrawCreate(259.600891, 424.728281, "box");
	TextDrawLetterSize(TaxiBackground, 0.000000, 1.693349);
	TextDrawTextSize(TaxiBackground, 375.000000, 0.000000);
	TextDrawAlignment(TaxiBackground, 1);
	TextDrawColor(TaxiBackground, -1);
	TextDrawUseBox(TaxiBackground, 1);
	//TextDrawBoxColor(TaxiBackground, 0x4A86B650 );
	TextDrawBoxColor(TaxiBackground, 0x1E999930 );
	TextDrawSetShadow(TaxiBackground, 0);
	TextDrawSetOutline(TaxiBackground, 0);
	TextDrawBackgroundColor(TaxiBackground, 95);
	TextDrawFont(TaxiBackground, 1);
	TextDrawSetProportional(TaxiBackground, 1);
	
	SpeedFon[1] = TextDrawCreate(242.882369, 402.916687, "LD_BEAT:chit");
	TextDrawLetterSize(SpeedFon[1], 0.000000, 0.000000);
	TextDrawTextSize(SpeedFon[1], 148.000000, -2.000000);
	TextDrawAlignment(SpeedFon[1], 1);
	TextDrawColor(SpeedFon[1], -1);
	TextDrawSetOutline(SpeedFon[1], 0);
	TextDrawBackgroundColor(SpeedFon[1], 255);
	TextDrawFont(SpeedFon[1], 4);
	TextDrawSetProportional(SpeedFon[1], 0);
	TextDrawSetShadow(SpeedFon[1], 0);
	
	SpeedFon[2]= TextDrawCreate(307.711853, 384.250030, "MP/H");
	TextDrawLetterSize(SpeedFon[2], 0.150588, 1.016666);
	TextDrawAlignment(SpeedFon[2], 2);
	TextDrawColor(SpeedFon[2], -1);
	TextDrawSetShadow(SpeedFon[2], 0);
	TextDrawSetOutline(SpeedFon[2], 0);
	TextDrawBackgroundColor(SpeedFon[2], 255);
	TextDrawFont(SpeedFon[2], 2);
	TextDrawSetProportional(SpeedFon[2], 1);
	TextDrawSetShadow(SpeedFon[2], 0);
	
	MenuPlayer[0] = TextDrawCreate(265.000000, 131.000000, "_");
	TextDrawBackgroundColor(MenuPlayer[0], 255);
	TextDrawFont(MenuPlayer[0], 1);
	TextDrawLetterSize(MenuPlayer[0], 0.500000, 25.300025);
	TextDrawColor(MenuPlayer[0], -1);
	TextDrawSetOutline(MenuPlayer[0], 0);
	TextDrawSetProportional(MenuPlayer[0], 1);
	TextDrawSetShadow(MenuPlayer[0], 1);
	TextDrawUseBox(MenuPlayer[0], 1);
	TextDrawBoxColor(MenuPlayer[0], td_cBLUE);
	TextDrawTextSize(MenuPlayer[0], 76.000000, 0.000000);
	TextDrawSetSelectable(MenuPlayer[0], 0);
	
	MenuPlayer[1] = TextDrawCreate(262.000000, 134.000000, "_");
	TextDrawBackgroundColor(MenuPlayer[1], 255);
	TextDrawFont(MenuPlayer[1], 1);
	TextDrawLetterSize(MenuPlayer[1], 0.500000, 24.600023);
	TextDrawColor(MenuPlayer[1], -1);
	TextDrawSetOutline(MenuPlayer[1], 0);
	TextDrawSetProportional(MenuPlayer[1], 1);
	TextDrawSetShadow(MenuPlayer[1], 1);
	TextDrawUseBox(MenuPlayer[1], 1);
	TextDrawBoxColor(MenuPlayer[1], 96);
	TextDrawTextSize(MenuPlayer[1], 79.000000, 0.000000);
	TextDrawSetSelectable(MenuPlayer[1], 0);
	
	MenuPlayer[2] = TextDrawCreate(260.000000, 137.000000, "_");
	TextDrawBackgroundColor(MenuPlayer[2], 255);
	TextDrawFont(MenuPlayer[2], 1);
	TextDrawLetterSize(MenuPlayer[2], 0.500000, 1.300024);
	TextDrawColor(MenuPlayer[2], -1);
	TextDrawSetOutline(MenuPlayer[2], 0);
	TextDrawSetProportional(MenuPlayer[2], 1);
	TextDrawSetShadow(MenuPlayer[2], 1);
	TextDrawUseBox(MenuPlayer[2], 1);
	TextDrawBoxColor(MenuPlayer[2], td_cBLUE);
	TextDrawTextSize(MenuPlayer[2], 81.000000, 0.000000);
	TextDrawSetSelectable(MenuPlayer[2], 0);
	
	MenuPlayer[3] = TextDrawCreate(435.000000, 170.000000, "_");
	TextDrawAlignment(MenuPlayer[3], 2);
	TextDrawBackgroundColor(MenuPlayer[3], 255);
	TextDrawFont(MenuPlayer[3], 1);
	TextDrawLetterSize(MenuPlayer[3], 0.500000, 1.799999);
	TextDrawColor(MenuPlayer[3], -1);
	TextDrawSetOutline(MenuPlayer[3], 0);
	TextDrawSetProportional(MenuPlayer[3], 1);
	TextDrawSetShadow(MenuPlayer[3], 1);
	TextDrawUseBox(MenuPlayer[3], 1);
	TextDrawBoxColor(MenuPlayer[3], td_cBLUE);
	TextDrawTextSize(MenuPlayer[3], 6.000000, -128.000000);
	TextDrawSetSelectable(MenuPlayer[3], 0);
	
	MenuPlayer[4] = TextDrawCreate(435.000000, 195.000000, "_");
	TextDrawAlignment(MenuPlayer[4], 2);
	TextDrawBackgroundColor(MenuPlayer[4], 255);
	TextDrawFont(MenuPlayer[4], 1);
	TextDrawLetterSize(MenuPlayer[4], 0.500000, 1.799999);
	TextDrawColor(MenuPlayer[4], -1);
	TextDrawSetOutline(MenuPlayer[4], 0);
	TextDrawSetProportional(MenuPlayer[4], 1);
	TextDrawSetShadow(MenuPlayer[4], 1);
	TextDrawUseBox(MenuPlayer[4], 1);
	TextDrawBoxColor(MenuPlayer[4], td_cBLUE);
	TextDrawTextSize(MenuPlayer[4], 6.000000, -128.000000);
	TextDrawSetSelectable(MenuPlayer[4], 0);
	
	MenuPlayer[5] = TextDrawCreate(435.000000, 220.000000, "_");
	TextDrawAlignment(MenuPlayer[5], 2);
	TextDrawBackgroundColor(MenuPlayer[5], 255);
	TextDrawFont(MenuPlayer[5], 1);
	TextDrawLetterSize(MenuPlayer[5], 0.500000, 1.799999);
	TextDrawColor(MenuPlayer[5], -1);
	TextDrawSetOutline(MenuPlayer[5], 0);
	TextDrawSetProportional(MenuPlayer[5], 1);
	TextDrawSetShadow(MenuPlayer[5], 1);
	TextDrawUseBox(MenuPlayer[5], 1);
	TextDrawBoxColor(MenuPlayer[5], td_cBLUE);
	TextDrawTextSize(MenuPlayer[5], 6.000000, -128.000000);
	TextDrawSetSelectable(MenuPlayer[5], 0);
	
	MenuPlayer[6] = TextDrawCreate(435.000000, 245.000000, "_");
	TextDrawAlignment(MenuPlayer[6], 2);
	TextDrawBackgroundColor(MenuPlayer[6], 255);
	TextDrawFont(MenuPlayer[6], 1);
	TextDrawLetterSize(MenuPlayer[6], 0.500000, 1.799999);
	TextDrawColor(MenuPlayer[6], -1);
	TextDrawSetOutline(MenuPlayer[6], 0);
	TextDrawSetProportional(MenuPlayer[6], 1);
	TextDrawSetShadow(MenuPlayer[6], 1);
	TextDrawUseBox(MenuPlayer[6], 1);
	TextDrawBoxColor(MenuPlayer[6], td_cBLUE);
	TextDrawTextSize(MenuPlayer[6], 6.000000, -128.000000);
	TextDrawSetSelectable(MenuPlayer[6], 0);
	
	MenuPlayer[7] = TextDrawCreate(435.000000, 270.000000, "_");
	TextDrawAlignment(MenuPlayer[7], 2);
	TextDrawBackgroundColor(MenuPlayer[7], 255);
	TextDrawFont(MenuPlayer[7], 1);
	TextDrawLetterSize(MenuPlayer[7], 0.500000, 1.799999);
	TextDrawColor(MenuPlayer[7], -1);
	TextDrawSetOutline(MenuPlayer[7], 0);
	TextDrawSetProportional(MenuPlayer[7], 1);
	TextDrawSetShadow(MenuPlayer[7], 1);
	TextDrawUseBox(MenuPlayer[7], 1);
	TextDrawBoxColor(MenuPlayer[7], td_cBLUE);
	TextDrawTextSize(MenuPlayer[7], 6.000000, -128.000000);
	TextDrawSetSelectable(MenuPlayer[7], 0);
	
	MenuPlayer[8] = TextDrawCreate(435.000000, 295.000000, "_");
	TextDrawAlignment(MenuPlayer[8], 2);
	TextDrawBackgroundColor(MenuPlayer[8], 255);
	TextDrawFont(MenuPlayer[8], 1);
	TextDrawLetterSize(MenuPlayer[8], 0.500000, 1.799999);
	TextDrawColor(MenuPlayer[8], -1);
	TextDrawSetOutline(MenuPlayer[8], 0);
	TextDrawSetProportional(MenuPlayer[8], 1);
	TextDrawSetShadow(MenuPlayer[8], 1);
	TextDrawUseBox(MenuPlayer[8], 1);
	TextDrawBoxColor(MenuPlayer[8], td_cBLUE);
	TextDrawTextSize(MenuPlayer[8], 6.000000, -128.000000);
	TextDrawSetSelectable(MenuPlayer[8], 0);
	
	MenuPlayer[9] = TextDrawCreate(435.000000, 172.000000, "_");
	TextDrawAlignment(MenuPlayer[9], 2);
	TextDrawBackgroundColor(MenuPlayer[9], 255);
	TextDrawFont(MenuPlayer[9], 1);
	TextDrawLetterSize(MenuPlayer[9], 0.500000, 1.399999);
	TextDrawColor(MenuPlayer[9], -1);
	TextDrawSetOutline(MenuPlayer[9], 0);
	TextDrawSetProportional(MenuPlayer[9], 1);
	TextDrawSetShadow(MenuPlayer[9], 1);
	TextDrawUseBox(MenuPlayer[9], 1);
	TextDrawBoxColor(MenuPlayer[9], 96);
	TextDrawTextSize(MenuPlayer[9], 6.000000, -125.000000);
	TextDrawSetSelectable(MenuPlayer[9], 0);
	
	MenuPlayer[10] = TextDrawCreate(435.000000, 197.000000, "_");
	TextDrawAlignment(MenuPlayer[10], 2);
	TextDrawBackgroundColor(MenuPlayer[10], 255);
	TextDrawFont(MenuPlayer[10], 1);
	TextDrawLetterSize(MenuPlayer[10], 0.500000, 1.399999);
	TextDrawColor(MenuPlayer[10], -1);
	TextDrawSetOutline(MenuPlayer[10], 0);
	TextDrawSetProportional(MenuPlayer[10], 1);
	TextDrawSetShadow(MenuPlayer[10], 1);
	TextDrawUseBox(MenuPlayer[10], 1);
	TextDrawBoxColor(MenuPlayer[10], 96);
	TextDrawTextSize(MenuPlayer[10], 6.000000, -125.000000);
	TextDrawSetSelectable(MenuPlayer[10], 0);
	
	MenuPlayer[11] = TextDrawCreate(435.000000, 222.000000, "_");
	TextDrawAlignment(MenuPlayer[11], 2);
	TextDrawBackgroundColor(MenuPlayer[11], 255);
	TextDrawFont(MenuPlayer[11], 1);
	TextDrawLetterSize(MenuPlayer[11], 0.500000, 1.299999);
	TextDrawColor(MenuPlayer[11], -1);
	TextDrawSetOutline(MenuPlayer[11], 0);
	TextDrawSetProportional(MenuPlayer[11], 1);
	TextDrawSetShadow(MenuPlayer[11], 1);
	TextDrawUseBox(MenuPlayer[11], 1);
	TextDrawBoxColor(MenuPlayer[11], 96);
	TextDrawTextSize(MenuPlayer[11], 6.000000, -125.000000);
	TextDrawSetSelectable(MenuPlayer[11], 0);
	
	MenuPlayer[12] = TextDrawCreate(435.000000, 247.000000, "_");
	TextDrawAlignment(MenuPlayer[12], 2);
	TextDrawBackgroundColor(MenuPlayer[12], 255);
	TextDrawFont(MenuPlayer[12], 1);
	TextDrawLetterSize(MenuPlayer[12], 0.500000, 1.299999);
	TextDrawColor(MenuPlayer[12], -1);
	TextDrawSetOutline(MenuPlayer[12], 0);
	TextDrawSetProportional(MenuPlayer[12], 1);
	TextDrawSetShadow(MenuPlayer[12], 1);
	TextDrawUseBox(MenuPlayer[12], 1);
	TextDrawBoxColor(MenuPlayer[12], 96);
	TextDrawTextSize(MenuPlayer[12], 6.000000, -125.000000);
	TextDrawSetSelectable(MenuPlayer[12], 0);
	
	MenuPlayer[13] = TextDrawCreate(435.000000, 272.000000, "_");
	TextDrawAlignment(MenuPlayer[13], 2);
	TextDrawBackgroundColor(MenuPlayer[13], 255);
	TextDrawFont(MenuPlayer[13], 1);
	TextDrawLetterSize(MenuPlayer[13], 0.500000, 1.299999);
	TextDrawColor(MenuPlayer[13], -1);
	TextDrawSetOutline(MenuPlayer[13], 0);
	TextDrawSetProportional(MenuPlayer[13], 1);
	TextDrawSetShadow(MenuPlayer[13], 1);
	TextDrawUseBox(MenuPlayer[13], 1);
	TextDrawBoxColor(MenuPlayer[13], 96);
	TextDrawTextSize(MenuPlayer[13], 6.000000, -125.000000);
	TextDrawSetSelectable(MenuPlayer[13], 0);
	
	MenuPlayer[14] = TextDrawCreate(435.000000, 297.000000, "_");
	TextDrawAlignment(MenuPlayer[14], 2);
	TextDrawBackgroundColor(MenuPlayer[14], 255);
	TextDrawFont(MenuPlayer[14], 1);
	TextDrawLetterSize(MenuPlayer[14], 0.500000, 1.299999);
	TextDrawColor(MenuPlayer[14], -1);
	TextDrawSetOutline(MenuPlayer[14], 0);
	TextDrawSetProportional(MenuPlayer[14], 1);
	TextDrawSetShadow(MenuPlayer[14], 1);
	TextDrawUseBox(MenuPlayer[14], 1);
	TextDrawBoxColor(MenuPlayer[14], 96);
	TextDrawTextSize(MenuPlayer[14], 6.000000, -125.000000);
	TextDrawSetSelectable(MenuPlayer[14], 0);
	
	MenuPlayer[15] = TextDrawCreate(377.000000, 170.500000, "Связь_с_администрацией");
	TextDrawBackgroundColor(MenuPlayer[15], 255);
	TextDrawFont(MenuPlayer[15], 2);
	TextDrawLetterSize(MenuPlayer[15], 0.209999, 1.399999);
	TextDrawColor(MenuPlayer[15], -1);
	TextDrawSetOutline(MenuPlayer[15], 0);
	TextDrawSetProportional(MenuPlayer[15], 1);
	TextDrawSetShadow(MenuPlayer[15], 0);
	TextDrawUseBox(MenuPlayer[15], 1);
	TextDrawBoxColor(MenuPlayer[15], 0);
	TextDrawTextSize(MenuPlayer[15], 492.000000, 10.000000);
	TextDrawSetSelectable(MenuPlayer[15], 1);
	
	MenuPlayer[16] = TextDrawCreate(399.000000, 195.500000, "Помощь_по_игре");
	TextDrawBackgroundColor(MenuPlayer[16], 255);
	TextDrawFont(MenuPlayer[16], 2);
	TextDrawLetterSize(MenuPlayer[16], 0.209999, 1.399999);
	TextDrawColor(MenuPlayer[16], -1);
	TextDrawSetOutline(MenuPlayer[16], 0);
	TextDrawSetProportional(MenuPlayer[16], 1);
	TextDrawSetShadow(MenuPlayer[16], 0);
	TextDrawUseBox(MenuPlayer[16], 1);
	TextDrawBoxColor(MenuPlayer[16], 0);
	TextDrawTextSize(MenuPlayer[16], 470.000000, 10.000000);
	TextDrawSetSelectable(MenuPlayer[16], 1);
	
	MenuPlayer[17] = TextDrawCreate(399.000000, 220.500000, "Мои_настройки");
	TextDrawBackgroundColor(MenuPlayer[17], 255);
	TextDrawFont(MenuPlayer[17], 2);
	TextDrawLetterSize(MenuPlayer[17], 0.209999, 1.399999);
	TextDrawColor(MenuPlayer[17], -1);
	TextDrawSetOutline(MenuPlayer[17], 0);
	TextDrawSetProportional(MenuPlayer[17], 1);
	TextDrawSetShadow(MenuPlayer[17], 0);
	TextDrawUseBox(MenuPlayer[17], 1);
	TextDrawBoxColor(MenuPlayer[17], 0);
	TextDrawTextSize(MenuPlayer[17], 469.000000, 10.000000);
	TextDrawSetSelectable(MenuPlayer[17], 1);
	
	MenuPlayer[18] = TextDrawCreate(394.000000, 245.500000, "Команды_сервера");
	TextDrawBackgroundColor(MenuPlayer[18], 255);
	TextDrawFont(MenuPlayer[18], 2);
	TextDrawLetterSize(MenuPlayer[18], 0.209999, 1.399999);
	TextDrawColor(MenuPlayer[18], -1);
	TextDrawSetOutline(MenuPlayer[18], 0);
	TextDrawSetProportional(MenuPlayer[18], 1);
	TextDrawSetShadow(MenuPlayer[18], 0);
	TextDrawUseBox(MenuPlayer[18], 1);
	TextDrawBoxColor(MenuPlayer[18], 0);
	TextDrawTextSize(MenuPlayer[18], 475.000000, 10.000000);
	TextDrawSetSelectable(MenuPlayer[18], 1);
	
	MenuPlayer[19] = TextDrawCreate( 407.000000, 270.500000, "Статистика" );
	TextDrawBackgroundColor(MenuPlayer[19], 255);
	TextDrawFont(MenuPlayer[19], 2);
	TextDrawLetterSize(MenuPlayer[19], 0.209999, 1.399999);
	TextDrawColor(MenuPlayer[19], -1);
	TextDrawSetOutline(MenuPlayer[19], 0);
	TextDrawSetProportional(MenuPlayer[19], 1);
	TextDrawSetShadow(MenuPlayer[19], 0);
	TextDrawUseBox(MenuPlayer[19], 1);
	TextDrawBoxColor(MenuPlayer[19], 0);
	TextDrawTextSize(MenuPlayer[19], 488.000000, 10.000000);
	TextDrawSetSelectable(MenuPlayer[19], 1);
	
	MenuPlayer[20] = TextDrawCreate( 416.000000, 295.500000, "Магазин" );
	TextDrawBackgroundColor(MenuPlayer[20], 255);
	TextDrawFont(MenuPlayer[20], 2);
	TextDrawLetterSize(MenuPlayer[20], 0.209999, 1.399999);
	TextDrawColor(MenuPlayer[20], -1);
	TextDrawSetOutline(MenuPlayer[20], 0);
	TextDrawSetProportional(MenuPlayer[20], 1);
	TextDrawSetShadow(MenuPlayer[20], 0);
	TextDrawUseBox(MenuPlayer[20], 1);
	TextDrawBoxColor(MenuPlayer[20], 0);
	TextDrawTextSize(MenuPlayer[20], 449.000000, 10.000000);
	TextDrawSetSelectable(MenuPlayer[20], 1);
	
	/* PhoneFonOne
	phoneFonOne[0] = TextDrawCreate(593.000000, 235.000000, "_");TextDrawBackgroundColor(phoneFonOne[0], 0x7c7a83AA);TextDrawFont(phoneFonOne[0], 1);TextDrawLetterSize(phoneFonOne[0], 0.500000, 20.300003);
    TextDrawColor(phoneFonOne[0], -1);TextDrawSetOutline(phoneFonOne[0], 0);TextDrawSetProportional(phoneFonOne[0], 1);TextDrawSetShadow(phoneFonOne[0], 1);
    TextDrawUseBox(phoneFonOne[0], 1);TextDrawBoxColor(phoneFonOne[0], 0x7c7a83FF);TextDrawTextSize(phoneFonOne[0], 511.000000, -88.000000);TextDrawSetSelectable(phoneFonOne[0], 0);
	
	phoneFonOne[1] = TextDrawCreate(593.000000, 235.000000, "_");TextDrawBackgroundColor(phoneFonOne[1], 0x064607AA);TextDrawFont(phoneFonOne[1], 1);TextDrawLetterSize(phoneFonOne[1], 0.500000, 20.300003);
    TextDrawColor(phoneFonOne[1], -1);TextDrawSetOutline(phoneFonOne[1], 0);TextDrawSetProportional(phoneFonOne[1], 1);TextDrawSetShadow(phoneFonOne[1], 1);
    TextDrawUseBox(phoneFonOne[1], 1);TextDrawBoxColor(phoneFonOne[1], 0x064607FF);TextDrawTextSize(phoneFonOne[1], 511.000000, -88.000000);TextDrawSetSelectable(phoneFonOne[1], 0);
	
	phoneFonOne[2] = TextDrawCreate(593.000000, 235.000000, "_");TextDrawBackgroundColor(phoneFonOne[2], 0x02133cAA);TextDrawFont(phoneFonOne[2], 1);TextDrawLetterSize(phoneFonOne[2], 0.500000, 20.300003);
    TextDrawColor(phoneFonOne[2], -1);TextDrawSetOutline(phoneFonOne[2], 0);TextDrawSetProportional(phoneFonOne[2], 1);TextDrawSetShadow(phoneFonOne[2], 1);
    TextDrawUseBox(phoneFonOne[2], 1);TextDrawBoxColor(phoneFonOne[2], 0x02133cFF);TextDrawTextSize(phoneFonOne[2], 511.000000, -88.000000);TextDrawSetSelectable(phoneFonOne[2], 0);
	// PhoneFonTwo
	phoneFonTwo[0] = TextDrawCreate(593.500000, 274.000000, "_");TextDrawBackgroundColor(phoneFonTwo[0], 0xa360a8AA);TextDrawFont(phoneFonTwo[0], 1);TextDrawLetterSize(phoneFonTwo[0], 0.490000, 15.799999);
	TextDrawColor(phoneFonTwo[0], -1);TextDrawSetOutline(phoneFonTwo[0], 0);TextDrawSetProportional(phoneFonTwo[0], 1);TextDrawSetShadow(phoneFonTwo[0], 1);
	TextDrawUseBox(phoneFonTwo[0], 1);TextDrawBoxColor(phoneFonTwo[0], 0xa360a8FF);TextDrawTextSize(phoneFonTwo[0], 513.000000, 0.000000);TextDrawSetSelectable(phoneFonTwo[0], 0);
	
	phoneFonTwo[1] = TextDrawCreate(593.500000, 274.000000, "_");TextDrawBackgroundColor(phoneFonTwo[1], 0x900e0eAA);TextDrawFont(phoneFonTwo[1], 1);TextDrawLetterSize(phoneFonTwo[1], 0.490000, 15.799999);
	TextDrawColor(phoneFonTwo[1], -1);TextDrawSetOutline(phoneFonTwo[1], 0);TextDrawSetProportional(phoneFonTwo[1], 1);TextDrawSetShadow(phoneFonTwo[1], 1);
	TextDrawUseBox(phoneFonTwo[1], 1);TextDrawBoxColor(phoneFonTwo[1], 0x900e0eFF);TextDrawTextSize(phoneFonTwo[1], 513.000000, 0.000000);TextDrawSetSelectable(phoneFonTwo[1], 0);
	
	phoneFonTwo[2] = TextDrawCreate(593.500000, 274.000000, "_");TextDrawBackgroundColor(phoneFonTwo[2], 0x2e5279AA);TextDrawFont(phoneFonTwo[2], 1);TextDrawLetterSize(phoneFonTwo[2], 0.490000, 15.799999);
	TextDrawColor(phoneFonTwo[2], -1);TextDrawSetOutline(phoneFonTwo[2], 0);TextDrawSetProportional(phoneFonTwo[2], 1);TextDrawSetShadow(phoneFonTwo[2], 1);
	TextDrawUseBox(phoneFonTwo[2], 1);TextDrawBoxColor(phoneFonTwo[2], 0x2e5279FF);TextDrawTextSize(phoneFonTwo[2], 513.000000, 0.000000);TextDrawSetSelectable(phoneFonTwo[2], 0);
	// PhoneFonThree
	phoneFonThree[0] = TextDrawCreate(610.000000, 212.300003, "_");TextDrawBackgroundColor(phoneFonThree[0], 0xb06a05AA);TextDrawFont(phoneFonThree[0], 1);TextDrawLetterSize(phoneFonThree[0], 0.500000, 22.899999);TextDrawColor(phoneFonThree[0], -1);
	TextDrawSetOutline(phoneFonThree[0], 0);TextDrawSetProportional(phoneFonThree[0], 1);TextDrawSetShadow(phoneFonThree[0], 1);
	TextDrawUseBox(phoneFonThree[0], 1);TextDrawBoxColor(phoneFonThree[0], 0xb06a05FF);TextDrawTextSize(phoneFonThree[0], 495.000000, 21.000000);TextDrawSetSelectable(phoneFonThree[0], 0);
	
	phoneFonThree[1] = TextDrawCreate(610.000000, 212.300003, "_");TextDrawBackgroundColor(phoneFonThree[1], 0x4b4a4dAA);TextDrawFont(phoneFonThree[1], 1);TextDrawLetterSize(phoneFonThree[1], 0.500000, 22.899999);TextDrawColor(phoneFonThree[1], -1);
	TextDrawSetOutline(phoneFonThree[1], 0);TextDrawSetProportional(phoneFonThree[1], 1);TextDrawSetShadow(phoneFonThree[1], 1);
	TextDrawUseBox(phoneFonThree[1], 1);TextDrawBoxColor(phoneFonThree[1], 0x4b4a4dFF);TextDrawTextSize(phoneFonThree[1], 495.000000, 21.000000);TextDrawSetSelectable(phoneFonThree[1], 0);
	
	phoneFonThree[2] = TextDrawCreate(610.000000, 212.300003, "_");TextDrawBackgroundColor(phoneFonThree[2], 0x9b3100AA);TextDrawFont(phoneFonThree[2], 1);TextDrawLetterSize(phoneFonThree[2], 0.500000, 22.899999);TextDrawColor(phoneFonThree[2], -1);
	TextDrawSetOutline(phoneFonThree[2], 0);TextDrawSetProportional(phoneFonThree[2], 1);TextDrawSetShadow(phoneFonThree[2], 1);
	TextDrawUseBox(phoneFonThree[2], 1);TextDrawBoxColor(phoneFonThree[2], 0x9b3100FF);TextDrawTextSize(phoneFonThree[2], 495.000000, 21.000000);TextDrawSetSelectable(phoneFonThree[2], 0);
	//
	
    phoneOne[1] = TextDrawCreate(528.000000, 401.000000, ".");TextDrawAlignment(phoneOne[1], 2);TextDrawBackgroundColor(phoneOne[1], 255);TextDrawFont(phoneOne[1], 2);TextDrawLetterSize(phoneOne[1], 0.500000, 1.299998);
    TextDrawColor(phoneOne[1], -1);TextDrawSetOutline(phoneOne[1], 0);TextDrawSetProportional(phoneOne[1], 1);TextDrawSetShadow(phoneOne[1], 0);
    TextDrawUseBox(phoneOne[1], 1);TextDrawBoxColor(phoneOne[1], -707407072);TextDrawTextSize(phoneOne[1], 0.000000, -25.000000);TextDrawSetSelectable(phoneOne[1], 0);
    phoneOne[2] = TextDrawCreate(552.000000, 401.000000, "0");TextDrawAlignment(phoneOne[2], 2);TextDrawBackgroundColor(phoneOne[2], 255);TextDrawFont(phoneOne[2], 2);
    TextDrawLetterSize(phoneOne[2], 0.500000, 1.299998);TextDrawColor(phoneOne[2], -1);TextDrawSetOutline(phoneOne[2], 0);TextDrawSetProportional(phoneOne[2], 1);TextDrawSetShadow(phoneOne[2], 0);
    TextDrawUseBox(phoneOne[2], 1);TextDrawBoxColor(phoneOne[2], -707407072);TextDrawTextSize(phoneOne[2], 0.000000, -25.000000);TextDrawSetSelectable(phoneOne[2], 0);
    phoneOne[3] = TextDrawCreate(576.000000, 401.000000, "#");TextDrawAlignment(phoneOne[3], 2);TextDrawBackgroundColor(phoneOne[3], 255);TextDrawFont(phoneOne[3], 1);
    TextDrawLetterSize(phoneOne[3], 0.500000, 1.299998);TextDrawColor(phoneOne[3], -1);TextDrawSetOutline(phoneOne[3], 0);TextDrawSetProportional(phoneOne[3], 1);TextDrawSetShadow(phoneOne[3], 0);
    TextDrawUseBox(phoneOne[3], 1);TextDrawBoxColor(phoneOne[3], -707407072);TextDrawTextSize(phoneOne[3], 0.000000, -25.000000);TextDrawSetSelectable(phoneOne[3], 0);
    phoneOne[4] = TextDrawCreate(528.000000, 382.000000, "7");TextDrawAlignment(phoneOne[4], 2);TextDrawBackgroundColor(phoneOne[4], 255);TextDrawFont(phoneOne[4], 2);
    TextDrawLetterSize(phoneOne[4], 0.500000, 1.299998);TextDrawColor(phoneOne[4], -1);TextDrawSetOutline(phoneOne[4], 0);TextDrawSetProportional(phoneOne[4], 1);TextDrawSetShadow(phoneOne[4], 0);
    TextDrawUseBox(phoneOne[4], 1);TextDrawBoxColor(phoneOne[4], -707407072);TextDrawTextSize(phoneOne[4], 0.000000, -25.000000);TextDrawSetSelectable(phoneOne[4], 0);
    phoneOne[5] = TextDrawCreate(552.000000, 382.000000, "8");TextDrawAlignment(phoneOne[5], 2);TextDrawBackgroundColor(phoneOne[5], 255);TextDrawFont(phoneOne[5], 2);TextDrawLetterSize(phoneOne[5], 0.500000, 1.299998);
    TextDrawColor(phoneOne[5], -1);TextDrawSetOutline(phoneOne[5], 0);TextDrawSetProportional(phoneOne[5], 1);TextDrawSetShadow(phoneOne[5], 0);
    TextDrawUseBox(phoneOne[5], 1);TextDrawBoxColor(phoneOne[5], -707407072);TextDrawTextSize(phoneOne[5], 0.000000, -25.000000);TextDrawSetSelectable(phoneOne[5], 0);
    phoneOne[6] = TextDrawCreate(576.000000, 382.000000, "9");TextDrawAlignment(phoneOne[6], 2);TextDrawBackgroundColor(phoneOne[6], 255);TextDrawFont(phoneOne[6], 2);TextDrawLetterSize(phoneOne[6], 0.500000, 1.299998);
    TextDrawColor(phoneOne[6], -1);TextDrawSetOutline(phoneOne[6], 0);TextDrawSetProportional(phoneOne[6], 1);TextDrawSetShadow(phoneOne[6], 0);
    TextDrawUseBox(phoneOne[6], 1);TextDrawBoxColor(phoneOne[6], -707407072);TextDrawTextSize(phoneOne[6], 0.000000, -25.000000);TextDrawSetSelectable(phoneOne[6], 0);
    phoneOne[7] = TextDrawCreate(528.000000, 362.500000, "4");TextDrawAlignment(phoneOne[7], 2);TextDrawBackgroundColor(phoneOne[7], 255);TextDrawFont(phoneOne[7], 2);TextDrawLetterSize(phoneOne[7], 0.500000, 1.299998);
    TextDrawColor(phoneOne[7], -1);TextDrawSetOutline(phoneOne[7], 0);TextDrawSetProportional(phoneOne[7], 1);TextDrawSetShadow(phoneOne[7], 0);
    TextDrawUseBox(phoneOne[7], 1);TextDrawBoxColor(phoneOne[7], -707407072);TextDrawTextSize(phoneOne[7], 0.000000, -25.000000);TextDrawSetSelectable(phoneOne[7], 0);
    phoneOne[8] = TextDrawCreate(552.000000, 362.500000, "5");TextDrawAlignment(phoneOne[8], 2);TextDrawBackgroundColor(phoneOne[8], 255);TextDrawFont(phoneOne[8], 2);
    TextDrawLetterSize(phoneOne[8], 0.500000, 1.299998);TextDrawColor(phoneOne[8], -1);TextDrawSetOutline(phoneOne[8], 0);TextDrawSetProportional(phoneOne[8], 1);TextDrawSetShadow(phoneOne[8], 0);
    TextDrawUseBox(phoneOne[8], 1);TextDrawBoxColor(phoneOne[8], -707407072);TextDrawTextSize(phoneOne[8], 0.000000, -25.000000);TextDrawSetSelectable(phoneOne[8], 0);
    phoneOne[9] = TextDrawCreate(576.000000, 362.500000, "6");TextDrawAlignment(phoneOne[9], 2);TextDrawBackgroundColor(phoneOne[9], 255);TextDrawFont(phoneOne[9], 2);
    TextDrawLetterSize(phoneOne[9], 0.500000, 1.299998);TextDrawColor(phoneOne[9], -1);TextDrawSetOutline(phoneOne[9], 0);TextDrawSetProportional(phoneOne[9], 1);TextDrawSetShadow(phoneOne[9], 0);
    TextDrawUseBox(phoneOne[9], 1);TextDrawBoxColor(phoneOne[9], -707407072);TextDrawTextSize(phoneOne[9], 0.000000, -25.000000);TextDrawSetSelectable(phoneOne[9], 0);
    phoneOne[10] = TextDrawCreate(576.000000, 343.500000, "3");TextDrawAlignment(phoneOne[10], 2);TextDrawBackgroundColor(phoneOne[10], 255);TextDrawFont(phoneOne[10], 2);
    TextDrawLetterSize(phoneOne[10], 0.500000, 1.299998);TextDrawColor(phoneOne[10], -1);TextDrawSetOutline(phoneOne[10], 0);TextDrawSetProportional(phoneOne[10], 1);
    TextDrawSetShadow(phoneOne[10], 0);TextDrawUseBox(phoneOne[10], 1);TextDrawBoxColor(phoneOne[10], -707407072);TextDrawTextSize(phoneOne[10], 0.000000, -25.000000);TextDrawSetSelectable(phoneOne[10], 0);
    phoneOne[11] = TextDrawCreate(552.000000, 343.500000, "2");TextDrawAlignment(phoneOne[11], 2);TextDrawBackgroundColor(phoneOne[11], 255);TextDrawFont(phoneOne[11], 2);TextDrawLetterSize(phoneOne[11], 0.500000, 1.299998);
    TextDrawColor(phoneOne[11], -1);TextDrawSetOutline(phoneOne[11], 0);TextDrawSetProportional(phoneOne[11], 1);TextDrawSetShadow(phoneOne[11], 0);
    TextDrawUseBox(phoneOne[11], 1);TextDrawBoxColor(phoneOne[11], -707407072);TextDrawTextSize(phoneOne[11], 0.000000, -25.000000);TextDrawSetSelectable(phoneOne[11], 0);
    phoneOne[12] = TextDrawCreate(528.000000, 343.500000, "1");TextDrawAlignment(phoneOne[12], 2);TextDrawBackgroundColor(phoneOne[12], 255);TextDrawFont(phoneOne[12], 2);
    TextDrawLetterSize(phoneOne[12], 0.500000, 1.299998);TextDrawColor(phoneOne[12], -1);TextDrawSetOutline(phoneOne[12], 0);TextDrawSetProportional(phoneOne[12], 1);TextDrawSetShadow(phoneOne[12], 0);
    TextDrawUseBox(phoneOne[12], 1);TextDrawBoxColor(phoneOne[12], -707407072);TextDrawTextSize(phoneOne[12], 0.000000, -25.000000);TextDrawSetSelectable(phoneOne[12], 0);
    phoneOne[13] = TextDrawCreate(588.500000, 240.000000, "_");TextDrawBackgroundColor(phoneOne[13], 255);TextDrawFont(phoneOne[13], 1);
    TextDrawLetterSize(phoneOne[13], 0.500000, 10.600006);TextDrawColor(phoneOne[13], -1);TextDrawSetOutline(phoneOne[13], 0);TextDrawSetProportional(phoneOne[13], 1);TextDrawSetShadow(phoneOne[13], 1);
    TextDrawUseBox(phoneOne[13], 1);TextDrawBoxColor(phoneOne[13], -1);TextDrawTextSize(phoneOne[13], 515.000000, 0.000000);TextDrawSetSelectable(phoneOne[13], 0);
    phoneOne[14] = TextDrawCreate(588.500000, 240.000000, "_");TextDrawBackgroundColor(phoneOne[14], 255);TextDrawFont(phoneOne[14], 1);
    TextDrawLetterSize(phoneOne[14], 0.500000, 0.199999);TextDrawColor(phoneOne[14], -1);TextDrawSetOutline(phoneOne[14], 0);TextDrawSetProportional(phoneOne[14], 1);
    TextDrawSetShadow(phoneOne[14], 1);TextDrawUseBox(phoneOne[14], 1);TextDrawBoxColor(phoneOne[14], 1010580624);TextDrawTextSize(phoneOne[14], 515.000000, 0.000000);TextDrawSetSelectable(phoneOne[14], 0);
    phoneOne[15] = TextDrawCreate(586.000000, 237.000000, "sa-telecom");TextDrawAlignment(phoneOne[15], 3);TextDrawBackgroundColor(phoneOne[15], 255);TextDrawFont(phoneOne[15], 2);TextDrawLetterSize(phoneOne[15], 0.109999, 0.799998);TextDrawColor(phoneOne[15], -1);
    TextDrawSetOutline(phoneOne[15], 0);TextDrawSetProportional(phoneOne[15], 1);TextDrawSetShadow(phoneOne[15], 0);TextDrawSetSelectable(phoneOne[15], 0);
    phoneOne[16] = TextDrawCreate(524.000000, 244.000000, "00:00");TextDrawBackgroundColor(phoneOne[16], 255);TextDrawFont(phoneOne[16], 2);TextDrawLetterSize(phoneOne[16], 0.500000, 2.000000);TextDrawColor(phoneOne[16], 255);
    TextDrawSetOutline(phoneOne[16], 0);TextDrawSetProportional(phoneOne[16], 1);TextDrawSetShadow(phoneOne[16], 0);TextDrawSetSelectable(phoneOne[16], 0);
    phoneOne[17] = TextDrawCreate(552.000000, 267.500000, "_");TextDrawAlignment(phoneOne[17], 2);TextDrawBackgroundColor(phoneOne[17], 255);TextDrawFont(phoneOne[17], 2);
    TextDrawLetterSize(phoneOne[17], 0.209999, 0.899999);TextDrawColor(phoneOne[17], -1);TextDrawSetOutline(phoneOne[17], 0);TextDrawSetProportional(phoneOne[17], 1);TextDrawSetShadow(phoneOne[17], 0);
    TextDrawUseBox(phoneOne[17], 1);TextDrawBoxColor(phoneOne[17], 1010580624);TextDrawTextSize(phoneOne[17], 0.000000, -67.000000);TextDrawSetSelectable(phoneOne[17], 1);
    phoneOne[18] = TextDrawCreate(552.000000, 281.500000, "_");TextDrawAlignment(phoneOne[18], 2);TextDrawBackgroundColor(phoneOne[18], 255);TextDrawFont(phoneOne[18], 2);
    TextDrawLetterSize(phoneOne[18], 0.209999, 0.899999);TextDrawColor(phoneOne[18], -1);TextDrawSetOutline(phoneOne[18], 0);TextDrawSetProportional(phoneOne[18], 1);TextDrawSetShadow(phoneOne[18], 0);
    TextDrawUseBox(phoneOne[18], 1);TextDrawBoxColor(phoneOne[18], 1010580624);TextDrawTextSize(phoneOne[18], 0.000000, -67.000000);TextDrawSetSelectable(phoneOne[18], 1);
    phoneOne[19] = TextDrawCreate(552.000000, 295.500000, "_");TextDrawAlignment(phoneOne[19], 2);TextDrawBackgroundColor(phoneOne[19], 255);TextDrawFont(phoneOne[19], 2);
    TextDrawLetterSize(phoneOne[19], 0.209999, 0.899999);TextDrawColor(phoneOne[19], -1);TextDrawSetOutline(phoneOne[19], 0);TextDrawSetProportional(phoneOne[19], 1);
    TextDrawSetShadow(phoneOne[19], 0);TextDrawUseBox(phoneOne[19], 1);TextDrawBoxColor(phoneOne[19], 1010580624);TextDrawTextSize(phoneOne[19], 0.000000, -67.000000);TextDrawSetSelectable(phoneOne[19], 1);
    phoneOne[20] = TextDrawCreate(552.000000, 309.500000, "_");TextDrawAlignment(phoneOne[20], 2);TextDrawBackgroundColor(phoneOne[20], 255);TextDrawFont(phoneOne[20], 2);TextDrawLetterSize(phoneOne[20], 0.209999, 0.899999);
    TextDrawColor(phoneOne[20], -1);TextDrawSetOutline(phoneOne[20], 0);TextDrawSetProportional(phoneOne[20], 1);TextDrawSetShadow(phoneOne[20], 0);
    TextDrawUseBox(phoneOne[20], 1);TextDrawBoxColor(phoneOne[20], 1010580624);TextDrawTextSize(phoneOne[20], 0.000000, -67.000000);TextDrawSetSelectable(phoneOne[20], 1);
    phoneOne[21] = TextDrawCreate(552.000000, 323.500000, "_");TextDrawAlignment(phoneOne[21], 2);TextDrawBackgroundColor(phoneOne[21], 255);TextDrawFont(phoneOne[21], 2);
    TextDrawLetterSize(phoneOne[21], 0.189999, 0.899999);TextDrawColor(phoneOne[21], -1);TextDrawSetOutline(phoneOne[21], 0);TextDrawSetProportional(phoneOne[21], 1);TextDrawSetShadow(phoneOne[21], 0);
    TextDrawUseBox(phoneOne[21], 1);TextDrawBoxColor(phoneOne[21], 1010580624);TextDrawTextSize(phoneOne[21], 0.000000, -67.000000);TextDrawSetSelectable(phoneOne[21], 1);
    phoneOne[22] = TextDrawCreate(545.000000, 237.000000, "00/00/0000");TextDrawAlignment(phoneOne[22], 3);TextDrawBackgroundColor(phoneOne[22], 255);TextDrawFont(phoneOne[22], 2);TextDrawLetterSize(phoneOne[22], 0.109999, 0.799998);TextDrawColor(phoneOne[22], -1);
    TextDrawSetOutline(phoneOne[22], 0);TextDrawSetProportional(phoneOne[22], 1);TextDrawSetShadow(phoneOne[22], 0);TextDrawSetSelectable(phoneOne[22], 0);
    phoneOne[23] = TextDrawCreate(532.000000, 265.000000, "Контакты");TextDrawBackgroundColor(phoneOne[23], 255);TextDrawFont(phoneOne[23], 2);TextDrawLetterSize(phoneOne[23], 0.180000, 1.299999);
    TextDrawColor(phoneOne[23], -1);TextDrawSetOutline(phoneOne[23], 0);TextDrawSetProportional(phoneOne[23], 1);TextDrawSetShadow(phoneOne[23], 0);
    TextDrawUseBox(phoneOne[23], 1);TextDrawBoxColor(phoneOne[23], 0);TextDrawTextSize(phoneOne[23], 571.000000, 10.000000);TextDrawSetSelectable(phoneOne[23], 1);
    phoneOne[24] = TextDrawCreate(530.000000, 279.000000, "Настройки");TextDrawBackgroundColor(phoneOne[24], 255);TextDrawFont(phoneOne[24], 2);TextDrawLetterSize(phoneOne[24], 0.180000, 1.299999);
    TextDrawColor(phoneOne[24], -1);TextDrawSetOutline(phoneOne[24], 0);TextDrawSetProportional(phoneOne[24], 1);TextDrawSetShadow(phoneOne[24], 0);
    TextDrawUseBox(phoneOne[24], 1);TextDrawBoxColor(phoneOne[24], 0);TextDrawTextSize(phoneOne[24], 573.000000, 10.000000);TextDrawSetSelectable(phoneOne[24], 1);
    phoneOne[25] = TextDrawCreate(530.000000, 293.000000, "Сообщения");TextDrawBackgroundColor(phoneOne[25], 255);TextDrawFont(phoneOne[25], 2);TextDrawLetterSize(phoneOne[25], 0.180000, 1.299999);
    TextDrawColor(phoneOne[25], -1);TextDrawSetOutline(phoneOne[25], 0);TextDrawSetProportional(phoneOne[25], 1);TextDrawSetShadow(phoneOne[25], 0);
    TextDrawUseBox(phoneOne[25], 1);TextDrawBoxColor(phoneOne[25], 0);TextDrawTextSize(phoneOne[25], 573.000000, 10.000000);TextDrawSetSelectable(phoneOne[25], 1);
    phoneOne[26] = TextDrawCreate(530.000000, 307.000000, "Набр.Hомер");TextDrawBackgroundColor(phoneOne[26], 255);TextDrawFont(phoneOne[26], 2);TextDrawLetterSize(phoneOne[26], 0.180000, 1.299999);
    TextDrawColor(phoneOne[26], -1);TextDrawSetOutline(phoneOne[26], 0);TextDrawSetProportional(phoneOne[26], 1);TextDrawSetShadow(phoneOne[26], 0);
    TextDrawUseBox(phoneOne[26], 1);TextDrawBoxColor(phoneOne[26], 0);TextDrawTextSize(phoneOne[26], 574.000000, 10.000000);TextDrawSetSelectable(phoneOne[26], 1);
    phoneOne[27] = TextDrawCreate(526.000000, 321.000000, "Убр.Телефон");TextDrawBackgroundColor(phoneOne[27], 255);TextDrawFont(phoneOne[27], 2);TextDrawLetterSize(phoneOne[27], 0.180000, 1.299999);
    TextDrawColor(phoneOne[27], -1);TextDrawSetOutline(phoneOne[27], 0);TextDrawSetProportional(phoneOne[27], 1);TextDrawSetShadow(phoneOne[27], 0);
    TextDrawUseBox(phoneOne[27], 1);TextDrawBoxColor(phoneOne[27], 0);TextDrawTextSize(phoneOne[27], 580.000000, 10.000000);TextDrawSetSelectable(phoneOne[27], 1);
	// Phone Two
	phoneTwo[1] = TextDrawCreate(545.000000, 397.000000, "|");
	TextDrawBackgroundColor(phoneTwo[1], 255);TextDrawFont(phoneTwo[1], 2);TextDrawLetterSize(phoneTwo[1], 1.000000, 3.299998);TextDrawColor(phoneTwo[1], -1);TextDrawSetOutline(phoneTwo[1], 0);TextDrawSetProportional(phoneTwo[1], 1);TextDrawSetShadow(phoneTwo[1], 0);TextDrawSetSelectable(phoneTwo[1], 0);
	phoneTwo[2] = TextDrawCreate(553.000000, 281.000000, "_");TextDrawAlignment(phoneTwo[2], 2);TextDrawBackgroundColor(phoneTwo[2], 255);TextDrawFont(phoneTwo[2], 1);TextDrawLetterSize(phoneTwo[2], 0.500000, 13.099995);
	TextDrawColor(phoneTwo[2], -1);TextDrawSetOutline(phoneTwo[2], 0);TextDrawSetProportional(phoneTwo[2], 1);TextDrawSetShadow(phoneTwo[2], 1);
	TextDrawUseBox(phoneTwo[2], 1);TextDrawBoxColor(phoneTwo[2], -1);TextDrawTextSize(phoneTwo[2], 506.000000, -72.000000);TextDrawSetSelectable(phoneTwo[2], 0);
	phoneTwo[3] = TextDrawCreate(522.000000, 387.000000, "~g~-");TextDrawBackgroundColor(phoneTwo[3], 255);TextDrawFont(phoneTwo[3], 1);TextDrawLetterSize(phoneTwo[3], 1.799999, 4.000000);TextDrawColor(phoneTwo[3], -1);
	TextDrawSetOutline(phoneTwo[3], 0);TextDrawSetProportional(phoneTwo[3], 1);TextDrawSetShadow(phoneTwo[3], 0);TextDrawSetSelectable(phoneTwo[3], 0);
	phoneTwo[4] = TextDrawCreate(565.000000, 387.000000, "~r~-");TextDrawBackgroundColor(phoneTwo[4], 255);TextDrawFont(phoneTwo[4], 1);TextDrawLetterSize(phoneTwo[4], 1.799999, 4.000000);TextDrawColor(phoneTwo[4], -1);TextDrawSetOutline(phoneTwo[4], 0);
	TextDrawSetProportional(phoneTwo[4], 1);TextDrawSetShadow(phoneTwo[4], 0);TextDrawSetSelectable(phoneTwo[4], 0);
	phoneTwo[5] = TextDrawCreate(553.000000, 276.000000, "_");TextDrawAlignment(phoneTwo[5], 2);TextDrawBackgroundColor(phoneTwo[5], 255);TextDrawFont(phoneTwo[5], 1);TextDrawLetterSize(phoneTwo[5], 0.500000, -0.300000);
	TextDrawColor(phoneTwo[5], -1);TextDrawSetOutline(phoneTwo[5], 0);TextDrawSetProportional(phoneTwo[5], 1);TextDrawSetShadow(phoneTwo[5], 1);
	TextDrawUseBox(phoneTwo[5], 1);TextDrawBoxColor(phoneTwo[5], 1010580560);TextDrawTextSize(phoneTwo[5], 0.000000, -40.000000);TextDrawSetSelectable(phoneTwo[5], 0);
	phoneTwo[6] = TextDrawCreate(589.000000, 281.000000, "_");TextDrawBackgroundColor(phoneTwo[6], 255);TextDrawFont(phoneTwo[6], 1);TextDrawLetterSize(phoneTwo[6], 0.500000, 0.199999);
	TextDrawColor(phoneTwo[6], -1);TextDrawSetOutline(phoneTwo[6], 0);TextDrawSetProportional(phoneTwo[6], 1);TextDrawSetShadow(phoneTwo[6], 1);
	TextDrawUseBox(phoneTwo[6], 1);TextDrawBoxColor(phoneTwo[6], 1010580624);TextDrawTextSize(phoneTwo[6], 517.000000, -6.000000);TextDrawSetSelectable(phoneTwo[6], 0);
	phoneTwo[7] = TextDrawCreate(521.000000, 277.500000, "SA-TELECOM");TextDrawBackgroundColor(phoneTwo[7], 255);
	TextDrawFont(phoneTwo[7], 2);TextDrawLetterSize(phoneTwo[7], 0.119999, 0.799998);TextDrawColor(phoneTwo[7], -1);TextDrawSetOutline(phoneTwo[7], 0);
	TextDrawSetProportional(phoneTwo[7], 1);TextDrawSetShadow(phoneTwo[7], 0);TextDrawSetSelectable(phoneTwo[7], 0);
	phoneTwo[8] = TextDrawCreate(523.000000, 289.000000, "callFon");TextDrawAlignment(phoneTwo[8], 2);TextDrawBackgroundColor(phoneTwo[8], 1182971135);TextDrawFont(phoneTwo[8], 5);
	TextDrawLetterSize(phoneTwo[8], 0.259999, 2.899998);TextDrawColor(phoneTwo[8], -1);TextDrawSetOutline(phoneTwo[8], 0);TextDrawSetProportional(phoneTwo[8], 1);
	TextDrawSetShadow(phoneTwo[8], 0);TextDrawUseBox(phoneTwo[8], 1);TextDrawBoxColor(phoneTwo[8], 0);TextDrawTextSize(phoneTwo[8], 28.000000, 31.000000);
	TextDrawSetPreviewModel(phoneTwo[8], 11111111);TextDrawSetPreviewRot(phoneTwo[8], -16.000000, 0.000000, -55.000000, 1000.000000);TextDrawSetSelectable(phoneTwo[8], 1);
	phoneTwo[9] = TextDrawCreate(555.000000, 326.000000, "settingsFon");TextDrawAlignment(phoneTwo[9], 2);TextDrawBackgroundColor(phoneTwo[9], 1182971135);
	TextDrawFont(phoneTwo[9], 5);TextDrawLetterSize(phoneTwo[9], 0.259999, 2.899998);TextDrawColor(phoneTwo[9], -1);TextDrawSetOutline(phoneTwo[9], 0);
	TextDrawSetProportional(phoneTwo[9], 1);TextDrawSetShadow(phoneTwo[9], 0);TextDrawUseBox(phoneTwo[9], 1);TextDrawBoxColor(phoneTwo[9], 0);
	TextDrawTextSize(phoneTwo[9], 28.000000, 31.000000);TextDrawSetPreviewModel(phoneTwo[9], 11111111);TextDrawSetPreviewRot(phoneTwo[9], -16.000000, 0.000000, -55.000000, 1000.000000);TextDrawSetSelectable(phoneTwo[9], 1);
	phoneTwo[10] = TextDrawCreate(523.000000, 326.000000, "messageFon");TextDrawAlignment(phoneTwo[10], 2);TextDrawBackgroundColor(phoneTwo[10], 1182971135);
	TextDrawFont(phoneTwo[10], 5);TextDrawLetterSize(phoneTwo[10], 0.259999, 2.899998);TextDrawColor(phoneTwo[10], -1);TextDrawSetOutline(phoneTwo[10], 0);
	TextDrawSetProportional(phoneTwo[10], 1);TextDrawSetShadow(phoneTwo[10], 0);TextDrawUseBox(phoneTwo[10], 1);TextDrawBoxColor(phoneTwo[10], 0);
	TextDrawTextSize(phoneTwo[10], 28.000000, 31.000000);TextDrawSetPreviewModel(phoneTwo[10], 11111111);TextDrawSetPreviewRot(phoneTwo[10], -16.000000, 0.000000, -55.000000, 1000.000000);TextDrawSetSelectable(phoneTwo[10], 1);
	phoneTwo[11] = TextDrawCreate(555.000000, 362.000000, "contactsFon");TextDrawAlignment(phoneTwo[11], 2);TextDrawBackgroundColor(phoneTwo[11], 1182971135);
	TextDrawFont(phoneTwo[11], 5);TextDrawLetterSize(phoneTwo[11], 0.259999, 2.899998);TextDrawColor(phoneTwo[11], -1);TextDrawSetOutline(phoneTwo[11], 0);
	TextDrawSetProportional(phoneTwo[11], 1);TextDrawSetShadow(phoneTwo[11], 0);TextDrawUseBox(phoneTwo[11], 1);TextDrawBoxColor(phoneTwo[11], 0);
	TextDrawTextSize(phoneTwo[11], 28.000000, 31.000000);TextDrawSetPreviewModel(phoneTwo[11], 11111111);TextDrawSetPreviewRot(phoneTwo[11], -16.000000, 0.000000, -55.000000, 1000.000000);TextDrawSetSelectable(phoneTwo[11], 1);
	phoneTwo[12] = TextDrawCreate(523.000000, 362.000000, "offlineFon");TextDrawAlignment(phoneTwo[12], 2);TextDrawBackgroundColor(phoneTwo[12], 1182971135);
	TextDrawFont(phoneTwo[12], 5);TextDrawLetterSize(phoneTwo[12], 0.259999, 2.899998);TextDrawColor(phoneTwo[12], -1);TextDrawSetOutline(phoneTwo[12], 0);
	TextDrawSetProportional(phoneTwo[12], 1);TextDrawSetShadow(phoneTwo[12], 0);TextDrawUseBox(phoneTwo[12], 1);TextDrawBoxColor(phoneTwo[12], 0);
	TextDrawTextSize(phoneTwo[12], 28.000000, 31.000000);TextDrawSetPreviewModel(phoneTwo[12], 11111111);TextDrawSetPreviewRot(phoneTwo[12], -16.000000, 0.000000, -55.000000, 1000.000000);TextDrawSetSelectable(phoneTwo[12], 1);
	phoneTwo[13] = TextDrawCreate(555.000000, 286.000000, "00:00");TextDrawBackgroundColor(phoneTwo[13], 255);TextDrawFont(phoneTwo[13], 2);
	TextDrawLetterSize(phoneTwo[13], 0.250000, 1.600000);TextDrawColor(phoneTwo[13], 255);TextDrawSetOutline(phoneTwo[13], 0);
	TextDrawSetProportional(phoneTwo[13], 1);TextDrawSetShadow(phoneTwo[13], 0);TextDrawSetSelectable(phoneTwo[13], 0);
	phoneTwo[14] = TextDrawCreate(537.000000, 310.000000, "call");TextDrawAlignment(phoneTwo[14], 2);TextDrawBackgroundColor(phoneTwo[14], 255);
	TextDrawFont(phoneTwo[14], 2);TextDrawLetterSize(phoneTwo[14], 0.140000, 0.899999);TextDrawColor(phoneTwo[14], -1);
	TextDrawSetOutline(phoneTwo[14], 0);TextDrawSetProportional(phoneTwo[14], 1);TextDrawSetShadow(phoneTwo[14], 0);TextDrawSetSelectable(phoneTwo[14], 0);
	phoneTwo[15] = TextDrawCreate(537.500000, 347.000000, "message");TextDrawAlignment(phoneTwo[15], 2);TextDrawBackgroundColor(phoneTwo[15], 255);
	TextDrawFont(phoneTwo[15], 2);TextDrawLetterSize(phoneTwo[15], 0.140000, 0.899999);TextDrawColor(phoneTwo[15], -1);
	TextDrawSetOutline(phoneTwo[15], 0);TextDrawSetProportional(phoneTwo[15], 1);TextDrawSetShadow(phoneTwo[15], 0);TextDrawSetSelectable(phoneTwo[15], 0);
	phoneTwo[16] = TextDrawCreate(569.500000, 347.000000, "settings");TextDrawAlignment(phoneTwo[16], 2);TextDrawBackgroundColor(phoneTwo[16], 255);
	TextDrawFont(phoneTwo[16], 2);TextDrawLetterSize(phoneTwo[16], 0.140000, 0.899999);TextDrawColor(phoneTwo[16], -1);
	TextDrawSetOutline(phoneTwo[16], 0);TextDrawSetProportional(phoneTwo[16], 1);TextDrawSetShadow(phoneTwo[16], 0);TextDrawSetSelectable(phoneTwo[16], 0);
	phoneTwo[17] = TextDrawCreate(537.500000, 383.000000, "offline");TextDrawAlignment(phoneTwo[17], 2);TextDrawBackgroundColor(phoneTwo[17], 255);
	TextDrawFont(phoneTwo[17], 2);TextDrawLetterSize(phoneTwo[17], 0.140000, 0.899999);TextDrawColor(phoneTwo[17], -1);
	TextDrawSetOutline(phoneTwo[17], 0);TextDrawSetProportional(phoneTwo[17], 1);TextDrawSetShadow(phoneTwo[17], 0);TextDrawSetSelectable(phoneTwo[17], 0);
	phoneTwo[18] = TextDrawCreate(569.500000, 383.000000, "contacts");TextDrawAlignment(phoneTwo[18], 2);TextDrawBackgroundColor(phoneTwo[18], 255);
	TextDrawFont(phoneTwo[18], 2);TextDrawLetterSize(phoneTwo[18], 0.119998, 0.899999);TextDrawColor(phoneTwo[18], -1);
	TextDrawSetOutline(phoneTwo[18], 0);TextDrawSetProportional(phoneTwo[18], 1);TextDrawSetShadow(phoneTwo[18], 0);TextDrawSetSelectable(phoneTwo[18], 0);
	// Phone Three
	phoneThree[1] = TextDrawCreate(605.000000, 224.000000, "_");TextDrawBackgroundColor(phoneThree[1], 255);TextDrawFont(phoneThree[1], 2);TextDrawLetterSize(phoneThree[1], 0.500000, 19.000000);TextDrawColor(phoneThree[1], -1);
	TextDrawSetOutline(phoneThree[1], 0);TextDrawSetProportional(phoneThree[1], 1);TextDrawSetShadow(phoneThree[1], 1);TextDrawUseBox(phoneThree[1], 1);
	TextDrawBoxColor(phoneThree[1], -1);TextDrawTextSize(phoneThree[1], 500.000000, 200.000000);TextDrawSetSelectable(phoneThree[1], 0);
	phoneThree[2] = TextDrawCreate(502.000000, 195.000000, ".");TextDrawBackgroundColor(phoneThree[2], 255);TextDrawFont(phoneThree[2], 1);
	TextDrawLetterSize(phoneThree[2], 0.699999, 3.000000);TextDrawColor(phoneThree[2], -707407056);TextDrawSetOutline(phoneThree[2], 0);
	TextDrawSetProportional(phoneThree[2], 1);TextDrawSetShadow(phoneThree[2], 0);TextDrawSetSelectable(phoneThree[2], 0);
	phoneThree[3] = TextDrawCreate(548.000000, 397.000000, "|");TextDrawBackgroundColor(phoneThree[3], 255);
	TextDrawFont(phoneThree[3], 2);TextDrawLetterSize(phoneThree[3], 0.699998, 3.199999);TextDrawColor(phoneThree[3], -1);TextDrawSetOutline(phoneThree[3], 0);
	TextDrawSetProportional(phoneThree[3], 1);TextDrawSetShadow(phoneThree[3], 0);TextDrawSetSelectable(phoneThree[3], 0);
	phoneThree[4] = TextDrawCreate(602.500000, 236.500000, "_");TextDrawBackgroundColor(phoneThree[4], 255);TextDrawFont(phoneThree[4], 1);TextDrawLetterSize(phoneThree[4], 0.500000, 4.099998);TextDrawColor(phoneThree[4], -1);
	TextDrawSetOutline(phoneThree[4], 0);TextDrawSetProportional(phoneThree[4], 1);TextDrawSetShadow(phoneThree[4], 1);
	TextDrawUseBox(phoneThree[4], 1);TextDrawBoxColor(phoneThree[4], 1018393087);TextDrawTextSize(phoneThree[4], 503.000000, 12.000000);TextDrawSetSelectable(phoneThree[4], 0);
	phoneThree[5] = TextDrawCreate(509.000000, 231.000000, "00:00");TextDrawBackgroundColor(phoneThree[5], 255);
	TextDrawFont(phoneThree[5], 2);TextDrawLetterSize(phoneThree[5], 0.549998, 3.399997);TextDrawColor(phoneThree[5], -1);TextDrawSetOutline(phoneThree[5], 0);
	TextDrawSetProportional(phoneThree[5], 1);TextDrawSetShadow(phoneThree[5], 0);TextDrawSetSelectable(phoneThree[5], 0);
	phoneThree[6] = TextDrawCreate(605.500000, 224.000000, "_");TextDrawBackgroundColor(phoneThree[6], 255);TextDrawFont(phoneThree[6], 1);TextDrawLetterSize(phoneThree[6], 0.500000, 0.399998);TextDrawColor(phoneThree[6], -1);
	TextDrawSetOutline(phoneThree[6], 0);TextDrawSetProportional(phoneThree[6], 1);TextDrawSetShadow(phoneThree[6], 1);TextDrawUseBox(phoneThree[6], 1);
	TextDrawBoxColor(phoneThree[6], 909522576);TextDrawTextSize(phoneThree[6], 500.000000, 0.000000);TextDrawSetSelectable(phoneThree[6], 0);
	phoneThree[7] = TextDrawCreate(510.000000, 261.000000, "19 ?EBPA‡• 2014");TextDrawBackgroundColor(phoneThree[7], 255);TextDrawFont(phoneThree[7], 2);
	TextDrawLetterSize(phoneThree[7], 0.180000, 1.000000);TextDrawColor(phoneThree[7], -1);TextDrawSetOutline(phoneThree[7], 0);
	TextDrawSetProportional(phoneThree[7], 1);TextDrawSetShadow(phoneThree[7], 0);TextDrawSetSelectable(phoneThree[7], 0);
	phoneThree[8] = TextDrawCreate(602.000000, 220.500000, "SA-TELECOM");TextDrawAlignment(phoneThree[8], 3);TextDrawBackgroundColor(phoneThree[8], 255);TextDrawFont(phoneThree[8], 2);
	TextDrawLetterSize(phoneThree[8], 0.189999, 1.000000);TextDrawColor(phoneThree[8], -1);TextDrawSetOutline(phoneThree[8], 0);
	TextDrawSetProportional(phoneThree[8], 1);TextDrawSetShadow(phoneThree[8], 0);TextDrawSetSelectable(phoneThree[8], 0);
	phoneThree[9] = TextDrawCreate(505.000000, 277.500000, "nastroikiFon");TextDrawAlignment(phoneThree[9], 2);TextDrawBackgroundColor(phoneThree[9], 1182971135);TextDrawFont(phoneThree[9], 5);
	TextDrawLetterSize(phoneThree[9], 0.500000, 5.299997);TextDrawColor(phoneThree[9], -1);TextDrawSetOutline(phoneThree[9], 0);TextDrawSetProportional(phoneThree[9], 1);
	TextDrawSetShadow(phoneThree[9], 1);TextDrawUseBox(phoneThree[9], 1);TextDrawBoxColor(phoneThree[9], 0);TextDrawTextSize(phoneThree[9], 40.000000, 42.000000);
	TextDrawSetPreviewModel(phoneThree[9], 111111);TextDrawSetPreviewRot(phoneThree[9], -16.000000, 0.000000, -55.000000, 1000.000000);TextDrawSetSelectable(phoneThree[9], 1);
	phoneThree[10] = TextDrawCreate(546.500000, 277.500000, "contactsFon");TextDrawAlignment(phoneThree[10], 2);TextDrawBackgroundColor(phoneThree[10], 1182971135);TextDrawFont(phoneThree[10], 5);
	TextDrawLetterSize(phoneThree[10], 0.500000, 5.299997);TextDrawColor(phoneThree[10], -1);TextDrawSetOutline(phoneThree[10], 0);TextDrawSetProportional(phoneThree[10], 1);
	TextDrawSetShadow(phoneThree[10], 1);TextDrawUseBox(phoneThree[10], 1);TextDrawBoxColor(phoneThree[10], 0);TextDrawTextSize(phoneThree[10], 54.000000, 42.000000);
	TextDrawSetPreviewModel(phoneThree[10], 111111);TextDrawSetPreviewRot(phoneThree[10], -16.000000, 0.000000, -55.000000, 1000.000000);TextDrawSetSelectable(phoneThree[10], 1);
	phoneThree[11] = TextDrawCreate(505.000000, 321.000000, "numberFon");TextDrawAlignment(phoneThree[11], 2);TextDrawBackgroundColor(phoneThree[11], 1182971135);
	TextDrawFont(phoneThree[11], 5);TextDrawLetterSize(phoneThree[11], 0.500000, 5.299997);TextDrawColor(phoneThree[11], -1);TextDrawSetOutline(phoneThree[11], 0);
	TextDrawSetProportional(phoneThree[11], 1);TextDrawSetShadow(phoneThree[11], 1);TextDrawUseBox(phoneThree[11], 1);TextDrawBoxColor(phoneThree[11], 0);
	TextDrawTextSize(phoneThree[11], 96.000000, 23.000000);TextDrawSetPreviewModel(phoneThree[11], 111111);TextDrawSetPreviewRot(phoneThree[11], -16.000000, 0.000000, -55.000000, 1000.000000);TextDrawSetSelectable(phoneThree[11], 1);
	phoneThree[12] = TextDrawCreate(505.000000, 345.500000, "messageFon");TextDrawAlignment(phoneThree[12], 2);TextDrawBackgroundColor(phoneThree[12], 1182971135);TextDrawFont(phoneThree[12], 5);
	TextDrawLetterSize(phoneThree[12], 0.559999, 5.299997);TextDrawColor(phoneThree[12], -1);TextDrawSetOutline(phoneThree[12], 0);TextDrawSetProportional(phoneThree[12], 1);
	TextDrawSetShadow(phoneThree[12], 1);TextDrawUseBox(phoneThree[12], 1);TextDrawBoxColor(phoneThree[12], 0);TextDrawTextSize(phoneThree[12], 96.000000, 23.000000);
	TextDrawSetPreviewModel(phoneThree[12], 111111);TextDrawSetPreviewRot(phoneThree[12], -16.000000, 0.000000, -55.000000, 1000.000000);TextDrawSetSelectable(phoneThree[12], 1);
	phoneThree[13] = TextDrawCreate(507.500000, 308.000000, "Настройки");TextDrawBackgroundColor(phoneThree[13], 255);TextDrawFont(phoneThree[13], 2);TextDrawLetterSize(phoneThree[13], 0.150000, 1.000000);TextDrawColor(phoneThree[13], -1);
	TextDrawSetOutline(phoneThree[13], 0);TextDrawSetProportional(phoneThree[13], 1);TextDrawSetShadow(phoneThree[13], 0);TextDrawSetSelectable(phoneThree[13], 0);
	phoneThree[14] = TextDrawCreate(549.500000, 308.000000, "Контакты");TextDrawBackgroundColor(phoneThree[14], 255);
	TextDrawFont(phoneThree[14], 2);TextDrawLetterSize(phoneThree[14], 0.150000, 1.000000);TextDrawColor(phoneThree[14], -1);
	TextDrawSetOutline(phoneThree[14], 0);TextDrawSetProportional(phoneThree[14], 1);TextDrawSetShadow(phoneThree[14], 0);TextDrawSetSelectable(phoneThree[14], 0);
	phoneThree[15] = TextDrawCreate(507.500000, 333.000000, "Набрать номер");TextDrawBackgroundColor(phoneThree[15], 255);
	TextDrawFont(phoneThree[15], 2);TextDrawLetterSize(phoneThree[15], 0.150000, 1.000000);TextDrawColor(phoneThree[15], -1);TextDrawSetOutline(phoneThree[15], 0);
	TextDrawSetProportional(phoneThree[15], 1);TextDrawSetShadow(phoneThree[15], 0);TextDrawSetSelectable(phoneThree[15], 0);
	phoneThree[16] = TextDrawCreate(507.500000, 358.000000, "Сообщения");TextDrawBackgroundColor(phoneThree[16], 255);TextDrawFont(phoneThree[16], 2);
	TextDrawLetterSize(phoneThree[16], 0.150000, 1.000000);TextDrawColor(phoneThree[16], -1);TextDrawSetOutline(phoneThree[16], 0);
	TextDrawSetProportional(phoneThree[16], 1);TextDrawSetShadow(phoneThree[16], 0);TextDrawSetSelectable(phoneThree[16], 0);
	phoneThree[17] = TextDrawCreate(505.000000, 370.000000, "offlineFon");TextDrawAlignment(phoneThree[17], 2);TextDrawBackgroundColor(phoneThree[17], 1182971135);
	TextDrawFont(phoneThree[17], 5);TextDrawLetterSize(phoneThree[17], 0.559999, 5.299997);TextDrawColor(phoneThree[17], -1);TextDrawSetOutline(phoneThree[17], 0);
	TextDrawSetProportional(phoneThree[17], 1);TextDrawSetShadow(phoneThree[17], 1);TextDrawUseBox(phoneThree[17], 1);TextDrawBoxColor(phoneThree[17], 0);
	TextDrawTextSize(phoneThree[17], 96.000000, 23.000000);TextDrawSetPreviewModel(phoneThree[17], 111111);TextDrawSetPreviewRot(phoneThree[17], -16.000000, 0.000000, -55.000000, 1000.000000);TextDrawSetSelectable(phoneThree[17], 1);
	phoneThree[18] = TextDrawCreate(507.500000, 383.000000, "Убрать телефон");TextDrawBackgroundColor(phoneThree[18], 255);TextDrawFont(phoneThree[18], 2);
	TextDrawLetterSize(phoneThree[18], 0.150000, 1.000000);TextDrawColor(phoneThree[18], -1);TextDrawSetOutline(phoneThree[18], 0);
	TextDrawSetProportional(phoneThree[18], 1);TextDrawSetShadow(phoneThree[18], 0);TextDrawSetSelectable(phoneThree[18], 0);
	*/
	/*
	HungerFon[0] = TextDrawCreate(547.500000, 58.000000, "_");TextDrawBackgroundColor(HungerFon[0], 255);TextDrawFont(HungerFon[0], 1);TextDrawLetterSize(HungerFon[0], 0.500000, 0.399999);
	TextDrawColor(HungerFon[0], -1);TextDrawSetOutline(HungerFon[0], 0);TextDrawSetProportional(HungerFon[0], 1);TextDrawSetShadow(HungerFon[0], 1);
	TextDrawUseBox(HungerFon[0], 1);TextDrawBoxColor(HungerFon[0], 255);TextDrawTextSize(HungerFon[0], 606.000000, 40.000000);TextDrawSetSelectable(HungerFon[0], 0);

	HungerFon[1] = TextDrawCreate(549.500000, 60.000000, "_");TextDrawBackgroundColor(HungerFon[1], 255);TextDrawFont(HungerFon[1], 1);
	TextDrawLetterSize(HungerFon[1], 0.490000, -0.000000);TextDrawColor(HungerFon[1], -1);TextDrawSetOutline(HungerFon[1], 0);TextDrawSetProportional(HungerFon[1], 1);
	TextDrawSetShadow(HungerFon[1], 1);TextDrawUseBox(HungerFon[1], 1);TextDrawBoxColor(HungerFon[1], 1787344480);TextDrawTextSize(HungerFon[1], 604.000000, 40.000000);TextDrawSetSelectable(HungerFon[1], 0);
	*/
	
	furnitureBuy[1] = TextDrawCreate(320.000000, 380.000000, "_");
	TextDrawAlignment(furnitureBuy[1], 2);
	TextDrawBackgroundColor(furnitureBuy[1], 255);
	TextDrawFont(furnitureBuy[1], 1);
	TextDrawLetterSize(furnitureBuy[1], 30.500000, 2.100000);
	TextDrawColor(furnitureBuy[1], -1);
	TextDrawSetOutline(furnitureBuy[1], 0);
	TextDrawSetProportional(furnitureBuy[1], 1);
	TextDrawSetShadow(furnitureBuy[1], 0);
	TextDrawUseBox(furnitureBuy[1], 1);
	//TextDrawBoxColor(furnitureBuy[1], 0x4A86B630);
	TextDrawBoxColor(furnitureBuy[1], 0x1E999930);
	TextDrawTextSize(furnitureBuy[1], 0.000000, -179.000000);
	TextDrawSetSelectable(furnitureBuy[1], 0);
	
	furnitureBuy[6] = TextDrawCreate(320.000000, 356.000000, "_");
	TextDrawAlignment(furnitureBuy[6], 2);
	TextDrawBackgroundColor(furnitureBuy[6], 255);
	TextDrawFont(furnitureBuy[6], 1);
	TextDrawLetterSize(furnitureBuy[6], 30.500000, 2.100000);
	TextDrawColor(furnitureBuy[6], -1);
	TextDrawSetOutline(furnitureBuy[6], 0);
	TextDrawSetProportional(furnitureBuy[6], 1);
	TextDrawSetShadow(furnitureBuy[6], 0);
	TextDrawUseBox(furnitureBuy[6], 1);
	//TextDrawBoxColor(furnitureBuy[6], 0x4A86B630);
	TextDrawBoxColor(furnitureBuy[6], 0x1E999930);
	TextDrawTextSize(furnitureBuy[6], 0.000000, -179.000000);
	TextDrawSetSelectable(furnitureBuy[6], 0);
	
	furnitureBuy[0] = TextDrawCreate(320.000000, 404.000000, "_");
	TextDrawLetterSize(furnitureBuy[0], 0.500000, 2.100000);
	TextDrawTextSize(furnitureBuy[0], 0.000000, -179.000000);
	TextDrawAlignment(furnitureBuy[0], 2);
	TextDrawColor(furnitureBuy[0], -1);
	TextDrawUseBox(furnitureBuy[0], 1);
	//TextDrawBoxColor(furnitureBuy[0], 0x4A86B630);
	TextDrawBoxColor(furnitureBuy[0], 0x1E999930);
	TextDrawSetShadow(furnitureBuy[0], 0);
	TextDrawSetOutline(furnitureBuy[0], 0);
	TextDrawBackgroundColor(furnitureBuy[0], 255);
	TextDrawFont(furnitureBuy[0], 1);
	TextDrawSetProportional(furnitureBuy[0], 1);
	
	furnitureBuy[2] = TextDrawCreate(234.000000, 403.000000, "ld_beat:left");
	TextDrawBackgroundColor(furnitureBuy[2], 255);
	TextDrawFont(furnitureBuy[2], 4);
	TextDrawLetterSize(furnitureBuy[2], 0.500000, 1.000000);
	TextDrawColor(furnitureBuy[2], 0x1E999930);
	TextDrawSetOutline(furnitureBuy[2], 0);
	TextDrawSetProportional(furnitureBuy[2], 1);
	TextDrawSetShadow(furnitureBuy[2], 1);
	TextDrawUseBox(furnitureBuy[2], 1);
	TextDrawBoxColor(furnitureBuy[2], 255);
	TextDrawTextSize(furnitureBuy[2], 21.000000, 22.000000);
	TextDrawSetSelectable(furnitureBuy[2], 1);
	
	furnitureBuy[3] = TextDrawCreate(386.000000, 403.000000, "ld_beat:right");
	TextDrawBackgroundColor(furnitureBuy[3], 255);
	TextDrawFont(furnitureBuy[3], 4);
	TextDrawLetterSize(furnitureBuy[3], 0.500000, 1.000000);
	TextDrawColor(furnitureBuy[3], 0x1E999930);
	TextDrawSetOutline(furnitureBuy[3], 0);
	TextDrawSetProportional(furnitureBuy[3], 1);
	TextDrawSetShadow(furnitureBuy[3], 1);
	TextDrawUseBox(furnitureBuy[3], 1);
	TextDrawBoxColor(furnitureBuy[3], 255);
	TextDrawTextSize(furnitureBuy[3], 21.000000, 22.000000);
	TextDrawSetSelectable(furnitureBuy[3], 1);
	
	furnitureBuy[4] = TextDrawCreate(265.000000, 404.000000, "купить");
	TextDrawBackgroundColor(furnitureBuy[4], 255);
	TextDrawFont(furnitureBuy[4], 2);
	TextDrawLetterSize(furnitureBuy[4], 0.320000, 1.899999);
	TextDrawColor(furnitureBuy[4], -1);
	TextDrawSetOutline(furnitureBuy[4], 0);
	TextDrawSetProportional(furnitureBuy[4], 1);
	TextDrawSetShadow(furnitureBuy[4], 0);
	TextDrawUseBox(furnitureBuy[4], 1);
	TextDrawBoxColor(furnitureBuy[4], 0);
	TextDrawTextSize(furnitureBuy[4], 310.000000, 20.000000);
	TextDrawSetSelectable(furnitureBuy[4], 1);
	
	furnitureBuy[5] = TextDrawCreate(319.000000, 404.000000, "закрыть");
	TextDrawBackgroundColor(furnitureBuy[5], 255);
	TextDrawFont(furnitureBuy[5], 2);
	TextDrawLetterSize(furnitureBuy[5], 0.320000, 1.899999);
	TextDrawColor(furnitureBuy[5], -1);
	TextDrawSetOutline(furnitureBuy[5], 0);
	TextDrawSetProportional(furnitureBuy[5], 1);
	TextDrawSetShadow(furnitureBuy[5], 0);
	TextDrawUseBox(furnitureBuy[5], 1);
	TextDrawBoxColor(furnitureBuy[5], 0);
	TextDrawTextSize(furnitureBuy[5], 376.000000, 20.000000);
	TextDrawSetSelectable(furnitureBuy[5], 1);
	
	//Разное для бизнеса
	furnitureOther[0] = TextDrawCreate(234.000000, 403.000000, "ld_beat:left");
	TextDrawBackgroundColor(furnitureOther[0], 255);
	TextDrawFont(furnitureOther[0], 4);
	TextDrawLetterSize(furnitureOther[0], 0.500000, 1.000000);
	TextDrawColor(furnitureOther[0], 0x1E999930);
	TextDrawSetOutline(furnitureOther[0], 0);
	TextDrawSetProportional(furnitureOther[0], 1);
	TextDrawSetShadow(furnitureOther[0], 1);
	TextDrawUseBox(furnitureOther[0], 1);
	TextDrawBoxColor(furnitureOther[0], 255);
	TextDrawTextSize(furnitureOther[0], 21.000000, 22.000000);
	TextDrawSetSelectable(furnitureOther[0], 1);
	
	furnitureOther[1] = TextDrawCreate(386.000000, 403.000000, "ld_beat:right");
	TextDrawBackgroundColor(furnitureOther[1], 255);
	TextDrawFont(furnitureOther[1], 4);
	TextDrawLetterSize(furnitureOther[1], 0.500000, 1.000000);
	TextDrawColor(furnitureOther[1], 0x1E999930);
	TextDrawSetOutline(furnitureOther[1], 0);
	TextDrawSetProportional(furnitureOther[1], 1);
	TextDrawSetShadow(furnitureOther[1], 1);
	TextDrawUseBox(furnitureOther[1], 1);
	TextDrawBoxColor(furnitureOther[1], 255);
	TextDrawTextSize(furnitureOther[1], 21.000000, 22.000000);
	TextDrawSetSelectable(furnitureOther[1], 1);
	
	furnitureOther[2] = TextDrawCreate(265.000000, 404.000000, "купить");
	TextDrawBackgroundColor(furnitureOther[2], 255);
	TextDrawFont(furnitureOther[2], 2);
	TextDrawLetterSize(furnitureOther[2], 0.320000, 1.899999);
	TextDrawColor(furnitureOther[2], -1);
	TextDrawSetOutline(furnitureOther[2], 0);
	TextDrawSetProportional(furnitureOther[2], 1);
	TextDrawSetShadow(furnitureOther[2], 0);
	TextDrawUseBox(furnitureOther[2], 1);
	TextDrawBoxColor(furnitureOther[2], 0);
	TextDrawTextSize(furnitureOther[2], 310.000000, 20.000000);
	TextDrawSetSelectable(furnitureOther[2], 1);
	
	furnitureOther[3] = TextDrawCreate(319.000000, 404.000000, "закрыть");
	TextDrawBackgroundColor(furnitureOther[3], 255);
	TextDrawFont(furnitureOther[3], 2);
	TextDrawLetterSize(furnitureOther[3], 0.320000, 1.899999);
	TextDrawColor(furnitureOther[3], -1);
	TextDrawSetOutline(furnitureOther[3], 0);
	TextDrawSetProportional(furnitureOther[3], 1);
	TextDrawSetShadow(furnitureOther[3], 0);
	TextDrawUseBox(furnitureOther[3], 1);
	TextDrawBoxColor(furnitureOther[3], 0);
	TextDrawTextSize(furnitureOther[3], 376.000000, 20.000000);
	TextDrawSetSelectable(furnitureOther[3], 1);
	
	//Кнопка "Купить" для дома
	furnitureOther[4] = TextDrawCreate(265.000000, 404.000000, "купить");
	TextDrawBackgroundColor(furnitureOther[4], 255);
	TextDrawFont(furnitureOther[4], 2);
	TextDrawLetterSize(furnitureOther[4], 0.320000, 1.899999);
	TextDrawColor(furnitureOther[4], -1);
	TextDrawSetOutline(furnitureOther[4], 0);
	TextDrawSetProportional(furnitureOther[4], 1);
	TextDrawSetShadow(furnitureOther[4], 0);
	TextDrawUseBox(furnitureOther[4], 1);
	TextDrawBoxColor(furnitureOther[4], 0);
	TextDrawTextSize(furnitureOther[4], 310.000000, 20.000000);
	TextDrawSetSelectable(furnitureOther[4], 1);
	
	//Тюнинг
	car_tuning[0] = TextDrawCreate(234.000000, 403.000000, "ld_beat:left");
	TextDrawBackgroundColor(car_tuning[0], 255);
	TextDrawFont(car_tuning[0], 4);
	TextDrawLetterSize(car_tuning[0], 0.500000, 1.000000);
	TextDrawColor(car_tuning[0], 0x1E999930);
	TextDrawSetOutline(car_tuning[0], 0);
	TextDrawSetProportional(car_tuning[0], 1);
	TextDrawSetShadow(car_tuning[0], 1);
	TextDrawUseBox(car_tuning[0], 1);
	TextDrawBoxColor(car_tuning[0], 255);
	TextDrawTextSize(car_tuning[0], 21.000000, 22.000000);
	TextDrawSetSelectable(car_tuning[0], 1);
	
	car_tuning[1] = TextDrawCreate(386.000000, 403.000000, "ld_beat:right");
	TextDrawBackgroundColor(car_tuning[1], 255);
	TextDrawFont(car_tuning[1], 4);
	TextDrawLetterSize(car_tuning[1], 0.500000, 1.000000);
	TextDrawColor(car_tuning[1], 0x1E999930);
	TextDrawSetOutline(car_tuning[1], 0);
	TextDrawSetProportional(car_tuning[1], 1);
	TextDrawSetShadow(car_tuning[1], 1);
	TextDrawUseBox(car_tuning[1], 1);
	TextDrawBoxColor(car_tuning[1], 255);
	TextDrawTextSize(car_tuning[1], 21.000000, 22.000000);
	TextDrawSetSelectable(car_tuning[1], 1);
	
	car_tuning[2] = TextDrawCreate(258.000000, 404.000000, "установка");
	TextDrawBackgroundColor(car_tuning[2], 255);
	TextDrawFont(car_tuning[2], 2);
	TextDrawLetterSize(car_tuning[2], 0.320000, 1.899999);
	TextDrawColor(car_tuning[2], -1);
	TextDrawSetOutline(car_tuning[2], 0);
	TextDrawSetProportional(car_tuning[2], 1);
	TextDrawSetShadow(car_tuning[2], 0);
	TextDrawUseBox(car_tuning[2], 1);
	TextDrawBoxColor(car_tuning[2], 0);
	TextDrawTextSize(car_tuning[2], 310.000000, 20.000000);
	TextDrawSetSelectable(car_tuning[2], 1);
	
	car_tuning[3] = TextDrawCreate(337.000000, 404.000000, "назад");
	TextDrawBackgroundColor(car_tuning[3], 255);
	TextDrawFont(car_tuning[3], 2);
	TextDrawLetterSize(car_tuning[3], 0.320000, 1.899999);
	TextDrawColor(car_tuning[3], -1);
	TextDrawSetOutline(car_tuning[3], 0);
	TextDrawSetProportional(car_tuning[3], 1);
	TextDrawSetShadow(car_tuning[3], 0);
	TextDrawUseBox(car_tuning[3], 1);
	TextDrawBoxColor(car_tuning[3], 0);
	TextDrawTextSize(car_tuning[3], 376.000000, 20.000000);
	TextDrawSetSelectable(car_tuning[3], 1);
	
	car_tuning[4] = TextDrawCreate(320.000000, 380.000000, "_");
	TextDrawAlignment(car_tuning[4], 2);
	TextDrawBackgroundColor(car_tuning[4], 255);
	TextDrawFont(car_tuning[4], 1);
	TextDrawLetterSize(car_tuning[4], 30.500000, 2.100000);
	TextDrawColor(car_tuning[4], -1);
	TextDrawSetOutline(car_tuning[4], 0);
	TextDrawSetProportional(car_tuning[4], 1);
	TextDrawSetShadow(car_tuning[4], 0);
	TextDrawUseBox(car_tuning[4], 1);
	TextDrawBoxColor(car_tuning[4], 0x1E999930);
	TextDrawTextSize(car_tuning[4], 0.000000, -179.000000);
	TextDrawSetSelectable(car_tuning[4], 0);
	
	car_tuning[5] = TextDrawCreate(320.000000, 356.000000, "_");
	TextDrawAlignment(car_tuning[5], 2);
	TextDrawBackgroundColor(car_tuning[5], 255);
	TextDrawFont(car_tuning[5], 1);
	TextDrawLetterSize(car_tuning[5], 30.500000, 2.100000);
	TextDrawColor(car_tuning[5], -1);
	TextDrawSetOutline(car_tuning[5], 0);
	TextDrawSetProportional(car_tuning[5], 1);
	TextDrawSetShadow(car_tuning[5], 0);
	TextDrawUseBox(car_tuning[5], 1);
	TextDrawBoxColor(car_tuning[5], 0x1E999930);
	TextDrawTextSize(car_tuning[5], 0.000000, -179.000000);
	TextDrawSetSelectable(car_tuning[5], 0);
	
	car_tuning[6] = TextDrawCreate(320.000000, 404.000000, "_");
	TextDrawLetterSize(car_tuning[6], 0.500000, 2.100000);
	TextDrawTextSize(car_tuning[6], 0.000000, -179.000000);
	TextDrawAlignment(car_tuning[6], 2);
	TextDrawColor(car_tuning[6], -1);
	TextDrawUseBox(car_tuning[6], 1);
	TextDrawBoxColor(car_tuning[6], 0x1E999930);
	TextDrawSetShadow(car_tuning[6], 0);
	TextDrawSetOutline(car_tuning[6], 0);
	TextDrawBackgroundColor(car_tuning[6], 255);
	TextDrawFont(car_tuning[6], 1);
	TextDrawSetProportional(furnitureBuy[0], 1);
	
	car_tuning[7] = TextDrawCreate(260.000000, 404.000000, "покраска");
	TextDrawBackgroundColor(car_tuning[7], 255);
	TextDrawFont(car_tuning[7], 2);
	TextDrawLetterSize(car_tuning[7], 0.320000, 1.899999);
	TextDrawColor(car_tuning[7], -1);
	TextDrawSetOutline(car_tuning[7], 0);
	TextDrawSetProportional(car_tuning[7], 1);
	TextDrawSetShadow(car_tuning[7], 0);
	TextDrawUseBox(car_tuning[7], 1);
	TextDrawBoxColor(car_tuning[7], 0);
	TextDrawTextSize(car_tuning[7], 310.000000, 20.000000);
	TextDrawSetSelectable(car_tuning[7], 1);
	
	car_tuning[8] = TextDrawCreate(336.000000, 404.000000, "назад");
	TextDrawBackgroundColor(car_tuning[8], 255);
	TextDrawFont(car_tuning[8], 2);
	TextDrawLetterSize(car_tuning[8], 0.320000, 1.899999);
	TextDrawColor(car_tuning[8], -1);
	TextDrawSetOutline(car_tuning[8], 0);
	TextDrawSetProportional(car_tuning[8], 1);
	TextDrawSetShadow(car_tuning[8], 0);
	TextDrawUseBox(car_tuning[8], 1);
	TextDrawBoxColor(car_tuning[8], 0);
	TextDrawTextSize(car_tuning[8], 376.000000, 20.000000);
	TextDrawSetSelectable(car_tuning[8], 1);
	
	carshop[0] = TextDrawCreate(320.000000, 380.000000, "_");
	TextDrawAlignment(carshop[0], 2);
	TextDrawBackgroundColor(carshop[0], 255);
	TextDrawFont(carshop[0], 1);
	TextDrawLetterSize(carshop[0], 30.500000, 2.100000);
	TextDrawColor(carshop[0], -1);
	TextDrawSetOutline(carshop[0], 0);
	TextDrawSetProportional(carshop[0], 1);
	TextDrawSetShadow(carshop[0], 0);
	TextDrawUseBox(carshop[0], 1);
	TextDrawBoxColor(carshop[0], 0x1E999930);
	TextDrawTextSize(carshop[0], 0.000000, -179.000000);
	TextDrawSetSelectable(carshop[0], 0);
	
	carshop[1] = TextDrawCreate(320.000000, 356.000000, "_");
	TextDrawAlignment(carshop[1], 2);
	TextDrawBackgroundColor(carshop[1], 255);
	TextDrawFont(carshop[1], 1);
	TextDrawLetterSize(carshop[1], 30.500000, 2.100000);
	TextDrawColor(carshop[1], -1);
	TextDrawSetOutline(carshop[1], 0);
	TextDrawSetProportional(carshop[1], 1);
	TextDrawSetShadow(carshop[1], 0);
	TextDrawUseBox(carshop[1], 1);
	TextDrawBoxColor(carshop[1], 0x1E999930);
	TextDrawTextSize(carshop[1], 0.000000, -179.000000);
	TextDrawSetSelectable(carshop[1], 0);
	
	carshop[2] = TextDrawCreate(320.000000, 404.000000, "_");
	TextDrawLetterSize(carshop[2], 0.500000, 2.100000);
	TextDrawTextSize(carshop[2], 0.000000, -179.000000);
	TextDrawAlignment(carshop[2], 2);
	TextDrawColor(carshop[2], -1);
	TextDrawUseBox(carshop[2], 1);
	TextDrawBoxColor(carshop[2], 0x1E999930);
	TextDrawSetShadow(carshop[2], 0);
	TextDrawSetOutline(carshop[2], 0);
	TextDrawBackgroundColor(carshop[2], 255);
	TextDrawFont(carshop[2], 1);
	TextDrawSetProportional(carshop[2], 1);
	
	carshop[3] = TextDrawCreate(234.000000, 403.000000, "ld_beat:left");
	TextDrawBackgroundColor(carshop[3], 255);
	TextDrawFont(carshop[3], 4);
	TextDrawLetterSize(carshop[3], 0.500000, 1.000000);
	TextDrawColor(carshop[3], 0x1E999930);
	TextDrawSetOutline(carshop[3], 0);
	TextDrawSetProportional(carshop[3], 1);
	TextDrawSetShadow(carshop[3], 1);
	TextDrawUseBox(carshop[3], 1);
	TextDrawBoxColor(carshop[3], 255);
	TextDrawTextSize(carshop[3], 21.000000, 22.000000);
	TextDrawSetSelectable(carshop[3], 1);
	
	carshop[4] = TextDrawCreate(386.000000, 403.000000, "ld_beat:right");
	TextDrawBackgroundColor(carshop[4], 255);
	TextDrawFont(carshop[4], 4);
	TextDrawLetterSize(carshop[4], 0.500000, 1.000000);
	TextDrawColor(carshop[4], 0x1E999930);
	TextDrawSetOutline(carshop[4], 0);
	TextDrawSetProportional(carshop[4], 1);
	TextDrawSetShadow(carshop[4], 1);
	TextDrawUseBox(carshop[4], 1);
	TextDrawBoxColor(carshop[4], 255);
	TextDrawTextSize(carshop[4], 21.000000, 22.000000);
	TextDrawSetSelectable(carshop[4], 1);
	
	carshop[5] = TextDrawCreate(265.000000, 404.000000, "купить");
	TextDrawBackgroundColor(carshop[5], 255);
	TextDrawFont(carshop[5], 2);
	TextDrawLetterSize(carshop[5], 0.320000, 1.899999);
	TextDrawColor(carshop[5], -1);
	TextDrawSetOutline(carshop[5], 0);
	TextDrawSetProportional(carshop[5], 1);
	TextDrawSetShadow(carshop[5], 0);
	TextDrawUseBox(carshop[5], 1);
	TextDrawBoxColor(carshop[5], 0);
	TextDrawTextSize(carshop[5], 310.000000, 20.000000);
	TextDrawSetSelectable(carshop[5], 1);
	
	carshop[6] = TextDrawCreate(319.000000, 404.000000, "закрыть");
	TextDrawBackgroundColor(carshop[6], 255);
	TextDrawFont(carshop[6], 2);
	TextDrawLetterSize(carshop[6], 0.320000, 1.899999);
	TextDrawColor(carshop[6], -1);
	TextDrawSetOutline(carshop[6], 0);
	TextDrawSetProportional(carshop[6], 1);
	TextDrawSetShadow(carshop[6], 0);
	TextDrawUseBox(carshop[6], 1);
	TextDrawBoxColor(carshop[6], 0);
	TextDrawTextSize(carshop[6], 376.000000, 20.000000);
	TextDrawSetSelectable(carshop[6], 1);
	
	
	/* - TD: Выбор скина при регистрации - */
	chooseSkin[1] = TextDrawCreate(320.000000, 390.000000, "_");
	TextDrawLetterSize(chooseSkin[1], 0.500000, 2.099999);
	TextDrawTextSize(chooseSkin[1], -179.000000, 150.000000);
	TextDrawAlignment(chooseSkin[1], 2);
	TextDrawColor(chooseSkin[1], -1);
	TextDrawUseBox(chooseSkin[1], 1);
	TextDrawBoxColor(chooseSkin[1], 0x1E999920);
	TextDrawSetShadow(chooseSkin[1], 0);
	TextDrawSetOutline(chooseSkin[1], 0);
	TextDrawBackgroundColor(chooseSkin[1], 255);
	TextDrawFont(chooseSkin[1], 1);
	TextDrawSetProportional(chooseSkin[1], 1);
	TextDrawSetShadow(chooseSkin[1], 0);
	
	chooseSkin[0] = TextDrawCreate(239.499908, 384.767364, ""); //Назад
	TextDrawLetterSize(chooseSkin[0], 0.000000, 0.000000);
	TextDrawTextSize(chooseSkin[0], 30.000000, 30.000000);
	TextDrawAlignment(chooseSkin[0], 1);
	TextDrawColor(chooseSkin[0], 204624);
	TextDrawSetShadow(chooseSkin[0], 0);
	TextDrawSetOutline(chooseSkin[0], 0);
	TextDrawBackgroundColor(chooseSkin[0], 0);
	TextDrawFont(chooseSkin[0], 5);
	TextDrawSetProportional(chooseSkin[0], 0);
	TextDrawSetShadow(chooseSkin[0], 0);
	TextDrawSetSelectable(chooseSkin[0], true);
	TextDrawSetPreviewModel(chooseSkin[0], 19134);
	TextDrawSetPreviewRot(chooseSkin[0], 0.000000, 90.000000, 90.000000, 0.85);

	chooseSkin[2] = TextDrawCreate(370.307891, 384.767364, ""); //Вперед
	TextDrawLetterSize(chooseSkin[2], 0.000000, 0.000000);
	TextDrawTextSize(chooseSkin[2], 30.000000, 30.000000);
	TextDrawAlignment(chooseSkin[2], 1);
	TextDrawColor(chooseSkin[2], 204624);
	TextDrawSetShadow(chooseSkin[2], 0);
	TextDrawSetOutline(chooseSkin[2], 0);
	TextDrawBackgroundColor(chooseSkin[2], 0);
	TextDrawFont(chooseSkin[2], 5);
	TextDrawSetProportional(chooseSkin[2], 0);
	TextDrawSetShadow(chooseSkin[2], 0);
	TextDrawSetSelectable(chooseSkin[2], true);
	TextDrawSetPreviewModel(chooseSkin[2], 19134);
	TextDrawSetPreviewRot(chooseSkin[2], 0.000000, -90.000000, 90.000000, 0.85);

	chooseSkin[3] = TextDrawCreate(319.500091, 389.772277, "выбрать");
	TextDrawLetterSize(chooseSkin[3], 0.319999, 1.899999);
	TextDrawTextSize(chooseSkin[3], 20.000000, 50.000000);
	TextDrawAlignment(chooseSkin[3], 2);
	TextDrawColor(chooseSkin[3], -1);
	TextDrawSetShadow(chooseSkin[3], 0);
	TextDrawSetOutline(chooseSkin[3], 0);
	TextDrawBackgroundColor(chooseSkin[3], 255);
	TextDrawFont(chooseSkin[3], 2);
	TextDrawSetProportional(chooseSkin[3], 1);
	TextDrawSetShadow(chooseSkin[3], 0);
	TextDrawSetSelectable(chooseSkin[3], 1);
	
	blind_background = TextDrawCreate(641.199951, 1.500000, "usebox");
	TextDrawLetterSize( blind_background, 0.000000, 49.378147);
	TextDrawTextSize( blind_background, -2.000000, 0.000000);
	TextDrawAlignment( blind_background, 3);
	TextDrawColor( blind_background, -1);
	TextDrawUseBox( blind_background, true);
	TextDrawBoxColor( blind_background, 255);
	TextDrawSetShadow( blind_background, 0);
	TextDrawSetOutline( blind_background, 0);
	TextDrawBackgroundColor( blind_background, 255);
	TextDrawFont( blind_background, 1);
	
	return 1;
}

TextDraws_OnPlayerConnect( playerid )
{
	// New
	/* - TD: Радио(slot,channel,radio info) - */
	radio[0][playerid] = CreatePlayerTextDraw(playerid, 530.470153, 105.999961, "radio Info");
	PlayerTextDrawLetterSize(playerid, radio[0][playerid], 0.254117, 1.191666);
	PlayerTextDrawAlignment(playerid, radio[0][playerid], 2);
	PlayerTextDrawColor(playerid, radio[0][playerid], td_cBLUE);
	PlayerTextDrawSetShadow(playerid, radio[0][playerid], 0);
	PlayerTextDrawSetOutline(playerid, radio[0][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, radio[0][playerid], 255);
	PlayerTextDrawFont(playerid, radio[0][playerid], 2);
	PlayerTextDrawSetProportional(playerid, radio[0][playerid], 1);
	PlayerTextDrawSetShadow(playerid, radio[0][playerid], 0);

	radio[1][playerid] = CreatePlayerTextDraw(playerid, 502.705841, 118.833343, "channel: 0");
	PlayerTextDrawLetterSize(playerid, radio[1][playerid], 0.167529, 0.929166);
	PlayerTextDrawAlignment(playerid, radio[1][playerid], 1);
	PlayerTextDrawColor(playerid, radio[1][playerid], td_cWHITE);
	PlayerTextDrawSetShadow(playerid, radio[1][playerid], 0);
	PlayerTextDrawSetOutline(playerid, radio[1][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, radio[1][playerid], 255);
	PlayerTextDrawFont(playerid, radio[1][playerid], 2);
	PlayerTextDrawSetProportional(playerid, radio[1][playerid], 1);
	PlayerTextDrawSetShadow(playerid, radio[1][playerid], 0);

	radio[2][playerid] = CreatePlayerTextDraw(playerid, 502.705841, 128.750030, "SLOT: 12");
	PlayerTextDrawLetterSize(playerid, radio[2][playerid], 0.167529, 0.929166);
	PlayerTextDrawAlignment(playerid, radio[2][playerid], 1);
	PlayerTextDrawColor(playerid, radio[2][playerid], td_cWHITE);
	PlayerTextDrawSetShadow(playerid, radio[2][playerid], 0);
	PlayerTextDrawSetOutline(playerid, radio[2][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, radio[2][playerid], 255);
	PlayerTextDrawFont(playerid, radio[2][playerid], 2);
	PlayerTextDrawSetProportional(playerid, radio[2][playerid], 1);
	PlayerTextDrawSetShadow(playerid, radio[2][playerid], 0);
	/* - TD: Радио(slot,channel,radio info) - End */
	
	// Спидометр
	
	Speed[0][playerid] = CreatePlayerTextDraw(playerid,296.823303, 405.850128, "ENG");
	PlayerTextDrawLetterSize(playerid,Speed[0][playerid], 0.185881, 1.168331);
	PlayerTextDrawAlignment(playerid,Speed[0][playerid], 1);
	PlayerTextDrawColor(playerid,Speed[0][playerid], -1);
	PlayerTextDrawSetShadow(playerid,Speed[0][playerid], 0);
	PlayerTextDrawSetOutline(playerid,Speed[0][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,Speed[0][playerid], 255);
	PlayerTextDrawFont(playerid,Speed[0][playerid], 2);
	PlayerTextDrawSetProportional(playerid,Speed[0][playerid], 1);
	
	Speed[1][playerid] = CreatePlayerTextDraw(playerid,343.017425, 405.866821, "LIMIT");
	PlayerTextDrawLetterSize(playerid,Speed[1][playerid], 0.185881, 1.168331);
	PlayerTextDrawAlignment(playerid,Speed[1][playerid], 1);
	PlayerTextDrawColor(playerid,Speed[1][playerid], -1);
	PlayerTextDrawSetShadow(playerid,Speed[1][playerid], 0);
	PlayerTextDrawSetOutline(playerid,Speed[1][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,Speed[1][playerid], 255);
	PlayerTextDrawFont(playerid,Speed[1][playerid], 2);
	PlayerTextDrawSetProportional(playerid,Speed[1][playerid], 1);
	
	Speed[2][playerid] = CreatePlayerTextDraw(playerid,271.240997, 406.150177, "LIGHT");
	PlayerTextDrawLetterSize(playerid,Speed[2][playerid], 0.185881, 1.168331);
	PlayerTextDrawAlignment(playerid,Speed[2][playerid], 1);
	PlayerTextDrawColor(playerid,Speed[2][playerid], -1);
	PlayerTextDrawSetShadow(playerid,Speed[2][playerid], 0);
	PlayerTextDrawSetOutline(playerid,Speed[2][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,Speed[2][playerid], 255);
	PlayerTextDrawFont(playerid,Speed[2][playerid], 2);
	PlayerTextDrawSetProportional(playerid,Speed[2][playerid], 1);
	
	Speed[3][playerid] = CreatePlayerTextDraw(playerid,317.829101, 405.850128, "LOCK");
	PlayerTextDrawLetterSize(playerid,Speed[3][playerid], 0.185881, 1.168331);
	PlayerTextDrawAlignment(playerid,Speed[3][playerid], 1);
	PlayerTextDrawColor(playerid,Speed[3][playerid], -1);
	PlayerTextDrawSetShadow(playerid,Speed[3][playerid], 0);
	PlayerTextDrawSetOutline(playerid,Speed[3][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,Speed[3][playerid], 255);
	PlayerTextDrawFont(playerid,Speed[3][playerid], 2);
	PlayerTextDrawSetProportional(playerid,Speed[3][playerid], 1);
	
	Speed[4][playerid] = CreatePlayerTextDraw(playerid,326.505889, 388.333465, "MILE: 1000.0");
	PlayerTextDrawLetterSize(playerid,Speed[4][playerid], 0.177882, 1.156666);
	PlayerTextDrawAlignment(playerid,Speed[4][playerid], 1);
	PlayerTextDrawColor(playerid,Speed[4][playerid], -1);
	PlayerTextDrawSetShadow(playerid,Speed[4][playerid], 0);
	PlayerTextDrawSetOutline(playerid,Speed[4][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,Speed[4][playerid], 255);
	PlayerTextDrawFont(playerid,Speed[4][playerid], 2);
	PlayerTextDrawSetProportional(playerid,Speed[4][playerid], 1);
	
	Speed[5][playerid] = CreatePlayerTextDraw(playerid,297.888214, 376.133270, "100");
	PlayerTextDrawLetterSize(playerid,Speed[5][playerid], 0.450352, 2.603336);
	PlayerTextDrawAlignment(playerid,Speed[5][playerid], 3);
	PlayerTextDrawColor(playerid,Speed[5][playerid], -1);
	PlayerTextDrawSetShadow(playerid,Speed[5][playerid], 0);
	PlayerTextDrawSetOutline(playerid,Speed[5][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,Speed[5][playerid], 255);
	PlayerTextDrawFont(playerid,Speed[5][playerid], 2);
	PlayerTextDrawSetProportional(playerid,Speed[5][playerid], 1);
	
	Speed[6][playerid] = CreatePlayerTextDraw(playerid,326.705780, 377.833404, "FUEL: 100.0");
	PlayerTextDrawLetterSize(playerid,Speed[6][playerid], 0.177882, 1.156666);
	PlayerTextDrawAlignment(playerid,Speed[6][playerid], 1);
	PlayerTextDrawColor(playerid,Speed[6][playerid], -1);
	PlayerTextDrawSetShadow(playerid,Speed[6][playerid], 0);
	PlayerTextDrawSetOutline(playerid,Speed[6][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,Speed[6][playerid], 255);
	PlayerTextDrawFont(playerid,Speed[6][playerid], 2);
	PlayerTextDrawSetProportional(playerid,Speed[6][playerid], 1);
	
	//Таксометр
	Taximeter[playerid] = CreatePlayerTextDraw(playerid, 286.058532, 426.405700, "taximeter: $0");
	PlayerTextDrawLetterSize(playerid, Taximeter[playerid], 0.185881, 1.168331);
	PlayerTextDrawAlignment(playerid, Taximeter[playerid], 1);
	PlayerTextDrawColor(playerid, Taximeter[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Taximeter[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Taximeter[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Taximeter[playerid], 255);
	PlayerTextDrawFont(playerid, Taximeter[playerid], 2);
	PlayerTextDrawSetProportional(playerid, Taximeter[playerid], 1);
	
	//Дальнобойщик
	Trucker[playerid] = CreatePlayerTextDraw(playerid, 276.058532, 426.405700, "none");
	PlayerTextDrawLetterSize(playerid, Trucker[playerid], 0.185881, 1.168331);
	PlayerTextDrawAlignment(playerid, Trucker[playerid], 1);
	PlayerTextDrawColor(playerid, Trucker[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Trucker[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Trucker[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Trucker[playerid], 255);
	PlayerTextDrawFont(playerid, Trucker[playerid], 2);
	PlayerTextDrawSetProportional(playerid, Trucker[playerid], 1);
	
	//Автобусник
	Drivebus[playerid] = CreatePlayerTextDraw(playerid, 292.058532, 426.405700, "none");
	PlayerTextDrawLetterSize(playerid, Drivebus[playerid], 0.185881, 1.168331);
	PlayerTextDrawAlignment(playerid, Drivebus[playerid], 1);
	PlayerTextDrawColor(playerid, Drivebus[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Drivebus[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Drivebus[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Drivebus[playerid], 255);
	PlayerTextDrawFont(playerid, Drivebus[playerid], 2);
	PlayerTextDrawSetProportional(playerid, Drivebus[playerid], 1);
	
	/*NewSkinSelect[0][playerid] = CreatePlayerTextDraw(playerid, 139.000000, 146.429595, "PreviewModel");
	PlayerTextDrawLetterSize(playerid,NewSkinSelect[0][playerid], 0.095666, 3.364151);
	PlayerTextDrawTextSize(playerid,NewSkinSelect[0][playerid], 61.666648, 69.274085);
	PlayerTextDrawAlignment(playerid,NewSkinSelect[0][playerid], 1);
	PlayerTextDrawColor(playerid,NewSkinSelect[0][playerid], -1);
	PlayerTextDrawSetShadow(playerid,NewSkinSelect[0][playerid], 0);
	PlayerTextDrawSetOutline(playerid,NewSkinSelect[0][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,NewSkinSelect[0][playerid], -707406934);
	PlayerTextDrawFont(playerid,NewSkinSelect[0][playerid], 5);
	PlayerTextDrawSetPreviewModel(playerid,NewSkinSelect[0][playerid], 0);
	PlayerTextDrawSetPreviewRot(playerid,NewSkinSelect[0][playerid], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid,NewSkinSelect[0][playerid], true);

	NewSkinSelect[1][playerid] = CreatePlayerTextDraw(playerid, 203.666671, 146.600006, "PreviewModel");
	PlayerTextDrawLetterSize(playerid,NewSkinSelect[1][playerid], 0.060333, 0.647111);
	PlayerTextDrawTextSize(playerid,NewSkinSelect[1][playerid], 61.666648, 69.274085);
	PlayerTextDrawAlignment(playerid,NewSkinSelect[1][playerid], 1);
	PlayerTextDrawColor(playerid,NewSkinSelect[1][playerid], -1);
	PlayerTextDrawSetShadow(playerid,NewSkinSelect[1][playerid], 0);
	PlayerTextDrawSetOutline(playerid,NewSkinSelect[1][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,NewSkinSelect[1][playerid], -707406934);
	PlayerTextDrawFont(playerid,NewSkinSelect[1][playerid], 5);
	PlayerTextDrawSetPreviewModel(playerid,NewSkinSelect[1][playerid], 0);
	PlayerTextDrawSetPreviewRot(playerid,NewSkinSelect[1][playerid], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid,NewSkinSelect[1][playerid], true);

	NewSkinSelect[2][playerid] = CreatePlayerTextDraw(playerid, 268.666473, 146.770355, "PreviewModel");
	PlayerTextDrawLetterSize(playerid,NewSkinSelect[2][playerid], 0.060666, 0.672000);
	PlayerTextDrawTextSize(playerid,NewSkinSelect[2][playerid], 61.666648, 69.274085);
	PlayerTextDrawAlignment(playerid,NewSkinSelect[2][playerid], 1);
	PlayerTextDrawColor(playerid,NewSkinSelect[2][playerid], -1);
	PlayerTextDrawSetShadow(playerid,NewSkinSelect[2][playerid], 0);
	PlayerTextDrawSetOutline(playerid,NewSkinSelect[2][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,NewSkinSelect[2][playerid], -707406934);
	PlayerTextDrawFont(playerid,NewSkinSelect[2][playerid], 5);
	PlayerTextDrawSetPreviewModel(playerid,NewSkinSelect[2][playerid], 0);
	PlayerTextDrawSetPreviewRot(playerid,NewSkinSelect[2][playerid], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid,NewSkinSelect[2][playerid], true);

	NewSkinSelect[3][playerid] = CreatePlayerTextDraw(playerid,332.999816, 146.940734, "PreviewModel");
	PlayerTextDrawLetterSize(playerid,NewSkinSelect[3][playerid], 0.059333, 0.684444);
	PlayerTextDrawTextSize(playerid,NewSkinSelect[3][playerid], 61.666648, 69.274085);
	PlayerTextDrawAlignment(playerid,NewSkinSelect[3][playerid], 1);
	PlayerTextDrawColor(playerid,NewSkinSelect[3][playerid], -1);
	PlayerTextDrawSetShadow(playerid,NewSkinSelect[3][playerid], 0);
	PlayerTextDrawSetOutline(playerid,NewSkinSelect[3][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,NewSkinSelect[3][playerid], -707406934);
	PlayerTextDrawFont(playerid,NewSkinSelect[3][playerid], 5);
	PlayerTextDrawSetPreviewModel(playerid,NewSkinSelect[3][playerid], 0);
	PlayerTextDrawSetPreviewRot(playerid,NewSkinSelect[3][playerid], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid,NewSkinSelect[3][playerid], true);

	NewSkinSelect[4][playerid] = CreatePlayerTextDraw(playerid,397.333129, 146.696365, "PreviewModel");
	PlayerTextDrawLetterSize(playerid,NewSkinSelect[4][playerid], 0.123999, 0.754962);
	PlayerTextDrawTextSize(playerid,NewSkinSelect[4][playerid], 61.666648, 69.274085);
	PlayerTextDrawAlignment(playerid,NewSkinSelect[4][playerid], 1);
	PlayerTextDrawColor(playerid,NewSkinSelect[4][playerid], -1);
	PlayerTextDrawSetShadow(playerid,NewSkinSelect[4][playerid], 0);
	PlayerTextDrawSetOutline(playerid,NewSkinSelect[4][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,NewSkinSelect[4][playerid], -707406934);
	PlayerTextDrawFont(playerid,NewSkinSelect[4][playerid], 5);
	PlayerTextDrawSetPreviewModel(playerid,NewSkinSelect[4][playerid], 0);
	PlayerTextDrawSetPreviewRot(playerid,NewSkinSelect[4][playerid], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid,NewSkinSelect[4][playerid], true);

	NewSkinSelect[5][playerid] = CreatePlayerTextDraw(playerid,461.999725, 146.866729, "PreviewModel");
	PlayerTextDrawLetterSize(playerid,NewSkinSelect[5][playerid], 0.066999, 1.335703);
	PlayerTextDrawTextSize(playerid,NewSkinSelect[5][playerid], 61.666648, 69.274085);
	PlayerTextDrawAlignment(playerid,NewSkinSelect[5][playerid], 1);
	PlayerTextDrawColor(playerid,NewSkinSelect[5][playerid], -1);
	PlayerTextDrawSetShadow(playerid,NewSkinSelect[5][playerid], 0);
	PlayerTextDrawSetOutline(playerid,NewSkinSelect[5][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,NewSkinSelect[5][playerid], -707406934);
	PlayerTextDrawFont(playerid,NewSkinSelect[5][playerid], 5);
	PlayerTextDrawSetPreviewModel(playerid,NewSkinSelect[5][playerid], 0);
	PlayerTextDrawSetPreviewRot(playerid,NewSkinSelect[5][playerid], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid,NewSkinSelect[5][playerid], true);

	NewSkinSelect[6][playerid] = CreatePlayerTextDraw(playerid,139.000000, 221.681442, "PreviewModel");
	PlayerTextDrawLetterSize(playerid,NewSkinSelect[6][playerid], 0.155333, 4.048594);
	PlayerTextDrawTextSize(playerid,NewSkinSelect[6][playerid], 61.666648, 69.274085);
	PlayerTextDrawAlignment(playerid,NewSkinSelect[6][playerid], 1);
	PlayerTextDrawColor(playerid,NewSkinSelect[6][playerid], -1);
	PlayerTextDrawSetShadow(playerid,NewSkinSelect[6][playerid], 0);
	PlayerTextDrawSetOutline(playerid,NewSkinSelect[6][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,NewSkinSelect[6][playerid], -707406934);
	PlayerTextDrawFont(playerid,NewSkinSelect[6][playerid], 5);
	PlayerTextDrawSetPreviewModel(playerid,NewSkinSelect[6][playerid], 0);
	PlayerTextDrawSetPreviewRot(playerid,NewSkinSelect[6][playerid], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid,NewSkinSelect[6][playerid], true);

	NewSkinSelect[7][playerid] = CreatePlayerTextDraw(playerid,204.000045, 221.851806, "PreviewModel");
	PlayerTextDrawLetterSize(playerid,NewSkinSelect[7][playerid], 0.158666, 4.023706);
	PlayerTextDrawTextSize(playerid,NewSkinSelect[7][playerid], 61.666648, 69.274085);
	PlayerTextDrawAlignment(playerid,NewSkinSelect[7][playerid], 1);
	PlayerTextDrawColor(playerid,NewSkinSelect[7][playerid], -1);
	PlayerTextDrawSetShadow(playerid,NewSkinSelect[7][playerid], 0);
	PlayerTextDrawSetOutline(playerid,NewSkinSelect[7][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,NewSkinSelect[7][playerid], -707406934);
	PlayerTextDrawFont(playerid,NewSkinSelect[7][playerid], 5);
	PlayerTextDrawSetPreviewModel(playerid,NewSkinSelect[7][playerid], 0);
	PlayerTextDrawSetPreviewRot(playerid,NewSkinSelect[7][playerid], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid,NewSkinSelect[7][playerid], true);

	NewSkinSelect[8][playerid] = CreatePlayerTextDraw(playerid,269.333374, 221.607376, "PreviewModel");
	PlayerTextDrawLetterSize(playerid,NewSkinSelect[8][playerid], 0.158999, 4.011263);
	PlayerTextDrawTextSize(playerid,NewSkinSelect[8][playerid], 61.666648, 69.274085);
	PlayerTextDrawAlignment(playerid,NewSkinSelect[8][playerid], 1);
	PlayerTextDrawColor(playerid,NewSkinSelect[8][playerid], -1);
	PlayerTextDrawSetShadow(playerid,NewSkinSelect[8][playerid], 0);
	PlayerTextDrawSetOutline(playerid,NewSkinSelect[8][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,NewSkinSelect[8][playerid], -707406934);
	PlayerTextDrawFont(playerid,NewSkinSelect[8][playerid], 5);
	PlayerTextDrawSetPreviewModel(playerid,NewSkinSelect[8][playerid], 0);
	PlayerTextDrawSetPreviewRot(playerid,NewSkinSelect[8][playerid], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid,NewSkinSelect[8][playerid], true);

	NewSkinSelect[9][playerid] = CreatePlayerTextDraw(playerid,334.666625, 221.777725, "PreviewModel");
	PlayerTextDrawLetterSize(playerid,NewSkinSelect[9][playerid], 0.157999, 4.048594);
	PlayerTextDrawTextSize(playerid,NewSkinSelect[9][playerid], 61.666648, 69.274085);
	PlayerTextDrawAlignment(playerid,NewSkinSelect[9][playerid], 1);
	PlayerTextDrawColor(playerid,NewSkinSelect[9][playerid], -1);
	PlayerTextDrawSetShadow(playerid,NewSkinSelect[9][playerid], 0);
	PlayerTextDrawSetOutline(playerid,NewSkinSelect[9][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,NewSkinSelect[9][playerid], -707406934);
	PlayerTextDrawFont(playerid,NewSkinSelect[9][playerid], 5);
	PlayerTextDrawSetPreviewModel(playerid,NewSkinSelect[9][playerid], 0);
	PlayerTextDrawSetPreviewRot(playerid,NewSkinSelect[9][playerid], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid,NewSkinSelect[9][playerid], true);

	NewSkinSelect[10][playerid] = CreatePlayerTextDraw(playerid,400.333312, 221.948089, "PreviewModel");
	PlayerTextDrawLetterSize(playerid,NewSkinSelect[10][playerid], 0.161333, 4.023707);
	PlayerTextDrawTextSize(playerid,NewSkinSelect[10][playerid], 61.666648, 69.274085);
	PlayerTextDrawAlignment(playerid,NewSkinSelect[10][playerid], 1);
	PlayerTextDrawColor(playerid,NewSkinSelect[10][playerid], -1);
	PlayerTextDrawSetShadow(playerid,NewSkinSelect[10][playerid], 0);
	PlayerTextDrawSetOutline(playerid,NewSkinSelect[10][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,NewSkinSelect[10][playerid], -707406934);
	PlayerTextDrawFont(playerid,NewSkinSelect[10][playerid], 5);
	PlayerTextDrawSetPreviewModel(playerid,NewSkinSelect[10][playerid], 0);
	PlayerTextDrawSetPreviewRot(playerid,NewSkinSelect[10][playerid], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid,NewSkinSelect[10][playerid], true);

	NewSkinSelect[11][playerid] = CreatePlayerTextDraw(playerid,465.333190, 221.703628, "PreviewModel");
	PlayerTextDrawLetterSize(playerid,NewSkinSelect[11][playerid], 0.159999, 4.048596);
	PlayerTextDrawTextSize(playerid,NewSkinSelect[11][playerid], 61.666648, 69.274085);
	PlayerTextDrawAlignment(playerid,NewSkinSelect[11][playerid], 1);
	PlayerTextDrawColor(playerid,NewSkinSelect[11][playerid], -1);
	PlayerTextDrawSetShadow(playerid,NewSkinSelect[11][playerid], 0);
	PlayerTextDrawSetOutline(playerid,NewSkinSelect[11][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,NewSkinSelect[11][playerid], -707406934);
	PlayerTextDrawFont(playerid,NewSkinSelect[11][playerid], 5);
	PlayerTextDrawSetPreviewModel(playerid,NewSkinSelect[11][playerid], 0);
	PlayerTextDrawSetPreviewRot(playerid,NewSkinSelect[11][playerid], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid,NewSkinSelect[11][playerid], true);

	NewSkinSelect[12][playerid] = CreatePlayerTextDraw(playerid,535.666625, 144.611114, "usebox");
	PlayerTextDrawLetterSize(playerid,NewSkinSelect[12][playerid], 0.000000, 16.829011);
	PlayerTextDrawTextSize(playerid,NewSkinSelect[12][playerid], 131.333328, 0.000000);
	PlayerTextDrawAlignment(playerid,NewSkinSelect[12][playerid], 1);
	PlayerTextDrawColor(playerid,NewSkinSelect[12][playerid], 0);
	PlayerTextDrawUseBox(playerid,NewSkinSelect[12][playerid], true);
	PlayerTextDrawBoxColor(playerid,NewSkinSelect[12][playerid], 102);
	PlayerTextDrawSetShadow(playerid,NewSkinSelect[12][playerid], 0);
	PlayerTextDrawSetOutline(playerid,NewSkinSelect[12][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,NewSkinSelect[12][playerid], td_cBLUE);
	PlayerTextDrawFont(playerid,NewSkinSelect[12][playerid], 0);*/
	
	menuPlayer[0][playerid] = CreatePlayerTextDraw(playerid,84.000000, 154.000000, "none");PlayerTextDrawBackgroundColor(playerid,menuPlayer[0][playerid], 255);PlayerTextDrawFont(playerid,menuPlayer[0][playerid], 2);PlayerTextDrawLetterSize(playerid,menuPlayer[0][playerid], 0.200000, 1.200000);PlayerTextDrawColor(playerid,menuPlayer[0][playerid], -1);
	PlayerTextDrawSetOutline(playerid,menuPlayer[0][playerid], 0);PlayerTextDrawSetProportional(playerid,menuPlayer[0][playerid], 1);PlayerTextDrawSetShadow(playerid,menuPlayer[0][playerid], 0);PlayerTextDrawSetSelectable(playerid,menuPlayer[0][playerid], 0);
	menuPlayer[1][playerid] = CreatePlayerTextDraw(playerid,256.000000, 154.000000, "none");PlayerTextDrawAlignment(playerid,menuPlayer[1][playerid], 3);PlayerTextDrawBackgroundColor(playerid,menuPlayer[1][playerid], 255);PlayerTextDrawFont(playerid,menuPlayer[1][playerid], 2);PlayerTextDrawLetterSize(playerid,menuPlayer[1][playerid], 0.200000, 1.200000);
	PlayerTextDrawColor(playerid,menuPlayer[1][playerid], -1);PlayerTextDrawSetOutline(playerid,menuPlayer[1][playerid], 0);PlayerTextDrawSetProportional(playerid,menuPlayer[1][playerid], 1);PlayerTextDrawSetShadow(playerid,menuPlayer[1][playerid], 0);PlayerTextDrawSetSelectable(playerid,menuPlayer[1][playerid], 0);
	menuPlayer[2][playerid] = CreatePlayerTextDraw(playerid,172.000000, 135.000000, "nick_names");PlayerTextDrawAlignment(playerid,menuPlayer[2][playerid], 2);PlayerTextDrawBackgroundColor(playerid,menuPlayer[2][playerid], 255);PlayerTextDrawFont(playerid,menuPlayer[2][playerid], 2);PlayerTextDrawLetterSize(playerid,menuPlayer[2][playerid], 0.230000, 1.399999);
	PlayerTextDrawColor(playerid,menuPlayer[2][playerid], -1);PlayerTextDrawSetOutline(playerid,menuPlayer[2][playerid], 0);PlayerTextDrawSetProportional(playerid,menuPlayer[2][playerid], 1);PlayerTextDrawSetShadow(playerid,menuPlayer[2][playerid], 0);PlayerTextDrawSetSelectable(playerid,menuPlayer[2][playerid], 0);PlayerTextDrawSetShadow(playerid,menuPlayer[2][playerid], 0);PlayerTextDrawSetSelectable(playerid,menuPlayer[2][playerid], 0);PlayerTextDrawSetSelectable(playerid,menuPlayer[2][playerid], 0);
	
	/*
	HungerProgres[playerid] = CreatePlayerTextDraw(playerid,549.500000, 60.000000, "____");PlayerTextDrawBackgroundColor(playerid,HungerProgres[playerid], 255);PlayerTextDrawFont(playerid,HungerProgres[playerid], 1);PlayerTextDrawLetterSize(playerid,HungerProgres[playerid], 0.490000, -0.000000);
	PlayerTextDrawColor(playerid,HungerProgres[playerid], -1);PlayerTextDrawSetOutline(playerid,HungerProgres[playerid], 0);PlayerTextDrawSetProportional(playerid,HungerProgres[playerid], 1);PlayerTextDrawSetShadow(playerid,HungerProgres[playerid], 1);
	PlayerTextDrawUseBox(playerid,HungerProgres[playerid], 1);PlayerTextDrawBoxColor(playerid,HungerProgres[playerid], 0x559cd4AA);PlayerTextDrawTextSize(playerid,HungerProgres[playerid], 604.000000, 40.000000);PlayerTextDrawSetSelectable(playerid,HungerProgres[playerid], 0);*/
	
	furniturePrice[playerid] = CreatePlayerTextDraw(playerid,321.000000, 379.000000, "price");
	PlayerTextDrawAlignment(playerid,furniturePrice[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,furniturePrice[playerid], 255);
	PlayerTextDrawFont(playerid,furniturePrice[playerid], 2);
	PlayerTextDrawLetterSize(playerid,furniturePrice[playerid], 0.290000, 2.000000);
	PlayerTextDrawColor(playerid,furniturePrice[playerid], -1);
	PlayerTextDrawSetOutline(playerid,furniturePrice[playerid], 0);
	PlayerTextDrawSetProportional(playerid,furniturePrice[playerid], 1);
	PlayerTextDrawSetShadow(playerid,furniturePrice[playerid], 0);
	PlayerTextDrawSetSelectable(playerid,furniturePrice[playerid], 0);
	
	furnitureName[playerid] = CreatePlayerTextDraw(playerid,321.000000, 359.000000, "n");
	PlayerTextDrawAlignment(playerid,furnitureName[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,furnitureName[playerid], 255);
	PlayerTextDrawFont(playerid,furnitureName[playerid], 2);
	PlayerTextDrawLetterSize(playerid,furnitureName[playerid], 0.290000, 2.000000);
	PlayerTextDrawColor(playerid,furnitureName[playerid], -1);
	PlayerTextDrawSetOutline(playerid,furnitureName[playerid], 0);
	PlayerTextDrawSetProportional(playerid,furnitureName[playerid], 1);
	PlayerTextDrawSetShadow(playerid,furnitureName[playerid], 0);
	PlayerTextDrawSetSelectable(playerid,furnitureName[playerid], 0);
	
	//Тюнинг Название - Цена
	tuning_price[playerid] = CreatePlayerTextDraw(playerid,321.000000, 379.000000, "price");
	PlayerTextDrawAlignment(playerid,tuning_price[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,tuning_price[playerid], 255);
	PlayerTextDrawFont(playerid,tuning_price[playerid], 2);
	PlayerTextDrawLetterSize(playerid,tuning_price[playerid], 0.290000, 2.000000);
	PlayerTextDrawColor(playerid,tuning_price[playerid], -1);
	PlayerTextDrawSetOutline(playerid,tuning_price[playerid], 0);
	PlayerTextDrawSetProportional(playerid,tuning_price[playerid], 1);
	PlayerTextDrawSetShadow(playerid,tuning_price[playerid], 0);
	PlayerTextDrawSetSelectable(playerid,tuning_price[playerid], 0);
	
	tuning_name[playerid] = CreatePlayerTextDraw(playerid,321.000000, 359.000000, "n");
	PlayerTextDrawAlignment(playerid,tuning_name[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,tuning_name[playerid], 255);
	PlayerTextDrawFont(playerid,tuning_name[playerid], 2);
	PlayerTextDrawLetterSize(playerid,tuning_name[playerid], 0.290000, 2.000000);
	PlayerTextDrawColor(playerid,tuning_name[playerid], -1);
	PlayerTextDrawSetOutline(playerid,tuning_name[playerid], 0);
	PlayerTextDrawSetProportional(playerid,tuning_name[playerid], 1);
	PlayerTextDrawSetShadow(playerid,tuning_name[playerid], 0);
	PlayerTextDrawSetSelectable(playerid,tuning_name[playerid], 0);
	
	carshop_info[playerid] = CreatePlayerTextDraw( playerid, 380.123229, 80.916595, "_" );
	PlayerTextDrawLetterSize( playerid, carshop_info[playerid], 0.175058, 1.034166 );
	PlayerTextDrawAlignment( playerid, carshop_info[playerid], 1 );
	PlayerTextDrawColor( playerid, carshop_info[playerid], -1 );
	PlayerTextDrawSetShadow( playerid, carshop_info[playerid], 0 );
	PlayerTextDrawSetOutline( playerid, carshop_info[playerid], 0 );
	PlayerTextDrawBackgroundColor( playerid, carshop_info[playerid], 60 );
	PlayerTextDrawFont( playerid, carshop_info[playerid], 2 );
	PlayerTextDrawSetProportional( playerid, carshop_info[playerid], 1 );
	PlayerTextDrawSetShadow( playerid, carshop_info[playerid], 0 );
	
	//Информация при изменении интерьера / текстуры
	interior_info[playerid] = CreatePlayerTextDraw(playerid, 555.693359, 413.121826, "interior 19 $100000");
	PlayerTextDrawLetterSize(playerid, interior_info[playerid], 0.272000, 1.456888);
	PlayerTextDrawAlignment(playerid, interior_info[playerid], 2);
	PlayerTextDrawColor(playerid, interior_info[playerid], -1);
	PlayerTextDrawSetShadow(playerid, interior_info[playerid], 0);
	PlayerTextDrawSetOutline(playerid, interior_info[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, interior_info[playerid], 255);
	PlayerTextDrawFont(playerid, interior_info[playerid], 2);
	PlayerTextDrawSetProportional(playerid, interior_info[playerid], 1);
	PlayerTextDrawSetShadow(playerid, interior_info[playerid], 0);
	
	//Текстдрав в тюрьме на камерах видеонаблюдения
	TDPrisonCCTV[playerid] = CreatePlayerTextDraw( playerid, 20.0, 360.0, "~y~Camera ~w~#1~n~~y~Date: ~w~01.01.2016 01:55~n~~y~Location: ~w~Block ~n~");
	PlayerTextDrawLetterSize( playerid, TDPrisonCCTV[playerid], 0.8, 2.2 );
    PlayerTextDrawSetShadow( playerid, TDPrisonCCTV[playerid], 0);
    PlayerTextDrawUseBox( playerid, TDPrisonCCTV[playerid], 0 );
	PlayerTextDrawBoxColor( playerid, TDPrisonCCTV[playerid],0x00000055);
	PlayerTextDrawTextSize( playerid, TDPrisonCCTV[playerid], 380, 400);
	
	return 1;
}