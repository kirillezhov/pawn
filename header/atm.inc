
/*new atm_zone[50],
	atm_server;*/
	
enum e_CASHBOX_INFO
{
	c_name[ 32 ],					//��� �����
	Float: c_cashbox_pos[3],		//���������� 3d ������
}	

//����� � �����
new const cashbox_info[][ e_CASHBOX_INFO ] = 
{
	{ "�����", { 1463.8583, -1006.0172, 2725.8760 } }, // 0
	{ "�����", { 1459.5745, -1006.0161, 2725.8760 } }, // 0
	{ "�����", { 1455.4482, -1006.0210, 2725.8760 } }, // 0
	{ "�����", { 1451.4005, -1006.0151, 2725.8760 } } // 0
};

#define dialog_bank			"\
								"cBLUE"1. "cGRAY"��������� ������ �����\n\
								"cBLUE"2. "cGRAY"����� ������\n\
								"cBLUE"3. "cGRAY"�������� ������\n\
								"cBLUE"4. "cGRAY"��������� ������\n\
								"cBLUE"5. "cGRAY"���������� ���\n\
								"cBLUE"6. "cGRAY"������ �����\
							"
							
#define dialog_pay			"\
								"cBLUE"-"cGRAY" ������ �����\n\
								"cBLUE"-"cGRAY" ������ �������\
							"
							
#define dialog_cashout		"\
								"cBLUE"����� ������\n\n\
								"cWHITE"������� �����, ������� �� ������ ����� � ����������� �����:\n\
								"gbDialog"����������� ����� $1, ������������ $100000\
							"
							
#define dialog_cashin		"\
								"cBLUE"�������� ������\n\n\
								"cWHITE"������� �����, ������� �� ������ �������� �� ���������� ����:\n\
								"gbDialog"����������� ����� $1, ������������ $100000\
							"
							
#define dialog_transfer		"\
								"cBLUE"��������� ������\n\n\
								"cWHITE"������� ID ������, �������� ������ ��������� ������:\
							"
							
#define dialog_transfer_2	"\
								"cBLUE"��������� ������\n\n\
								"cGRAY"������� ������: "cBLUE"%s[%d]\n\
								"cWHITE"������� ����� ��� ��������:\n\
								"gbDialog"����������� ����� $1, ������������ $1000000\
							"