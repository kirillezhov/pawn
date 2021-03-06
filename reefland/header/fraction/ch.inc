const
	MAX_RECOURSE = 30,
	MAX_DOCUMENT = 20;
	
enum e_RECOURSE
{
	r_id,								// �� ���������
	r_date,								// ���� ���������
	r_nameto	[ MAX_PLAYER_NAME ],	// ����
	r_text		[ 1024 ],				// �����
	r_namefrom	[ MAX_PLAYER_NAME ],	// �� ����
	r_answer	[ 256 ],				// �����
	r_nameans	[ MAX_PLAYER_NAME ],	// ��� �������
	r_status,							// ������: ����������� ��� ���
}

enum e_DOCUMENT
{
	d_id,							// �� ���������
	d_type,							// ��� ���������
	d_date,							// ���� ���������
	d_text	[ 512 ],				// ����� ���������
	d_name	[ MAX_PLAYER_NAME ],	// ��� �����������
}

new
	Recourse	[ MAX_RECOURSE ]	[ e_RECOURSE ],
	Document	[ MAX_PLAYERS ]		[ MAX_DOCUMENT ]	[ e_DOCUMENT ];
	
new 
	document_type[][] =	
	{
		{ "������� ������" },
		{ "����������" },
		{ "��������" },
		{ "���" },
		{ "������" },
		{ "���������" },
		{ "������" },
		{ "����������� ����������" },
		{ "������������" },
		{ "��������� �������" }
	}; 
	
#define reception_info				"\
										"cBLUE"�������� ����\n\n\
										"cWHITE"������ ��������� ����� �������� ���������� � ���� ������ ��� ������\n\
										� ������ ���� �������� ��� �������, ������� ���� ���������. ���� ��������� �����\n\
										����������� � ���������� �����.\
									"
	
#define	dialog_reception			"\
										"cWHITE"�������� ���������\n\
										"cWHITE"����� �� ���������\
									"