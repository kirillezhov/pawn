#include <a_samp>
#include <foreach>
#include <nex-ac>
#include <streamer>
#include <a_mysql>
#include <sscanf2>
#include <crp>
#include <tr_at>
#include <core>
#include <crashdetect>
#include <mxDate>
#include <mxINI>
#include <zcmd>
#include <TOTP>
#include <mail> 
#include <mailer>

#include "reefland\config.inc"
#include "reefland\header\macrosses.inc"
#include "reefland\header\constants.inc"
#include "reefland\header\structures.inc"
#include "reefland\header\variables.inc"
#include "reefland\array.pwn"

main(){}

#include "reefland\header.inc"
#include "reefland\core.inc"

public OnGameModeInit() 
{
	new 
		stack_memory = heapspace();
		
	Connection_OnGameModeInit();
	Server_OnGameModeInit();
	AntiCheat_OnGameModeInit();
	Objects_OnGameModeInit();
	TextDraws_OnGameModeInit();
	Admin_OnGameModeInit();
	Enter_OnGameModeInit();
	Weather_OnGameModeInit();
	Inv_OnGameModeInit();
	Frac_OnGameModeInit();
	House_OnGameModeInit();
	Furniture_OnGameModeInit();
	HInterior_OnGameModeInit();
	Crime_OnGameModeInit();
	Vehicle_OnGameModeInit();
	Prison_OnGameModeInit();
	Gate_OnGameModeInit();
	Door_OnGameModeInit();
	Overpass_OnGameModeInit();
	Business_OnGameModeInit();
	BInterior_OnGameModeInit();
	IBusiness_OnGameModeInit();
	Job_OnGameModeInit();
	Phone_OnGameModeInit();
	Police_OnGameModeInit();

	clean_array();
	Dobject_OnGameModeInit();
	
	printf( "[Stack Memory]: Losted - %d bytes.", stack_memory - heapspace() );
	return 1;
}

public OnGameModeExit() 
{
	foreach(new i : Player)
	{
		if( IsKicked( i ) ) continue;
		
		gbMessageKick( i, ""cRED"Технический рестарт"cWHITE"" );
	}

	/*foreach(new i : Player)
	{	
		if( IsLogged( i ) )
		{		
			SavePlayerData( i );
			Vehicle_OnGameModeExit( i );
			Job_OnGameModeExit( i );
			
   			showPlayerDialog( i, -1, DIALOG_STYLE_MSGBOX, "1", "1", "1","1");
		}
	}*/

	mysql_close( mysql );
	return 1;
}

public OnPlayerConnect( playerid )
{	
	Player_OnPlayerConnect( playerid );
	Vehicle_OnPlayerConnect( playerid );
	RemoveObj_OnPlayerConnect( playerid );
	TextDraws_OnPlayerConnect( playerid );
	Admin_OnPlayerConnect( playerid );
	Inv_OnPlayerConnect( playerid );
	//House_OnPlayerConnect( playerid );
	//Crime_OnPlayerConnect( playerid );
	Death_OnPlayerConnect( playerid );
	Obj_OnPlayerConnect( playerid );
	Att_OnPlayerConnect( playerid );
	return 1;
}

public OnPlayerRequestSpawn( playerid )
{
	return 0;
}

public OnPlayerRequestClass( playerid, classid )
{
	#pragma unused classid
	
	Player_OnPlayerRequestClass( playerid );
	
	return 1;
}

public OnPlayerSpawn( playerid ) 
{	
	if( IsPlayerNPC( playerid ) )
		return 1;
		
	if( !IsLogged( playerid ) && !GetPVarInt( playerid, "Login:Joined" ) ) 
		return Kick( playerid );
	
	Player_OnPlayerSpawn( playerid );
	Death_OnPlayerSpawn( playerid );
	Inv_OnPlayerSpawn( playerid );
	
	return 1;
} 

public OnPlayerDisconnect( playerid, reason )
{	
	if( IsPlayerNPC( playerid ) ) 
		return 1;
		
    if( !IsLogged( playerid ) ) 
		return 1;

	Vehicle_OnPlayerDisconnect( playerid, reason );
	House_OnPlayerDisconnect( playerid, reason );		//Только проверка на премиум
	Business_OnPlayerDisconnect( playerid, reason );	//Только проверка на премиум
	Player_OnPlayerDisconnect( playerid, reason );
	Admin_OnPlayerDisconnect( playerid, reason );
	Inv_OnPlayerDisconnect( playerid, reason );
	Death_OnPlayerDisconnect( playerid, reason );
	Interface_OnPlayerDisconnect( playerid );
	Job_OnPlayerDisconnect( playerid );
	San_OnPlayerDisconnect( playerid );
	
	return 1;
}

#include "gambit\cmd"

public OnPlayerEnterDynamicArea( playerid, areaid ) 
{
	clean_array();
	
	Prison_OnPlayerEnterDynamicArea( playerid, areaid );
	//Atm_OnPlayerEnterDynamicArea( playerid, areaid );
	Job_OnPlayerEnterDynamicArea( playerid, areaid );
	Fire_OnPlayerEnterDynamicArea( playerid, areaid );
	
	clean:<g_small_string>;
	foreach(new i: Player)
	{
	    if( !IsLogged( playerid ) ) 
			continue;
			
		if(areaid == GetPVarInt(i, "BBArea"))
  		{
			clean:<g_small_string>;
    		GetPVarString( i, "BBStation", g_small_string, sizeof g_small_string );
   			PlayAudioStreamForPlayer( playerid, g_small_string, GetPVarFloat(i, "BBX"), GetPVarFloat(i, "BBY"), GetPVarFloat(i, "BBZ"), 10.0, 1 );
    		break;
    	}
	}
	return 1;
}

public OnPlayerLeaveDynamicArea( playerid, areaid ) 
{
	clean_array();
	
	//Atm_OnPlayerLeaveDynamicArea( playerid, areaid );
	Job_OnPlayerLeaveDynamicArea( playerid, areaid );
	Prison_OnPlayerLeaveDynamicArea( playerid, areaid );

    foreach(new i: Player) 
	{
        if( !IsLogged( playerid ) ) 
			continue;
		
		if( areaid == GetPVarInt( i, "BBArea" ) )
		{
			StopAudioStreamForPlayer( playerid );
			break;
		}
	}
	
	return 1;
}

public OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] )
{
	clean_array();
	
	if( dialogid == INVALID_DIALOG_ID )
		return STATUS_OK;

	strreplace(inputtext, '%', '#');
	strreplace(inputtext, '\n', '#');
	
	if( Player[playerid][tDialogId] != dialogid )
		return STATUS_OK;
		
	Player[playerid][tDialogId] = -1;
	
	Admin_OnDialogResponse( playerid, dialogid, response, listitem, inputtext );
	UserMenu_OnDialogResponse( playerid, dialogid, response, listitem, inputtext );
	Extra_OnDialogResponse( playerid, dialogid, response, listitem, inputtext );
	Atm_OnDialogResponse( playerid, dialogid, response, listitem, inputtext ); 
	Pattach_OnDialogResponse( playerid, dialogid, response, listitem, inputtext ); 
	Target_OnDialogResponse( playerid, dialogid, response, listitem, inputtext );
	Inv_OnDialogResponse( playerid, dialogid, response, listitem, inputtext );
	//Radio_OnDialogResponse( playerid, dialogid, response, listitem, inputtext );
	Player_OnDialogResponse( playerid, dialogid, response, listitem, inputtext );
	Death_OnDialogResponse( playerid, dialogid, response, listitem, inputtext ); 
	Anim_OnDialogResponse( playerid, dialogid, response, listitem, inputtext );
	GPS_OnDialogResponse( playerid, dialogid, response, listitem, inputtext );
	San_OnDialogResponse( playerid, dialogid, response, listitem, inputtext );
	House_OnDialogResponse( playerid, dialogid, response, listitem, inputtext );
	Furniture_OnDialogResponse( playerid, dialogid, response, listitem, inputtext );
	Prison_OnDialogResponse( playerid, dialogid, response, listitem, inputtext );
	Crime_OnDialogResponse( playerid, dialogid, response, listitem, inputtext );
	Help_OnDialogResponse( playerid, dialogid, response, listitem, inputtext );
	Vehicle_OnDialogResponse( playerid, dialogid, response, listitem, inputtext );
	Frac_OnDialogResponse( playerid, dialogid, response, listitem, inputtext );
	Business_OnDialogResponse( playerid, dialogid, response, listitem, inputtext );
	IBusiness_OnDialogResponse( playerid, dialogid, response, inputtext );
	Job_OnDialogResponse( playerid, dialogid, response, listitem, inputtext );
	Phone_OnDialogResponse( playerid, dialogid, response, listitem, inputtext );
	Overpass_OnDialogResponse( playerid, dialogid, response, listitem, inputtext ); 
	Tune_OnDialogResponse( playerid, dialogid, response, listitem, inputtext ); 
	Lic_OnDialogResponse( playerid, dialogid, response, listitem, inputtext ); 
	Police_OnDialogResponse( playerid, dialogid, response, listitem, inputtext ); 
	Fire_OnDialogResponse( playerid, dialogid, response, listitem, inputtext ); 
	Obj_OnDialogResponse( playerid, dialogid, response, listitem, inputtext );
	Att_OnDialogResponse( playerid, dialogid, response, listitem, inputtext );
	City_OnDialogResponse( playerid, dialogid, response, listitem, inputtext );
	Donate_OnDialogResponse( playerid, dialogid, response, listitem, inputtext );
	
	return 1;
}

public OnPlayerEnterCheckpoint( playerid ) 
{
	clean_array();
	
	Job_OnPlayerEnterCheckpoint( playerid );
	GPS_OnPlayerEnterCheckpoint( playerid );

	DisablePlayerCheckpoint(playerid);
	return 1;
}

public OnDynamicObjectMoved( objectid ) 
{
	Job_OnDynamicObjectMoved( objectid );
	return 1;
}

public OnPlayerEnterRaceCheckpoint( playerid ) 
{
	Veh_OnPlayerEnterRaceCheckpoint( playerid );
	Job_OnPlayerEnterRaceCheckpoint( playerid );
	return 1;
}

public OnVehicleSpawn( vehicleid ) 
{
	Veh_OnVehicleSpawn( vehicleid );
	return 1;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid) 
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid) 
{
	return 1;
}

public OnPlayerEditDynamicObject( playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz ) 
{
	clean_array();
	
	Furn_OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz );
	Inv_OnPlayerEditDynamicObject( playerid, objectid, response, Float: x, Float: y, Float: z, Float: rx, Float: ry, Float: rz );
	Obj_OnPlayerEditDynamicObject( playerid, objectid, response, Float: x, Float:y, Float:z, Float:rx, Float:ry, Float:rz );
	
	return 0;
}

public OnPlayerCommandText( playerid, cmdtext[] ) 
{
	return 0;
}

public OnPlayerStreamIn( playerid, forplayerid ) 
{
	if( Player[playerid][uSettings][3] == 1 )
	{
		ShowPlayerNameTagForPlayer( playerid, forplayerid, true );
	}
	
	return 1;
}

public OnPlayerStreamOut( playerid, forplayerid )
{
	return 1;
}

public OnPlayerStateChange( playerid, newstate, oldstate ) 
{
	AntiCheat_OnPlayerStateChange( playerid, newstate, oldstate );	
	Vehicle_OnPlayerStateChange( playerid, newstate, oldstate );
	Job_OnPlayerStateChange( playerid, newstate, oldstate );
    return 1;
}

public OnPlayerGiveDamage( playerid, damagedid, Float: amount, weaponid, bodypart ) 
{
	Death_OnPlayerGiveDamage( playerid, damagedid, Float: amount, weaponid, bodypart ); 
    return 1;
}

public OnPlayerTakeDamage( playerid, issuerid, Float: amount, weaponid, bodypart )
{
	if( GetPVarInt( playerid, "Join:Timer" ) )
	{
		printf( "playerid = %d amount = %f weaponid = %d bodypart = %d", playerid, amount, weaponid, bodypart );
	}

	AntiCheat_OnPlayerTakeDamage( playerid, issuerid, Float: amount, weaponid, bodypart );
	Death_OnPlayerTakeDamage( playerid, issuerid, Float: amount, weaponid, bodypart );
	return 1;
}

public OnPlayerEnterVehicle( playerid, vehicleid, ispassenger )
{
	AntiCheat_OnPlayerEnterVehicle( playerid, vehicleid, ispassenger );
	Strobe_OnPlayerEnterVehicle( playerid, vehicleid );
	Frac_OnPlayerEnterVehicle( playerid, vehicleid, ispassenger );
	Job_OnPlayerEnterVehicle( playerid, vehicleid );
	
	return 1;
}

public OnPlayerExitVehicle( playerid, vehicleid )
{
	AntiCheat_OnPlayerExitVehicle( playerid, vehicleid );
	Strobe_OnPlayerExitVehicle( playerid, vehicleid );
	Job_OnPlayerExitVehicle( playerid, vehicleid );
	
	return 1;
}

public OnVehicleDeath( vehicleid, killerid )
{
    printf("[Log]: Player %s[%d] death vehicle ID %d", Player[killerid][uName], killerid, vehicleid );
	
	AntiCheat_OnVehicleDeath( vehicleid, killerid );
	Job_OnVehicleDeath( vehicleid, killerid );
	Strobe_OnVehicleDeath( vehicleid );
	Frac_OnVehicleDeath( vehicleid );
	
	if( vehicleid >= cars_prod[0] && vehicleid <= cars_mech[1] ) return 1;

	Vehicle[vehicleid][vehicle_death] = true;
	
	return 1;
}

public OnPlayerDeath( playerid, killerid, reason )
{	
    SetCameraBehindPlayer(playerid);

	if( GetPlayerWeapon( killerid ) > 34 && GetPlayerWeapon( killerid ) < 41 )
		CheatDetected( playerid, "DGun", CHEAT_GUN, 2 );
		
	if( !IsLogged( playerid ) )
		gbKick( playerid );
		
	if( GetPVarInt( playerid, "Player:Follow" ) != INVALID_PLAYER_ID ) 
	{
		SetPVarInt( GetPVarInt( playerid,"Player:Follow" ), "Player:Lead", INVALID_PLAYER_ID );
	}
	else if( GetPVarInt( playerid, "Player:Lead" ) != INVALID_PLAYER_ID )
	{
		SetPVarInt( GetPVarInt( playerid,"Player:Lead" ), "Player:Follow", INVALID_PLAYER_ID );
	}
	
	Admin_OnPlayerDeath( playerid, killerid, reason );
	Death_OnPlayerDeath( playerid, killerid, reason );
	Interface_OnPlayerDeath( playerid );
	Job_OnPlayerDeath( playerid );
	San_OnPlayerDeath( playerid, killerid, reason );
	
	return 1;
}

public OnVehicleMod(playerid,vehicleid,componentid) 
{
    return 0;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2) 
{
    return 1;
}

public OnVehiclePaintjob(playerid,vehicleid, paintjobid) 
{
    return 0;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid) 
{
	CheckVehicleDamageStatus( vehicleid );
	Job_OnVehicleDamageStatusUpdate( vehicleid, playerid );
	
	return 1;
}

public OnEnterExitModShop( playerid, enterexit, interiorid ) 
{
    return 1;
} 

public OnObjectMoved( objectid ) 
{
    return 1;
}

public OnPlayerKeyStateChange( playerid, newkeys, oldkeys ) 
{
	Player_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	Help_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	Enter_OnPlayerKeyStateChange( playerid, newkeys );
	Target_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	Inv_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	Anim_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	San_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	House_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	Furn_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	Texture_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	Prison_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	Crime_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	Vehicle_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	Atm_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	Gate_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	Door_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	UserMenu_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	Business_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	Job_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	Phone_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	Overpass_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	Tuning_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	Lic_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	Police_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	Fire_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	City_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	Frac_OnPlayerKeyStateChange( playerid, newkeys, oldkeys );
	
	clean_array();
	
	new 
		car = GetPlayerVehicleID( playerid );

	if( ( newkeys & KEY_ACTION ) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER )
	{
	    if( IsVelo( car ) && GetVehicleSpeed( GetPlayerVehicleID( playerid ) ) > 10 )
		{
		    new Float: slx, Float: sly, Float: slz;
		    GetPlayerPos(playerid, slx, sly, slz);
	    	setPlayerPos(playerid, slx, sly, slz+1);
	    	GameTextForPlayer( playerid, "~r~You fell", 3000, 1 );
		}
	}
	
	if(newkeys & KEY_JUMP && newkeys & KEY_SPRINT) 
	{
	    if( GetPVarInt(playerid, "Procedure") >= 1 ) return 1;
	    else if( !IsPlayerInAnyVehicle( playerid ) ) 
		{
			new index = GetPlayerAnimationIndex(playerid);
			
			if( index == 1224 || index == 1247 || index == 1257 || index == 1249 || index == 1196 || index == 1249 ) 
			{
				new 
					keys, ud, lr;
					
				GetPlayerKeys( playerid, keys, ud, lr );
				if(ud != 0 || lr != 0) ClearAnimations(playerid);
			}
		}
	}
	
	return 1;
}

public OnPlayerClickPlayerTextDraw( playerid, PlayerText:playertextid ) 
{
	Inv_OnPlayerClickPlayerTextDraw( playerid, PlayerText: playertextid );
	Bus_OnPlayerClickPlayerTextDraw( playerid, PlayerText: playertextid );
	
	return 1;
}

public OnPlayerClickPlayer( playerid, clickedplayerid, source )
{
	if( source == CLICK_SOURCE_SCOREBOARD )
	{
		Admin_OnPlayerClickPlayer( playerid, clickedplayerid );
	}
	
	return 1;
}

public OnPlayerClickMap( playerid, Float:fX, Float:fY, Float:fZ )
{
	Admin_OnPlayerClickMap( playerid, Float:fX, Float:fY, Float:fZ );
	Job_OnPlayerClickMap( playerid, Float:fX, Float:fY, Float:fZ );
	
	return 1;
}

public OnPlayerClickTextDraw( playerid, Text: clickedid ) 
{
	Skin_OnPlayerClickTextDraw( playerid, Text: clickedid );
	Inv_OnPlayerClickTextDraw( playerid, Text: clickedid );
	Furniture_OnPlayerClickTextDraw( playerid, Text: clickedid );
	UserMenu_OnPlayerClickTextDraw( playerid, Text: clickedid );
	IBusiness_OnPlayerClickTextDraw( playerid, Text:clickedid );
	Phone_OnPlayerClickTextDraw( playerid, Text:clickedid );
	Tuning_OnPlayerClickTextDraw( playerid, Text:clickedid );
	Vehicle_OnPlayerClickTextDraw( playerid, Text:clickedid );

    if( _:clickedid == INVALID_TEXT_DRAW ) 
	{	
		switch( GetPVarInt( playerid, "PlayerMenuShow" ) ) 
		{
		    case 2: 
			{
		        SetPVarInt(playerid,"PlayerMenuShow",0);
		        CancelSelectTextDraw(playerid);
				return 1;
		    }
			case 6: 
			{
			    for(new i; i != 6; i ++) TextDrawHideForPlayer(playerid, furnitureBuy[i]);
				PlayerTextDrawHide(playerid, furniturePrice[playerid]);
			    SetPVarInt(playerid,"PlayerMenuShow",0);
			    SetCameraBehindPlayer(playerid);
			    CancelSelectTextDraw(playerid);
			    togglePlayerControllable(playerid,true);
				return 1;
			}
		}
    }
	
	return 0;
}


public OnPlayerText( playerid, text[] ) 
{
	Chat_OnPlayerText( playerid, text );
	return 0;
}

public OnPlayerShootDynamicObject(playerid, weaponid, objectid, Float:x, Float:y, Float:z) 
{
	return 1;
}

public OnPlayerSelectedMenuRow( playerid, row )
{
	Admin_OnPlayerSelectedMenuRow( playerid, row );
	
	return 1;
}

public OnPlayerWeaponShot( playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ ) 
{
	if( GetPVarInt( playerid, "Shoot:GreenZone" ) )
	{
		DeletePVar( playerid, "Shoot:GreenZone" );
		return 0;
	}

	Admin_OnPlayerWeaponShot( playerid, hitid );
	
	return 1;   
}

function VehicleToPoint( Float:radi, vehicleid, Float:x, Float:y, Float:z ) 
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetVehiclePos(vehicleid, oldposx, oldposy, oldposz);
	tempposx = (oldposx -x);
	tempposy = (oldposy -y);
	tempposz = (oldposz -z);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi))) return 1;
	return 0;
}

stock SetPlayerToFacePlayer(playerid, targetid) 
{
    new Float:pX, Float:pY, Float:pZ, Float:X, Float:Y, Float:Z,Float:ang;
    if(!IsPlayerConnected(playerid) || !IsPlayerConnected(targetid)) return 0;
    GetPlayerPos(targetid, X, Y, Z);
    GetPlayerPos(playerid, pX, pY, pZ);
    if( Y > pY ) ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
    else if( Y < pY && X < pX ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
    else if( Y < pY ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
    if(X > pX) ang = (floatabs(floatabs(ang) + 180.0));
    else ang = (floatabs(ang) - 180.0);
    SetPlayerFacingAngle(playerid, ang);
    return 0;
}

stock IsPlane(carid) 
{
	switch(GetVehicleModel(carid)) 
	{ case 417,425,447,460,469,467,476,487,488,497,511,512,513,519,520,548,553,563,577,592,593: return true; }
	return false;
}

stock GetAvailableSeat(vehicleid, start = 1)
{
	new seats = GetVehicleMaxSeats(vehicleid);

	for (new i = start; i < seats; i ++) if (!IsVehicleSeatUsed(vehicleid, i)) {
	    return i;
	}
	return -1;
}

stock GetVehicleMaxSeats(vehicleid)
{
    static const g_arrMaxSeats[] = {
		4, 2, 2, 2, 4, 4, 1, 2, 2, 4, 2, 2, 2, 4, 2, 2, 4, 2, 4, 2, 4, 4, 2, 2, 2, 1, 4, 4, 4, 2,
		1, 7, 1, 2, 2, 0, 2, 7, 4, 2, 4, 1, 2, 2, 2, 4, 1, 2, 1, 0, 0, 2, 1, 1, 1, 2, 2, 2, 4, 4,
		2, 2, 2, 2, 1, 1, 4, 4, 2, 2, 4, 2, 1, 1, 2, 2, 1, 2, 2, 4, 2, 1, 4, 3, 1, 1, 1, 4, 2, 2,
		4, 2, 4, 1, 2, 2, 2, 4, 4, 2, 2, 1, 2, 2, 2, 2, 2, 4, 2, 1, 1, 2, 1, 1, 2, 2, 4, 2, 2, 1,
		1, 2, 2, 2, 2, 2, 2, 2, 2, 4, 1, 1, 1, 2, 2, 2, 2, 7, 7, 1, 4, 2, 2, 2, 2, 2, 4, 4, 2, 2,
		4, 4, 2, 1, 2, 2, 2, 2, 2, 2, 4, 4, 2, 2, 1, 2, 4, 4, 1, 0, 0, 1, 1, 2, 1, 2, 2, 1, 2, 4,
		4, 2, 4, 1, 0, 4, 2, 2, 2, 2, 0, 0, 7, 2, 2, 1, 4, 4, 4, 2, 2, 2, 2, 2, 4, 2, 0, 0, 0, 4,
		0, 0
	};
	new
	    model = GetVehicleModel(vehicleid);

	if (400 <= model <= 611)
	    return g_arrMaxSeats[model - 400];

	return 0;
}

stock IsVehicleSeatUsed(vehicleid, seat)
{
	foreach (new i : Player) if (IsPlayerInVehicle(i, vehicleid) && GetPlayerVehicleSeat(i) == seat) {
	    return 1;
	}
	return 0;
}

stock getDay(day = 0,month = 0, year = 0) 
{
	if(!day) getdate(year, month, day);
	new j, e, days;
	if (month <= 2) 
	{
    	month += 12;
    	--year;
    }
    j = year % 100;
  	e = year / 100;
  	days = (day + (month + 1) * 26/10 + j + j/4 + e/4 - 2 * e) % 7;
	return days;
}

public OnVehicleStreamIn(vehicleid, forplayerid) {

 	return 1;
}

stock TurnPlayerFaceToPlayer(playerid, facingtoid)
{
    new Float:angle;
    new Float:misc = 5.0;
    new Float:x, Float:y, Float:z;
    new Float:ix, Float:iy, Float:iz;
    GetPlayerPos(facingtoid, x, y, z);
    GetPlayerPos(playerid, ix, iy, iz);
    angle = 180.0-atan2(ix-x,iy-y);
    angle += misc;
    misc *= -1;
    SetPlayerFacingAngle(playerid, angle+misc);
}

public OnPlayerEditAttachedObject( playerid, response, index, modelid, boneid,Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ,Float:fRotX, Float:fRotY, Float:fRotZ,Float:fScaleX, Float:fScaleY, Float:fScaleZ ) 
{
	Att_OnPlayerEditAttachedObject( playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ );
	if( Inv_OnPlayerEditAttachedObject( playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ ) )
		return 1;
		
	SetPlayerAttachedObject(playerid,index,modelid,boneid,fOffsetX,fOffsetY,fOffsetZ,fRotX,fRotY,fRotZ,fScaleX,fScaleY,fScaleZ);
    return 1;
}

public OnPlayerSelectDynamicObject(playerid, objectid, modelid, Float:x, Float:y, Float:z) 
{	
	Obj_OnPlayerSelectDynamicObject( playerid, objectid, modelid, Float: x, Float: y, Float: z );
	return 1;
}

public OnPlayerCommandReceived( playerid, cmdtext[] ) 
{
	clean:<g_small_string>;
	clean:<g_big_string>;
	clean:<g_string>;
	
	if( !IsLogged( playerid ) ) 
	{
		SendClientMessage( playerid, C_WHITE, !""gbError"Для того, чтобы использовать команды, необходимо авторизоваться." );
		return 0;
	}
	
	return 1;
}

public OnPlayerCommandPerformed( playerid, cmdtext[], success ) 
{
	if( !success ) 
		return SendClientMessage(playerid, C_WHITE, !""gbError"Данная команда не существует. Для помощи используйте - "cBLUE"Y"cWHITE".");
	
	return 1;
}
 
function OnCheatDetected(playerid, ip_address[], type, code)
{
	switch( code )
	{
		case 6, 13, 12, 14, 15, 32, 40, 41, 52: return 1; //CarJack, HigthPing, CheatWeapon, CheatMoney, Teleport Hack (pickups), CheatHealth, CheatArmour
		
		case 5:
		{
			new
				model = GetVehicleModel( GetPlayerVehicleID( playerid ) );
		
			if( model == 435 ||
				model == 450 || 
				model == 584 || 
				model == 591 )
				return 1;
			else
			{
				CheatDetected( playerid, CHEAT_NAME_NEXAC[code], code + 1000, 2 );
			}
		}
		
		default:
		{
			CheatDetected( playerid, CHEAT_NAME_NEXAC[code], code + 1000, 2 );
		}
	}
	
	return 1;
}