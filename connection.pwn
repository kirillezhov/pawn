Connection_OnGameModeInit() 
{
	new 
		FileID = ini_openFile("mysql_settings.ini"), 
		errCode;
	
	if(FileID < 0) 
	{
		printf("[Mysql]: Error while opening MySQL settings file. Error code: %d", FileID);
		return 0;
	}
	
	errCode = ini_getString( FileID,"host", Connection[HOST] );
	if( errCode < 0 )
		printf("[Mysql]: Error while reading MySQL settings file (host). Error code: %d",errCode);
		
	errCode = ini_getString( FileID,"username", Connection[USERNAME] );
	if( errCode < 0 ) 
		printf("[Mysql]: Error while reading MySQL settings file (username). Error code: %d",errCode);
		
	errCode = ini_getString( FileID,"password", Connection[PASSWORD] );
	if( errCode < 0 ) 
		printf("[Mysql]: Error while reading MySQL settings file (password). Error code: %d",errCode);
		
	errCode = ini_getString( FileID,"database", Connection[DATABASE] );
	if( errCode < 0 ) 
		printf("[Mysql]: Error while reading MySQL settings file (database). Error code: %d",errCode);
	
	ini_closeFile(FileID);
	
	print( "[Mysql]: Database connection is established." );
   
	mysql_log( LOG_ALL );
	mysql = mysql_connect( Connection[HOST], Connection[USERNAME], Connection[DATABASE], Connection[PASSWORD] );
	
 	mysql_tquery( mysql, !"SET NAMES 'utf8'", "", "");
    mysql_tquery( mysql, !"SET CHARACTER SET 'cp1251'", "", "");
	mysql_tquery( mysql, !"UPDATE "DB_USERS" SET uStatus = '0'", "", "");
	mysql_tquery( mysql, !"UPDATE "DB_ADMINS" SET aStatus = '0'", "", "");
	
	return 1;
}

public OnQueryError( errorid, error[], callback[], query[], connectionHandle )
{
	switch( errorid )
	{
		case CR_SERVER_GONE_ERROR:
		{
			printf("[Mysql]: Lost connection to server, trying reconnect...");
			mysql_reconnect( connectionHandle );
		}
		case ER_SYNTAX_ERROR:
		{
			printf("[Mysql]: Error %s, query: %s | Where Callback: %s", error, query, callback );
		}
	}
	return 1;
}