
<!doctype html>
<html ng-app="downloadApp" xmlns:fb="http://ogp.me/ns/fb#">
	<head>


		
		
		<link rel="stylesheet" href="http://getbootstrap.com/dist/css/bootstrap.min.css">
		<link rel="stylesheet" href="http://whatiztrending.com/css/app.css">
			
		<link rel="stylesheet" type="text/css" href="css/ng-grid.css" />
        <script src="http://pagehelper.in/fancybox/lib/jquery-1.10.1.min.js"></script>
        <script src="http://angular.github.io/angular-phonecat/step-7/app/bower_components//angular/angular.js"></script> 
        <script src="http://angular.github.io/angular-phonecat/step-7/app/bower_components/angular-route/angular-route.js"></script>
		<script type="text/javascript" src="http://angular-ui.github.com/ng-grid/lib/ng-grid.debug.js"></script>
       
	    <script src="js/checklist-model.js"></script>
	     <script src="js/ng-grid.js"></script>
		<script src="js/controllers.js"></script>
		<script src="js/app.js"></script>
		<script src="js/bootstrap.min.js">

		</script>
		<style>
           .gridStyle {
    border: 1px solid rgb(212,212,212);
    height: 200px;
	text-align:center
}
.cellToolTip {
    overflow: visible;
}

.tooltip {
  top: 0 !important;
}
		</style>
<Script>
function detail(name)
{
 window.top.location= '?time=' + document.getElementById('time').value + '&name=' + name;
}
</script>

</head>

<body style='text-align:center' class='container center-block'>

<!-- Topbar Starts-->
	
<nav class="navbar navbar-default green" role="navigation">
  <!-- Brand and toggle get grouped for better mobile display -->
  <div class="navbar-header">
    <img src ='http://quizworld.in/img/logo.jpg' width=50 height=50 />
  </div>

  <!-- Collect the nav links, forms, and other content for toggling -->
  <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
    <ul class="nav navbar-nav">
	  <li> <a class="green navbar-brand" style='color:#47a447;font-weight: 900;' href="http://truefbfriends.com">WFH<span style='color: rgb(186, 226, 24);'>-</span>Counter</a></li>
	  <li><p class="navbar-text"><span class="glyphicon glyphicon glyphicon-user"></span> Welcome <a href="#" class="navbar-link"> ColdFusioner</a></p></li>
	</ul>
    

  </div><!-- /.navbar-collapse -->
</nav>
	
<!-- Topbar Ends-->

<h1 class='green'>WFH Counter</h1>

<cfparam name='form.time' default=30>

<cfif isdefined('url.time')>
 <cfset form.time = url.time>
</cfif>

<cfform action='wfh.cfm' type='get'>
<span class='green'>Time Frame</span> : 
 <select id='time'  name='time' value='<cfoutput>#form.time#</cfoutput>'>
   <option value='30' <cfif form.time eq '30'>selected</cfif>>Last 1 month</option>
    <option value='180' <cfif form.time eq '180'>selected</cfif>>Last 6 months</option>
    <option value='360' <cfif form.time eq '360'>selected</cfif>>Last 1 year</option>
    <option value='720' <cfif form.time eq '720'>selected</cfif>>Last 2 years</option>
     <option value='3000' <cfif form.time eq '3000'>selected</cfif>>Lifetime</option>
  </select>
 
<br>
<br>
<cfinput type='submit' value='Start Scanning' name='button' class='btn btn-success'/>

</cfform>



<!---
<cfexchangeconnection

action = 'open'
server = 'see-wv-a038'
username = 'user1'
connection='con'
password='Adobe123'
protocol='https'
port='80'
serverversion = '2010'
>
<cfpop action='getall' server = 'outlook.office365.com'
username = 'uogra@adobe.com'
password='Shikhasharma1##' name='n'>
--->

<cfexchangeconnection

action = 'open'
server = 'outlook.office365.com'
username = 'uogra@adobe.com'
connection='con'
password='Shikhasharma1##'
protocol='https'
serverversion = '2013'
>



<cfset rightnow = Now()>
<cfset oneyearback = Dateadd("d", '-360',rightnow)>
<cfset twoyearback = Dateadd("d", '-720',rightnow)>
<cfset threeyearback = Dateadd("d", '-1100',rightnow)>

<cfset time = Dateadd("d", '-#FORM.time#',rightnow)>
<cfset words = "wfh,work from home,working from home">

<cfif isdefined('url.name') and len(url.name) gt 0>
<h1 class='green'>Details of user: <cfoutput><b>#url.name#</b>(#form.time# days report)<br> <hr></cfoutput></h1>

<cfloop list= #words# delimiters="," index = 'word'>
  <cfexchangemail action='get' connection='con' name='mails' folder='inbox'>
    <cfexchangefilter name='subject' value='#word#'>
    <cfexchangefilter name='fromid' value='#url.name#'>
    <cfexchangefilter name='timesent' from='#threeyearback#' to = '#oneyearback#'>
  </cfexchangemail>
  <div style='margin-left:400px'>
  <cftry>
  
  <cftable query='mails' border='true' colheaders='true' htmltable headerlines=1>
    <cfcol header='From' text = '#fromid#'>
    <cfcol header='Timesent' text = '#DATEFORMAT(timesent)#'>
    <cfcol header='Subject' text = '#subject#'>
  </cftable>

   <cfgrid name = "FirstGrid" format="html"
        height="320" width="580"
        font="Tahoma" fontsize="12"
        query = "mails">
    <cfgridcolumn name = "Fromid" header = "fromid" width="125">
     <cfgridcolumn name = "subject" header = "subject" width="125">
   </cfgrid>

  <cfcatch type='any'>
  </cfcatch>
  </cftry>
  </div>
</cfloop>
</cfif>






</body>

