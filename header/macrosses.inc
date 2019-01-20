// -- Macrosses

// Get
#define GetCharacterName(%0)		(Player[%0][uRPName])

#define GetVehicleModelName(%0) 	VehicleInfo[%0 - 400][v_name]
#define GetVehiclePrice(%0)			VehicleInfo[%0 - 400][v_price]
#define GetVehicleBag(%0)			VehicleInfo[%0 - 400][v_boot]
#define GetVehicleMaxSpeed(%0)		VehicleInfo[%0 - 400][v_speed]
#define GetVehicleMaxAcSpeed(%0)	VehicleInfo[%0 - 400][v_ac_speed]

#define GetBusinessType(%0)			g_business_type[BusinessInfo[%0][b_type]][BusinessInfo[%0][b_shop]]
#define GetMaxFurnBusiness(%0)		g_max_furniture[BusinessInfo[%0][b_type]][BusinessInfo[%0][b_shop]]
#define GetMaxPageBusiness(%0)		g_max_items[BusinessInfo[%0][b_type]][BusinessInfo[%0][b_shop]]
#define GetPriceInterior(%0,%1)		floatround( float( BusinessInfo[%0][b_price] ) / 100.0 * business_int[%1][bt_percent] )
#define GetPriceImprove(%0)			floatround( float( BusinessInfo[%0][b_price] ) / 100.0 * 25.0 )
#define GetPriceImprove2(%0)		floatround( float( BusinessInfo[%0][b_price] ) / 100.0 * 15.0 )

#define GetMaxFurnHouse(%0)			hinterior_info[HouseInfo[%0][hInterior]-1][h_max_furn]
#define GetNameInteriorHouse(%0)	hinterior_info[HouseInfo[%0][hInterior]-1][h_int_name]
#define GetPriceRentHouse(%0)		floatround( HouseInfo[%0][hPrice]/ 100 * PERCENT_RENT )
#define GetPricePaymentHouse(%0)	floatround( HouseInfo[%0][hPrice]/ 100 * PERCENT_PAYMENT )
#define GetTypeHouse(%0)			hinterior_info[HouseInfo[%0][hInterior]-1][h_type]

#define GetAccountName(%0)      	Player[%0][uName]
#define GetNationName(%0)			nation_name[%0 - 1]
#define GetCountryName(%0)			country_name[%0 - 1]
#define GetPremiumName(%0)			premium_info[%0][ prem_name ]
#define GetPremiumColor(%0)			premium_color[ %0 ]
#define GetJobName(%0)				job_name[%0]
#define GetSexName(%0)				sex_name[%0 - 1]
#define GetFractionRank(%0)			Player[%0][uRank]

// Is
#define IsKicked(%0) 				GetPVarInt(%0, "Player:Kicked")
#define IsLogged(%0)				(IsPlayerConnected(%0) && g_player_login{%0})

#if !defined isnull
	#define isnull(%0)				((!(%0[0])) || (((%0[0]) == '\1') && (!(%0[1]))))
#endif

#define IsSpectated(%0)				Player[%0][tSpectate]			

#define function%0(%1)     			forward %0(%1); public %0(%1)

#define GivePVarInt(%0,%1,%2)		SetPVarInt(%0,%1,GetPVarInt(%0,%1)+%2)
#define TakePVarInt(%0,%1,%2)		SetPVarInt(%0,%1,GetPVarInt(%0,%1)-%2)

#define SexTextEnd(%0)				( Player[%0][uSex] == 2 ) ? ("а") : ("")
#define AgeTextEnd(%0)				( %0 == 1 )? ("год"):((%0 < 5 && %0 != 0)? ("года"):("лет"))
#define log:(%0,%1)					SendClientMessage(%0,-1,%1)

#define clean:<%0>					%0[0] = EOS			
#define mysql_format:%0(			%0[0] = EOS,mysql_format(mysql,%0,sizeof(%0),
#define format:%0(		    		%0[0] = EOS,format(%0,sizeof(%0),
									
#define pformat:(					g_small_string[0] = EOS,format(g_small_string,sizeof(g_small_string),						
#define psend:(%0,%1) 				SendClientMessage(%0,%1,g_small_string)

#define gbKick(%0)					SetPVarInt(%0,"Player:Kicked",1), SetTimerEx("OnPlayerDelayKick",300,0,"d",%0)
									
#define SendClient:					SendClientMessage
#define SendClientAll:				SendClientMessageToAll
#define SendAdmin:					SendAdminMessage
#define SendAdminAll:				SendAdminMessageToAll
#define SendSupport:				SendSupportMessage
#define SendLong:					SendLongMessage
#define SendAdminLongAll:			SendAdminLongMessageToAll
#define SendLongNoRadius:			SendLongNoRadius
#define SendRPAction				SendRolePlayAction

#define PRESSED(%0) 				(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define HOLDING(%0)             	((newkeys & (%0)) == (%0))
#define RELEASED(%0)				(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

#define RandomEx(%1,%2) 			(random(%2-%1)+%1)

#define CleanDate					g_year = g_month = g_day = g_hour = g_minute = 0