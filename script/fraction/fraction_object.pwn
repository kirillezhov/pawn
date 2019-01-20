
function Obj_OnPlayerConnect( playerid )
{
	SetPVarInt( playerid, "FObject:Mode", -1 );
	SetPVarInt( playerid, "FObject:Id", -1 );
	SetPVarInt( playerid, "FObject:Select", 0 );
	return 1;
}

function Obj_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	switch( dialogid ) 
	{
		case d_fobject:
		{
			if( !response )
				return 1;
				
			new
				fid = Player[playerid][uMember] - 1;
				
			for( new i; i < MAX_OBJECT; i++ )
			{
				if( Object[fid][i][f_object_id] != 0 )
					continue;
					
				new 
					Float: x,
					Float: y,
					Float: z;
					
				GetPlayerPos( playerid, x, y, z );
				
				Object[fid][i][f_object_id] = i + 1;
				Object[fid][i][f_object] = CreateDynamicObject( 
					f_objects[fid][listitem][obj_model], 
					x + 2.0,
					y,
					z,
					0.0,
					0.0,
					0.0,
					GetPlayerVirtualWorld( playerid ),
					-1,
					-1,
					150
				);
				
				SetPVarInt( playerid, "FObject:Mode", 1 );
				SetPVarInt( playerid, "FObject:Id", i );
				
				Streamer_UpdateEx( playerid, x, y, z );
				
				EditDynamicObject( playerid, Object[fid][i][f_object] );
				
				break;
			}
		}
		
		case d_fobject + 1:
		{
			if( !response )
				return 1;
				
			switch( listitem )
			{
				case 0:
				{
					return SendClient:( playerid, C_WHITE, !""gbDefault"Для удаления объекта используйте - "cBLUE"/dobject [id]" );
				}
				
				case 1:
				{
					SetPVarInt( playerid, "FObject:Select", 1 );
					SelectObject( playerid );
					
					return SendClient:( playerid, C_WHITE, ""gbDefault"Выберите объект для удаления на карте." );
				}
			}
		}
	}
	
	return 1;
}

function Obj_OnPlayerEditDynamicObject( playerid, objectid, response, Float: x, Float:y, Float:z, Float:rx, Float:ry, Float:rz ) 
{ 
	if( GetPVarInt( playerid, "FObject:Mode" ) != -1 )
	{
		switch( response )
		{
			case EDIT_RESPONSE_UPDATE :
			{
				new
					Float: distance = GetPlayerDistanceFromPoint( playerid, x, y, z ),
					id = GetPVarInt( playerid, "FObject:Id" ),
					fid = Player[playerid][uMember] - 1;
					
				if( distance > 130.0 )
				{
					if( IsValidDynamicObject( Object[ fid ][ id ][f_object] ) )
						DestroyDynamicObject( Object[ fid ][ id ][f_object] );
					
					ClearFObjectData( fid, id );
					CancelEdit( playerid );
					SetPVarInt( playerid, "FObject:Mode", -1 );
					SetPVarInt( playerid, "FObject:Id", -1 );
				}
			}
			
			case EDIT_RESPONSE_FINAL :
			{	
				if( !IsValidDynamicObject( objectid ) ) 
					return 1;
			
				MoveDynamicObject( objectid, x, y, z, 10.0, rx, ry, rz );
				
				new
					id = GetPVarInt( playerid, "FObject:Id" ),
					fid = Player[playerid][uMember] - 1;
					
				format:g_small_string( "[%d - %d]", Object[ fid ][ id ][f_object_id], Player[playerid][uMember] );
				Object[fid][id][f_object_text] = CreateDynamic3DTextLabel( g_small_string, C_DARKGRAY, x, y, z + 0.5, 3.0 );
				
				SetPVarInt( playerid, "FObject:Mode", -1 );
				SetPVarInt( playerid, "FObject:Id", -1 );
			}
			
			case EDIT_RESPONSE_CANCEL :
			{
				if( !IsValidDynamicObject( objectid ) ) 
					return 1;
			
				new
					id = GetPVarInt( playerid, "FObject:Id" ),
					fid = Player[playerid][uMember] - 1;
				
				DestroyDynamicObject( Object[ fid ][ id ][ f_object ] );
				
				ClearFObjectData( fid, id );
				
				SetPVarInt( playerid, "FObject:Mode", -1 );
				SetPVarInt( playerid, "FObject:Id", -1 );
			}
		}
	}
	return 1;
}

function Obj_OnPlayerSelectDynamicObject( playerid, objectid, modelid, Float: x, Float: y, Float: z ) 
{
	if( GetPVarInt( playerid, "FObject:Select" ) )
	{
		new
			fid = Player[playerid][uMember] - 1;
			
		for( new i; i < MAX_OBJECT; i++ ) 
		{
			if( !Object[ fid ][i][f_object_id] )
				continue;
				
			if( Object[ fid ][i][f_object] == objectid )
			{
				if( IsValidDynamicObject( objectid ) ) DestroyDynamicObject( objectid );
				
				if( IsValidDynamic3DTextLabel( Object[ fid ][i][f_object_text] ) )
				{
					DestroyDynamic3DTextLabel( Object[ fid ][i][f_object_text] );
					Object[ fid ][i][f_object_text] = Text3D: INVALID_3DTEXT_ID;
				}
				
				pformat:( ""gbSuccess"Вы удалили объект с ID: "cBLUE"%d"cWHITE".", Object[ fid ][i][f_object_id] );
				psend:( playerid, C_WHITE );
				
				ClearFObjectData( fid, i );
				CancelEdit( playerid );
				
				SetPVarInt( playerid, "FObject:Select", 0 );
				break;
			}
		}
	}
	
	return 1;
}

stock ClearFObjectData( fraction, id )
{
	Object[ fraction ][ id ][f_object_id] =
	Object[ fraction ][ id ][f_object] =
	Object[ fraction ][ id ][f_object_model] = 0;
	Object[ fraction ][ id ][f_object_text] = Text3D: INVALID_3DTEXT_ID;
	
	return 1;
}