
enum e_ADMIN
{
	aID,
	aUserID,
	aName[ MAX_PLAYER_NAME ],
	aLevel,
	aPassword[ 65 ],
	aStatus,
	aActive,
	aStats[ 4 ],
	aOnline[ 4 ],
	aHacked,
	aFirstIp[ 17 ],
}

enum e_SUPPORT 
{
	sID,
	sUserID,
	sName[ MAX_PLAYER_NAME ],
	sStatus,
	sActive,
	sStats[ 2 ],
}

enum e_PERMISSION 
{
	pName[ MAX_PLAYER_NAME ],
	pDescription[ 128 ],
	pLevel,
}

enum e_ADMIN_VEHICLE 
{
	avID,
	avServerID,
	avModel,
	avAdmin[ MAX_PLAYER_NAME ],
}

enum e_KILL_LOG
{
	killerID,
	killerName[ MAX_PLAYER_NAME ],
	killerGun,
	killedName[ MAX_PLAYER_NAME ],
	killedID,
	killedTime,
}

enum e_DISCONNECT_LOG
{
	disconnectName[ MAX_PLAYER_NAME ],
	disconnectReason[ 12 ],
	disconnectTime,
}

enum e_OFFLINE_BAN
{
	ban_name 	[ 24 ],
	ban_reason 	[ 128 ],
	ban_days,
}
    
new
	Admin							[ MAX_PLAYERS ][ e_ADMIN ],
	Permission						[ MAX_PERMISSIONS ][ e_PERMISSION ],
	Support                         [ MAX_PLAYERS ][ e_SUPPORT ],
	AdminVehicle                    [ MAX_VEHICLES ][ e_ADMIN_VEHICLE ],
	KillLog							[ MAX_LOGS ][ e_KILL_LOG ],
	DisconnectLog					[ MAX_LOGS ][ e_DISCONNECT_LOG ],
	offline_ban						[ e_OFFLINE_BAN ];
	
new
	Menu: AdminSpectateMenu;
	
new 
	Text: admin_bg,
	
	PlayerText: admin_player_name	[ MAX_PLAYERS ],
	PlayerText: admin_player_info	[ MAX_PLAYERS ];
	