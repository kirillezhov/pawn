#define NUMBER_GUNDEALER		( 2929282 )
#define DAYS_TO_GUNDEALER		( 5 )

const
	MAX_CRIMINAL = 30,
	MAX_POINTS = 50,
	PERCENT_FOR_VEHICLE = 30,
	MAX_CRIME_ORDERS = 50;

enum e_CRIME_FRACTION 
{
	c_id,					//�� �������
	c_name[64],				//�������� �������
	c_type,					//��� �������
	c_leader[3],			//uID ������� �������
	c_vehicles,				//����������� �� ���������� ����������
	c_ranks,				//���������� ������ �� �������
	c_amountveh,			//���������� ���������� ����������
	c_members,				//���������� ������� �� �������
	c_type_vehicles,		//����������� ������������ ����������
	c_type_weapon,			//��� ������ � ��� �������
	
	c_time,					//����� ������� �������� ����������� �������
	c_time_dealer,			//����� ������� �������� �����
	c_amount_weapon,		//���������� ������ ��� ������
	c_index_dealer,			//������ ������
}

enum e_CRIME_RANK
{
	r_id,				
	r_fracid,				//�� �������
	r_name[32],				//�������� �����
	r_invite,				//����� �� ��������� �� �������
	r_uninvite,				//����� �� ��������� �� �������
	Float:r_spawn[4],		//����� ������
	r_world[2],				//����������� ��� � �������� � ������
	r_attach,				//����� �� ������������ ������
	r_spawnveh,				//����������� ������ ����������
	r_vehicles[10],			//��������� �� ������������� ����� (������ ������ �����)
	r_call_weapon,			//������ ����������
}

enum e_CRIME_MEMBER
{
	m_id,
	m_name					[ MAX_PLAYER_NAME ],
	m_rank,
	m_lasttime,
}

enum e_CRIME_VEH
{
	v_id,
	v_number[10],
}

enum e_GUNDEALER
{
	g_id,
	g_actor,
	Float:g_actor_pos[4],
	g_car,
	Float:g_car_pos[4],
	g_time,
	g_fracid,
	g_car_id,
	g_actor_id,
	g_zone[30],
	Text3D: g_text,
}

enum e_GUN_ORDER
{
	gun_id[10],			//������, ������� ������ id ���������
	gun_amount[10],		//������, ������� ������ ���������� ���������
}

enum e_GUN_INFO
{
	gun_type,
	gun_id,
	gun_price,
	gun_amount,
}

enum e_CRIME_ATTACH
{
	c_a_name[32],
	c_a_object,
}

new
	CrimeFraction		[ MAX_CRIMINAL ][ e_CRIME_FRACTION ],
	CrimeRank			[ MAX_CRIMINAL ][ MAX_RANKS ][ e_CRIME_RANK ],
	CNameLeader			[ MAX_CRIMINAL ][ 3 ][ MAX_PLAYER_NAME ],
	CMember				[ MAX_CRIMINAL ][ MAX_MEMBERS ][ e_CRIME_MEMBER ],
	CVehicle			[ MAX_CRIMINAL ][ MAX_FRACVEHICLES ][ e_CRIME_VEH ],
	GunDealer			[ MAX_POINTS ][ e_GUNDEALER ],
	CrimeOrder			[ MAX_CRIMINAL ][ 2 ][ e_GUN_ORDER ],
	DealerOrder			[ MAX_POINTS ][ 2 ][ e_GUN_ORDER ];

new	const
	crime_vehicles[][] = // Max 30
	{
		{//�����
			412,413,419,439,440,459,466,467,474,479,
			483,491,492,517,518,516,534,535,536,542,
			551,566,567,575,576,600,0,0,0,0
		},
		{//�����
			400,405,409,440,421,426,445,468,505,507,
			529,533,540,545,546,547,550,555,579,580,
			585,587,0,0,0,0,0,0,0,0
		},
		{//���������
			463,482,440,413,586, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		}
	},
	
	Float:crime_vehicles_spawn[][][] = 
	{
		{ 
			{ 126.5613, -228.4217, 2.0146, 179.8645 },
			{ 52.0552, -286.5670, 2.1392, 359.8896 },
			{ 103.0101, -288.1937, 2.0157, 357.8291 },
			{ 138.4312, -266.2670, 2.0158, 91.4675 },
			{ 164.3602, -294.7997, 2.0158, 270.1980 }
		},
		{
			{ -36.0146, -578.3973, -0.1773, 228.2476 },
			{ -44.5738, -586.8409, -0.1574, 225.3061 },
			{ -100.3164, -576.2678, -0.1841, 45.2811 },
			{ -88.0937, -588.6165, -0.1518, 224.8030 },
			{ -96.6650, -596.7802, -0.1449, 225.0151 }
		},
		{
			{ 424.8195, 2493.4226, 17.0471, 92.4815 },
			{ 424.7343, 2512.6604, 17.0468, 88.5380 },
			{ 381.8303, 2538.4492, 16.7168, 180.3289 },
			{ 352.6781, 2537.7917, 16.9033, 180.5451 },
			{ 338.2017, 2464.5747, 17.0266, 357.3731 }
		}
	},
	
	crime_vehicles_description[][] =
	{
		{ "��������� ��������� �� ������ ������ � Blueberry." },
		{ "��������� ��������� � ������� �� Farms Connector." },
		{ "��������� ��������� �� ����������� ���������." }
	},
	
	weapons_info[][][ e_GUN_INFO ] = 
	{
		{	//������
			{ 1, 14, 1800, 17 }, //M1911
			{ 1, 17, 2390, 7 },  //��������� ����
			{ 1, 25, 3000, 50 },  //TEC-9
			{ 2, 15, 2100, 17 }, //M1911 c ����������
			{ 2, 18, 2150, 8 },  //��������
			{ 3, 20, 3300, 8 },  //������ ��������
			{ 3, 21, 2900, 50 },  //MAC-10
			{ 3, 23, 4500, 30 },  //��
			{ 3, 27, 6500, 16 }, //����������� ��������
			//{ 3, 103, 300, 5 }   //������� �����
			{ 0, 0, 0, 0 }
		},
		{	//�������
			{ 1, 35, 210, 51 }, //������� ��� M1911
			{ 1, 36, 175, 21 }, //������� ��� ���������� ����
			{ 2, 37, 350, 24 }, //��������,������ ��������
			{ 2, 38, 420, 100 },//TEC-9, MAC-10
			{ 3, 39, 540, 60 }, //��������,��
			{ 0, 0, 0, 0 },
			{ 0, 0, 0, 0 },
			{ 0, 0, 0, 0 },
			{ 0, 0, 0, 0 },
			{ 0, 0, 0, 0 }
		}
	},
	
	crime_attach[][ e_CRIME_ATTACH ] = 
	{
		{ "������ �����", 11745 },
		{ "��������� �����", 19036 },
		{ "���������", 19801 },
		{ "�����", 19942 },
		{ "����� � ��������", 1550 },
		{ "����� � ����������� (�����)", 1575 },
		{ "����� � ����������� (�������)", 1580 },
		{ "����� � ����������� (������)", 1577 },
		{ "����� � ����������� (�������)", 1578 },
		{ "����� � ����������� (�����)", 1579 },
		{ "����������", 19472 },
		{ "������� ����", 19627 },
		{ "�������", 18635 },
		{ "����������", 18634 },
		{ "�������", 18641 },
		{ "������", 19773 },
		{ "��������", 19625 },
		{ "������", 1485 },
		{ "�����", 3027 },
		{ "����������� ����", 19914 },
		{ "����������� ���� c ��������", 2045 },
		{ "����� �����", 1212 },
		{ "���", 335 },
		{ "��������������� �����", 19904 }
	};
	
#define crime_change		"\
								"cBLUE"1. "cWHITE"��������\n\
								"cBLUE"2. "cWHITE"����� ����������\n\
								"cBLUE"3. "cWHITE"������ ����������\n\
								"cBLUE"4. "cWHITE"���������\
							"
							
#define weapon_change		"\
								"cWHITE"���\n\
								1 ������\n\
								2 ������\n\
								3 ������\n\
								"gbDialog"����������\
							"
							
#define weapon_info			"\
								"cBLUE"����������\n\n\
								"cWHITE"������ ��������� ��������� �������� ��������� ���������� ������ � ����������.\n\
								������� �������� �������� �� ������������ �����������, ������ ����� ����� �������� ��� ���������\n\n\
								"cBLUE"1 ������: "cWHITE"M1911, ��������� ����\n\
								"cBLUE"2 ������: "cWHITE"M1911, M1911 � ����������, ��������� ����, ��������, TEC-9\n\
								"cBLUE"3 ������: "cWHITE"M1911, M1911 � ����������, ��������� ����, ��������, ������ ��������\n\
								TEC-9, MAC-10, AK, ����������� ��������\
							"
							
#define crime_vehicle		"\
								"cWHITE"\t"cWHITE"���������\n\
								"cWHITE"������������ ����������\t"cBLUE"%s\
							"
							
#define mpanel_dialog		"\
								"cBLUE"1. "cWHITE"������ �����������\n\
								"cBLUE"2. "cWHITE"������ ������\n\
								"cBLUE"3. "cWHITE"���������\n\
								"cBLUE"4. "cWHITE"�������� ���������� ������\
							"	
							
#define mpanel_settings		"\
								"cWHITE"���������\t"cWHITE"��������\n\
								�������� ��������\n\
								����� �������\t"cBLUE"%s"cWHITE"\n\
								���������� �������\t"cBLUE"%s"cWHITE"\n\
								������������� �������\t"cBLUE"%s"cWHITE"\n\
								����� ����������\t"cBLUE"%s"cWHITE"\n\
								������ ���������\t"cBLUE"%s"cWHITE"\n\
								������������� ����������\n\
								��������� ������ �����\n\
								���������� ���� ������\t"cGRAY"/setrank\n\
								"gbDialog"������� ����\
							"
							
#define mpanel_vehicles		"\
								"cWHITE"��������\t"cWHITE"������\n\
								������ ����������\n\
								������������ ����������\n\
								������� ��������� �� ����������� �����\t"cGRAY"/fixcar"cWHITE"\n\
								������� ���� ��������� �� ����������� �����\t"cGRAY"/fixcarall"cWHITE"\n\
								������������ ���������\t"cGRAY"/park"cWHITE"\n\
								������� ���������\
							"	
							
#define dialog_gundealer	"\
								"cBLUE"��������� �����\n\n\
								"cWHITE"�� ��������� ������ ��� ������ ������ ������.\n\n\
								����� ������������ ����������� �������� ������ "cBLUE"%d"cWHITE" ������.\n\
								��� ������ ����������, ��� � ����� ������� ������ 1 ������� ��������,\n\
								� � ����� ������� � ��������� - 2(3) ��������.\n\n\
								�������� ��������, ��������� ������ �������� ��������� ����� "cBLUE"%d"cWHITE" ����.\
							"	
	
stock getIndexCrimeFraction( id )
{
	for( new i; i < MAX_CRIMINAL; i++ )
	{
		if( CrimeFraction[i][c_id] == id )
		{
			return i;
		}
	}
	
	return INVALID_PARAM;
}

stock PlayerLeaderCrime( playerid, crime )
{
	for( new i; i < 3; i++ )
	{
		if( Player[playerid][uCrimeL] == CrimeFraction[ crime ][c_id] && 
			Player[playerid][uID] == CrimeFraction[ crime ][c_leader][i] )
			return 1;
	}

	return STATUS_ERROR;
}

stock getCrimeRankId( playerid, crime )
{
	for( new i; i < CrimeFraction[crime][c_ranks]; i++ )
	{
		if( CrimeRank[crime][i][r_id] == Player[playerid][uCrimeRank] )
			return i;
	}

	return INVALID_PARAM;
}

stock SendCrimeLeaderMessage( crime, color, const message[] )
{
	foreach(new playerid : Player)
		if( IsLogged( playerid ) )
			if( PlayerLeaderCrime( playerid, crime ) )
				SendClient:( playerid, color, message );

	return 1;
}