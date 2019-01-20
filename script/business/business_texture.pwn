
SetBusinessTexture( bid, texture, type, number )
{
	if( texture < 0 )
		texture = 0;

	switch( type )
	{
		case 0://Текстуры стен
		{	
			for( new i = BTextureWall[bid][number][0]; i < BTextureWall[bid][number][1] + 1; i++ )
			{
				if( !IsValidDynamicObject( i ) || !i ) continue;
				
				SetDynamicObjectMaterial( i, 0, b_wall_textures[ texture ][b_tx_id], b_wall_textures[ texture ][b_tx_number], b_wall_textures[ texture ][b_tx_model], 0 );
			}
		}
		case 1://Текстуры полов
		{
			for( new i = BTextureFloor[bid][number][0]; i < BTextureFloor[bid][number][1] + 1; i++ )
			{
				if( !IsValidDynamicObject( i ) || !i ) continue;
				
				SetDynamicObjectMaterial( i, 0, b_floor_textures[ texture ][b_tx_id], b_floor_textures[ texture ][b_tx_number], b_floor_textures[ texture ][b_tx_model], 0 );
			}
		}
		case 2://Текстуры пололков
		{
			for( new i = BTextureRoof[bid][number][0]; i < BTextureRoof[bid][number][1] + 1; i++ )
			{
				if( !IsValidDynamicObject( i ) || !i ) continue;
				
				SetDynamicObjectMaterial( i, 0, b_roof_textures[ texture ][b_tx_id], b_roof_textures[ texture ][b_tx_number], b_roof_textures[ texture ][b_tx_model], 0 );
			}
		}
		
		case 3://Текстуры лестниц
		{
			for( new i = BTextureStairs[bid][0]; i < BTextureStairs[bid][1] + 1; i++ )
			{
				if( !IsValidDynamicObject( i ) || !i ) continue;
				
				SetDynamicObjectMaterial( i, 0, b_floor_textures[ texture ][b_tx_id], b_floor_textures[ texture ][b_tx_number], b_floor_textures[ texture ][b_tx_model], 0 );
				SetDynamicObjectMaterial( i, 1, b_floor_textures[ texture ][b_tx_id], b_floor_textures[ texture ][b_tx_number], b_floor_textures[ texture ][b_tx_model], 0 );
			}
		}
	}
	
	return 1;
}

UpdateBusinessTexture( playerid, bid, type, number )
{
	switch( type )
	{
		case 0:
		{
			BusinessInfo[bid][b_wall][ number ] = SelectedBox[playerid] + Menu3DData[playerid][CurrTextureIndex];
				
			mysql_format:g_small_string( "UPDATE `"DB_BUSINESS"` \
			SET `b_wall` = '%d|%d|%d|%d|%d' \
			WHERE `b_id` = %d LIMIT 1",
				BusinessInfo[bid][b_wall][0],
				BusinessInfo[bid][b_wall][1],
				BusinessInfo[bid][b_wall][2],
				BusinessInfo[bid][b_wall][3],
				BusinessInfo[bid][b_wall][4],
				BusinessInfo[bid][b_id]
			);
			
			mysql_tquery( mysql, g_small_string );
		}
		
		case 1:
		{
			BusinessInfo[bid][b_floor][ number ] = SelectedBox[playerid] + Menu3DData[playerid][CurrTextureIndex];
			
			mysql_format:g_small_string( "UPDATE `"DB_BUSINESS"` \
			SET `b_floor` = '%d|%d|%d|%d|%d' \
			WHERE `b_id` = %d LIMIT 1",
				BusinessInfo[bid][b_floor][0],
				BusinessInfo[bid][b_floor][1],
				BusinessInfo[bid][b_floor][2],
				BusinessInfo[bid][b_floor][3],
				BusinessInfo[bid][b_floor][4],
				BusinessInfo[bid][b_id]
			);
			
			mysql_tquery( mysql, g_small_string );
		}
		
		case 2:
		{
			BusinessInfo[bid][b_roof][ number ] = SelectedBox[playerid] + Menu3DData[playerid][CurrTextureIndex];
			
			mysql_format:g_small_string( "UPDATE `"DB_BUSINESS"` \
			SET `b_roof` = '%d|%d|%d|%d' \
			WHERE `b_id` = %d LIMIT 1",
				BusinessInfo[bid][b_roof][0],
				BusinessInfo[bid][b_roof][1],
				BusinessInfo[bid][b_roof][2],
				BusinessInfo[bid][b_roof][3],
				BusinessInfo[bid][b_id]
			);
			
			mysql_tquery( mysql, g_small_string );
		}
		
		case 3:
		{
			BusinessInfo[bid][b_stair] = SelectedBox[playerid] + Menu3DData[playerid][CurrTextureIndex];
			UpdateBusiness( bid, "b_stair", BusinessInfo[bid][b_stair] );
		}
	}
}