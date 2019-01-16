<cfscript>
/**
 * Produces output used by the iCalendar standard for inclusion in calendaring tools such as Outlook, Sunbird, etc. 
 * Adapted from the vCal() function found on cflib.org by Chris Wigginton
 * Works to correctly offset daylight savings time in U.S.
 * Will set a reminder alarm 30 minutes prior to event. Look at the spec if you want to change this.
 * Good resource for the iCal spec -- http://www.kanzaki.com/docs/ical/
 * 
 * @param stEvent 	 Structure containg the key/value pairs comprising the event data.  Keys are shown below: 
 * @param stEvent.organizerName		string First and Last name of person holding the event.
 * @param stEvent.organizerEmail 	string Email address of person holding the event.
 * @param stEvent.description		string Event's description. Use one continuous string separated by \n for newlines.
 * @param stEvent.subject 	 		string Event's subject of the event. 
 * @param stEvent.location			string Event's location.  
 * @param stEvent.startTime 	 	dateObj Event's start date/time in U.S. Eastern time. 
 * @param stEvent.endTime 	 		dateObj Event's end date/time in U.S. Eastern time. 
 * @param stEvent.priority 	 		integer Must be in the range [0..9] 0=none, 1=highest. 
 * @param eventStr.timeZoneOffset 	integer of Time Zone Offset.
 * @param eventStr.timeZoneDesc		string description of Time Zone Offset.
 * @return Returns a string in the iCalendar format. 
 * @author Troy Pullis (tpullis@yahoo.com)  
 * @version 1.0, March 18, 2008
 * @version 2.0, Dec 16, 2008 -- Dan Russell drussell@charteroak.edu
 * @version 3.0, October 6, 2013 -- Milford Morgan
 */
function iCalUS(stEvent)
{
	var vCal = "";
	var CRLF=chr(13)&chr(10);
	var date_now = Now();
		
	if (NOT IsDefined("stEvent.organizerName"))
		stEvent.organizerName = "Organizer Name";
		
	if (NOT IsDefined("stEvent.organizerEmail"))
		stEvent.organizerEmail = "admin@SalonWorks.com";
				
	if (NOT IsDefined("stEvent.subject"))
		stEvent.subject = "Event subject goes here";
		
	if (NOT IsDefined("stEvent.location"))
		stEvent.location = "Event location goes here";
	
	if (NOT IsDefined("stEvent.description"))
		stEvent.description = "Event description goes here\n---------------------------\nProvide the complete event details\n\nUse backslash+n sequences for newlines.";
		
	if (NOT IsDefined("stEvent.startTime"))  
		stEvent.startTime = Now(); 
	
	if (NOT IsDefined("stEvent.endTime"))
		stEvent.endTime = Now(); 
		
	if (NOT IsDefined("stEvent.priority"))
		stEvent.priority = "1";
	
	TZOFFSETFROM_STANDARD = eventStr.timeZoneOffset + 1;
	TZOFFSETTO_STANDARD = eventStr.timeZoneOffset;
	
	negative = "";
	if(TZOFFSETFROM_STANDARD < 0 ){
		TZOFFSETFROM_STANDARD = TZOFFSETFROM_STANDARD * -1;
		negative = "-";
	}
	if(TZOFFSETFROM_STANDARD < 10) TZOFFSETFROM_STANDARD = "0" & TZOFFSETFROM_STANDARD;
	TZOFFSETFROM_STANDARD = negative & TZOFFSETFROM_STANDARD & "00";
	
	negative = "";
	if(TZOFFSETTO_STANDARD < 0 ){
		TZOFFSETTO_STANDARD = TZOFFSETTO_STANDARD * -1;
		negative = "-";
	}
	if(TZOFFSETTO_STANDARD < 10) TZOFFSETTO_STANDARD = "0" & TZOFFSETTO_STANDARD;
	TZOFFSETTO_STANDARD = negative & TZOFFSETTO_STANDARD & "00";
				
	TZOFFSETFROM_DAYLIGHT = TZOFFSETTO_STANDARD;
	TZOFFSETTO_DAYLIGHT = TZOFFSETFROM_STANDARD;
	
	vCal = "BEGIN:VCALENDAR" & CRLF;
	vCal = vCal & "PRODID: -//SalonWorks.com//iCalUS()//EN" & CRLF;
	vCal = vCal & "VERSION:2.1" & CRLF;
	vCal = vCal & "METHOD:REQUEST" & CRLF;
	
	vCal = vCal & "BEGIN:VTIMEZONE" & CRLF;
	vCal = vCal & "TZID:" & eventStr.timeZoneDesc & CRLF;
	vCal = vCal & "BEGIN:STANDARD" & CRLF;
	vCal = vCal & "DTSTART:20061101T020000" & CRLF;
	vCal = vCal & "RRULE:FREQ=YEARLY;INTERVAL=1;BYDAY=1SU;BYMONTH=11" & CRLF;
	vCal = vCal & "TZOFFSETFROM:" & TZOFFSETFROM_STANDARD & CRLF;
	vCal = vCal & "TZOFFSETTO:" & TZOFFSETTO_STANDARD & CRLF;
	vCal = vCal & "TZNAME:Standard Time" & CRLF;
	vCal = vCal & "END:STANDARD" & CRLF;
	
	vCal = vCal & "BEGIN:DAYLIGHT" & CRLF;
	vCal = vCal & "DTSTART:20060301T020000" & CRLF;
	vCal = vCal & "RRULE:FREQ=YEARLY;INTERVAL=1;BYDAY=2SU;BYMONTH=3" & CRLF;
	vCal = vCal & "TZOFFSETFROM:" & TZOFFSETFROM_DAYLIGHT & CRLF;
	vCal = vCal & "TZOFFSETTO:" & TZOFFSETTO_DAYLIGHT & CRLF;
	vCal = vCal & "TZNAME:Daylight Savings Time" & CRLF;
	vCal = vCal & "END:DAYLIGHT" & CRLF;
	vCal = vCal & "END:VTIMEZONE" & CRLF;
	
	vCal = vCal & "BEGIN:VEVENT" & CRLF;
	vCal = vCal & "UID:#date_now.getTime()#.CFLIB.ORG" & CRLF;  // creates a unique identifier
	vCal = vCal & "ORGANIZER;CN=#stEvent.organizerName#:MAILTO:#stEvent.organizerEmail#" & CRLF;
	vCal = vCal & "DTSTAMP:" & 
			DateFormat(date_now,"yyyymmdd") & "T" & 
			TimeFormat(date_now, "HHmmss") & CRLF;
	vCal = vCal & "DTSTART;TZID=" &  eventStr.timeZoneDesc & ":" & 
			DateFormat(stEvent.startTime,"yyyymmdd") & "T" & 
			TimeFormat(stEvent.startTime, "HHmmss") & CRLF;
	vCal = vCal & "DTEND;TZID=" &  eventStr.timeZoneDesc & ":" & 
			DateFormat(stEvent.endTime,"yyyymmdd") & "T" & 
			TimeFormat(stEvent.endTime, "HHmmss") & CRLF;
	vCal = vCal & "SUMMARY:#stEvent.subject#" & CRLF;
	vCal = vCal & "LOCATION:#stEvent.location#" & CRLF;
	vCal = vCal & "DESCRIPTION:#stEvent.description#" & CRLF;
	vCal = vCal & "PRIORITY:#stEvent.priority#" & CRLF;
	vCal = vCal & "TRANSP:OPAQUE" & CRLF;
	vCal = vCal & "CLASS:PUBLIC" & CRLF;
	vCal = vCal & "BEGIN:VALARM" & CRLF;
	vCal = vCal & "TRIGGER:-PT30M" & CRLF;  // alert user 30 minutes before meeting begins
	vCal = vCal & "ACTION:DISPLAY" & CRLF;
	vCal = vCal & "DESCRIPTION:Reminder" & CRLF;
	vCal = vCal & "END:VALARM" & CRLF;
	vCal = vCal & "END:VEVENT" & CRLF;
	vCal = vCal & "END:VCALENDAR";
	return Trim(vCal);
}
</cfscript>