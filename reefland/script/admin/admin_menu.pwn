Admin_OnPlayerSelectedMenuRow( playerid, row )
{
	if( GetPlayerMenu( playerid ) == AdminSpectateMenu )
	{
		switch( row )
		{
			case 0 : // Next
			{
				if( GetPVarInt( playerid, "Admin:SpectateId") >= GetPlayerPoolSize() )
				{
					SetPVarInt( playerid, "Admin:SpectateId", 0 );
				}
				else
				{
					GivePVarInt( playerid, "Admin:SpectateId", 1 );
				}
						
				for( new i = GetPVarInt( playerid, "Admin:SpectateId" ), j = GetPlayerPoolSize(); i <= j; i++ )
				{
					if( !IsLogged( i ) || ( i == playerid ) || IsSpectated( i ) || ( Admin[i][aLevel] > 4 && Admin[playerid][aLevel] < 4 ) )
						continue;
					
					AdminUpdateSpectatePlayer( playerid, i );
					
					SetPVarInt( playerid, "Admin:SpectateId", i );
					
					break;
				}
			}
			
			case 1 : // Back
			{
				new
					specid = GetPVarInt( playerid, "Admin:SpectateId" );
			
				if( GetPVarInt( playerid, "Admin:SpectateId" ) <= 0 )
				{
					SetPVarInt( playerid, "Admin:SpectateId", GetPlayerPoolSize() );
				}
				else 
				{
					TakePVarInt( playerid, "Admin:SpectateId", 1 );
				}
					
				for( new i = GetPVarInt( playerid, "Admin:SpectateId"); i >= 0; i-- )
				{
					if( !IsLogged( i ) || ( i == playerid ) || IsSpectated( i ) || ( Admin[i][aLevel] > 4 && Admin[playerid][aLevel] < 4 ) )
							continue;
						
					AdminUpdateSpectatePlayer( playerid, i );
					SetPVarInt( playerid, "Admin:SpectateId", i );
					
					return 1;
				}
				
				SetPVarInt( playerid, "Admin:SpectateId", specid );
				AdminUpdateSpectatePlayer( playerid, specid );
			}
			
			case 2 : // Update
			{
				new 
					i = GetPVarInt( playerid, "Admin:SpectateId" );
				
				if( !IsLogged( i ) || i == playerid )
				{
					SendClientMessage( playerid, C_WHITE, ""gbDefault"Данный игрок отсоединился от сервера.");
					return AdminUnSpectate( playerid );
				}
							
				AdminUpdateSpectatePlayer( playerid, i );
					
				SetPVarInt( playerid, "Admin:SpectateId", i );
			}
			
			case 3 : // Exit
				return AdminUnSpectate( playerid );
		}
	}
	
	return 1;
}