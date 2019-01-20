#define YEAR0           1900  				// the first year 
#define EPOCH_YR        1970  				// EPOCH = Jan 1 1970 00:00:00 
#define SECS_DAY        (24 * 60 * 60)
#define LEAPYEAR(%0)    (!((%0) % 4) && (((%0) % 100) || !((%0) % 400)))
#define YEARSIZE(%0)    (LEAPYEAR(%0) ? 366 : 365)

new
	g_year,
	g_month,
	g_day,
	g_hour,
	g_minute;

static const _ytab[2][12] = 
{
	{ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 },
	{ 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
};

stock gmtime( timestamp, &year = EPOCH_YR, &month = 1, &day = 1, &hour = 0, &minute = 0, &second = 0 )
{
	static dayclock;

	year = EPOCH_YR;
	dayclock = timestamp % SECS_DAY;
	day = timestamp / SECS_DAY;

	second = dayclock % 60;
	minute = ( dayclock % 3600 ) / 60;
	hour = dayclock / 3600 + 3;

	if( hour > 23 )
		hour -= 24;
	
	while( day >= YEARSIZE( year ) ) 
	{
		day -= YEARSIZE(year);
		year++;
	}

	month = 0;

	while ( day >= _ytab[LEAPYEAR( year )][month] ) 
	{
		day -= _ytab[LEAPYEAR( year )][month];
		month++;
	}

	day++;
	month++;
}
