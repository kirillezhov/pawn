CMD:job( playerid ) 
{
	if( !Player[playerid][uJob] ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

	switch( Player[playerid][uJob] )
	{
		//��������
		case 1:
		{
			if( !job_duty{playerid} ) 
				return SendClient:( playerid, C_WHITE, !""gbError"�� �� ������ ������� ����." );
			
			if( !IsPlayerInAnyVehicle( playerid ) ) 
				return SendClient:( playerid, C_WHITE, !""gbError"�� ������ ���������� � ������." );
			
			if( GetPlayerState( playerid ) != PLAYER_STATE_DRIVER ) 
				return SendClient:( playerid, C_WHITE, !""gbError"�� ������ ���������� �� ����� ����������." );
		
			if( GetPlayerVehicleID( playerid ) != Job[playerid][j_vehicleid] ) 
				return SendClient:( playerid, C_WHITE, !""gbError"�� ������ ���������� � ������� ������." );
		
			switch( GetVehicleModel( GetPlayerVehicleID( playerid ) ) ) 
			{
				case 420, 438:
				{
					format:g_small_string( taxi_dialog, !VehicleJob[Job[playerid][j_vehicleid]][v_rate] ? ("����������") : ("�����") );
					showPlayerDialog( playerid, d_taxi + 2, DIALOG_STYLE_LIST, " ", g_small_string, "�������", "�������" );
				}
				
				default:	
					return SendClient:( playerid, C_WHITE, !""gbError"�� ������ ���������� � ������� ������." );
			}
		}
		//�����������
		case 2:
		{
		}
		//����������
		case 3:
		{
			if( job_duty{playerid} && IsPlayerInAnyVehicle( playerid ) && GetPlayerState( playerid ) == PLAYER_STATE_DRIVER )
			{
				if( GetPlayerVehicleID( playerid ) != Job[playerid][j_vehicleid] ) 
					return SendClient:( playerid, C_WHITE, !""gbError"�� ������ ���������� � ������� ������." );
			
				switch( GetVehicleModel( GetPlayerVehicleID( playerid ) ) ) 
				{
	        		case 499,414:
					{			
						if( GetPVarInt( playerid, "Job:Unload" ) )
							return SendClient:( playerid, C_WHITE, !""gbError"�� �� ��������� ��������� �������." );
						
						OpenListOrders( playerid );
					}
					
					case 514,515: return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
				}
			}
		}
		
		case 4:
		{
			if( !job_duty{playerid} ) 
				return SendClient:( playerid, C_WHITE, !""gbError"�� �� ������ ������� ����." );
			
			if( !IsPlayerInAnyVehicle( playerid ) ) 
				return SendClient:( playerid, C_WHITE, !""gbError"�� ������ ���������� � ������." );
			
			if( GetPlayerState( playerid ) != PLAYER_STATE_DRIVER ) 
				return SendClient:( playerid, C_WHITE, !""gbError"�� ������ ���������� �� ����� ����������." );
		
			if( Job[playerid][j_taxi] ) 
				return SendClient:( playerid, C_WHITE, !""gbError"� ��� ���� ������������� ������." );
		
			if( GetPlayerVehicleID( playerid ) != Job[playerid][j_vehicleid] ) 
				return SendClient:( playerid, C_WHITE, !""gbError"�� ������ ���������� � ������� ������." );
		
			switch( GetVehicleModel( GetPlayerVehicleID( playerid ) ) ) 
			{
				case 525: ShowListMechCalls( playerid );
				
				default:	
					return SendClient:( playerid, C_WHITE, ""gbError"�� �� � ������� ������." );
			}
		}
	}
	
	return 1;
}

CMD:routes( playerid )
{
	if( !GetAccessCommand( playerid, "routes" ) )
	   return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	   
	showPlayerDialog( playerid, d_makeroute, DIALOG_STYLE_LIST, " ", "\
		�������� ���������\n\
		������� �������\n\
		�������� ��������", 
	"�������", "�������" );
	
	return 1;
}

//���������� ���������
CMD:ap( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "ap" ) )
	   return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, -1, ""gbDefault"�������: /ap [ �������� ]" );
	
	if( params[0] < INVALID_PARAM || params[0] > 0 ) 
		return SendClient:( playerid, -1, ""gbDefault"���������: -1 ������� ��������, 0 ���������� ���������." );
		
	if( !IsPlayerInAnyVehicle( playerid ) )
		return SendClient:( playerid, C_WHITE, ""gbError"�� ������ ���������� � ������!" );
		
	new
		route = GetPVarInt( playerid, "Job:AddRoute" ),
		param = params[0];
	  
	if( !route )
		return SendClient:( playerid, C_WHITE, ""gbError"������� �� ������!" );
	
	AddCheckpoint( playerid, route - 1, param );
	
	return 1;
}

CMD:unload( playerid )
{
	new
		bool:flag = false;

	if( GetPVarInt( playerid, "Job:SetCheckPointProd" ) )
	{
		if( GetPlayerVehicleID( playerid ) >= cars_prod[0] || GetPlayerVehicleID( playerid ) <= cars_prod[0] )
		{
			if( Job[playerid][j_vehicleid] == GetPlayerVehicleID( playerid ) && GetPlayerState( playerid ) == PLAYER_STATE_DRIVER )
			{
				new 
					order = GetPVarInt( playerid, "Job:SelectOrder" ),
					bid = ProductsInfo[order][b_id],
					Float:unload_pos,
					vid = GetPlayerVehicleID( playerid ),
					result;
		
				unload_pos = GetPlayerDistanceFromPoint( playerid, BusinessInfo[bid][b_enter_pos][0], BusinessInfo[bid][b_enter_pos][1], BusinessInfo[bid][b_enter_pos][2] );
				
				if( unload_pos < 7.0 )
					return SendClient:( playerid, C_WHITE, ""gbError"�� ���������� ������� ������ � ����� ���������." );
				else if( unload_pos > 20.0 )
					return SendClient:( playerid, C_WHITE, ""gbError"�� ���������� ������� ������ �� ����� ���������." );
				
				DisablePlayerCheckpoint( playerid );
				
				result = Job[playerid][j_count_order] % MAX_BOX_PRODUCTS;
				
				if( result )
				{
					Job[playerid][j_count] = floatround( float( Job[playerid][j_count_order] ) / float( MAX_BOX_PRODUCTS ), floatround_ceil );
				}
				else
				{
					Job[playerid][j_count] = floatround( Job[playerid][j_count_order] / MAX_BOX_PRODUCTS );
				}
				
				KillTimer( timer_order[playerid] );
				
				CheckVehicleParams( vid );
				Vehicle[vid][vehicle_state_boot] = true;
				SetVehicleParams( vid );
				
				SendClient:( playerid, C_WHITE, ""gbDefault"��������� ����� �� ������ ������ �������� ����������." );
				SetPVarInt( playerid, "Job:Unload", 1 );
				SetPVarInt( playerid, "Job:UnloadCount", 1 );
				
				flag = true;
			}
		}
	}
	
	if( !flag )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	return 1;
}

CMD:tow( playerid, params[] ) 
{
	if( Player[playerid][uJob] != JOB_MECHANIC || !job_duty{playerid} )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

	if( sscanf( params, "i", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, ""gbDefault"�������: /tow [ id ������ � /dl ]" );

	if( !GetVehicleModel( params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbError"������������ id ����������." );
		
	if( IsPlayerInAnyVehicle( playerid ) && GetPlayerState( playerid ) == PLAYER_STATE_DRIVER ) 
	{ 
		if( GetVehicleModel( GetPlayerVehicleID( playerid ) ) == 525 ) 
		{ 
			new 
				Float:pX,
				Float:pY,
				Float:pZ;
				
			GetPosVehicleBoot( GetPlayerVehicleID( playerid ), pX, pY, pZ );
			
			if( GetVehicleDistanceFromPoint( params[0], pX, pY, pZ ) > 5.0 )	
				return SendClient:( playerid, C_WHITE, ""gbError"�� ������� ������ �� ������." ); 
				
			if( Vehicle[params[0]][vehicle_user_id] )
			{
				if( Vehicle[params[0]][vehicle_user_id] == Player[playerid][uID] )
				{
					AttachTrailerToVehicle( params[0], GetPlayerVehicleID( playerid ) ); 
					SendClient:( playerid, C_WHITE, ""gbSuccess"���� ������ ����������." ); 
					return 1;
				}
			
				if( GetPVarInt( playerid, "Mech:Vid" ) == params[0] )
				{
					AttachTrailerToVehicle( params[0], GetPlayerVehicleID( playerid ) ); 
					SendClient:( playerid, C_WHITE, ""gbSuccess"������ ����������." );
					
					DeletePVar( playerid, "Mech:Vid" );
					return 1;
				}
			
				foreach(new i : Player)
				{
					if( !IsLogged( i ) )
						continue;
				
					if( Vehicle[params[0]][vehicle_user_id] == Player[i][uID] )
					{
						pformat:( ""gbSuccess"�� ��������� ������ �� ��������� "cBLUE"%s"cWHITE", �������� ������������� �� ���������.",
							GetVehicleModelName( Vehicle[params[0]][vehicle_model] ) );
						psend:( playerid, C_WHITE );
					
						SetPVarInt( i, "Mech:Driverid", playerid );
						SetPVarInt( i, "Mech:Vid", params[0] );
						
						format:g_small_string( "\
							"cBLUE"���������\n\n\
							"cWHITE"������� ���������� ������������ ��� ���������� "cBLUE"%s"cWHITE".\n\n\
							�� ��������?", GetVehicleModelName( Vehicle[params[0]][vehicle_model] ) );
						
						showPlayerDialog( i, d_mech + 2, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );
						break;
					}
				}
			}
			else
			{
				AttachTrailerToVehicle( params[0], GetPlayerVehicleID( playerid ) ); 
				SendClient:( playerid, C_WHITE, ""gbSuccess"������ ����������." );  
			}
		} 		
	} 
	return 1;
}

CMD:repair( playerid, params[] )
{
	if( Player[playerid][uJob] != JOB_MECHANIC || !job_duty{playerid} )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( IsPlayerInAreaRepair( playerid ) == INVALID_PARAM )
		return SendClient:( playerid, C_WHITE, !""gbError"�� ������ ���������� �� ���������� ���." );
		
	if( sscanf( params, "i", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, ""gbDefault"�������: /repair [ id ������ � /dl ]" );
		
	if( GetPVarInt( playerid, "Mech:VId" ) )
		return SendClient:( playerid, C_WHITE, ""gbError"�� ��� ����������� ��������." );
		
	if( !GetVehicleModel( params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbError"������������ id ����������." );
		
	if( VehicleInfo[GetVehicleModel( params[0] ) - 400][v_repair] == INVALID_PARAM ) 
		return SendClient:( playerid, C_WHITE, !""gbError"�� �� ������ ��������������� ���� ���������." );
		
	new 
		Float:pX,
		Float:pY,
		Float:pZ;
		
	GetPlayerPos( playerid, pX, pY, pZ );
	
	if( GetVehicleDistanceFromPoint( params[0], pX, pY, pZ ) > 4.0 )
		return SendClient:( playerid, C_WHITE, ""gbError"�� ������� ������ �� ������." ); 
		
	format:g_small_string( ""cBLUE"������ %s", GetVehicleModelName( GetVehicleModel( params[0] ) ) );	
	showPlayerDialog( playerid, d_mech + 5, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
		���������\n\
		�����\n\
		����\n\
		��������\n\
		����������� ������",
	"�������", "�������" );
	
	SetPVarInt( playerid, "Mech:VId", params[0] );
	
	return 1;
}
