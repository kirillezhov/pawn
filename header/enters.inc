
const
	MAX_ENTERS = 200,
	MAX_ENTERS_INSIDE = 200;

enum eInfo 
{
	eID,
	Float:eP[3],
	Float:ePe[3],
	eInt[2],
	eName[32],
	exInt[2],
}

enum e_INSIDE 
{
	e_id,
	Float:e_pos[3],
	Float:e_pos_exit[3],
	e_name[12],
	e_world,
}

new 
	EnterInfo		[ MAX_ENTERS ][ eInfo ],
	EnterInside		[ MAX_ENTERS_INSIDE ][ e_INSIDE ];