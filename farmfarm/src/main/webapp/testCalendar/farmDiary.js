var todayDate;
if (typeof(headerfooter_time_year) != "undefined"){
    /* 오늘의 날짜를 서버 날짜로 설정 */
    todayDate = new Date(
                    headerfooter_time_year, headerfooter_time_month - 1,
                    headerfooter_time_day, headerfooter_time_hour,
                    headerfooter_time_minute, headerfooter_time_second);
}
else
    todayDate = new Date();

function memorialDay(name, month, day, solarLunar, holiday, type){
    this.name = name;
    this.month = month;
    this.day = day;
    this.solarLunar = solarLunar;
    this.holiday = holiday;    /* true : 빨간날 false : 안빨간날 */
    this.type = type;    /* true : real time setting */
    this.techneer = true;
}

function myDate(year, month, day, leapMonth){
    this.year = year;
    this.month = month;
    this.day = day;
    this.leapMonth = leapMonth;
}

// 음력 데이터 (평달 - 작은달 :1,  큰달:2 )
// (윤달이 있는 달 - 평달이 작고 윤달도 작으면 :3 , 평달이 작고 윤달이 크면 : 4)
// (윤달이 있는 달 - 평달이 크고 윤달이 작으면 :5,  평달과 윤달이 모두 크면 : 6)
var lunarMonthTable = [
	[2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2],
	[1, 2, 1, 1, 2, 1, 2, 5, 2, 2, 1, 2],
	[1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],   /* 1901 */
	[2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2],
	[1, 2, 1, 2, 3, 2, 1, 1, 2, 2, 1, 2],
	[2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1],
	[2, 2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 2],
	[1, 2, 2, 4, 1, 2, 1, 2, 1, 2, 1, 2],
	[1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1],
	[2, 1, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2],
	[1, 5, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2],
	[1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],
	[2, 1, 2, 1, 1, 5, 1, 2, 2, 1, 2, 2],   /* 1911 */
	[2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2],
	[2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2],
	[2, 2, 1, 2, 5, 1, 2, 1, 2, 1, 1, 2],
	[2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2],
	[1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1],
	[2, 3, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1],
	[2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2],
	[1, 2, 1, 1, 2, 1, 5, 2, 2, 1, 2, 2],
	[1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2],
	[2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2],   /* 1921 */
	[2, 1, 2, 2, 3, 2, 1, 1, 2, 1, 2, 2],
	[1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2],
	[2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1],
	[2, 1, 2, 5, 2, 1, 2, 2, 1, 2, 1, 2],
	[1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
	[2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2],
	[1, 5, 1, 2, 1, 1, 2, 2, 1, 2, 2, 2],
	[1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2],
	[1, 2, 2, 1, 1, 5, 1, 2, 1, 2, 2, 1],
	[2, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1],   /* 1931 */
	[2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2],
	[1, 2, 2, 1, 6, 1, 2, 1, 2, 1, 1, 2],
	[1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 2],
	[1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
	[2, 1, 4, 1, 2, 1, 2, 1, 2, 2, 2, 1],
	[2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1],
	[2, 2, 1, 1, 2, 1, 4, 1, 2, 2, 1, 2],
	[2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1, 2],
	[2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1],
	[2, 2, 1, 2, 2, 4, 1, 1, 2, 1, 2, 1],   /* 1941 */
	[2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 1, 2],
	[1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2],
	[1, 1, 2, 4, 1, 2, 1, 2, 2, 1, 2, 2],
	[1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2],
	[2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2],
	[2, 5, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2],
	[2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
	[2, 2, 1, 2, 1, 2, 3, 2, 1, 2, 1, 2],
	[2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1],
	[2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2],   /* 1951 */
	[1, 2, 1, 2, 4, 2, 1, 2, 1, 2, 1, 2],
	[1, 2, 1, 1, 2, 2, 1, 2, 2, 1, 2, 2],
	[1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2],
	[2, 1, 4, 1, 1, 2, 1, 2, 1, 2, 2, 2],
	[1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2],
	[2, 1, 2, 1, 2, 1, 1, 5, 2, 1, 2, 2],
	[1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
	[1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1],
	[2, 1, 2, 1, 2, 5, 2, 1, 2, 1, 2, 1],
	[2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2],   /* 1961 */
	[1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1],
	[2, 1, 2, 3, 2, 1, 2, 1, 2, 2, 2, 1],
	[2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2],
	[1, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 2],
	[1, 2, 5, 2, 1, 1, 2, 1, 1, 2, 2, 1],
	[2, 2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 2],
	[1, 2, 2, 1, 2, 1, 5, 2, 1, 2, 1, 2],
	[1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1],
	[2, 1, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2],
	[1, 2, 1, 1, 5, 2, 1, 2, 2, 2, 1, 2],   /* 1971 */
	[1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],
	[2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 2, 1],
	[2, 2, 1, 5, 1, 2, 1, 1, 2, 2, 1, 2],
	[2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2],
	[2, 2, 1, 2, 1, 2, 1, 5, 2, 1, 1, 2],
	[2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 1],
	[2, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1],
	[2, 1, 1, 2, 1, 6, 1, 2, 2, 1, 2, 1],
	[2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2],
	[1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2],   /* 1981 */
	[2, 1, 2, 3, 2, 1, 1, 2, 2, 1, 2, 2],
	[2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2],
	[2, 1, 2, 2, 1, 1, 2, 1, 1, 5, 2, 2],
	[1, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2],
	[1, 2, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1],
	[2, 1, 2, 2, 1, 5, 2, 2, 1, 2, 1, 2],
	[1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
	[2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2],
	[1, 2, 1, 1, 5, 1, 2, 1, 2, 2, 2, 2],
	[1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2],   /* 1991 */
	[1, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2],
	[1, 2, 5, 2, 1, 2, 1, 1, 2, 1, 2, 1],
	[2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2],
	[1, 2, 2, 1, 2, 2, 1, 5, 2, 1, 1, 2],
	[1, 2, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2],
	[1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
	[2, 1, 1, 2, 3, 2, 2, 1, 2, 2, 2, 1],
	[2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1],
	[2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1],
	[2, 2, 2, 3, 2, 1, 1, 2, 1, 2, 1, 2],   /* 2001 */
	[2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1],
	[2, 2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2],
	[1, 5, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2],
	[1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 1],
	[2, 1, 2, 1, 2, 1, 5, 2, 2, 1, 2, 2],
	[1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2],
	[2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2],
	[2, 2, 1, 1, 5, 1, 2, 1, 2, 1, 2, 2],
	[2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
	[2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1],   /* 2011 */
	[2, 1, 6, 2, 1, 2, 1, 1, 2, 1, 2, 1],
	[2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2],
	[1, 2, 1, 2, 1, 2, 1, 2, 5, 2, 1, 2],
	[1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2, 1],
	[2, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2],
	[2, 1, 1, 2, 3, 2, 1, 2, 1, 2, 2, 2],
	[1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2],
	[2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
	[2, 1, 2, 5, 2, 1, 1, 2, 1, 2, 1, 2],
	[1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1],   /* 2021 */
	[2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2],
	[1, 5, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2],
	[1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1],
	[2, 1, 2, 1, 1, 5, 2, 1, 2, 2, 2, 1],
	[2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2],
	[1, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 2],
	[1, 2, 2, 1, 5, 1, 2, 1, 1, 2, 2, 1],
	[2, 2, 1, 2, 2, 1, 1, 2, 1, 1, 2, 2],
	[1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1],
	[2, 1, 5, 2, 1, 2, 2, 1, 2, 1, 2, 1],   /* 2031 */
	[2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2],
	[1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 5, 2],
	[1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],
	[2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2],
	[2, 2, 1, 2, 1, 4, 1, 1, 2, 2, 1, 2],
	[2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2],
	[2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2, 1],
	[2, 2, 1, 2, 5, 2, 1, 2, 1, 2, 1, 1],
	[2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 2, 1],
	[2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2],   /* 2041 */
	[1, 5, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2],
	[1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2]];

/* 양력 <-> 음력 변환 함수
* type : 1 - 양력 -> 음력
*        2 - 음력 -> 양력
* leapmonth : 0 - 평달
*             1 - 윤달 (type = 2 일때만 유효)
*/ 
function lunarCalc(year, month, day, type, leapmonth){
    var solYear, solMonth, solDay;
    var lunYear, lunMonth, lunDay;
    var lunLeapMonth, lunMonthDay;    
    var i, lunIndex;

    var solMonthDay = [31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    /* range check */
    if (year < 1900 || year > 2040){
        alert('1900년부터 2040년까지만 지원합니다');
        return;
    }

    /* 속도 개선을 위해 기준 일자를 여러개로 한다 */
    if (year >= 2000){
        /* 기준일자 양력 2000년 1월 1일 (음력 1999년 11월 25일) */
        solYear = 2000;
        solMonth = 1;
        solDay = 1;
        lunYear = 1999;
        lunMonth = 11;
        lunDay = 25;
        lunLeapMonth = 0;

        solMonthDay[1] = 29;    /* 2000 년 2월 28일 */
        lunMonthDay = 30;    /* 1999년 11월 */
    } else if (year >= 1970){
        /* 기준일자 양력 1970년 1월 1일 (음력 1969년 11월 24일) */
        solYear = 1970;
        solMonth = 1;
        solDay = 1;
        lunYear = 1969;
        lunMonth = 11;
        lunDay = 24;
        lunLeapMonth = 0;

        solMonthDay[1] = 28;    /* 1970 년 2월 28일 */
        lunMonthDay = 30;    /* 1969년 11월 */
    } else if (year >= 1940){
        /* 기준일자 양력 1940년 1월 1일 (음력 1939년 11월 22일) */
        solYear = 1940;
        solMonth = 1;
        solDay = 1;
        lunYear = 1939;
        lunMonth = 11;
        lunDay = 22;
        lunLeapMonth = 0;

        solMonthDay[1] = 29;    /* 1940 년 2월 28일 */
        lunMonthDay = 29;    /* 1939년 11월 */
    } else{
        /* 기준일자 양력 1900년 1월 1일 (음력 1899년 12월 1일) */
        solYear = 1900;
        solMonth = 1;
        solDay = 1;
        lunYear = 1899;
        lunMonth = 12;
        lunDay = 1;
        lunLeapMonth = 0;

        solMonthDay[1] = 28;    /* 1900 년 2월 28일 */
        lunMonthDay = 30;    /* 1899년 12월 */
    }

    lunIndex = lunYear - 1899;

    while (true){

        if (type == 1 && year == solYear && month == solMonth && day == solDay) {
            return new myDate(lunYear, lunMonth, lunDay, lunLeapMonth);
        } else if (type == 2 &&
                year == lunYear &&
                month == lunMonth &&
                day == lunDay && 
                leapmonth == lunLeapMonth){
            return new myDate(solYear, solMonth, solDay, 0);
        }

        /* add a day of solar calendar */
        if (solMonth == 12 && solDay == 31){
            solYear++;
            solMonth = 1;
            solDay = 1;

            /* set monthDay of Feb */
            if (solYear % 400 == 0)
                solMonthDay[1] = 29;
            else if (solYear % 100 == 0)
                solMonthDay[1] = 28;
            else if (solYear % 4 == 0)
                solMonthDay[1] = 29;
            else
                solMonthDay[1] = 28;

        } else if (solMonthDay[solMonth - 1] == solDay){
            solMonth++;
            solDay = 1;    
        } else
            solDay++;


        /* add a day of lunar calendar */
        if (lunMonth == 12 &&
            ((lunarMonthTable[lunIndex][lunMonth - 1] == 1 && lunDay == 29) ||
            (lunarMonthTable[lunIndex][lunMonth - 1] == 2 && lunDay == 30)) ){
            lunYear++;
            lunMonth = 1;
            lunDay = 1;

            lunIndex = lunYear - 1899;

            if (lunarMonthTable[lunIndex][lunMonth - 1] == 1)
                lunMonthDay = 29;
            else if (lunarMonthTable[lunIndex][lunMonth - 1] == 2)
                lunMonthDay = 30;
        } else if (lunDay == lunMonthDay){
            if (lunarMonthTable[lunIndex][lunMonth - 1] >= 3
                && lunLeapMonth == 0){
                lunDay = 1;
                lunLeapMonth = 1;
            } else{
                lunMonth++;
                lunDay = 1;
                lunLeapMonth = 0;
            }

            if (lunarMonthTable[lunIndex][lunMonth - 1] == 1)
                lunMonthDay = 29;
            else if (lunarMonthTable[lunIndex][lunMonth - 1] == 2)
                lunMonthDay = 30;
            else if (lunarMonthTable[lunIndex][lunMonth - 1] == 3)
                lunMonthDay = 29;
            else if (lunarMonthTable[lunIndex][lunMonth - 1] == 4 &&
                    lunLeapMonth == 0)
                lunMonthDay = 29;
            else if (lunarMonthTable[lunIndex][lunMonth - 1] == 4 &&
                    lunLeapMonth == 1)
                lunMonthDay = 30;
            else if (lunarMonthTable[lunIndex][lunMonth - 1] == 5 &&
                    lunLeapMonth == 0)
                lunMonthDay = 30;
            else if (lunarMonthTable[lunIndex][lunMonth - 1] == 5 &&
                    lunLeapMonth == 1)
                    lunMonthDay = 29;
            else if (lunarMonthTable[lunIndex][lunMonth - 1] == 6)
                lunMonthDay = 30;
        }else
            lunDay++;
    }
}

function getWeekday(year, month, day){
    var weekday = Array("일", "월", "화", "수", "목", "금", "토");
    var date = new Date(year, month - 1, day);

    if (date)
        return weekday[date.getDay()];
}

/*
function memorialDayCheck(solarDate, lunarDate){
    var i;
    var memorial;


    for (i = 0; i < memorialDays.length; i++){
        if (memorialDays[i].month == solarDate.month &&
            memorialDays[i].day == solarDate.day &&
            memorialDays[i].solarLunar == 1)
            return memorialDays[i];

        if (memorialDays[i].month == lunarDate.month &&
            memorialDays[i].day == lunarDate.day &&
            memorialDays[i].solarLunar == 2 &&
            !memorialDays[i].leapMonth)
            return memorialDays[i];
    }

    return null;
}
*/

function memorialDayCheck2(solarDate, lunarDate, holyDayData){
    for(var i=0; i<holyDayData.length; i++){
    	if (Number(holyDayData[i].ymd.substr(0,4)) == solarDate.year &&
    		Number(holyDayData[i].ymd.substr(4,2)) == solarDate.month &&
    		Number(holyDayData[i].ymd.substr(6,2)) == solarDate.day &&
    		holyDayData[i].cldrTy == 'S' )
    		return holyDayData[i];
    	
    	if (Number(holyDayData[i].ymd.substr(0,4)) == lunarDate.year &&
    		Number(holyDayData[i].ymd.substr(4,2)) == lunarDate.month &&
			Number(holyDayData[i].ymd.substr(6,2)) == lunarDate.day &&
			holyDayData[i].cldrTy == 'L' ) // && !holyDayData[i].leapMonth
    		return holyDayData[i];
	}
	return null;
}

function setStartDate(year, month, day){
    document.getElementById('startYear').value = year;
    document.getElementById('startMonth').value = month;
    document.getElementById('startDay').value = day;
}

function setCalendar(year, month){
	var initCalHtml = "";
	for (i = 0; i < 6; i++){
		initCalHtml += "<div class='weekWrap'>";
		initCalHtml += "	<table class='calendar'>";
		initCalHtml += "		<colgroup>";
		initCalHtml += "			<col width='83'>";
		initCalHtml += "			<col width='83'>";
		initCalHtml += "			<col width='83'>";
		initCalHtml += "			<col width='83'>";
		initCalHtml += "			<col width='83'>";
		initCalHtml += "			<col width='83'>";
		initCalHtml += "			<col width='83'>";
		initCalHtml += "		</colgroup>";
		if(i==0){
			initCalHtml += "	<thead>";
			initCalHtml += "		<tr>";
			initCalHtml += "			<th scope='col' class='holyDay'>일</th>";
			initCalHtml += "			<th scope='col'>월</th>";
			initCalHtml += "			<th scope='col'>화</th>";
			initCalHtml += "			<th scope='col'>수</th>";
			initCalHtml += "			<th scope='col'>목</th>";
			initCalHtml += "			<th scope='col'>금</th>";
			initCalHtml += "			<th scope='col'>토</th>";
			initCalHtml += "		</tr>";
			initCalHtml += "	</thead>";
		}
		initCalHtml += "<tbody>";
		for(k=0; k<6; k++){
			if(k==0){
				initCalHtml += "<tr class='dateRow'>";
			}else if(k==1){
				initCalHtml += "<tr class='farm'>";
			}else if(k==5){
				initCalHtml += "<tr class='moreRow'>";
			}else{
				initCalHtml += "<tr>";
			}
			for (j = 0; j < 7; j++){
				if(k==0){
					if(j==0){
						initCalHtml += "<td class='holyDay' onclick='popupSchdWriteLayer(event,"+( i * 7 + j )+",\"cal\")' id='cellNum" + ( i * 7 + j )+ "' ></td>";
					}else{
						initCalHtml += "<td id='cellNum" + ( i * 7 + j )+ "' onclick='popupSchdWriteLayer(event,"+( i * 7 + j )+",\"cal\")'></td>";
					}
				}else if(k==1){
					initCalHtml += "<td id='todo" + ( i * 7 + j )+ "' class='todo'></td>";
				}else if(k==5){
					initCalHtml += "<td id='more" + ( i * 7 + j )+ "' >"
								+ "<a href='javascript:void(0);' class='more' style='width: 100%;height: 100%;cursor: default;'"
								+ " onclick='popupSchdWriteLayer(event,"+( i * 7 + j )+",\"cal\")' ></a>"
								+ "</td>";
				}else{
					initCalHtml += "<td id='cellNum" + ( i * 7 + j )+ "_"+(k-2)+"' onclick='popupSchdWriteLayer(event,"+( i * 7 + j )+",\"cal\")' ></td>";
				}
			}
			initCalHtml += "</tr>";
		}
		initCalHtml += "		</tbody>";
		initCalHtml += "	</table>";
		initCalHtml += "</div>";
	}
    $(".calTable").html(initCalHtml);
    
    var i;
    var oYearSelect = document.getElementById('yearSelect');
    var oMonthSelect = document.getElementById('monthSelect');

    if (!year){
        year = oYearSelect.value;
        month = oMonthSelect.value;
    } else{
        for (i = 0; i < oYearSelect.length; i++)
            if (oYearSelect[i].value == year){
                oYearSelect.selectedIndex = i;
                break;
            }
    
        for (i = 0; i < oMonthSelect.length; i++)
            if (oMonthSelect[i].value == month){
                oMonthSelect.selectedIndex = i;
                break;
            }
    }
    $("#yearViewSpan").text(year);
    $("#monthViewSpan").text(month);
    
    var monthDay = Array(31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

    /* set monthDay of Feb */
    if (year % 400 == 0)
        monthDay[1] = 29;
    else if (year % 100 == 0)
        monthDay[1] = 28;
    else if (year % 4 == 0)
        monthDay[1] = 29;
    else
        monthDay[1] = 28;


    /* set the day before 설날 */
    /*if (lunarMonthTable[year - 1 - 1899][11] == 1)
        memorialDays[1].day = 29;
    else if (lunarMonthTable[year - 1 - 1899][11] == 2)
        memorialDays[1].day = 30;*/


    var date = new Date(year, month - 1, 1);
    var startWeekday = date.getDay();

    var yyyyMMdd = year+""+tensNum(month); 

    var imgObj = {
		"Clear":"sico_shine",
		"Partly Cloudy":"sico_cloud",
		"Mostly Cloudy":"sico_clouds",
		"Cloudy":"sico_blur",
		"Rain":"sico_rain",
		"Snow/Rain":"sico_snowrain",
		"Snow":"sico_snow"
    };
    
	$.ajax({
		type: "get",
		url	:c_url+"product/selectFarmDiarySchdList.do",
		data: {
			nowDate: yyyyMMdd,
			flag : ""
		},
		dataType:"json",
		success:function(result){
			var drObj = result.diaryList;
			var scObj = result.schdList;
			var stObj = result.solTermList;
			var hlObj = result.holyDayList;
	        var arrDate = [];
	        var todayIdx = null;
	        
		    /* fill day cell of before month */
		    var bMonthDay=0;
		    for(i=startWeekday-1; i>=0; i--){
		    	var dayVal = month==1? monthDay[11]-i : monthDay[month-2]-i;
		    	var dayHTML = dayVal;
		    	var tmpYear = (month==1 ? year-1 : year);
		    	var tmpMonth = (month==1 ? 12 : month-1);
		    	var solarDate = new myDate(tmpYear, tmpMonth, dayVal);
		    	var lunarDate = lunarCalc(tmpYear, tmpMonth, dayVal, 1);
		    	/* memorial day */
//		    	var memorial = memorialDayCheck(solarDate, lunarDate);
		    	var memorial = memorialDayCheck2(solarDate, lunarDate, hlObj);
		        if (memorial && memorial.hldyYn=="Y"){
		        	$("#cellNum"+bMonthDay).addClass('holyDay');
		        }
		        
		    	/* 쉬지않는 기념일 */
		    	var memorialDay = false;
		    	if (memorial && memorial.hldyYn == 'N')
		    		memorialDay = true;

		    	var tmpDate1 = new Date(year, month-2, dayVal);
		        var tmpDate2 = new Date(year, month-2, dayVal-1);
		        var tmpDate3 = new Date(year, month-2, dayVal-2);
		        if (tmpDate1.getFullYear() == todayDate.getFullYear()
			        	&& tmpDate1.getMonth() == todayDate.getMonth()
			        	&& tmpDate1.getDate() == todayDate.getDate() ){
		        	dayHTML = dayVal+"<img src='"+c_url+"images/product/ico/"+imgObj[$("#todayWeatherVal1").val()]+".png' alt='"+$("#todayWeatherDsc1").val()+"'>";
		        	todayIdx = bMonthDay;
		        }else if (tmpDate2.getFullYear() == todayDate.getFullYear()
			        	&& tmpDate2.getMonth() == todayDate.getMonth()
			        	&& tmpDate2.getDate() == todayDate.getDate() ){
		        	dayHTML = dayVal+"<img src='"+c_url+"images/product/ico/"+imgObj[$("#todayWeatherVal2").val()]+".png' alt='"+$("#todayWeatherDsc2").val()+"'>";
		        }else if (tmpDate3.getFullYear() == todayDate.getFullYear()
			        	&& tmpDate3.getMonth() == todayDate.getMonth()
			        	&& tmpDate3.getDate() == todayDate.getDate() ){
		        	dayHTML = dayVal+"<img src='"+c_url+"images/product/ico/"+imgObj[$("#todayWeatherVal3").val()]+".png' alt='"+$("#todayWeatherDsc3").val()+"'>";
		        }
		        
		        $("#cellNum"+bMonthDay).attr("date", tmpDate1.getFullYear()+tensNum(tmpDate1.getMonth()+1)+tensNum(tmpDate1.getDate()));
		        $("#cellNum"+bMonthDay).html(dayHTML);
		        
		        
		        $("#cellNum"+bMonthDay).addClass("pre");

		        
		        /* SPECIAL DAY SETTING */
		        if (memorial){ 						// holiday - 1st
		        	$("#cellNum"+bMonthDay).html(dayHTML+"<span class='cldLunar'>"+memorial.hldyNm+"</span>");
		        }
		        
		        /* 이전 달 영농일지, 영농일정 세팅 (today, idx, drObj, scObj) */
		        arrDate.push(tmpDate1.getFullYear()+""+tensNum(tmpDate1.getMonth()+1)+""+tensNum(tmpDate1.getDate()));
		        bMonthDay++;
		    }
		    
		    /* fill day cell */        
		    for (i = 0; i < monthDay[month - 1]; i ++){
		        var index = startWeekday + i;
		        var dayHTML;
		        var memoHTML;
		
		        var solarDate = new myDate(year, month, i + 1);
		        var lunarDate = lunarCalc(year, month, i + 1, 1);
		
		        /* memorial day */
//		        var memorial = memorialDayCheck(solarDate, lunarDate);
		        var memorial = memorialDayCheck2(solarDate, lunarDate, hlObj);
		
		        /* 쉬지않는 기념일 */
		        var memorialDay = false;
		        if (memorial && memorial.hldyYn == 'N')
		            memorialDay = true;
		
		        /* day print */
		        dayHTML = ( i + 1 );
		
		        /* decoration */
		        if (index % 7 == 0){
		        	$("#cellNum"+index).addClass('holyDay');
		        }else if (memorial && memorial.hldyYn=='Y'){
		        	$("#cellNum"+index).addClass('holyDay');
		        }
		        
		        /* today & weather Setting */
		        var tmpDate1 = new Date(year, month-1, i+1);
		        var tmpDate2 = new Date(year, month-1, i);
		        var tmpDate3 = new Date(year, month-1, i-1);
		        
		        if (tmpDate1.getFullYear() == todayDate.getFullYear()
			        	&& tmpDate1.getMonth() == todayDate.getMonth()
			        	&& tmpDate1.getDate() == todayDate.getDate() ){
		        	dayHTML = dayHTML + "<img src='"+c_url+"images/product/ico/"+imgObj[$("#todayWeatherVal1").val()]+".png' alt='"+$("#todayWeatherDsc1").val()+"'>";
		        	todayIdx = index;
		        }else if (tmpDate2.getFullYear() == todayDate.getFullYear()
			        	&& tmpDate2.getMonth() == todayDate.getMonth()
			        	&& tmpDate2.getDate() == todayDate.getDate() ){
		        	dayHTML = dayHTML +"<img src='"+c_url+"images/product/ico/"+imgObj[$("#todayWeatherVal2").val()]+".png' alt='"+$("#todayWeatherDsc2").val()+"'>";
		        }else if (tmpDate3.getFullYear() == todayDate.getFullYear()
			        	&& tmpDate3.getMonth() == todayDate.getMonth()
			        	&& tmpDate3.getDate() == todayDate.getDate() ){
		        	dayHTML = dayHTML +"<img src='"+c_url+"images/product/ico/"+imgObj[$("#todayWeatherVal3").val()]+".png' alt='"+$("#todayWeatherDsc3").val()+"'>";
		        }
		        $("#cellNum"+index).attr("date", tmpDate1.getFullYear()+tensNum(tmpDate1.getMonth()+1)+tensNum(tmpDate1.getDate()));
		        $("#cellNum"+index).html(dayHTML);
		
		        /* SPECIAL DAY SETTING START */
		        if (i == 0 || i == 14 || i == 29){ // lunar calnedar print
		        	$("#cellNum"+index).html(dayHTML+"<span class='cldLunar'>(음)"+tensNum(lunarDate.month)+"."+tensNum(lunarDate.day)+"</span>");
		        }
		        for(var sd=0; sd<stObj.length; sd++){
		        	if(stObj[sd].ymd.substr(6) == tensNum(i+1)){
		        		$("#cellNum"+index).html(dayHTML+"<span class='cldLunar'>"+stObj[sd].solarTermNm+"</span>");
		        	}
		        }
				if (memorial)
					$("#cellNum"+index).html(dayHTML+"<span class='cldLunar'>"+memorial.hldyNm+"</span>");	// holiday
				/* SPECIAL DAY SETTING END */
		
				/* 현재 달 영농일지, 영농일정 세팅 (today, idx, drObj, scObj) */
		        arrDate.push(tmpDate1.getFullYear()+""+tensNum(tmpDate1.getMonth()+1)+""+tensNum(tmpDate1.getDate()));
		    }
		    
		    /* fill day cell of after month */
		    aMonthDay = monthDay[month - 1]+startWeekday;
		    for (j=1; j < 42; j++){
		    	if(aMonthDay%7==0){
		    		if(aMonthDay<42){
		    			$("#cellNum"+aMonthDay).parent().parent().parent().parent().remove(); // 표 아래의 남는 행 제거
		    		}
		    		if(aMonthDay<35){
		    			$("#cellNum"+(aMonthDay+7)).parent().parent().parent().parent().remove(); // 표 아래의 남는 행 제거
		    		}
		    		break;
		    	}
		    	
		    	var dayVal = j;
		    	var dayHTML = ""+dayVal+"";
		    	var tmpYear = (month==12 ? Number(year)+1 : year);
		    	var tmpMonth = (month==12 ? 1 : Number(month)+1);
		    	var solarDate = new myDate(tmpYear, tmpMonth, dayVal);
		    	var lunarDate = lunarCalc(tmpYear, tmpMonth, dayVal, 1);
		
		    	/* memorial day */
//		    	var memorial = memorialDayCheck(solarDate, lunarDate);
		    	var memorial = memorialDayCheck2(solarDate, lunarDate, hlObj);
		        if (memorial && memorial.hldyYn=='Y'){
		        	$("#cellNum"+aMonthDay).addClass('holyDay');
		        }
		        
		    	/* 쉬지않는 기념일 */
		    	var memorialDay = false;
		    	if (memorial && memorial.hldyYn == 'N')
		    		memorialDay = true;
		    	
		        var tmpDate1 = new Date(year, month, dayVal);
		        var tmpDate2 = new Date(year, month, dayVal-1);
		        var tmpDate3 = new Date(year, month, dayVal-2);
		        if (tmpDate1.getFullYear() == todayDate.getFullYear()
			        	&& tmpDate1.getMonth() == todayDate.getMonth()
			        	&& tmpDate1.getDate() == todayDate.getDate() ){
		        	dayHTML = dayVal+"<img src='"+c_url+"images/product/ico/"+imgObj[$("#todayWeatherVal1").val()]+".png' alt='"+$("#todayWeatherDsc1").val()+"'>";
		        	todayIdx = aMonthDay;
		        }else if (tmpDate2.getFullYear() == todayDate.getFullYear()
			        	&& tmpDate2.getMonth() == todayDate.getMonth()
			        	&& tmpDate2.getDate() == todayDate.getDate() ){
		        	dayHTML = dayVal+"<img src='"+c_url+"images/product/ico/"+imgObj[$("#todayWeatherVal2").val()]+".png' alt='"+$("#todayWeatherDsc2").val()+"'>";
		        }else if (tmpDate3.getFullYear() == todayDate.getFullYear()
			        	&& tmpDate3.getMonth() == todayDate.getMonth()
			        	&& tmpDate3.getDate() == todayDate.getDate() ){
		        	dayHTML = dayVal+"<img src='"+c_url+"images/product/ico/"+imgObj[$("#todayWeatherVal3").val()]+".png' alt='"+$("#todayWeatherDsc3").val()+"'>";
		        }
		        

		        /* SPECIAL DAY / NORMAL DAY */
		        if (memorial){
		        	$("#cellNum"+aMonthDay).attr("date", tmpDate1.getFullYear()+tensNum(tmpDate1.getMonth()+1)+tensNum(tmpDate1.getDate()));
		        	$("#cellNum"+aMonthDay).html(dayHTML+"<span class='cldLunar'>"+memorial.hldyNm+"</span>");
		        }else{
		        	$("#cellNum"+aMonthDay).attr("date", tmpDate1.getFullYear()+tensNum(tmpDate1.getMonth()+1)+tensNum(tmpDate1.getDate()));
		        	$("#cellNum"+aMonthDay).html(dayHTML);
		        }
		        $("#cellNum"+aMonthDay).addClass("pre");
		        
		    	
		    	/* 다음 달 영농일지, 영농일정 세팅 (today, idx, drObj, scObj) */
		        arrDate.push(tmpDate1.getFullYear()+""+tensNum(tmpDate1.getMonth()+1)+""+tensNum(tmpDate1.getDate()));
		        aMonthDay++;
		    }
		    
		    calDataSet(arrDate, drObj, scObj);
		    /* today class 설정 */
		    if(todayIdx!=null){
			    $("#todo"+todayIdx).addClass("today");
			    var tmpObj = $("#cellNum"+todayIdx+", td[id^=cellNum"+todayIdx+"_]:not(.colHidden)");
			    for(var i=0; i<tmpObj.length; i++){
			    	if($(tmpObj[i]).attr("colspan")==undefined || $(tmpObj[i]).attr("colspan")==1){
			    		$(tmpObj[i]).addClass("today");
					}
			    }
			    $("#more"+todayIdx).addClass("today").addClass("end");
		    }
		    
		    var cropSelect = $("div.farmBtn div ul")
		    if($(cropSelect).find("li a.on").length!=0){
		    	$(cropSelect).find("li a.on").click()
		    }else{
		    	$(cropSelect).find("li:first a:first").click()
		    }
		},
		error:function(xhr, tst, err){
			console.log(xhr, tst, err)
		}
	});
}

function lunarMonthCheck(){
    if (document.getElementById('solarLunar').value == "solar") 
        document.getElementById('leapMonth').disabled = false;
    else
        document.getElementById('leapMonth').disabled = true;
}

var ayear = todayDate.getFullYear(), amonth = todayDate.getMonth() + 1;

function initCalendar(){
	var selectStr;
	var i, j;
	for (i = 1940; i <= 2040; i++)
		selectStr += "<option value='" + i + "'>" + i + " 년</option>";
	$(".calHeader span").after("<select id='yearSelect' style='display: none;'>"+selectStr+"</select>");
	selectStr = "";
	for (i = 1; i <= 12; i++)
		selectStr += "<option value='" + i + "'>" + i + " 월</option>";
	$(".calHeader span").after("<select id='monthSelect' style='display: none;'>"+selectStr+"</select>");
    if (typeof(rege_0_1) != "undefined" && 1900 <= rege_0_1 && rege_0_1 <= 2030){
        ayear = rege_0_1;
        amonth = 1;
    }

    if (typeof(rege_0_2) != "undefined" && 1 <= rege_0_2 && rege_0_2 <= 12)
        amonth = rege_0_2;

    setCalendar(ayear, amonth);
}

$(document).ready(function(){

	/* 작목선택 */
	$("#selectCrop, #realTimeMarketPrice, #farmNews").css("width", "33%").css("float", "left");
	
	initCalendar();
	setDatepicker();
	
});

/*$(window).load(function(){
	$("div.farmBtn div ul li:first a:first").click();
})*/

function numberFormat(num) {
	var pattern = /(-?[0-9]+)([0-9]{3})/;
	while(pattern.test(num)) {
		num = num.replace(pattern,"$1,$2");
	}
	return num;
}
function viewCropInfo(code, name){
	$(".farmInfo div ul li a").removeClass('on');
	$(".farmInfo div ul li a[value='"+code+"']").addClass('on');

	/* 실시간 시세 */
	getRealTimeFarmPrice(name);
	
	/* 뉴스 조회 */
	selectFarmNews(name);
	
	/* 농작업일정 조회 */
	selectFarmTodoList(code, name);
}

/* 실시간 시세 */
function getRealTimeFarmPrice(name){
	
	$.ajax({
		type:"POST",
		url:c_url+'product/getRealTimeFarmPrice.do',
		data:{
			mclassname : name
		},
		success:function(result){
			var data = result.marketPriceList;
			var _html ="";
			_html += "<span>실시간 농산물 시세</span>";
			if(data.length > 4){
				_html += "<div class='inner'>";
			}else{
				_html += "<div class='inner ani'>";
			}	
			
			_html += "<div>";
			for(var i=0; i<data.length; i++){
				var arrow = "";
				var fontColor = "";
				if(data[i].defference>0){
					arrow = "<img src='/images/distribute/polyUp.gif' alt='상승'>";
					fontColor = "pdBlue";
				}else if(data[i].defference==0){
					arrow = "<img src='/images/distribute/poly.gif' alt='고정'>";
					fontColor = "pdBlack";
				}else if(data[i].defference<0){
					arrow = "<img src='/images/distribute/polyDown.gif' alt='하락'>";
					fontColor = "pdRed";
				}
				_html +="<div class='newsPLine mgTop8'>";
				_html +="<span class='newsPTxt' title='"+data[i].sclassname+"("+data[i].unit+"/"+data[i].gradename+")'>";
				_html += arrow;
				_html += data[i].sclassname+"(";
				_html += data[i].unit+" / ";
				_html += data[i].gradename+")";
				_html +="</span>";
				_html +="<span class='newsPTxt2 "+fontColor+"'>";
				_html += numberFormat(data[i].todayPrice)+"원";
				_html +="</span>";
				_html +="</div>";
			}
			_html+= "</div>";
			_html+= "</div>";
			
			$("#mainRealTimeFarmPrice").html(_html);
		},
		error:function(xhr, tst, err){
			console.log(xhr, tst, err);
		}
	});
}


/* 뉴스 조회 */
function selectFarmNews(name){
	$.ajax({
		type:"POST",
		url:c_url+'product/selectFarmNews.do',
		data:{
			articlSj : name
		},
		success:function(result){
			data = result.newsResult;
			var _html = '';
			if(data!=undefined){
				_html += '<h4>' + data.articlSj + '</h4>'
					+ '<img src="' + data.indvdlzImageLink + '" width=82 height=54 alt="">'
					+ '<p style="cursor:pointer;" onClick="window.open(\''+data.indvdlzViewrLink+'\',\'farmNews\',\'toolbar=no,location=no,status=no,menubar=no, scrollbars=auto,resizable=no\')">'
					+ data.articlSumry + '</p>';/*</a>*/
			}
			$(".farmNews div").html(_html);

		},
		error:function(xhr, tst, err){
			console.log(xhr, tst, err);
		}
	});
}

/* 농작업일정 조회 */
function selectFarmTodoList(code, name){
	var type = "";
	if($(".calTable").css("display")=="block"){
		type = "cal";
	}else if($(".calList").css("display")=="block"){
		type = "list";
	}
	
	var month = $("#monthSelect option:selected").val();
	var year = $("#yearSelect option:selected").val();

	$.ajax({
		type:'POST',
		url:c_url+'product/selectFarmTodoList.do',
		data:{
			selYear : year,
			farmCropsSn:code,
			selMonth:month
		},
		success:function(result){
			$("div.calRy").hide();
			$("div.calRy span.titleName").html("");
			$("div.calRy div.calTxt01").html("");
			$("div.calRy div.calTxt02").html("");
			
			$("tr.farm td[id^=todo]").html("");
			
			var data = result.todoList;
			var todayIdNum = "";
			var todayCtvtCrseCode = "";
			var todayCode = "";

			if(type=="cal"){
				cellList = $('tr.dateRow td[id^=cellNum]')
				$.each(data, function(i){
					var fromDate = this.fromDate;
					var toDate = this.toDate;
					
					$.each(cellList, function(j){
						var cellDate = $(this).attr('date');
						var idNum = $(this).attr('id').split('cellNum')[1];
						if($(this).hasClass("today")){
							todayIdNum = idNum;
							if( fromDate <= cellDate && cellDate <= toDate){
								todayCode = code;
								todayCtvtCrseCode = data[i].ctvtCrseCode;
							}
						}else if( fromDate <= cellDate && cellDate <= toDate){
							var todoHtml = "<a href='javascript:void(0);' onclick='viewTodoList(event,"+code+","+data[i].ctvtCrseCode+","+idNum+",\""+type+"\");' class='todoBar'>농작업일정</a>";
							$("#todo"+idNum).html(todoHtml);
						}
					})
				})
				if($("tr.farm td.today").length != 0){
					todayIdNum = $("tr.farm td.today").attr("id").split("todo")[1]
					var todoHtml = "<a href='javascript:void(0);' onclick='viewTodoList(event,\""+todayCode+"\",\""+todayCtvtCrseCode+"\",\""+todayIdNum+"\",\""+type+"\");' class='todoBar' style='visibility: visible;'>농작업일정</a>";
					$("tr.farm td.today").html(todoHtml)
				}
			}else if(type=="list"){
				trList = $('div.calList tr[id^=listNum]');
				$.each(data, function(i){
					var fromDate = this.fromDate;
					var toDate = this.toDate;
					
					$.each(trList, function(j){
						var listDate = $(this).attr('date');
						var idNum = $(this).attr('id').split('listNum')[1];
						if($(this).hasClass("today")){
							todayIdNum = idNum;
							if( fromDate <= listDate && listDate <= toDate){
								todayCode = code;
								todayCtvtCrseCode = data[i].ctvtCrseCode;
							}
						}else if( fromDate <= listDate && listDate <= toDate){
							var todoHtml =
								"<a href='javascript:void(0);'"
								+" onclick='viewTodoList(event,"+code+","+data[i].ctvtCrseCode+","+idNum+",\""+type+"\");' class='todoBar'>"
								+"<img src='/images/product/icoTask.png' alt=''/>농작업일정</a>";
							$("#listNum"+idNum+" td.e div.farmday").html(todoHtml);
						}
					})
				})
				if($("div.calList tr.today").length != 0){
					todayIdNum = $("div.calList tr.today").attr("id").split("listNum")[1]
					var todoHtml = 
							"<a href='javascript:void(0);'"
							+" onclick='viewTodoList(event,\""+todayCode+"\",\""+todayCtvtCrseCode+"\",\""+todayIdNum+"\",\""+type+"\");'"
							+" class='todoBar' style='display: block;'>"
							+"<img src='/images/product/icoTask.png' alt=''/>농작업일정</a>";
					$("div.calList tr.today div.farmday").html(todoHtml)
				}
				
			}
			
		},
		error:function(xhr, sts, err){
			console.log(xhr, sts, err);
		}
	})
}




function setDiaryForm(){
	
	if($(".calTable").css("display")=="block"){
		setCalendar();
	}else if($(".calList").css("display")=="block"){
		makeList();
	}
}


function chgDiaryForm(type){
	$(".calRy").hide();
	var year = $("#yearSelect option:selected").val();
	var month = $("#monthSelect option:selected").val();
	if(type=='table'){
		$(".calTable").show();
		$(".calList").hide();
		$(".sel02").removeClass("on");
		$(".sel01").addClass("on");
		
		initCalendar();
		setCalendar(year, month);
	}else if(type=='list'){
		$(".calTable").hide();
		$(".calList").show();
		$(".sel01").removeClass("on");
		$(".sel02").addClass("on");

		makeList(year, month);
	}
}

function makeList(){
	var initListHtml = "";
	var monthDay = Array(31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	var year = $("#yearSelect option:selected").val();
	var month = $("#monthSelect option:selected").val();
    /* set monthDay of Feb */
    if (year % 400 == 0)
        monthDay[1] = 29;
    else if (year % 100 == 0)
        monthDay[1] = 28;
    else if (year % 4 == 0)
        monthDay[1] = 29;
    else
        monthDay[1] = 28;

    $("#yearViewSpan").text(year);
    $("#monthViewSpan").text(month);
    
    var imgObj = {
    		"Clear":"sico_shine",
    		"Partly Cloudy":"sico_cloud",
    		"Mostly Cloudy":"sico_clouds",
    		"Cloudy":"sico_blur",
    		"Rain":"sico_rain",
    		"Snow/Rain":"sico_snowrain",
    		"Snow":"sico_snow"
    };
    
    $.ajax({
		type: "get",
		url	:c_url+"product/selectFarmDiarySchdList.do",
		data: {
			nowDate: year+tensNum(month),
			flag : "list"
		},
		dataType:"json",
		success:function(result){
			var drObj = result.diaryList;
			var scObj = result.schdList;
			var stObj = result.solTermList;
			var hlObj = result.holyDayList;
			for(var i=0; i<monthDay[month-1]; i++){
		
		        var dayHTML = "",
		        	typeHTML = "",
		        	timeHTML = "",
		        	gbHTML = "",
		        	todoHTML = "",
		        	todayClass = "",
		        	colSpanYn = 0,
		        	contentWeatherHTML = "",
		        	solarName= "",
		        	contentHeadHTML = "",
		        	contentHTML = "",
		        	todayOptHTML = "",
		        	todoValign = "";
		
		        var startWeekday = getWeekday(year, month, (i+1));
		        
		        var solarDate = new myDate(year, month, i + 1);
		        var lunarDate = lunarCalc(year, month, i + 1, 1);
		
		        /* memorial day */
		        var memorial = memorialDayCheck2(solarDate, lunarDate, hlObj);
		
		        /* 쉬지않는 기념일 */
		        var memorialDay = false;
		        if (memorial && memorial.hldyYn == 'N')
		            memorialDay = true;
		
		        /* day print */
		        dayHTML = "<b>"+tensNum(month) + "." + tensNum(i+1)+"</b> "+startWeekday;
		        /* decoration */
		        if (startWeekday == '일'){
		        	dayHTML = "<span class='ListHd'>" + dayHTML + "</span>";
		        }else if (memorial && memorial.hldyYn == 'Y'){
		        	dayHTML = "<span class='ListHd'>" + dayHTML + "</span>";
		        }
		        
		        /* today & weather Setting */
		        var tmpDate1 = new Date(year, month-1, i+1);
		        var tmpDate2 = new Date(year, month-1, i);
		        var tmpDate3 = new Date(year, month-1, i-1);
		        
//		        todoHTML = "<div class='farmday'><a href='javascript:void(0);' onclick='viewTodoList(event,"+i+",\"list\");' class='todoViewGo'><img src='"+c_url+"images/product/icoTask.png' alt=''>농작업일정</a></div>";
		        todoHTML = "<div class='farmday'>"
//		        	+"<a href='javascript:void(0);' onclick='viewTodoList(event,"+i+",\"list\");' class='todoViewGo'><img src='"+c_url+"images/product/icoTask.png' alt=''>농작업일정</a>"
		        	+"</div>";
		        
	        	if( tmpDate1.getFullYear() == todayDate.getFullYear()
			        	&& tmpDate1.getMonth() == todayDate.getMonth()
			        	&& tmpDate1.getDate() == todayDate.getDate() ){		// 오늘
		        	todayOptHTML = "<tr><td colspan='"+(3+3)+"' style='height:0; background:#87dcff; border:none'></td></tr>"; // today option HTML
		        	todayClass = " class='today'";
		        	contentWeatherHTML = "<img src='"+c_url+"images/product/ico/"+imgObj[$("#todayWeatherVal1").val()]+".png' alt='"+$("#todayWeatherDsc1").val()+"'>";
		        	todoHTML = "<div class='farmday'><a href='javascript:void(0);' onclick='viewTodoList(event,"+i+",\"list\");' style='display:block;' class='todoViewGo'><img src='/images/product/icoTask.png' alt=''>농작업일정</a></div>"; // display block
		        }else if (tmpDate2.getFullYear() == todayDate.getFullYear()
			        	&& tmpDate2.getMonth() == todayDate.getMonth()
			        	&& tmpDate2.getDate() == todayDate.getDate() ){		// 내일
		        	contentWeatherHTML = "<img src='"+c_url+"images/product/ico/"+imgObj[$("#todayWeatherVal2").val()]+".png' alt='"+$("#todayWeatherDsc2").val()+"'>";
		        }else if (tmpDate3.getFullYear() == todayDate.getFullYear()
			        	&& tmpDate3.getMonth() == todayDate.getMonth()
			        	&& tmpDate3.getDate() == todayDate.getDate() ){		// 모레
		        	contentWeatherHTML = "<img src='"+c_url+"images/product/ico/"+imgObj[$("#todayWeatherVal3").val()]+".png' alt='"+$("#todayWeatherDsc3").val()+"'>";
		        }
	        	
		        for(var sd=0; sd<stObj.length; sd++){
		        	if(stObj[sd].ymd.substr(6) == tensNum(i+1)){
		        		solarName = stObj[sd].solarTermNm;
		        	}
		        }
		        if (memorial){        									// holiday - 1st
		        	contentHeadHTML = "<span class='LineTxt' style='line-height: 26px;'>"+memorial.hldyNm+"</span>";
		        }else if(solarName){									// solar term - 2nd
		        	contentHeadHTML = "<span class='LineTxt' style='line-height: 26px;'>"+solarName+"</span>";
		        }else if(i==0||i==14||i==29){							// lunarday show a 1, 15, 30 days - 3rd
		        	contentHeadHTML = "<span class='LineTxt' style='line-height: 26px;'>(음)"+tensNum(lunarDate.month)+"."+tensNum(lunarDate.day)+"</span>";
		        }
				/* SPECIAL DAY SETTING END */


		        if(contentHeadHTML!="" || contentWeatherHTML!=""){
		        	colSpanYn++;
		        	gbHTML = "<div></div>";
		        	timeHTML = "<div></div>";
		        	contentHTML = "<div>"+contentHeadHTML + contentWeatherHTML+"</div>";
		        }
		        
		        var tdYMD = year+""+tensNum(month)+""+tensNum(i+1);
		        for(var k=0; k<drObj.length; k++){
		        	if(drObj[k].diaryDe == tdYMD ){
		        		colSpanYn++;
		        		gbHTML		+= "<div><span class='journal'>일지</span></div>";
		        		timeHTML	+= "<div>-</div>";
		        		contentHTML	+= "<div><a href='javascript:void(0);' onClick='diaryViewGo(event, "+drObj[k].diarySn+")'>"+drObj[k].diarySj+"</a></div>";
		        	}
		        }
	        	for(var k=0;k<scObj.length;k++){
	        		if( ( scObj[k].fromDate <= tdYMD ) && ( scObj[k].todate >= tdYMD ) ){
	        			colSpanYn++;
	        			gbHTML		+= "<div><span class='journal02'>일정</span></div>";
	        			
	        			timeHTML	+= (scObj[k].fromDate < tdYMD ? "<div><img src='"+c_url+"images/product/arrow2.gif' class='arrow' alt='시간'>" : "<div>");
	        			timeHTML	+= (scObj[k].alldayYn=='Y' ? "종일일정" : scObj[k].fromHm.substr(0,2)+":"+scObj[k].fromHm.substr(2,2));
	        			timeHTML	+= (scObj[k].todate > tdYMD ? "<img src='"+c_url+"images/product/arrow.gif' class='arrow' alt='시간'></div>" : "</div>")

	        			contentHTML	+= "<div><a href='javascript:void(0);' onclick='popupTodoLayer(event, "+scObj[k].schdulSn+", \"list\")' >"+scObj[k].schdulSj+"</a></div>";
	        		}
		        }
	        	
	        	if(colSpanYn>1){
	        		colSpanYn = "lineLc ";
	        		todoValign = "style='vertical-align: top;'"
	        	}else{ // 1line일때는 앞 뒤 <div></div> 태그 절삭
	        		colSpanYn = "";
	        		gbHTML =  gbHTML.substr(5).substr(0,gbHTML.length-6);
	        		timeHTML =  timeHTML.substr(5).substr(0,timeHTML.length-6);
	        		contentHTML =  contentHTML.substr(5).substr(0,contentHTML.length-6);
	        	}
	        	
	        	if(contentHTML==""){
	        		contentHTML = contentHeadHTML + contentWeatherHTML;
	        	}
	        	
	        	
				initListHtml +=	todayOptHTML;
				initListHtml +=	"<tr id='listNum"+i+"' "+todayClass+" date='"+tdYMD+"'>";
				initListHtml +=	"	<td class='"+colSpanYn+" a'> "+dayHTML+"</td>"; // LineLC = vAlign:top, top-paddin:g9px; colspan일때만
				initListHtml +=	"	<td class='"+colSpanYn+" b'><input type='image' src='"+c_url+"images/global/plus.gif' alt='추가버튼' onclick='popupSchdWriteLayer(event,"+i+",\"list\")'></td>";
				initListHtml +=	"	<td class='c'>"+gbHTML+"</td>";
				initListHtml +=	"	<td class='d'>"+timeHTML+"</td>";
				initListHtml +=	"	<td class='e' "+todoValign+">"+todoHTML+"</td>";
				initListHtml +=	"	<td class='line01 f'>"+contentHTML+"</td>";		//LineTxt:소한,음력   , line01:td클래스
				initListHtml +=	"</tr>";
				initListHtml +=	todayOptHTML;
			}
			$(".calList table tbody").html(initListHtml);
			
			var cropSelect = $("div.farmBtn div ul")
		    if($(cropSelect).find("li a.on").length!=0){
		    	$(cropSelect).find("li a.on").click()
		    }else{
		    	$(cropSelect).find("li:first a:first").click()
		    }
		}
    });
}


/*영농일지 레이어 마스킹(black)*/
function wrapWindowByMask(){
	var maskHeight = $(document).height();  
	var maskWidth = $(window).width();  
	$('#mask').css({'width':maskWidth,'height':maskHeight});  
	$('#mask').fadeTo("slow",0.4); 
}

function monthMove(arrow){
	$(".calRy").hide();
	var selYearOpt = $("#yearSelect option:selected");
	var selMonthOpt = $("#monthSelect option:selected");
	if(arrow=="dn"){
		if( selMonthOpt.index() == 0){
			$("#monthSelect option:last").attr("selected", true);
			$("#yearSelect option:eq("+(selYearOpt.index()-1)+")").attr("selected", true);
		}else{
			$("#monthSelect option:eq("+(selMonthOpt.index()-1)+")").attr("selected", true);
		}
		setDiaryForm();
	}else if(arrow=="up"){
		if( selMonthOpt.index() == 11){
			$("#monthSelect option:first").attr("selected", true);
			$("#yearSelect option:eq("+(selYearOpt.index()+1)+")").attr("selected", true);
		}else{
			$("#monthSelect option:eq("+(selMonthOpt.index()+1)+")").attr("selected", true);
		}
		setDiaryForm();
	}else{
		alert("ERROR");
	}
}

function goToday(){
	var dt = new Date();
	var year = dt.getFullYear();
	var month = dt.getMonth()+1;
	$("#yearSelect option[value='"+year+"']").attr("selected", "selected");
	$("#monthSelect option[value='"+month+"']").attr("selected", "selected");
	
	setDiaryForm();
}

function tensNum(num){
	if(num.toString().length==1){
		return "0"+num;
	}else{
		return ""+num;
	}
}


/* more list 클릭시 생성되는 layer 창 */
function viewTodoDv(objStr, e){
	var topPx = Math.floor((objStr.substr(8)/7)) * 123 + 91;
	var leftPx = $(objStr)[0].offsetLeft;
	var tmpList = $("td[id^='"+objStr.substr(1)+"_']");
	var todoList = [];
	
	for(var i=0; i<tmpList.length; i++){
		if($(tmpList[i]).attr("class")!="colHidden"){
			todoList.push(tmpList[i]);
		}else{
			for(var j=1; j<7; j++){
				var idVal = $(tmpList[i]).attr("id").substr(7).split('_');
				var idStr = "#cellNum"+(Number(idVal[0])-j)+"_"+idVal[1];
				if($(idStr).attr("colspan")!=0 && $(idStr).attr("colspan")!=undefined){
					todoList.push($(idStr)[0]);
					break;
				}
			}
		}
	}
	
	var objTarget = objStr.split(" ")[0];
	var todoDvlayerHTML = "";
	todoDvlayerHTML += "<div class='todoDv' style='top:"+topPx+"px; left:"+leftPx+"px; display:block;'>";
	todoDvlayerHTML += "	<ul>";
	for(var i=0; i<todoList.length; i++){
		todoDvlayerHTML += "<li>"+todoList[i].innerHTML+"</li>";
	}
	todoDvlayerHTML += "	</ul>";
	todoDvlayerHTML += "	<a href='javascript:fnTodoDvRemove()' class='close'>닫기</a>";
	todoDvlayerHTML += "</div>";
	if($(".todoDv").length>0){
		$(".todoDv").remove();
	}
	$(".calTable").append(todoDvlayerHTML);
//	$(".todoDv").show();
}

function viewTodoList(e, farmCropsSn, ctvtCrseCode, idx, type){
	var tdTop = "";
	var top = 0;
	var left = 0;
	if(type=="cal"){
		tdTop = $("#cellNum"+idx)[0];
		top = (Math.floor(idx/7))*123+111;
		left = tdTop.offsetLeft-115;
	}else if(type=="list"){
		tdTop = $("#listNum"+idx)[0];
		top = $("#listNum"+idx)[0].offsetTop+60;
		left = 248;
	}
	
	$.ajax({
		type:'POST',
		url:c_url+'product/selectFarmTodoDetail.do',
		data:{
			farmCropsSn:farmCropsSn,
			ctvtCrseCode:ctvtCrseCode
		},
		success:function(result){
			var data = result.todoList;
			var titleName = $("div.farmBtn a.on span").text();
			var txt01Html = "<span>농작업 일정이 없습니다.</span>";
			var txt02Html = "";
			for(var i=0; i<data.length; i++){
				if(i==0){
					titleName = data[i].cropsNm;
					txt01Html = data[i].ctvtCrseNm;
				}
				txt02Html += "<span>"
						+ data[i].ctvtSj	+ " : "
						+ data[i].fromMt	+ "월 "
						+ data[i].fromMtDiv	+ "순 ~ "
						+ data[i].toMt		+ "월 "
						+ data[i].toMtDiv	+ "순 "
						+ "</span>";
			}
			$(".calRy span.titleName").html(titleName);
			$(".calRy div.calTxt01").html(txt01Html);
			$(".calRy div.calTxt02").html(txt02Html);

			if(data.length==0){
				$(".calRy span.titleName").html(titleName);
				$(".calRy div.calTxt01").html(txt01Html);
				$(".calRy div.calTxt02").html(txt02Html);
			}
		},
		error:function(xhr, tst, err){
			console.log(xhr, tst, err);
		}
		
	})
	$(".calRy").show();
	$(".calRy").css("top", top);
	$(".calRy").css("left", left);
	$(".closeBtn02").on("click", function(e){
		$(".calRy").hide();
		e.preventDefault ? e.preventDefault(): e.returnValue = false;
		
	})
}
//농산물 시세
function fn_market(){
	var winX = 0;
	var winY = 0;
	winX = (screen.availWidth - 800) * 0.5;
	winY = (screen.availHeight - 520) * 0.5;
//	window.open("/portal/main/popup_market_price.do","marketPrice","width=817,height=520, scrollbars=yes, left=" + winX + ",top=" + winY );
}


function addTextLunar(dt){
	var year = dt.substr(0,4);
	var month = dt.substr(5,2);
	var day = dt.substr(8,2);
	var lunarDate = lunarCalc(year, month, day, 1, 0);
	
	return " " + getWeekday(year, month, day) + " (음 "+tensNum(lunarDate.month)+"."+tensNum(lunarDate.day)+")"
}
function addTextLunar2(dt){
	var year = dt.substr(0,4);
	var month = dt.substr(5,2);
	var day = dt.substr(8,2);
	var lunarDate = lunarCalc(year, month, day, 1, 0);
	
	return " (음)"+tensNum(lunarDate.month)+"."+tensNum(lunarDate.day);
}

function allDay(){
	if($('#taskStartDt').attr('disabled')){
		$('#taskStartDt, #taskEndDt').attr('disabled', false);
		$('#taskStartTm, #taskEndTm').attr('disabled', false);
	}else{
		$('#taskStartTm option:first, #taskEndTm option:last').attr("selected", true);
		$('#taskStartDt, #taskEndDt').attr('disabled', true);
		$('#taskStartTm, #taskEndTm').attr('disabled', true);
	}
}

/* byte 계산 및 제한 */
//function rtnStringByte(id, _str){
//	var str = _str ? _str : $("#"+id).val();
//	var strLength = str.length;
//	var strByteLength = 0;
//	
//	/* 
//	 * c를 2048로 나누어 몫이 있으면 3byte, 그보다 작을때 128로 나누어 몫이 있으면 2byte, 그 외는 1byte.
//	 * byte가 500보다 클 경우 br에 글자 수 저장.
//	 */
//	strByteLength = (function(s, b, i, c, br, f){	// s=str, b=byte. i=var, c=char, br=break, flag
//		for(b=i=0, f=true;c=s.charCodeAt(i++);b+=c>>11?3:c>>7?2:1, f&&b>500?(br=i, f=false):true);
//		if(b<=500){
//			$("#"+id).val(str);
//			$("#"+id+"Byte").html("<b>"+b+"</b> /500 byte");
//		}else if(br){
////			alert("500byte를 초과 하였습니다.");
//			str = str.substr(0, br-1);
//			rtnStringByte(id, str); // 재귀
//		}
//	})(str);
//}
function rtnStringByte(id, maxByte){
	var obj = document.getElementById(id);
	var str = obj.value;
	var str_len = str.length;

	var rbyte = 0;
	var rlen = 0;
	var one_char = "";
	var str2 = "";

	for(var i=0; i<str_len; i++){
		one_char = str.charAt(i);
		if(escape(one_char).length > 4){
		    rbyte += 2;                                         //한글2Byte
		}else{
		    rbyte++;                                            //영문 등 나머지 1Byte
		}

		if(rbyte <= maxByte){
			rlen = i+1;                                          //return할 문자열 갯수
		}
	}
	if(rbyte > maxByte){
	    alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
	    str2 = str.substr(0,rlen);                                  //문자열 자르기
	    obj.value = str2;
	    fnChkByte(obj, maxByte);
	}else{
		$("#"+id+"Byte").html("<b>"+rbyte+"</b> /500 byte");	
	}
}

/*
 * 지역정보 찿기 popup
 */
function openGnbPopup(){ // 이후 진행은 product/statlayer.js 참고
	$("#areaSelectLayer").css("top", "130px").css("left", "225px").show();
}

/**/
function searchLocalWeatherInfo(){ // product/statlayer.js 의 함수 구현
	selList("", "T");
	setCookie("weatherstat",$("#statHdn").val(), 30);
	setCookie("weatherstatname",$("#statSpan").text(), 30);

	var localAreaCode = $("#statHdn").val().split("|");
	var localAreaName = $("#statSpan").text().split(" ");
	var area = {
		code:localAreaCode[1],
		stat:localAreaCode[2],
		type:"getInfo"
	};
	
	$.ajax({
		type: "post",
		url	:c_url+"product/getAreaTopList.do",
		data: area,
		dataType:"json",
		success:function(result){
			var rs = result.apiList;
			var temp = rs.temp+"<span>℃</span>";
			var tMaxMin = (rs.tmm == "-999.0" ? "-" : rs.tmm+"℃") + "<br/>" + (rs.tmn == "-999.0" ? "-" : rs.tmn+"℃");
			$(".weather dl dd[class=tem]").html(temp);
			$(".weather dl dd[class=temHigh]").html(tMaxMin);
		},
		error:function(xhr, tst, err){
			console.log(xhr, tst, err)
		}
	});
}


/*레이어 중간정렬*/
function layerAlignCenter(){
//	var $layerPopupObj = $('.diaryWrite, .diaryView, .todoView');
	var $layerPopupObj = $('.diaryWrite, .diaryView');
	var left = ( $(window).scrollLeft() + ($(window).width() - $layerPopupObj.width()) / 2 );
	var top = ( $(window).scrollTop() + ($(window).height() - $layerPopupObj.height()) / 2 );
	$layerPopupObj.css({'left':left,'top':top, 'position':'absolute'});
	
	left = ( $(window).scrollLeft() + ($(window).width() - $('.todoView').width()) / 2 );
	top = ( $(window).scrollTop() + ($(window).height() - $('.todoView').height()) / 2 );
	$('.todoView').css({'left':left,'top':top, 'position':'absolute'});
//	$('body').css('position','relative').append($layerPopupObj);
}

/* 영농일정 입력 창 생성 */
function popupSchdWriteLayer(e, idx, type){
	$.ajax({
		type:'POST',
		url:c_url+'product/checkSession.do',
		data:{},
		success:function(data){
			
			if(data.loginUrl != ""){						// 세션 종료시
				if( confirm("세션이 종료되었습니다. 로그인 하시겠습니까?") ){
					document.location.href = data.loginUrl + "?preUrl=" + escape(encodeURIComponent(window.location['href']));
				}else{
					return;
				}
				
			}else{	
				
				layerAlignCenter();
				
				var _date = "";
				if(type=="cal"){
					_date = $("#cellNum"+idx).attr("date");
				}else if(type=="list"){
					_date = $("#listNum"+idx).attr("date");
				}
				_date = _date.substr(0,4)+"-"+_date.substr(4,2)+"-"+_date.substr(6,2);
				
				$("#schduWriteType").val("0"); // 값초기화
				
				$("#addSchdul").text("등록");
				$("#delSchdul").attr("style" , "display:none");//삭제버튼
				$("#decpt02, #tarea02").val("");	// 제목, 내용 초기화
				$("#tarea02Byte b").html("0");	// 내용 byte 초기화
			
				$("#taskStartDt, #taskEndDt").val(_date + addTextLunar(_date));	// 날짜 초기화
				if($(".timeLine input:checkbox").attr("checked")=="checked"){	// 체크박스 초기화
					$(".timeLine input:checkbox").click();
				}
				$("#taskStartTm option:first, #taskEndTm option:first, #decpt03 option:first").attr("selected", true);	// selectbox 초기화
				
				$(".todoView").show();
				e.preventDefault ? e.preventDefault(): e.returnValue = false;
				wrapWindowByMask();
			}
		},
		error:function(xhr, sts, err){
			
		}
	})
}


/*
 * 일정 정보 수정 및 저장 레이어 팝업 
 * e: 이벤트 object
 * sn: 키값 
 * */
function popupTodoLayer(e , sn){
	layerAlignCenter();
	//sn = "1021";
	//초기화
	var fmDate =$.datepicker.formatDate($.datepicker.ATOM, new Date()); 
	$("#addSchdul").text("등록");
	$("#schduWriteType").val("0");//key값
	$("#decpt02, #tarea02").val("");	// 제목, 내용 초기화
	$("#tarea02Byte").val("<b>0</b> /500 byte");	// 내용 byte 초기화
	$("#taskStartDt, #taskEndDt").val(fmDate + addTextLunar(fmDate));	// 날짜 초기화
	$("#delSchdul").attr("style" , "display:none");
	
	if($("#ck").is(":checked")){	// 체크박스 초기화
		$("#ck").click();
	}

	$("#taskStartTm option:first, #taskEndTm option:first, #decpt03 option:first").attr("selected", true);	// selectbox 초기화
	//수정
	if(sn != null && sn != "0"){
		var diaryData = {
//			"userId":"testadmin",
			"schdulSn":sn
		}
		var _url = "";
		_url = c_url+"product/selectSchdul.do";
		$.ajax({
			type : "POST",
			url	: _url,
			data: diaryData,
			dataType:"json",
			success:function(data){
				if(data.loginUrl != ""){
					if( confirm("세션이 종료되었습니다. 로그인 하시겠습니까?") ){
						document.location.href = data.loginUrl + "?preUrl=" + escape(encodeURIComponent(window.location['href']));
					}else{
						return;
					}
				}else if(typeof data.schMap =="undefined" ){
					alert("해당 정보는 이미 삭제 되었거나 존재하지 않는 정보입니다.");
					return;
				}else{
					$("#delSchdul").attr("style" , "display:block");//삭제버튼
					$("#addSchdul").text("수정");
					$("#schduWriteType").val(data.schMap.schdulSn);//key값
					$("#decpt02, #tarea02").val(data.schMap.schdulSj);	// 제목, 내용 초기화
					$("#tarea02").val(data.schMap.alarmMemo);
					rtnStringByte('tarea02');
					
					var strFDate = data.schMap.fromDate;
					if(strFDate != null && strFDate.length == 8){
						var strartDate = strFDate.substring(0,4) +"-"+strFDate.substring(4,6)+"-"+strFDate.substring(6,8);
						$("#taskStartDt").val(strartDate + addTextLunar(strartDate));	// 날짜 초기화
					}else{
						alert("날짜 정보가 잘못 저장되었습니다.");
					}
					
					var strEDate = data.schMap.todate;
					if(strEDate != null && strEDate.length == 8){
						var endDate = strEDate.substring(0,4) +"-"+strEDate.substring(4,6)+"-"+strEDate.substring(6,8);
						$("#taskEndDt").val(endDate + addTextLunar(endDate));	// 날짜 초기화
					}else{
						alert("날짜 정보가 잘못 저장되었습니다.");
					}
					if($(".timeLine input:checkbox").attr("checked")=="checked"){	// 체크박스 초기화
						$(".timeLine input:checkbox").click();
					}
					
					//시간
					$("#taskStartTm").val(data.schMap.fromHm);
					$("#taskEndTm").val(data.schMap.toHm);

					if(data.schMap.alldayYn=="Y"){
						$("#ck").click();
					}
					
					$(".todoView").show();
					e.preventDefault ? e.preventDefault(): e.returnValue = false;
					wrapWindowByMask();
				}
				//$("#taskStartTm option:first, #taskEndTm option:first, #decpt03 option:first").attr("selected", true);	// selectbox 초기화
			},
			error:function(xhr, tst, err){
				console.log(xhr, tst, err)
				layerClose();
			}
			
		});
	}
}

/* 영농일지 VIEW LAYER 생성 */
function diaryViewGo(e , sn){
	layerAlignCenter();
	
	if(sn!=0 && sn!=undefined){
		var yyyyMM = $("#yearViewSpan").html()+tensNum($("#monthViewSpan").html());
		$.ajax({
			type : "POST",
			url	: c_url+"product/selectViewDiary.do",
			data: {
//				"userId":"testadmin",
				"diarySn":sn,
				"currentDate":yyyyMM
			},
			dataType:"json",
			success:function(data){
				if(data.loginUrl != ""){
					if( confirm("세션이 종료되었습니다. 로그인 하시겠습니까?") ){
						document.location.href = data.loginUrl + "?preUrl=" + escape(encodeURIComponent(window.location['href']));
					}else{
						return;
					}
				}else if(typeof data.sdMap =="undefined" ){
					alert("해당 정보는 이미 삭제 되었거나 존재하지 않는 정보입니다.");
					return;
				}else{
					var sdObj = data.sdMap;
					var stObj = data.stMap;
					var hlObj = data.hlMap;
					var specialDayHtml = "";
					$("#diaryViewSn").val(sdObj.diarySn);		//key값
					$("#diaryViewTitle").html(sdObj.diarySj);	// 제목
					$("#ryOpenCnDiv").html(sdObj.diaryCn);
					//$("#diaryViewContent").html(sdObj.diaryCn);	// 내용
					var obj = "#"+sdObj.wethrCode;
					
					var wthList = {
						"190001":"wtRy07",
						"190002":"wtRy04",
						"190003":"wtRy05",
						"190004":"wtRy06",
						"190005":"wtRy03",
						"190006":"wtRy02",
						"190007":"wtRy01"
					}
					$("#diaryViewWetherImg").attr('src', c_url+"images/product/"+wthList[sdObj.wethrCode]+".gif");
					
					var strFDate = sdObj.diaryDe;
					if(strFDate != null && strFDate.length == 8){
						var dYear = strFDate.substring(0,4);
						var dMonth = strFDate.substring(4,6);
						var dDay = strFDate.substring(6,8);
						var strartDate = dYear +"-"+ dMonth +"-"+ dDay;
						
						var dtHtml = "<b>" + dYear + "년 " + dMonth + "월 " + dDay + "일 </b>"
									+ addTextLunar2(strartDate);
						$("#diaryViewDate").html(dtHtml);	// 날짜 초기화
						
						var solarDate = new myDate(dYear, dMonth, dDay);
				        var lunarDate = lunarCalc(dYear, dMonth, dDay, 1);
				        var memorial = memorialDayCheck2(solarDate, lunarDate, hlObj);

				        if(memorial){
				        	specialDayHtml = memorial.hldyNm;						// 공휴일
				        }else{
				        	for(var sd=0; sd<stObj.length; sd++){
					        	if(stObj[sd].ymd.substr(6) == dDay){
					        		specialDayHtml = stObj[sd].solarTermNm;		// 24절기
					        	}
				        	}
				        }
				        
					}else{
						alert("날짜 정보가 잘못 저장되었습니다.");
					}
					
					$("#diaryViewWeather").html(specialDayHtml);
					
					$(".diaryView").show();
					e.preventDefault ? e.preventDefault(): e.returnValue = false;
					wrapWindowByMask();
				}	
			},error:function(xhr, tst, err){
				console.log(xhr, tst, err);
				layerClose();
			}
		})
	}
}

function changeUpdateLayer(e){
	$(".diaryView").hide();
	var sn = $("#diaryViewSn").val();
	popupDiaryWriteLayer(e, sn);
}

/* 영농일지 INSERT / UPDATE LAYER 생성*/
function popupDiaryWriteLayer(e , sn){
	layerAlignCenter();

	oEditors.getById["se2"].exec("SET_IR", [""]); 
	
	$("#decpt").val("");
	// 제목, 내용 초기화
	var fmDate =$.datepicker.formatDate($.datepicker.ATOM, new Date()); 
	$("#date").val(fmDate + addTextLunar(fmDate));		// 날짜 초기화
	$("#diaryWriteType").val("0");//key값
	$("#delDiary").attr("style" , "display:none");//삭제버튼
	for(var i=1;i<=7;i++){
		imgObj = $("#19000" +i );
		imgObj.attr('src', imgObj.attr('src').replace('_on', ''));
		imgObj.removeClass('on');
	}
	$("#addDiary").text("등록");
//	if(sn != null && sn != "0"){
	var diaryData = {
//			"userId":"testadmin",
		"diarySn":sn
	};
	var _url = "";
	_url = c_url+"product/selectDiary.do";
	$.ajax({
		type : "POST",
		url	: _url,
		data: diaryData,
		dataType:"json",
		success:function(data){
			if(data.loginUrl != ""){						// 세션 종료시
				if( confirm("세션이 종료되었습니다. 로그인 하시겠습니까?") ){
					document.location.href = data.loginUrl + "?preUrl=" + escape(encodeURIComponent(window.location['href']));
				}else{
					return;
				}
				
			}else if( data.sn == 0 || data.sn == null ){	// 최초 작성시
				$("#190001").attr('src', $("#190001").attr('src').replace(".gif", "_on.gif"));
				$("#190001").addClass('on');
				
				$(".diaryWrite").show();
				/* IE의 경우 hide-show 과정이 들어가면 iframe내로 포커스가 안잡히는 현상이 발생. 그를 위한 후처리 부분 */
				oEditors.getById["se2"].exec("CHANGE_EDITING_MODE", ["WYSIWYG"]);
				oEditors.getById["se2"].exec("RESET_TOOLBAR");
				wrapWindowByMask();
				$("#decpt").focus();
				
			}else if(typeof data.sdMap =="undefined" ){		// 데이터 미 존재시
				alert("해당 정보는 이미 삭제 되었거나 존재하지 않는 정보입니다.");
				return;
				
			}else{											// 수정시
				$("#addDiary").text("수정");
//					$("#delDiary").attr("style" , "display:block");//삭제버튼
				$("#diaryWriteType").val(data.sdMap.diarySn);//key값
				$("#decpt").val(data.sdMap.diarySj);	// 제목
				var imgtag = data.sdMap.diaryCn;
				oEditors.getById["se2"].exec("PASTE_HTML", [imgtag]);
				
				var obj = "#"+data.sdMap.wethrCode;
				$(obj).attr('src', $(obj).attr('src').replace(".gif", "_on.gif"));
				$(obj).addClass('on');
				//rtnStringByte('tarea02');
				var strFDate = data.sdMap.diaryDe;
				if(strFDate != null && strFDate.length == 8){
					var strartDate = strFDate.substring(0,4) +"-"+strFDate.substring(4,6)+"-"+strFDate.substring(6,8);
					$("#date").val(strartDate + addTextLunar(strartDate));	// 날짜 초기화
				}else{
					alert("날짜 정보가 잘못 저장되었습니다.");
				}
				
				$(".diaryWrite").show();
				/* IE의 경우 hide-show 과정이 들어가면 iframe내로 포커스가 안잡히는 현상이 발생. 그를 위한 후처리 부분 */
				oEditors.getById["se2"].exec("CHANGE_EDITING_MODE", ["WYSIWYG"]);
				oEditors.getById["se2"].exec("RESET_TOOLBAR");
				wrapWindowByMask();
				$("#decpt").focus();
				
			}	
		},
		error:function(xhr, tst, err){
			console.log(xhr, tst, err)
			layerClose();
		}
		
	});
//	}else{
//		$("#190001").attr('src', $("#190001").attr('src').replace(".gif", "_on.gif"));
//		$("#190001").addClass('on');
//	}

	e.preventDefault ? e.preventDefault(): e.returnValue = false;
}

/* diary update layer clear & init */
/*function popupDiaryUpdateLayer(e){
	var udtTitle = $("#diaryViewTitle").text();
	var udtDate = $("#diaryViewDate").text();
	var udtWeather = $("#diaryViewWeather").text();
	var udtContent = $("#diaryViewContent").text();
	udtDate = udtDate.replace("년 ", "-").replace("월 ","-").replace("일","");
	
	$("#diaryWriteType").val("update");						// 삽입/수정 구분
	$(".diaryWrite .rayerTit span").text("일지수정");		// head title 초기화
	$("#decpt").val(udtTitle);								// 제목, 내용 초기화
	//$("#se2").val(udtContent);							// 제목, 내용 초기화
	oEditors.getById["se2"].exec("PASTE_HTML", [udtContent]);
	$("#date").val(udtDate + addTextLunar(udtDate));		// 날짜 초기화
	
	$(".diaryView").hide();
	$(".diaryWrite").show();
	e.preventDefault ? e.preventDefault(): e.returnValue = false;
	wrapWindowByMask();
}*/

function fnTodoDvRemove(){
	$(".todoDv").remove();
}
//일정 삭제
function delSchadul(e){
	if(confirm("일정을 삭제 하시겠습니까?")) {
		var _url = "";
		_url = c_url+"product/saveSchdul.do";
		var diaryData = {
//				"userId":"testadmin",
				"schdulSn":$("#schduWriteType").val() ,//키값
				"deleteYn":"Y"
			}
		$.ajax({
			type : "POST",
			url	: _url,
			data: diaryData,
			dataType:"json",
			success:function(data){
				if(data.result=="success"){
					alert("삭제가 완료 되었습니다.");
				}
				closeReload(e);
			},
			error:function(xhr, tst, err){
				console.log(xhr, tst, err)
			}
		});
	}
}
//일지 삭제
function delDiary(e){
	if(confirm("일지를 삭제 하시겠습니까?")) {
		var _url = "";
		_url = c_url+"product/insertFarmDiary.do";	
		var diaryData = {
//				"userId":"testadmin",
				"diarySn":$("#diaryViewSn").val(),//키값
				"deleteYn":"Y"
			}
		$.ajax({
			type : "POST",
			url	: _url,
			data: diaryData,
			dataType:"json",
			success:function(data){
				if(data.result=="success"){
					alert("삭제가 완료 되었습니다.");
				}
				closeReload(e);
			},
			error:function(xhr, tst, err){
				console.log(xhr, tst, err)
			}
		});
	}
}


function popupDiaryExit(){
	$('.diaryWrite').hide();
}


function setDatepicker(){
	$("#taskStartDt").datepicker({
		onSelect:function(selectedDate){
			var lunarHtml = addTextLunar(selectedDate);
			$('#taskStartDt').val($('#taskStartDt').val()+lunarHtml);
			$('#taskEndDt').val($('#taskEndDt').val().substr(0,10));		// 음력 문장을 제외한 값으로 임시 교체
			$('#taskEndDt').datepicker("option","minDate", selectedDate);
			if($('#taskEndDt').val()!=""){
				$('#taskEndDt').val($('#taskEndDt').val() + addTextLunar($('#taskEndDt').val())); // 음력 문장을 덧대어 생성
			}
		}
	});
	$("#taskEndDt").datepicker({
		onSelect:function(selectedDate){
			var lunarHtml = addTextLunar(selectedDate);
			$('#taskEndDt').val($('#taskEndDt').val()+lunarHtml); 
			$('#taskStartDt').val($('#taskStartDt').val().substr(0,10));	// 음력 문장을 제외한 값으로 임시 교체
			$('#taskStartDt').datepicker("option","maxDate", selectedDate);
			if($('#taskStartDt').val()!=""){
				$('#taskStartDt').val($('#taskStartDt').val() + addTextLunar($('#taskStartDt').val())); // 음력 문장을 덧대어 생성
			}
		}
	});
	$("#date").datepicker({
		onSelect:function(selectedDate){
			var lunarHtml = addTextLunar(selectedDate);
			$('#date').val($('#date').val()+lunarHtml); 
		}
	});
}

/* 지역 정보 검색 창 닫기 */
function layerClose(){
	$(".commonRayer").hide();
}

/* 일지,일정 창 닫은 후 달력 reload */
function closeReload(e){
    e.preventDefault ? e.preventDefault(): e.returnValue = false;  
    $('#mask, .diaryWrite, .diaryView, .todoView').hide();
    var year = $("#yearViewSpan").html();
    var month = $("#monthViewSpan").html();
    setDiaryForm();
}

/* 일정 저장 */
function saveSchadul(e){
	var taskStartDt = $("#taskStartDt").val().split("-").join("").substr(0,8);
	var taskEndDt = $("#taskEndDt").val().split("-").join("").substr(0,8);
	var taskStartTm = $("#taskStartTm").val();
	var taskEndTm = $("#taskEndTm").val();

	if($("#decpt02").val() ==""){
		alert("제목을 입력하세요.");
		$("#decpt02").focus();
		return;
	}else if( taskStartDt == "" ){
		alert("날짜를 입력하세요.");
		$("#taskStartDt").focus();
		return;
	}else if( taskEndDt == ""){
		alert("날짜를 입력하세요.");
		$("#taskEndDt").focus();
		return;
	}else if(taskStartDt > taskEndDt){
		alert("종료일이 시작일보다 이릅니다.");
		$("#taskStartDt").focus();
		return;
	}else if(taskStartDt == taskEndDt && taskStartTm > taskEndTm){
		alert("종료시간이 시작시간보다 이릅니다.");
		$("#taskStartTm").focus();
		return;
	}else if($("#tarea02").val() == ""){
		alert("내용을 입력하세요.");
		$("#tarea02").focus();
		return;
	}

	var ck = 'N';
	if($("#ck").attr("checked")){
		ck = 'Y';
	}
	var diaryData = {
//			"userId":"testadmin",
			"schdulSn":$("#schduWriteType").val() ,		//키값
			"schdulSj":$("#decpt02").val() ,			//제목
			"alarmMemo":$("#tarea02").val() ,			//알람메모
			"fromDate":taskStartDt,						//시작일
			"todate":taskEndDt,							//종료일
			"fromHm":taskStartTm,						//시작시간
			"toHm":taskEndTm,							//종료시간
			"alldayYn":ck  ,							//종일여부
			"alarmTmCode" :$("#decpt03").val()
//			"registerId":"testadmin",
		}
	var _url = "";
	_url = c_url+"product/saveSchdul.do";
	$.ajax({
		type : "POST",
		url	: _url,
		data: diaryData,
		dataType:"json",
		success:function(data){
			if(data.loginUrl != ""){
				if( confirm("세션이 종료되었습니다. 로그인 하시겠습니까?") ){
					document.location.href = data.loginUrl + "?preUrl=" + escape(encodeURIComponent(window.location['href']));
				}else{
					return;
				}
			}else if(data.result=="success"){
				alert("저장 완료 되었습니다.");
			}
			closeReload(e);
		},
		error:function(xhr, tst, err){
			console.log(xhr, tst, err)
//			layerClose();
		}
		
	});
}

//조회
function searchFrm(){
	$("#frm").attr('action',c_url+'product/farmdiary.do').submit();	
}

/* 일지 정보 입력 및 업데이트 */
function insertDiary(e){
	var _url = "";
	_url = c_url+"product/insertFarmDiary.do";	
	var wethrCode = $("#insertDiaryWeatherIcon li a img[class=on]").attr("name");
	//oEditors.getById["se2"].exec("UPDATE_CONTENTS_FIELD", []);
	
	var content = oEditors.getById["se2"].getIR();
	content = content.replace(unescape("%uFEFF"), "");
	                           
	content = content.replace("javascript", "?");
	content = content.replace("cookie", "?");
	content = content.replace("alert", "?");

	var diaryData = {
//		"userId":"testadmin",
		"diarySn":$("#diaryWriteType").val() ,//키값
		"diarySj":$.trim($("#decpt").val()),
		"diaryDe":$("#date").val().split("-").join("").substr(0,8),
		"wethrCode":wethrCode,
		"diaryCn":content
//		"registerId":"testadmin",
	}
	
	if(diaryData.diarySj==""){
		alert("제목을 입력하세요.");
		$("#decpt").focus();
		return;
	}else if(!Number(diaryData.diaryDe) || diaryData.diaryDe.length!=8){
		alert("날짜를 입력하세요.");
		$("#date").focus();
		return;
	}else if(diaryData.diaryCn==""){
		alert("내용을 입력하세요.");
		$("#se2").focus();
		return;
	}
	
	$.ajax({
		type : "POST",
		url	: _url,
		data: diaryData,
		dataType:"json",
		success:function(data){
			if(data.loginUrl != ""){
				if( confirm("세션이 종료되었습니다. 로그인 하시겠습니까?") ){
					document.location.href = data.loginUrl + "?preUrl=" + escape(encodeURIComponent(window.location['href']));
				}else{
					return;
				}
			}else if(data.result=="success"){
				alert("저장 완료 되었습니다.");
			}
			closeReload(e);
//			diaryViewGo(e, $("#diaryWriteType").val());
		},
		error:function(xhr, tst, err){
			console.log(xhr, tst, err)
		}
	});
}

function chgWeatherIcon(idx){
	var imgObj;
	var objId = "#1900"+idx;
	for(var i=1;i<=7;i++){
		imgObj = $("#19000" +i );
		imgObj.attr('src', imgObj.attr('src').replace('_on', ''));
		imgObj.removeClass('on');
	}
	imgObj = $(objId);
	imgObj.attr('src', imgObj.attr('src').replace(".gif", "_on.gif"));
	imgObj.addClass('on');
}

/* 해당 달 영농일지, 영농일정 세팅 시작 */
function calDataSet(arrDate, drObj, scObj){
	for(var i=0; i<arrDate.length; i++){
		for(var k=0;k<drObj.length;k++){
			if( arrDate[i]  == drObj[k].diaryDe ){
				addList.diaryBar("#cellNum"+i, drObj[k].diarySn, drObj[k].wethrCode, drObj[k].diarySj);
			}
		}
	}
	for(var i=0; i<arrDate.length; i++){
		for(var k=0;k<scObj.length;k++){
			if( ( scObj[k].fromDate != scObj[k].todate )
				&& ( scObj[k].fromDate <= arrDate[i] )
				&& ( scObj[k].todate >= arrDate[i] ) ){
				addList.taskBar("#cellNum"+i, arrDate[i], scObj[k].schdulSn, scObj[k].fromDate, scObj[k].fromHm, scObj[k].todate, scObj[k].schdulSj);
			}
		}
	}
	for(var i=0; i<arrDate.length; i++){
		for(var k=0, z=0;k<scObj.length;k++){
			if( ( scObj[k].fromDate == scObj[k].todate )
				&& ( scObj[k].fromDate == arrDate[i] ) ){
				addList.taskBarOnly("#cellNum"+i, arrDate[i], scObj[k].schdulSn, scObj[k].fromDate, scObj[k].fromHm, scObj[k].todate, scObj[k].schdulSj);
			}
		}
	}
}


var addList = {
	diaryBar : function(objStr, sn, wth, title){
		var imgObj = {
				"190001":"sico_shine",
				"190004":"sico_blur",
				"190003":"sico_clouds",
				"190002":"sico_cloud",
				"190005":"sico_rain",
				"190006":"sico_snowrain",
				"190007":"sico_snow"
		};
		var listHtml = "<a href='javascript:void(0);' onClick='diaryViewGo(event, \""+sn+"\")' class='diaryBar'><img src='"+c_url+"images/product/ico/"+imgObj[wth]+".png' alt=''>"+title+"</a>";
		addList.chkMoreList(objStr, 'daily', listHtml, 1, sn)
	},
	taskBar : function(objStr, today, sn, fDt, fHm, tDt, title){
		var idx = objStr.substr(8);
		var colSpanVal = 1;
		var aTagCls= "taskBar";
		var afterArrowHtml = "";
		var beforeArrowHtml = "";
		var loopBreakFlag = false;
		for(var i=idx%7,j=0; i<7; i++,j++){	// colspan 길이 계산
			var tmpDate = new Date(today.substr(0,4), Number(today.substr(4,2))-1, Number(today.substr(6,2))+j);
			var tdYMD = tmpDate.getFullYear()+""+tensNum(tmpDate.getMonth()+1)+""+tensNum(tmpDate.getDate());

			if(j==0 && tdYMD > fDt){	// 전날부터 이어지는지 체크
				beforeArrowHtml = "<b class='pr'>◀</b>";
			}
			if( i<6 && tdYMD < tDt ){
				colSpanVal++;
			}else if(tdYMD==tDt){
				loopBreakFlag = true;
				break;
			}
		}
		if(loopBreakFlag){ // 다음날까지 이어지는지 체크
			aTagCls = "taskBar end";
		}else{
			afterArrowHtml = "<b class='nt'>▶</b>";
		}
		
		var listHtml = "<a href='javascript:void(0);' onClick='popupTodoLayer(event, \""+sn+"\")' class='"+aTagCls+"'>"
					+ beforeArrowHtml
					+ fHm.substr(0,2)+":"+fHm.substr(2,2)+" "+ title
					+ afterArrowHtml+"</a>";
		addList.chkMoreList(objStr, "task", listHtml, colSpanVal, sn)
	},
	taskBarOnly : function(objStr, today, sn, fDt, fHm, tDt, title){
		var idx = objStr.substr(8);
		var colSpanVal = 1;
		var aTagCls= "taskBar only";
		
		var listHtml = "<a href='javascript:void(0);' onClick='popupTodoLayer(event, \""+sn+"\")' class='"+aTagCls+"'>"
					+ fHm.substr(0,2)+":"+fHm.substr(2,2)+" "+ title
					+"</a>";
		addList.chkMoreList(objStr, "taskBar only", listHtml, colSpanVal, sn)
	},
	chkMoreList : function(objStr, cls, listHtml, colSpanVal, sn){
		var moreHtml = "";
		var emptyIdx = -1;
		var emptyCnt = 0;
		var tdArrHtml = [];
		var snOverlapYn = false;
		var emptyIdxSchd = -1;
		
		var sibObjList = $("td[id^='"+objStr.substr(1)+"_']");
		for(var i=0; i<sibObjList.length; i++){
			if( $(sibObjList[i]).attr("sn") == sn){
				snOverlapYn = true;
				break;
			}
		}
		
		if(!snOverlapYn){					// 이미 sn이 등록되어있으면 그리지 않음
			/* 빈공간이 있으면 넣고, 없으면 moreHTML 작성 및 기존 TD숨기기 */
			for(var i=2; i>-1; i--){		// 비어있는 td 밑에서부터 위로 체크
				tdArrHtml[i] = $(objStr+"_"+i).html();
				if(tdArrHtml[i]==""){
					emptyIdx=i;
					emptyCnt++;
				}
				if(cls=="task"){
					for(var j=0; j<colSpanVal;j++){
						var nextIdx = objStr.substr(0,8) + (Number(objStr.substr(8))+j)+"_"+emptyIdx ; // 길이만큼 가로행에 diary가 있는지 추가 탐색
						if($(nextIdx).attr("class")=="daily"){					// diary 탐색 시 그 다음 인덱스 지정
							emptyIdxSchd= emptyIdxSchd > emptyIdx+1 ? emptyIdxSchd : emptyIdx+1;
						}
					}
				}
				if(cls=="taskBar only"){
					if($(objStr+"_"+i).attr("class")=="task" || $(objStr+"_"+i).attr("class")=="t_only" || $(objStr+"_"+i).attr("class")=="colHidden"){
						emptyIdx=i+1;
						break;
					}
				}
			}
			
			if(cls == "daily"){				/* @@@일정 추가@@@ */
				var siblingsCnt = $("td[id^='"+objStr.substr(1)+"_']").length;
				if(emptyCnt>0){				// 빈공간이 존재할 경우
					$(objStr+"_"+emptyIdx).attr({"class":cls, "colspan":colSpanVal, "sn":sn, "onclick":""}).html(listHtml);
				}else{
					$(objStr).parent().parent().last().append("<td id='"+objStr.substr(1)+"_"+siblingsCnt+"' sn='"+sn+"' class='hiddenCell' style='display:none;'>"+ listHtml +"</td>");

					moreHtml = "<a href='javascript:void(0);' class='moreBin' style='cursor: default;' onclick='popupSchdWriteLayer(event,"+objStr.substr(8)+",\"cal\")'></a>"
						+"<a href='javascript:void(0);' onClick='viewTodoDv(\""+objStr+"\",event)' class='more'>+"+ (siblingsCnt-2) +"</a>";
					$("#more"+objStr.substr(8)).html(moreHtml).addClass("more");
				}
			}else if(cls == "task"){		/* @@@일지 추가@@@ */
				var siblingsCntArr = [];
				var siblingsCntTop = 0;
				
				for(var j=0; j<colSpanVal;j++){			// 그려질 영역의 일정/일지 분포 및 가장 많은 분포영역을 찾아낸다.
					var colIdx = $("td[id^='cellNum"+(Number(objStr.substr(8))+j)+"_']");
					var count = 0;
					for(var k=0; k<colIdx.length; k++){
						if(colIdx[k].innerHTML!=""){ 	// colIdx[k].className!="more" && 
							count++;
						}
					}
					siblingsCntArr.push(count);
					siblingsCntTop = siblingsCntTop > count ? siblingsCntTop : count;
				}
				
				var resultSchIdx = emptyIdxSchd != -1 ? emptyIdxSchd : emptyIdx ;
				if(siblingsCntTop<3){					// 일반 삽입
					$(objStr+"_"+resultSchIdx).attr({"class":"task", "colspan":colSpanVal, "sn":sn, "onclick": ""}).html(listHtml);
					if(colSpanVal>1){					// colSpan이 1이상이면 옆의 열들을 Hidden 처리 함
						for(var i=0; i<colSpanVal-1; i++){
							var nextTdId = "#cellNum"+(Number(objStr.substr(8))+(i+1));
							$(nextTdId+"_"+resultSchIdx).css("display", "none").attr({"class":"colHidden","sn":sn}).html("hidden");
						}
					}
				}else if(siblingsCntTop>2){				// 하나라도 4를 초과하는 행이 있을 경우 맨 뒤에 none으로 붙여주고 more 행을 추가 함
					for(var i=0; i<colSpanVal; i++){
						objStrInc = '#cellNum'+(Number(objStr.substr(8))+i); // 옆칸으로 이동하면서 수행하도록 인덱스 값을 증가 시킴
						if(siblingsCntArr[i]<4){		// 세로 행이 네개 미만인 경우의 처리
							
							$(objStrInc).parent().parent().last().append("<td id='"+objStrInc.substr(1)+"_"+(siblingsCntTop+1)+"' class='hiddenCell' sn='"+sn+"' style='display:none;'>"+ listHtml +"</td>");
							
							var hdnListLength = $("td[id^='cellNum"+(Number(objStr.substr(8))+i)+"_'].hiddenCell").length;
							moreHtml = "<a href='javascript:void(0);' class='moreBin' style='cursor: default;' onclick='popupSchdWriteLayer(event,"+objStr.substr(8)+",\"cal\")'></a>"
								+ "<a href='javascript:void(0);' onClick='viewTodoDv(\""+objStrInc+"\",event)' class='more'>+"+hdnListLength+"</a>";
							$("#more"+objStrInc.substr(8)).html(moreHtml)
							
						}else if(siblingsCntArr[i]>3){	// 세로 행이 네개 이상인 경우의 처리
							
							$(objStrInc).parent().parent().last().append("<td id='"+objStrInc.substr(1)+"_"+(siblingsCntTop+1)+"' class='hiddenCell' sn='"+sn+"' style='display:none;'>"+ listHtml +"</td>");
							
							var hdnListLength = $("td[id^='cellNum"+(Number(objStr.substr(8))+i)+"_'].hiddenCell").length;
							moreHtml = "<a href='javascript:void(0);' class='moreBin' style='cursor: default;' onclick='popupSchdWriteLayer(event,"+objStr.substr(8)+",\"cal\")'></a>"
								+ "<a href='javascript:void(0);' onClick='viewTodoDv(\""+objStrInc+"\",event)' class='more'>+"+hdnListLength+"</a>";
							$("#more"+objStrInc.substr(8)).html(moreHtml)
						}
					}
				}
			}else if(cls=="taskBar only"){ /* @@@단순 일정 추가@@@ */
				var siblingsCnt = $("td[id^='"+objStr.substr(1)+"_']").length;
				if( /*siblingsCntTop<3 && */emptyCnt>0 && emptyIdx<3){				// 빈공간이 존재할 경우
					$(objStr+"_"+emptyIdx).attr({"class":/*cls*/"t_only", "colspan":colSpanVal, "sn":sn, "onclick":""}).html(listHtml);
				}else{
					$(objStr).parent().parent().last().append("<td id='"+objStr.substr(1)+"_"+siblingsCnt+"' sn='"+sn+"' class='hiddenCell' style='display:none;'>"+ listHtml +"</td>");

					moreHtml = "<a href='javascript:void(0);' class='moreBin' style='cursor: default;' onclick='popupSchdWriteLayer(event,"+objStr.substr(8)+",\"cal\")'></a>"
						+ "<a href='javascript:void(0);' onClick='viewTodoDv(\""+objStr+"\",event)' class='more'>+"+ (siblingsCnt-2) +"</a>";
					$("#more"+objStr.substr(8)).html(moreHtml).addClass("more");
				}
			}
		}
	}
};