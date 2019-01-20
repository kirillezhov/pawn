const
	MAX_RECOURSE = 30,
	MAX_DOCUMENT = 20;
	
enum e_RECOURSE
{
	r_id,								// Ид обращения
	r_date,								// Дата обращения
	r_nameto	[ MAX_PLAYER_NAME ],	// Кому
	r_text		[ 1024 ],				// Текст
	r_namefrom	[ MAX_PLAYER_NAME ],	// От кого
	r_answer	[ 256 ],				// Ответ
	r_nameans	[ MAX_PLAYER_NAME ],	// Кто ответил
	r_status,							// Статус: просмотрено или нет
}

enum e_DOCUMENT
{
	d_id,							// Ид документа
	d_type,							// Тип документа
	d_date,							// Дата документа
	d_text	[ 512 ],				// Текст документа
	d_name	[ MAX_PLAYER_NAME ],	// Имя составителя
}

new
	Recourse	[ MAX_RECOURSE ]	[ e_RECOURSE ],
	Document	[ MAX_PLAYERS ]		[ MAX_DOCUMENT ]	[ e_DOCUMENT ];
	
new 
	document_type[][] =	
	{
		{ "Деловое письмо" },
		{ "Рекламация" },
		{ "Протокол" },
		{ "Акт" },
		{ "Приказ" },
		{ "Заявление" },
		{ "Резюме" },
		{ "Должностная инструкция" },
		{ "Доверенность" },
		{ "Служебная записка" }
	}; 
	
#define reception_info				"\
										"cBLUE"Приемная мэра\n\n\
										"cWHITE"Каждый гражданин может публично обратиться к мэру города Лос Сантос\n\
										с любого рода просьбой или жалобой, оставив свое обращение. Ваше обращение будет\n\
										рассмотрено в кратчайшие сроки.\
									"
	
#define	dialog_reception			"\
										"cWHITE"Оставить обращение\n\
										"cWHITE"Ответ на обращение\
									"