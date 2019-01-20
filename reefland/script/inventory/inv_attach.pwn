#include <YSI\y_hooks>

hook OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) {
	switch( dialogid ) {
		case d_inv_attach: {
			switch( listitem ) {
				case 0: {
					showPlayerDialog( playerid, d_inv_attach + 1, DIALOG_STYLE_LIST, "Настроить положение",
						"1. Задать положение\n2. Редактировать положение\n3. Сбросить настройки",
						"Выбор", "Назад" );
				}
			}
		}
	}
	return true;
}	