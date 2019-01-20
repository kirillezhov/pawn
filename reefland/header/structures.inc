enum
{
	CHEAT_JETPACK = 1,
	CHEAT_SPEEDHACK,
	CHEAT_NOP_TELEPORT,
	CHEAT_AIRBREAK,
	CHEAT_AIRBREAK_CAR,
	CHEAT_CARSHOT,
	CHEAT_CARSPAM,
	CHEAT_SPECTATE,
	CHEAT_NOP_REMOVE_FROM_VEH,
	CHEAT_TP_IN_CAR,
	CHEAT_P_RVANKA,
	CHEAT_NOP_PUT_IN_VEH,
	CHEAT_SPAWN_CAR,
	CHEAT_GUN,
	CHEAT_GUN_2,
	CHEAT_REFILL,
	CHEAT_DIALOG_ID,
	CHEAT_CARHEAL,
	CHEAT_DAMAGE_DB
}

enum
{
	STATUS_ERROR = 0,
	STATUS_OK,
	STATUS_DONE,
}

enum SAZONE_MAIN
{ 
	SAZONE_NAME[28],
	Float:SAZONE_AREA[6]
}

enum e_MYSQL
{
	HOST,
	USERNAME,
	PASSWORD,
	DATABASE
}

enum e_PLAYER_SETTINGS
{
	s_speed = 0,
	s_spawn,
	s_names,
	s_advert,
	s_admin_action,
	s_walk,
	s_talk,
	s_radio,
	s_logo
}

new
	CHEAT_NAME_NEXAC[][] = 
	{
		{"AirBreak (onfoot)"},
		{"AirBreak (in vehicle)"},
		{"Teleport Hack (onfoot)"},
		{"Teleport Hack (in vehicle)"},
		{"Teleport Hack (into/between vehicles)"},
		{"Teleport Hack (vehicle to player)"},
		{"Teleport Hack (pickups)"},
		{"FlyHack (onfoot"},
		{"FlyHack (in vehicle)"},
		{"SpeedHack (onfoot)"},
		{"SpeedHack (in vehicle)"},
		{"Health Hack (in vehicle)"},
		{"Health Hack (onfoot)"},
		{"Armour Hack"},
		{"Money Hack"},
		{"Weapon Hack"},
		{"Ammo Hack (add)"},
		{"Ammo Hack (infinite)"},
		{"Special Actions Hack"},
		{"GodMode From Bullets (onfoot)"},
		{"GodMode From Bullets (in vehicle)"},
		{"Invisible Hack"},
		{"Lagcomp-Spoof"},
		{"Tuning Hack"},
		{"Parkour Mod"},
		{"Quick Turn"},
		{"Rapid Fire"},
		{"FakeSpawn"},
		{"FakeKill"},
		{"Pro Aim"},
		{"CJ Run"},
		{"CarShot"},
		{"CarJack"},
		{"UnFreeze"},
		{"AFK Ghost"},
		{"Full Aiming"},
		{"Fake NPC"},
		{"Reconnect"},
		{"High Ping"},
		{"Dialog Hack"},
		{"Protection From The Sandbox"},
		{"Protection Against An Invalid Version"},
		{"Rcon Hack"},
		{"Tuning Crasher"},
		{"Invalid Seat Crasher"},
		{"Dialog Crasher"},
		{"Attached Object Crasher"},
		{"Weapon Crasher"},
		{"Flood Protection Connects To One Slot"},
		{"Flood Callback Functions"},
		{"Flood Change Seat"},
		{"Anti-Ddos"},
		{"Anti-NOP's"}
	};