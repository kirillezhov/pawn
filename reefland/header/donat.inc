#define donat 				"\
								"cBLUE"1. "cWHITE"����������\n\
								"cBLUE"2. "cWHITE"����� ������\n\
								"cBLUE"3. "cWHITE"������� ��������\n\
								"cBLUE"4. "cWHITE"�������������� �����������\
							"
							
#define donatinfo			"\
								"cBLUE"1. "cWHITE"����� ����������\n\
								"cBLUE"2. "cWHITE"������ � ���������� �����\n\
								"cBLUE"3. "cWHITE"��� ������� �������\
							"
							
#define donatadd			""cWHITE" \t"cWHITE"���������"cWHITE"\n\
								��������� ����\t"cBLUE"%d RCoin"cWHITE"\n\
								��������� ����\t"cBLUE"%d RCoin"cWHITE"\n\
								��������� ����� ����\t"cBLUE"%d RCoin"cWHITE"\n\
								��������� ��������������\t"cBLUE"%d RCoin"cWHITE"\n\
								��������� ������ ��������\t"cBLUE"%d RCoin"cWHITE"\n\
								��������� ��������\t"cBLUE"%d RCoin"cWHITE"\n\
								�������� �������\t"cBLUE"%d RCoin"cWHITE"\n\
								������� ����� ���\t"cBLUE"%d RCoin"cWHITE"\n\
								������� ��� ����� ���\t"cBLUE"%d RCoin"cWHITE"\n\
								����� ��������������\t"cBLUE"%d RCoin"cWHITE"\n\
								����� ��� ��������������\t"cBLUE"%d RCoin"cWHITE"\n\
								����������� �������� �� ������\t"cBLUE"%d RCoin"cWHITE"\n\
								�������� ����� ��������\t"cBLUE"%d RCoin"cWHITE"\
							"
							
#define donattotal 			""cBLUE"����� ����������"cWHITE"\n\n\
								�� ������� ������������ ����������� �������� �������� ����� � RCoin - ������ ������� ������,\n\
								� ������� ������� �� ������� ���������� ������� �������, � ����� ������ �������������� ������,\n\
								����������� ������� ���������� ���� ����.\n\n\
								��� ����, ����� ��������� ���� �������� ��� ���������� ������� �� "cBLUE"reeflandrp.ru"cWHITE"\n\
								� "cBLUE"������� - ���������� �����"cWHITE" � ������� �������� ����� �� ����� 1 ����� = 1 RCoin.\n\n\
								"gbDialogError"����������:\n\
								"cWHITE"���������� ������� ������� � ������������� ����� 2 ������������ ��������, 2 ���� ��� 2 �������,\n\
								����������, ��� �� ��������� ����� �������� �������� 2-�� ������������ ��������/2-�� ���/2-�� ������\n\
								������������� ��������� � ��� ������������ ��� �������� ���������.\n\
								����� �������� �����, �������� ��� ������� �������, �� ������ � �������\n\
								"cBLUE"/donat - ������� �������� - �������� ������� �������"cWHITE".\n\n\
								�������, ����� �������� ���� �������� ������ ������� ��������, ��������� "cBLUE"/time"cWHITE".\
							"
							
#define donatbalance		""cBLUE"������ � ���������� �����"cWHITE"\n\n\
								�� ����� ����� - "cBLUE"%d"cWHITE" RCoin\n\n\
								����� ��������� ���� �������� ��� ���������� ������� �� "cBLUE"reeflandrp.ru"cWHITE"\n\
								� "cBLUE"������� - ���������� �����"cWHITE" � ������� �������� ����� �� ����� 1 ����� = 1 RCoin.\n\n\
								"gbDialogError"����������:\n\
								"cWHITE"��� ���������� ����� ������������� �������� � �������, ���������� ������ �������� ����.\n\
								����� �������� �������� ���������� ���� � ������ �������������� �������� "cBLUE"/donat"cWHITE".\n\n\
								���� � ��� �������� �������� � ����������� RCoin - ���������� �� �����\n\
								� ������ "cBLUE"������ � ����������� - �������� � �������"cWHITE".\n\n\
								"cRED"����������� ������� �������� �������!\
							"
							
#define donatpremium		"\
								"cBLUE"- "cWHITE"���������\n\
								"cBLUE"- "cWHITE"����������\n\
								"cBLUE"- "cWHITE"�����������\n\
								"cBLUE"- "cWHITE"�������������\n\
								"gbDialog"�������� ������� �������\
							"
							
#define donatmoney			""cBLUE"����� ������"cWHITE"\n\n\
								����� ������ - ��� ������� ����� RCoin � ������� ������� ������.\n\
								���� �������� ���������� "cBLUE"1 RCoin = $100"cWHITE".\n\n\
								�� ����� ����� - "cBLUE"%d"cWHITE" RCoin\n\n\
								"cGRAY"�������, ������� RCoin �� ������ ��������:\
							"			

// -- ���� --						
const
	PRICE_UNWARN = 60,				//������ �����
	PRICE_UNWARN_ALL = 100,			//������ ���� ������
	PRICE_CHANGE_ROLE = 45,			//���� (��������������, �������, ������ ��������, ���)
	PRICE_CHANGE_NATION = 10, 		//��������������
	PRICE_CHANGE_AGE = 20,			//�������
	PRICE_CHANGE_COUNTRY = 5,		//������ ��������
	PRICE_CHANGE_SEX = 15,			//���
	PRICE_CHANGE_COLOR = 15,		//���� ����
	PRICE_CHANGE_NAME = 40,			//���
	PRICE_STYLE = 50,				//����� ���
	PRICE_STYLE_ALL = 150,			//��� ����� ���
	PRICE_UNJOB = 15,				//������������ ��������
	PRICE_NUMBER_CAR = 70,			//����� ����������
	PRICE_NUMBER_PHONE = 60;		//����� ��������

							
enum e_PREMIUM
{
	prem_id,				// �������� ��������
	prem_time,				// ����� ��������� ��������
	prem_type,				// ��� ��������
	
	prem_color,				// ���� ��������
	prem_gmoney,			// GMoney � ���
	prem_bank,				// ������� � �����
	prem_salary,			// ������� � ��������
	prem_benefit,			// ������� � ������� �� �����������
	prem_mass,				// �������������� ��� � ���������
	
	prem_admins,			// ������ � /admins
	prem_supports,			// ������ � /supports
	prem_h_payment,			// �������������� ��� ��� ������ ����
	
	prem_car,				// ����������� ����� 2 ������
	prem_house,				// ����������� ����� 2 ����
	prem_business,			// ����������� ����� 2 �������
	
	prem_house_property,	// �������������� ������� � ������� ���������
	
	prem_drop_retreature,	// ������� �������� ����������
	prem_drop_tuning,		// ������� �������� �������
	prem_drop_repair,		// ������� �������� �������
	prem_drop_payment,		// ������� �������� ����������� �����
}

enum e_PREMIUM_INFO
{
	prem_name	[ 16 ],
	prem_price,
	
	prem_color		[2], //+
	prem_gmoney		[2], //+
	prem_bank		[2], //+
	prem_salary		[2], //+
	prem_benefit	[2], //+
	
	prem_mass		[2], //+
	prem_admins		[2], //+
	prem_supports	[2], //+
	prem_h_payment	[2], //+
	
	prem_car		[2], //+
	prem_house		[2], //+
	prem_business	[2], //+
	
	prem_house_property		[2], //+
	
	prem_drop_retreature	[2], //+
	prem_drop_tuning		[2], //+
	prem_drop_repair		[2], //+
	prem_drop_payment		[2], //+
}

enum e_VALUE_PREMIUM
{
	value_amount,		//���������� ��������� ��������
	value_gmoney,		//���������� RCoin
	value_days,			//���� �������� � ����
}

new
	Premium			[ MAX_PLAYERS ][ e_PREMIUM ],
	TimePremium		[ MAX_PLAYERS ][ e_PREMIUM ],
	ValuePremium	[ MAX_PLAYERS ][ e_VALUE_PREMIUM ];
			
new
	premium_info[][ e_PREMIUM_INFO ] = 
	{
		{ "���", 0, 			{ 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 },	{ 0, 0 }, { 0, 0 }, 	{ 0, 0 }, { 0, 0 },
		{ 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 },  	{ 0, 0 },  { 0, 0 },  { 0, 0 },  { 0, 0 } },
		
		{ "���������", 180, 	{ 1, 5 }, { 0, 0 }, { 1, 10 }, { 7, 15 }, { 20, 5 }, { 2, 30 }, { 0, 0 }, 	{ 1, 10 }, { 0, 0 },
		{ 0, 0 }, { 0, 0 }, { 0, 0 }, { 10, 30 }, 	{ 15, 15 },  { 15, 20 },  { 10, 20 },  { 10, 20 } },
		
		{ "����������", 400, 	{ 2, 5 }, { 0, 0 }, { 3, 15 }, { 12, 23 }, { 40, 7 }, { 4, 40 }, { 1, 10 }, 	{ 1, 10 }, { 5, 40 }, 
		{ 1, 50 }, { 1, 40 }, { 0, 0 }, { 20, 50 }, { 20, 20 },  { 20, 30 },  { 15, 30 },  { 15, 30 } },
		
		{ "�����������", 600, 	{ 3, 5 }, { 2, 70 }, { 7, 20 }, { 20, 30 }, { 80, 10 }, { 6, 50 }, { 1, 10 }, 	{ 1, 10 }, { 10, 55 }, 
		{ 1, 50 }, { 1, 40 }, { 1, 40 }, { 30, 60 }, { 30, 30 },  { 30, 40 },  { 20, 40 },  { 20, 40 } },
		
		{ "�������������", 0, 	{ 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 },	{ 0, 0 }, { 0, 0 }, 	{ 0, 0 },  { 0, 0 },
		{ 0, 0 }, { 0, 0 }, { 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 },  { 0, 0 },  { 0, 0 },  { 0, 0 } }
	},
	
	premium_color[][] = 
	{
		{"{FFFFFF}"},
		{"{46BD38}"},
		{"{E05A5A}"},
		{"{DEB047}"}
	};