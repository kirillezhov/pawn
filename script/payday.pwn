
stock payDay( playerid )
{
	new 
		pay,
		gmoney,
		bank,
		prem_pay,
		benefit,
		rank;

	Player[playerid][uPayTime] = 0;
	printf( "[Log]: Player %s[%d] have been PayDay.", Player[playerid][uName], playerid );
	
	SendClient:( playerid, C_GRAY, "-------------------"cBLUE"PayDay"cGRAY"-------------------" );
	
	if( gettime() - Player[playerid][tFirstTime] >= 10800 )
	{
		new
			time = gettime() - Player[playerid][tFirstTime],
			hour = floatround( float(time) / 3600.0, floatround_floor );
			
		pformat:( ""cBLUE"Вы играете на сервере %d час%s: Вы получаете удвоенный Exp и 1 RCoin!", hour, hour < 5 ? ("а") : ("ов") );
		psend:( playerid, C_WHITE );
	
		Player[playerid][uHours] ++;
		Player[playerid][uGMoney] ++;
	}
	
	Player[playerid][uHours] ++;
	if( ( Player[playerid][uHours] - getLevelHours( playerid ) ) >= ( Player[playerid][uLevel] + 1 ) * 6 )
	{
		Player[playerid][uLevel] ++;
		SetPlayerScore( playerid, Player[playerid][uLevel] );
	
		pformat:( ""cBLUE"Вы получили новый %d уровень!", Player[playerid][uLevel] );
		psend:( playerid, C_WHITE );
	}
	
	if( Player[playerid][uMember] )
	{
		if( Player[playerid][uRank] )
		{
			rank = getRankId( playerid, Player[playerid][uMember] - 1 );
			pay = FRank[ Player[playerid][uMember] - 1 ][ rank ][r_salary];
			
			pformat:( "Заработная плата: "cBLUE"$%d", pay );
			psend:( playerid, C_GRAY );
		}
		else
		{
			pay = BENEFIT_NORANK;
		
			pformat:( "Заработная плата: "cBLUE"$%d", pay );
			psend:( playerid, C_GRAY );
		}
	}
	else if( !Player[playerid][uJob] )
	{
		benefit = BENEFIT_VALUE;
	
		pformat:( "Пособие по безработице: "cBLUE"$%d", BENEFIT_VALUE );
		psend:( playerid, C_GRAY );
	}
	
	Player[playerid][uCheck] += pay;
	Player[playerid][uCheck] += benefit;
	
	pformat:( "Чековая книжка: "cBLUE"$%d", Player[playerid][uCheck] );
	psend:( playerid, C_GRAY );
	
	pformat:( "Банковский счет: "cBLUE"$%d", Player[playerid][uBank] );
	psend:( playerid, C_GRAY );
	
	if( Premium[playerid][prem_type] )
	{
		pformat:( ""cGRAY"Премиум аккаунт:%s %s", GetPremiumColor( Premium[playerid][prem_color] ), GetPremiumName( Premium[playerid][prem_type] ) );
		psend:( playerid, C_GRAY );
		
		if( Premium[playerid][prem_gmoney] )
		{
			Player[playerid][uGMoney] += Premium[playerid][prem_gmoney];
			
			pformat:( " + "cBLUE"%d"cGRAY" GMoney (%d)", gmoney, Player[playerid][uGMoney] );
			psend:( playerid, C_GRAY );
		}
		
		if( Premium[playerid][prem_salary] && pay )
		{
			prem_pay = floatround( pay * Premium[playerid][prem_salary] / 100 );
				
			pformat:( " + "cBLUE"$%d"cGRAY" к заработной плате", prem_pay );
			psend:( playerid, C_GRAY );
			
			Player[playerid][uCheck] += prem_pay;
		}
		else if( Premium[playerid][prem_benefit] && benefit )
		{
			prem_pay = floatround( benefit * Premium[playerid][prem_benefit] / 100 );
				
			pformat:( " + "cBLUE"$%d"cGRAY" к пособию по безработице", prem_pay );
			psend:( playerid, C_GRAY );
			
			Player[playerid][uCheck] += prem_pay;
		}
		
		if( Premium[playerid][prem_bank] )
		{
			bank = floatround( Player[playerid][uBank] * Premium[playerid][prem_bank]/1000 );
			
			if( bank )
			{
				pformat:( " + "cBLUE"$%d"cGRAY" на банковский счет", bank );
				psend:( playerid, C_GRAY );
				
				SetPlayerBank( playerid, "+", bank );
			}
		}
	}
	
	if( gettime() > Premium[playerid][prem_time] && Premium[playerid][prem_time] ) 
	{
		SendClient:( playerid, C_WHITE, !""gbDialogError"Срок действия Вашего премиум аккаунта истёк. Для продления премиум аккаунта используйте "cBLUE"/donate" );
		
		mysql_format:g_small_string( "DELETE FROM `"DB_PREMIUM"` WHERE `prem_id` = %d", Premium[playerid][prem_id] );
		mysql_tquery( mysql, g_small_string );
		
		Premium[playerid][prem_id] =
		Premium[playerid][prem_time] = 
		Premium[playerid][prem_type] = 
		Premium[playerid][prem_color] = 
		Premium[playerid][prem_gmoney] = 
		Premium[playerid][prem_bank] = 
		Premium[playerid][prem_salary] = 
		Premium[playerid][prem_benefit] = 
		Premium[playerid][prem_mass] = 
		Premium[playerid][prem_admins] = 
		Premium[playerid][prem_supports] = 
		Premium[playerid][prem_h_payment] = 
		Premium[playerid][prem_house] = 
		Premium[playerid][prem_car] = 
		Premium[playerid][prem_business] = 
		Premium[playerid][prem_house_property] = 
		Premium[playerid][prem_drop_retreature] = 
		Premium[playerid][prem_drop_tuning] = 
		Premium[playerid][prem_drop_repair] = 
		Premium[playerid][prem_drop_payment] = 0;
	}
	
	mysql_format:g_small_string( "UPDATE `"DB_USERS"` SET `uLevel` = %d, `uCheck` = %d, `uGMoney` = %d, `uPayTime` = 0, `uHours` = %d WHERE `uID` = %d LIMIT 1",
		Player[playerid][uLevel], Player[playerid][uCheck], Player[playerid][uGMoney], Player[playerid][uHours], Player[playerid][uID] );
	mysql_tquery( mysql, g_small_string );
}