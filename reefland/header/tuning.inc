//Price
#define REPAIR_MECH_ENGINE 	(3.5)
#define REPAIR_MECH_BODY 	(1)
#define REPAIR_MECH_LIGHT 	(0.5)
#define REPAIR_MECH_WHEELS 	(0.5)
#define REPAIR_MECH_COMPLEX (2.5)

#define REPAIR_ENGINE 		(5)
#define REPAIR_BODY 		(2)
#define REPAIR_LIGHT 		(0.5)
#define REPAIR_WHEELS 		(1)

const
	//�������� �������� �� ��������� ����
	PRICE_COLOR_1 = 5,
	PRICE_COLOR_2 = 2,
	PRICE_AERO = 18,
	PRICE_HYDRAULICS = 20;

	//�������� ������� �� ��������� ���� C ���������
	/*REPAIR_MECH_ENGINE = 7,
	REPAIR_MECH_BODY = 2,
	REPAIR_MECH_LIGHT = 1,
	REPAIR_MECH_WHEELS = 1,
	REPAIR_MECH_COMPLEX = 5,*/
	
	//�������� ������� �� ��������� ���� ��� ��������
	/*REPAIR_ENGINE = 10,
	REPAIR_BODY = 4,
	REPAIR_LIGHT = 1,
	REPAIR_WHEELS = 2;*/

new
	Text:car_tuning			[ 9 ],
	PlayerText:tuning_price	[ MAX_PLAYERS ],
	PlayerText:tuning_name	[ MAX_PLAYERS ],
	g_tuning_select			[ MAX_PLAYERS ];
									
enum e_COMPONENTS
{
    c_id,
    c_name[35],
	Float:c_price
};

new ComponentsInfo [][][ e_COMPONENTS ] = 
{
	//����� 17 3%
	{
		{ 1073, "����� Shadow", 5.7 },
		{ 1074, "����� Mega", 6.3 },
		{ 1075, "����� Rimshine", 6.0 },
		{ 1076, "����� Wires", 7.6 },
		{ 1077, "����� Classic", 8.0 },
		{ 1078, "����� Twist", 8.5 },
		{ 1079, "����� Cutter", 6.4 },
		{ 1080, "����� Switch", 6.8 },
		{ 1081, "����� Grove", 6.1 },
		{ 1082, "����� Import", 5.9 },
		{ 1083, "����� Dollar", 6.4 },
		{ 1084, "����� Trance", 6.4 },
		{ 1085, "����� Atomic", 7.4 },
		{ 1025, "����� Offroad", 6.2 },
		{ 1096, "����� Ahab", 5.9 },
		{ 1097, "����� Virtual", 5.5 },
		{ 1098, "����� Access", 5.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 }
	},
	//�������� ������ 23 8% -1
	{
		{ 1117, "�������� ������ Chrome", 6.8 },
		{ 1152, "�������� ������ X-Flow", 10.0 },
		{ 1153, "�������� ������ Alien", 12.0 },
		{ 1155, "�������� ������ Alien", 11.5 },
		{ 1157, "�������� ������ X-Flow", 11.0 },
		{ 1160, "�������� ������ Alien", 12.4 },
		{ 1165, "�������� ������ X-Flow", 10.7 },
		{ 1166, "�������� ������ Alien", 12.7 },
		{ 1169, "�������� ������ Alien", 13.2 },
		{ 1170, "�������� ������ X-Flow", 11.0 },
		{ 1171, "�������� ������ Alien", 12.0 },
		{ 1172, "�������� ������ X-Flow", 11.2 },
		{ 1173, "�������� ������ X-Flow", 10.4 },
		{ 1174, "�������� ������ Chrome", 6.0 },
		{ 1176, "�������� ������ Chrome", 5.6 },
		{ 1179, "�������� ������ Chrome", 7.0 },
		{ 1181, "�������� ������ Slamin", 5.4 },
		{ 1182, "�������� ������ Chrome", 5.5 },
		{ 1185, "�������� ������ Slamin", 7.4 },
		{ 1188, "�������� ������ Slamin", 8.0 },
		{ 1189, "�������� ������ Chrome", 7.0 },
		{ 1190, "�������� ������ Slamin", 6.0 },
		{ 1191, "�������� ������ Chrome", 5.6 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 }
	},
	//������ ������ 22 8%
	{
		{ 1140, "������ ������ X-Flow", 10.2 },
		{ 1141, "������ ������ Alien", 10.0 },
		{ 1148, "������ ������ X-Flow", 10.2 },
		{ 1149, "������ ������ Alien", 10.0 },
		{ 1150, "������ ������ Alien", 9.5 },
		{ 1151, "������ ������ X-Flow", 9.5 },
		{ 1154, "������ ������ Alien", 10.3 },
		{ 1156, "������ ������ X-Flow", 9.7 },
		{ 1159, "������ ������ Alien", 9.0 },
		{ 1161, "������ ������ X-Flow", 10.3 },
		{ 1167, "������ ������ X-Flow", 11.0 },
		{ 1168, "������ ������ Alien", 10.0 },
		{ 1175, "������ ������ Slamin", 5.8 },
		{ 1177, "������ ������ Slamin", 5.4 },
		{ 1178, "������ ������ Slamin", 6.3 },
		{ 1180, "������ ������ Chrome", 5.0 },
		{ 1183, "������ ������ Slamin", 5.8 },
		{ 1184, "������ ������ Chrome", 6.2 },
		{ 1186, "������ ������ Slamin", 6.6 },
		{ 1187, "������ ������ Chrome", 6.3 },
		{ 1192, "������ ������ Chrome", 5.5 },
		{ 1193, "������ ������ Slamin", 5.5 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 }
	},
	//����� 4 2%
	{
		{ 1004, "����� Champ Scoop", 4.5 },
		{ 1005, "����� Fury Scoop", 4.9 },
		{ 1011, "����� Race Scoop", 5.0 },
		{ 1012, "����� Worx Scoop", 5.4 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 }
	},
	//������� 19 4% -1
	{
		{ 1000, "������� Pro", 6.0 },
		{ 1001, "������� Win", 7.0 },
		{ 1002, "������� Drag", 6.0 },
		{ 1003, "������� Alpha", 7.0 },
		{ 1014, "������� Champ", 6.1 },
		{ 1015, "������� Race", 6.2 },
		{ 1016, "������� Worx", 6.0 },
		{ 1049, "������� Alien", 6.1 },
		{ 1050, "������� X-Flow", 5.9 },
		{ 1058, "������� Alien", 6.3 },
		{ 1023, "������� Fury", 7.0 },
		{ 1146, "������� X-Flow", 6.4 },
		{ 1147, "������� Alien", 6.0 },
		{ 1138, "������� Alien", 6.0 },
		{ 1139, "������� X-Flow", 7.0 },
		{ 1060, "������� X-Flow", 5.6 },
		{ 1162, "������� Alien", 5.8 },
		{ 1163, "������� X-Flow", 6.0 },
		{ 1164, "������� Alien", 8.2 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 }
	},
	//����� 17 2%
	{
		{ 1032, "����� Alien", 5.1 },
		{ 1006, "����� Scoop", 4.6 },
		{ 1038, "����� Alien", 5.1 },
		{ 1035, "����� X-Flow", 5.2 },
		{ 1033, "����� X-Flow", 5.2 },
		{ 1053, "����� X-Flow", 5.2 },
		{ 1054, "����� Alien", 5.3 },
		{ 1055, "����� Alien", 5.1 },
		{ 1061, "����� X-Flow", 5.0 },
		{ 1067, "����� Alien", 5.1 },
		{ 1068, "����� X-Flow", 4.8 },
		{ 1088, "����� Alien", 5.0 },
		{ 1091, "����� X-Flow", 5.2 },
		{ 1103, "����� Covertible", 6.0 },
		{ 1128, "����� Vinyl Hardtop", 9.2 },
		{ 1130, "����� Hardtop", 8.1 },
		{ 1131, "����� Softtop", 7.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 }
	},
	//���������� 2 1%
	{
		{ 1143, "���������� Oval", 4.0 },
		{ 1145, "���������� Square", 3.8 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 }
	},
	//������ 29 3%
	{
		{ 1018, "������ Upswept", 5.0 },
		{ 1019, "������ Twin", 4.6 },
		{ 1020, "������ Large", 4.0 },
		{ 1021, "������ Medium", 3.9 },
		{ 1022, "������ Small", 3.7 },
		{ 1028, "������ Alien", 5.3 },
		{ 1029, "������ X-Flow", 5.6 },
		{ 1034, "������ Alien", 5.3 },
		{ 1037, "������ X-Flow", 5.6 },
		{ 1043, "������ Slamin", 5.4 },
		{ 1044, "������ Chrome", 5.0 },
		{ 1045, "������ X-Flow", 5.8 },
		{ 1046, "������ Alien", 5.6 },
		{ 1059, "������ X-Flow", 5.8 },
		{ 1064, "������ Alien", 5.6 },
		{ 1065, "������ Alien", 5.5 },
		{ 1066, "������ X-Flow", 5.6 },
		{ 1092, "������ Alien", 5.4 },
		{ 1089, "������ X-Flow", 5.5 },
		{ 1126, "������ Chrome", 5.7 },
		{ 1127, "������ Slamin", 6.2 },
		{ 1129, "������ Chrome", 5.5 },
		{ 1113, "������ Chrome", 5.1 },
		{ 1114, "������ Slamin", 5.6 },
		{ 1104, "������ Chrome", 4.8 },
		{ 1105, "������ Slamin", 4.3 },
		{ 1132, "������ Slamin", 6.4 },
		{ 1135, "������ Slamin", 5.3 },
		{ 1136, "������ Chrome", 5.8 }
	},
	//������� ���� 23 3%
	{
		{ 1007, "������� ���� Sideskirt", 4.8 },
		{ 1026, "������� ���� Alien", 6.0 },
		{ 1031, "������� ���� X-Flow", 6.2 },
		{ 1036, "������� ���� Alien", 6.3 },
		//{ 1039, "������� ���� X-Flow", 6.4 },
		{ 1041, "������� ���� X-Flow", 6.5 },
		{ 1042, "������� ���� Chrome", 5.0 },
		{ 1047, "������� ���� Alien", 5.7 },
		{ 1048, "������� ���� X-Flow", 5.2 },
		{ 1056, "������� ���� Alien", 4.9 },
		{ 1057, "������� ���� X-Flow", 4.9 },
		{ 1069, "������� ���� Alien", 5.4 },
		{ 1070, "������� ���� X-Flow", 5.0 },
		{ 1090, "������� ���� Alien", 5.4 },
		{ 1093, "������� ���� X-Flow", 5.4 },
		{ 1095, "������� ���� X-Flow", 5.4 },
		{ 1106, "������� ���� Chrome Arches", 4.5 },
		{ 1108, "������� ���� Chrome Strip", 4.5 },
		{ 1118, "������� ���� Chrome Trim", 3.8 },
		{ 1119, "������� ���� Wheelcovers", 4.0 },
		{ 1122, "������� ���� Chrome Flames", 5.0 },
		{ 1133, "������� ���� Chrome Strip", 4.4 },
		{ 1134, "������� ���� Chrome Strip", 4.6 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 }
	},
	//���.��������� 2 1%
	{
		{ 1013, "���. ��������� Round Fog", 4.0 },
		{ 1024, "���. ��������� Square Fog", 3.8 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 }
	},
	//������7 1%
	{
		{ 1100, "������� ��������� Chrome Grill", 5.2 },
		{ 1123, "������� ��������� Chrome Bars", 3.7 },
		{ 1125, "������� ��������� Chrome Lights", 4.0 },
		{ 1109, "������ ������ Chrome", 4.5 },
		{ 1110, "������ ������ Slamin", 3.7 },
		{ 1115, "�������� ������ Chrome", 4.8 },
		{ 1116, "�������� ������ Slamin", 4.2 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 },
		{ 0, " ", 0.0 }
	}	
};

new Float:TuningPosition[][] = 
{
	{ 979.5805, -1369.2102, 13.6812 },
	{ 975.6102, -1369.3257, 13.6812 },
	{ 966.6491, -1371.4917, 13.6812 },
	{ 962.4542, -1371.4739, 13.6812 },
	{ 1354.6115, 201.3747, 19.7012 },
	{ 1367.9880, 196.7904, 19.7012 },
	{ 2507.2783, -1518.6752, 24.1472 },
	{ 2507.2456, -1526.9625, 24.1472 },
	{ 2139.4402, -2183.7778, 13.5544 },
	{ 2160.4895, -2163.6643, 13.5469 }
};

#define tune_dialog					"\	
										"cBLUE"1. "cWHITE"�����\n\
										"cBLUE"2. "cWHITE"�������� ������\n\
										"cBLUE"3. "cWHITE"������ ������\n\
										"cBLUE"4. "cWHITE"�����\n\
										"cBLUE"5. "cWHITE"�������\n\
										"cBLUE"6. "cWHITE"�����\n\
										"cBLUE"7. "cWHITE"����������\n\
										"cBLUE"8. "cWHITE"������\n\
										"cBLUE"9. "cWHITE"������� ����\n\
										"cBLUE"10. "cWHITE"���. ���������\n\
										"cBLUE"11. "cWHITE"������� ���������\n\
										"cBLUE"12. "cWHITE"�������������� ��������\
									"
