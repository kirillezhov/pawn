
#define GetPremiumAccount(%0)		premium_type[%0]
#define td_opacity_cBLUE				(945389692)

const
	MAX_LINE_CLEAR	= 20;

new
	Text: gmBox,
	Text: gmBarText						[2],
	Text: gmListItem					[5],
	Text: gmListItemName				[5],
	Text: gmHealthBar,
	Text: gmArmourBar,
	PlayerText: gmHealthProgressBar 	[MAX_PLAYERS],
	PlayerText: gmArmourProgressBar 	[MAX_PLAYERS],
	PlayerText: gmName					[MAX_PLAYERS],
	PlayerText: gmPremium				[MAX_PLAYERS];

new const
	premium_type[][] = 
	{
		{"None"},
		{"~y~Light"},
		{"~g~Medium"},
		{"~r~Hard"}
	};

stock hideChat( playerid )
{
	if( GetPVarInt( playerid, "GameMenu:Show") )
	{
		for( new i; i < MAX_LINE_CLEAR; i++ )
			SendClientMessage( playerid, C_WHITE, "" );
	}
	
	return 1;
}