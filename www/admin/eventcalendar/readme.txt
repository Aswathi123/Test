EventCalendar 
Project url: http://eventcalendar.riaforge.org
		
Author: John Mason, mason@fusionlink.com
Blog: www.codfusion.com
Twitter: john_mason_
Public Version: 1.0.4
Release Date: 01/27/2020
Last Updated: 02/09/2010
		
1.0.1 (01/27/2010) - First public release
1.0.2 (01/29/2010) - Fix for saving data if event is resized or drag and dropped somewhere else on the calendar
1.0.3 (02/09/2010) - Fix for Internet Explorer Date Format issue, events were not showing up on refresh
1.0.4 (02/09/2010) - Fix for CF9's uppercasing columns names in the JSON feed
		
Based on the following technologies:
- ColdFusion
- jQuery
- jQuery-week-calendar plugin - http://www.redredred.com.au/projects/jquery-week-calendar/

Installation:
- Unzip into a web accessible directory
- Review and modify the settings on top part of the EventCalendar.cfc file
- Review and modify the settings on top part of the settings.js file
- Setup a datasource that matches the settings on EventCalendar.cfc
- Create a table called events, the following sql command should work for you
	CREATE TABLE events (
  		id varchar(200) NOT NULL,
  		title varchar(400) NOT NULL,
  		body text,
  		starttime datetime NOT NULL,
  		endtime datetime NOT NULL,
  		userid varchar(200) default NULL,
  		PRIMARY KEY  (id)
	)
- Should be good to run at this point. By default each unique session can add/modify only their own events.
- You'll more than likely want to extend off the UserFacade to work with your login/user management system.

Credits and Licensing:
Coldfusion EventCalendar
	John Mason
	blog: codfusion.com
	twitter: john_mason_
	Dual licensed under the MIT and GPL licenses:
   	http://www.opensource.org/licenses/mit-license.php
   	http://www.gnu.org/licenses/gpl.html
	
jQuery-week-calendar plugin:
	Copyright (c) 2009 Rob Monie
	Dual licensed under the MIT and GPL licenses:
   	http://www.opensource.org/licenses/mit-license.php
   	http://www.gnu.org/licenses/gpl.html

jQuery
	John Resiq
	Licensed under the MIT:
   	http://www.opensource.org/licenses/mit-license.php

Reset.css
	Copyright (c) 2008, Yahoo! Inc. All rights reserved.
	Code licensed under the BSD License:
	http://developer.yahoo.net/yui/license.txt
	version: 2.5.1

Developer Notes:
The settings.js file simply does .getJSON calls to the EventCalendar.cfc. You can use Firebug to debug any communication problems.

Change to the core jquery.weekcalendar.js file
- I modified the _refreshEventDetails method to display the title in the event header instead of the time info which was simply redundant.