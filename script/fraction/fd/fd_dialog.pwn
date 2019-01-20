function Fire_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{	
	switch( dialogid ) 
	{	
		case d_fire:
		{
			if( !response ) return 1;
			
			new
				Float:X,
				Float:Y,
				Float:Z,
				seconds = randomize( 3, 8 ) * 60000;
				
			GetPlayerPos( playerid, X, Y, Z );
			
			SetSVarFloat( "Fire:X", X );
			SetSVarFloat( "Fire:Y", Y );
			SetSVarFloat( "Fire:Z", Z - 2.5 );
			
			SetSVarInt( "Fire:World", GetPlayerVirtualWorld( playerid ) );
			SetSVarInt( "Fire:Interior", GetPlayerInterior( playerid ) );
			
			CreateFire( 0, X, Y, Z - 2.5, GetPlayerVirtualWorld( playerid ), GetPlayerInterior( playerid ) );
			
			FIRE_ZONE = CreateDynamicCircle( X, Y, 15.0, GetPlayerVirtualWorld( playerid ), GetPlayerInterior( playerid ), -1 );
			FIRE_TIMER = SetTimer( "OnTimerFire", seconds, 0 );
			
			ClearAnimations( playerid );
			UseAnim( playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0 );
		}
	}
	
	return 1;
}