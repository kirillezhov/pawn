const
	NEWS_NUMBER = 777;
	
enum e_AD 
{
	a_text[ 100 ],
	a_name[ MAX_PLAYER_NAME ],
	a_phone,
	bool:a_used,
}

new 
	NETWORK_ZONE,
	NETWORK_COFFER,
	NETWORK_ADPRICE,
	bool:ETHER_CALL,
	bool:ETHER_SMS,
	AD				[ MAX_ADVERT_INFO ][ e_AD ],
	ETHER_STATUS 	= INVALID_PARAM,
	ETHER_CALLID	= INVALID_PARAM;

#define dialog_sanpanel		"\
								"cWHITE"������ ���������� - "cBLUE"%d �����\n\
								"cWHITE"������ ���� - %s\n\
								"cWHITE"���������� ������ � ����\n\
								"cWHITE"������� ������ � �����\n\
								"cWHITE"����� ������� � ����� - %s\n\
								"cWHITE"����� ��� � ����� - %s\n\
								"cWHITE"�������� ��������� ���������� - "cBLUE"$%d\n\
								"cWHITE"������ ����������� - "cBLUE"$%d\
							"

#define dialog_advert		"\
								"cBLUE"1. "cGRAY"��������� ����������\n\
								"cBLUE"2. "cGRAY"������������� ����������\n\
								"cBLUE"3. "cGRAY"������� ����������\
							"