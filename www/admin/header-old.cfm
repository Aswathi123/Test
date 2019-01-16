 <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.2.6/jquery.js"></script>
 
        <script type="text/javascript">
            var windowSizeArray = [ "width=200,height=200",
                                    "width=300,height=400,scrollbars=yes" ];
 
            $(document).ready(function(){
                $('.newWindow').click(function (event){
 
                    var url = $(this).attr("href");
                    var windowName = "popUp";//$(this).attr("name");
                    var windowSize = windowSizeArray[$(this).attr("rel")];
 
                    window.open(url, windowName, windowSize);
 
                    event.preventDefault();
 
                });
            });
        </script>

<a href="company_form.cfm">Modify Company</a> |
<a href="location_form.cfm">Modify Location</a> |
<a href="professionals_form.cfm">Modify Professional_Alias</a> |
<a href="company_themes_form.cfm">Modify Theme</a>