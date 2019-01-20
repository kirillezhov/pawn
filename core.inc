/*
* Reefland Core
* Developer: Found
*
* 2016
*/

// Base
#include "gambit\server.pwn"
#include "gambit\connection.pwn"

// G-AC

#include "gambit\script\anticheat.pwn"

#include "gambit\intercepted_functions.pwn" 
#include "gambit\timer.pwn"
#include "gambit\object.pwn"
#include "gambit\object_fraction.pwn"
#include "gambit\remove_object.pwn"
#include "gambit\textdraw.pwn"
#include "gambit\dialog.pwn"
//#include "gambit\date.pwn"
#include "gambit\functions.pwn"
#include "gambit\dobject.pwn"
#include "gambit\overpass.pwn"
#include "gambit\sendmail.pwn"

#include "gambit\script\enters.pwn"
#include "gambit\script\licenses.pwn"
#include "gambit\script\user_menu.pwn"
#include "gambit\script\atm.pwn"
#include "gambit\script\pattach.pwn"
#include "gambit\script\payday.pwn"
#include "gambit\script\weather.pwn"
#include "gambit\script\logs.pwn"
#include "gambit\script\chat.pwn"
#include "gambit\script\target.pwn"
#include "gambit\script\skin.pwn"

#include "gambit\script\interface.pwn"
//#include "gambit\script\radio.pwn"
#include "gambit\script\gate.pwn"
#include "gambit\script\door.pwn"
#include "gambit\script\spawn.pwn"
#include "gambit\script\player.pwn"
#include "gambit\script\death.pwn"
#include "gambit\script\anim.pwn"
#include "gambit\script\gps.pwn"
#include "gambit\script\help.pwn"
#include "gambit\script\donat.pwn"

#include "gambit\script\admin\admin_menu.pwn"
#include "gambit\script\admin\admin_cmd.pwn"
#include "gambit\script\admin\admin_func.pwn"
#include "gambit\script\admin\admin_dialog.pwn"
#include "gambit\script\admin\admin_td.pwn"

#include "gambit\script\inventory\inv_td.pwn"
#include "gambit\script\inventory\inv_core.pwn"
#include "gambit\script\inventory\inv_show.pwn"
#include "gambit\script\inventory\inv_load.pwn"
#include "gambit\script\inventory\inv_dialog.pwn"
#include "gambit\script\inventory\inv_cmd.pwn"
#include "gambit\script\inventory\inv_buy_menu.pwn"

#include "gambit\script\job\job_core.pwn"
#include "gambit\script\job\job_dialog.pwn"
#include "gambit\script\job\job_cmd.pwn"

#include "gambit\script\phone\phone_td.pwn"
#include "gambit\script\phone\phone_core.pwn"
#include "gambit\script\phone\phone_dialog.pwn"

//#include "gambit\script\house\hostel.pwn"
#include "gambit\script\house\house_core.pwn"
#include "gambit\script\house\house_dialog.pwn"
#include "gambit\script\house\house_enter.pwn"
#include "gambit\script\house\house_buy.pwn"
#include "gambit\script\house\house_cmd.pwn"
#include "gambit\script\house\house_interior.pwn"
#include "gambit\script\house\house_texture.pwn"

#include "gambit\script\business\business_buy.pwn"
#include "gambit\script\business\business_core.pwn"
#include "gambit\script\business\business_enter.pwn"
#include "gambit\script\business\business_dialog.pwn"
#include "gambit\script\business\business_cmd.pwn"
#include "gambit\script\business\business_texture.pwn"
#include "gambit\script\business\business_interior.pwn"

#include "gambit\script\criminal\crime_core.pwn"
#include "gambit\script\criminal\crime_cmd.pwn"
#include "gambit\script\criminal\crime_dialog.pwn"

#include "gambit\script\vehicle\vehicle_dialog.pwn"
#include "gambit\script\vehicle\vehicle_core.pwn"
#include "gambit\script\vehicle\vehicle_cmd.pwn"
#include "gambit\script\vehicle\vehicle_hud.pwn"
#include "gambit\script\vehicle\tuning.pwn"

#include "gambit\script\furniture\furniture_dialog.pwn"
#include "gambit\script\furniture\furniture_core.pwn"

#include "gambit\script\fraction\fraction_core.pwn"
#include "gambit\script\fraction\fraction_dialog.pwn"
#include "gambit\script\fraction\fraction_cmd.pwn"
#include "gambit\script\fraction\fraction_object.pwn"
#include "gambit\script\fraction\fraction_attach.pwn"
#include "gambit\script\fraction\strobe.pwn"

#include "gambit\script\fraction\pd\pd_cmd.pwn"
#include "gambit\script\fraction\pd\pd_core.pwn"
#include "gambit\script\fraction\pd\pd_dialog.pwn"

#include "gambit\script\fraction\fd\fd_core.pwn"
#include "gambit\script\fraction\fd\fd_dialog.pwn"
#include "gambit\script\fraction\fd\fd_cmd.pwn"

#include "gambit\script\fraction\san\san_core.pwn"
#include "gambit\script\fraction\san\san_dialog.pwn"
#include "gambit\script\fraction\san\san_cmd.pwn"

#include "gambit\script\fraction\ch\ch_core.pwn"
#include "gambit\script\fraction\ch\ch_dialog.pwn"
#include "gambit\script\fraction\ch\ch_cmd.pwn"

#include "gambit\script\fraction\sadoc\prison_core.pwn"
#include "gambit\script\fraction\sadoc\prison_dialog.pwn"
#include "gambit\script\fraction\sadoc\prison_cmd.pwn"