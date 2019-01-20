
/*new atm_zone[50],
	atm_server;*/
	
enum e_CASHBOX_INFO
{
	c_name[ 32 ],					//Имя кассы
	Float: c_cashbox_pos[3],		//Координаты 3d текста
}	

//Кассы в банке
new const cashbox_info[][ e_CASHBOX_INFO ] = 
{
	{ "Касса", { 1463.8583, -1006.0172, 2725.8760 } }, // 0
	{ "Касса", { 1459.5745, -1006.0161, 2725.8760 } }, // 0
	{ "Касса", { 1455.4482, -1006.0210, 2725.8760 } }, // 0
	{ "Касса", { 1451.4005, -1006.0151, 2725.8760 } } // 0
};

#define dialog_bank			"\
								"cBLUE"1. "cGRAY"Проверить баланс счета\n\
								"cBLUE"2. "cGRAY"Снять деньги\n\
								"cBLUE"3. "cGRAY"Положить деньги\n\
								"cBLUE"4. "cGRAY"Перевести деньги\n\
								"cBLUE"5. "cGRAY"Обналичить чек\n\
								"cBLUE"6. "cGRAY"Оплата услуг\
							"
							
#define dialog_pay			"\
								"cBLUE"-"cGRAY" оплата жилья\n\
								"cBLUE"-"cGRAY" оплата штрафов\
							"
							
#define dialog_cashout		"\
								"cBLUE"Снять деньги\n\n\
								"cWHITE"Укажите сумму, которую Вы хотите снять с банковского счета:\n\
								"gbDialog"Минимальная сумма $1, максимальная $100000\
							"
							
#define dialog_cashin		"\
								"cBLUE"Положить деньги\n\n\
								"cWHITE"Укажите сумму, которую Вы хотите положить на банковский счет:\n\
								"gbDialog"Минимальная сумма $1, максимальная $100000\
							"
							
#define dialog_transfer		"\
								"cBLUE"Перевести деньги\n\n\
								"cWHITE"Введите ID игрока, которому хотите перевести деньги:\
							"
							
#define dialog_transfer_2	"\
								"cBLUE"Перевести деньги\n\n\
								"cGRAY"Перевод игроку: "cBLUE"%s[%d]\n\
								"cWHITE"Укажите сумму для перевода:\n\
								"gbDialog"Минимальная сумма $1, максимальная $1000000\
							"