enum e_DOOR 
{
	d_object,
	Float:d_begin_pos[6],
	Float:d_end_pos[6],
	d_type,
	d_fraction,
}

new Door[][e_DOOR] =
{
	{ 1495, {994.957519, -1608.014770, 5000.078613, 0.0, 0.0, 0.0 }, {994.957519, -1608.014770, 5000.078613, 0.0, 0.0, 90.0 }, 4, 5 }, 	//���� ��
	{ 1495, {1009.304992, -1607.988159, 5000.078613, 0.0, 0.0, 180.0}, {1009.304992, -1607.988159, 5000.078613, 0.0, 0.0, 90.0}, 4, 5 }, //���� ��
	{ 1495, {1002.884521, -1601.388916, 5000.078613, 0.0, 0.0, 180.0}, {1002.884521, -1601.388916, 5000.078613, 0.0, 0.0, 90.0}, 4, 5 }, //���� ��
	{ 1495, {-931.339599, -538.421997, 2500.078613, 0.0, 0.0, -90.0}, {-931.339599, -538.421997, 2500.078613, 0.0, 0.0, 0.0}, 1, 5 },	//�� ���
	{ 1495, {-921.887512, -538.421997, 2500.078613, 0.0, 0.0, -90.0}, {-921.887512, -538.421997, 2500.078613, 0.0, 0.0, -180.0}, 1, 5 },//�� ���
	{ 1495, {1295.449951, -881.710021, 3000.068115, 0.0, 0.0, 0.0}, {1295.449951, -881.710021, 3000.068115, 0.0, 0.0, 90.0}, 2, 5 },	//�� 505
	{ 1495, {1310.265991, -921.534973, 5000.067871, 0.0, 0.0, 90.0}, {1310.265991, -921.534973, 5000.067871, 0.0, 0.0, 0.0}, 2, 5 },	//�� 505
	{ 1495, {1310.265991, -930.568969, 5000.067871, 0.0, 0.0, 90.0}, {1310.265991, -930.568969, 5000.067871, 0.0, 0.0, 0.0}, 2, 5 },	//�� 505
	{ 1495, {1550.170,-1680.994,2493.239,0.000,0.000,90.000}, {1550.170,-1680.994,2493.239,0.000,0.000,180.000}, 5, 2 }, // ������� ����
	{ 1495, {1534.282,-1680.824,2493.239,0.000,0.000,90.000}, {1534.282,-1680.824,2493.239,0.000,0.000,0.000}, 5, 2 },	// ������� ����
	{ 1495, {1555.119,-1680.995,2493.239,0.000,0.000,90.000}, {1555.119,-1680.995,2493.239,0.000,0.000,180.000}, 5, 2 },	// ������� ����
	{ 1495, {1557.437,-1676.021,2493.239,0.000,0.000,0.000}, {1557.437,-1676.021,2493.239,0.000,0.000,90.000}, 5, 2 },	// ������� ����
	{ 1495, {1555.086,-1666.328,2493.239,0.000,0.000,-90.000}, {1555.086,-1666.328,2493.239,0.000,0.000,0.000}, 5, 2 },	// ������� ����
	{ 1495, {1530.215,-1654.759,2493.239,0.000,0.000,90.000}, {1530.215,-1654.759,2493.239,0.000,0.000,0.000}, 5, 2 },	// ������� ����
	{ 1495, {1534.286,-1356.790,2493.239,0.000,0.000,0.000}, {1534.286,-1356.790,2493.239,0.000,0.000,90.000}, 5, 2 },	// ������� ����
	{ 1495, {411.536,-1859.046,2500.080,0.000,0.000,-90.000}, {411.536,-1859.046,2500.080,0.000,0.000,0.000}, 5, 2 },	// ��������� ����
	{ 1495, {-138.253,-1867.425,2500.070,0.000,0.000,0.000}, {-138.253,-1867.425,2500.070,0.000,0.000,90.000}, 5, 2 },	// ����� ����
	{ 1495, {-137.473,-1886.733,2500.070,0.000,0.000,0.000}, {-137.473,-1886.733,2500.070,0.000,0.000,90.000}, 5, 2 },	// ����� ����
	{ 1495, {-139.173,-1854.826,3000.074,0.000,0.000,90.000}, {-139.173,-1854.826,3000.074,0.000,0.000,0.000}, 5, 2 },	// ����� ����
	{ 1500, {636.381,-577.286,1993.077,0.000,0.000,-90.000}, {636.381,-577.286,1993.077,0.000,0.000,0.000}, 6, 2 },		// ������
	{ 1500, {617.820,-578.838,1993.077,0.000,0.000,90.000}, {617.820,-578.838,1993.077,0.000,0.000,180.000}, 6, 2 },	// ������
	{ 1500, {617.814,-565.997,1993.077,0.000,0.000,90.000}, {617.814,-565.997,1993.077,0.000,0.000,0.000}, 6, 2 },		// ������
	{ 1500, {616.888,-575.179,1993.077,0.000,0.000,180.000}, {616.888,-575.179,1993.077,0.000,0.000,90.000}, 6, 2 },	// ������
	{ 1500, {640.896,-578.681,2593.076,0.000,0.000,-180.000}, {640.896,-578.681,2593.076,0.000,0.000,90.000}, 6, 2 },	// ������
	{ 1500, {900.806,-1860.280,2500.081,0.000,0.000,0.000}, {900.806,-1860.280,2500.081,0.000,0.000,90.000}, 5, 3 },	// FBI
	{ 1500, {900.806,-1869.752,2500.081,0.000,0.000,0.000}, {900.806,-1869.752,2500.081,0.000,0.000,90.000}, 5, 3 }		// FBI
};

new
	d_door_id				[ MAX_DOORS ],
	bool: d_door_status		[ MAX_DOORS char ] = { false, ... };