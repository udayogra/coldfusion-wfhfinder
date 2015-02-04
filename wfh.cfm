
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
 var r = confirm('This process can take upto few minutes. Lifetime report can take even more than 5 mins. Press OK to continue');
 if(r == true){
  url = '?time=' + document.getElementById('time').value + '&type='  + document.getElementById('type').value + '&name=' + name;
  window.open(url);
 }
}

function detailwithsort()
{
 window.top.location= '?time=' + document.getElementById('time').value + '&type='  + document.getElementById('type').value + '&sorted=asc';
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
	  <li> <a class="green navbar-brand" style='font-weight: 900;' href="http://truefbfriends.com">WFH-PTO<span style=''>-</span>Counter</a></li>
	  <li><p class="navbar-text"> Welcome <a href="#" class="navbar-link green"><b> ColdFusioner</b></a></p></li>
	</ul>
    

  </div><!-- /.navbar-collapse -->
</nav>
	
<!-- Topbar Ends-->
<SMALL style='color:Red'>DISCLAIMER : <span class='green'>+-10% Error is expected ;)</span></SMALL>
<h1 class='green'>WFH-PTO-OOO Counter</h1>

<cfparam name='form.time' default=180>
<cfparam name='form.type' default='wfh'>

<cfif isdefined('url.time')>
 <cfset form.time = url.time>
</cfif>

<cfif isdefined('url.type')>
 <cfset form.type = url.type>
</cfif>

<cfform action='wfh.cfm' type='get'>
<span class='green'>Time Frame</span> : 
 <select id='time'  name='time' value='<cfoutput>#form.time#</cfoutput>'>
  <option value='7' <cfif form.time eq '7'>selected</cfif>>Last 1 week</option>
   <option value='30' <cfif form.time eq '30'>selected</cfif>>Last 1 month</option>
    <option value='180' <cfif form.time eq '180'>selected</cfif>>Last 6 months</option>
    <option value='360' <cfif form.time eq '360'>selected</cfif>>Last 1 year</option>
    <option value='720' <cfif form.time eq '720'>selected</cfif>>Last 2 years</option>
     <option value='3000' <cfif form.time eq '3000'>selected</cfif>>Lifetime</option>
  </select>
 
 <span class='green'>Type</span> : 
 <select id='type'  name='type' value='<cfoutput>#form.time#</cfoutput>'>
   <option value='wfh' <cfif form.type eq 'wfh'>selected</cfif>>WFH Counter</option>
    <option value='pto' <cfif form.type eq 'pto'>selected</cfif>>PTO Counter</option>
     <option value='ooo' <cfif form.type eq 'ooo'>selected</cfif>>OOO Counter</option>
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
password='YOURPASSWORD' name='n'>
--->

<cfexchangeconnection

action = 'open'
server = 'outlook.office365.com'
username = 'uogra@adobe.com'
connection='con'
password='YOURPASSWORD'
protocol='https'
serverversion = '2013'
>



<cfset rightnow = Now()>
<cfset oneyearback = Dateadd("d", '-360',rightnow)>
<cfset twoyearback = Dateadd("d", '-720',rightnow)>
<cfset threeyearback = Dateadd("d", '-1100',rightnow)>

<cfset time = Dateadd("d", '-#FORM.time#',rightnow)>
 <cfset words = "wfh,work from home,working from home">
<cfif isdefined('form.type') and form.type eq 'pto'>
 <cfset words = "pto,sick leave">
</cfif>
<cfif isdefined('form.type') and form.type eq 'ooo'>
 <cfset words = "ooo">
</cfif>

<cfif isdefined('url.name') and len(url.name) gt 0>
<h1 class='green'>Details of user: <cfoutput><b>#url.name#</b>(#form.time# days report)<br> <hr></cfoutput></h1>
<small>This list will also show mails starting with "RE:" subject but they are not part of the count shown in first page</small>
<cfloop list= #words# delimiters="," index = 'word'>
  <cfexchangemail action='get' connection='con' name='mails' folder='inbox'>
    <cfexchangefilter name='subject' value='#word#'>
    <cfexchangefilter name='fromid' value='#url.name#'>
    <cfexchangefilter name='timesent' from='#time#' to = '#rightnow#'>
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

<cfset data =structnew()>
<cfif isdefined('server.cachestruct')>
 <cfset cachestruct = server.cachestruct>
<cfelse>
 <cfset cachestruct = structnew()>  
 <cfset server.cachestruct = cachestruct>
</cfif>

<cfif structkeyexists(cachestruct , form.time & form.type)>
 <cfset data = cachestruct[form.time & form.type]>
<cfelse>

<cfloop list= #words# delimiters="," index = 'word'>
  <cfexchangemail action='get' connection='con' name='mails' folder='inbox'>
    <cfexchangefilter name='subject' value='#word#'>
    <cfexchangefilter name='timesent' from='#time#' to = '#rightnow#'>
    <cfexchangefilter name='maxrows' value='100000'>
  </cfexchangemail>
  <cfloop query='mails'>
 
  <cfif findnocase('re:',#subject#) gt 0>
    <cfcontinue>
  </cfif>
   <cfif structkeyexists(data, fromid)>
     <cfset data[fromid] = data[fromid] + 1>
   <Cfelse>
    <cfset data[fromid] = 1>
   </cfif>

  </cfloop>
</cfloop>
</cfif>

<cfoutput>
<cfset cachestruct[form.time & form.type] = data>
<cfset server.cachestruct = cachestruct>
<h1 class='green'>Summary of each user <small>(#form.time# days report for #form.type#s)</small> </h1>
<hr>

<button class='btn btn-success' value='Get details' onclick="detailwithsort()">Sort</button><br>

<cfif isdefined('url.sorted')>
 <cfset sorted = structSort(data, "numeric",'desc')>
<cfelse>
 <cfset sorted = structkeyarray(data)>
</cfif>

<cfloop array=#sorted# index='person'>
<cfset a = find('<',person)>
<cfset b = len(person)>
 <b class='green'>#person#</b> has taken <b><i class='green'>#data[person]#</i></b> #form.type#s - <button class='btn btn-success' value='Get details' onclick="detail('#mid(person,a+1,5)#')">Get details</button>
 <br><br>
</cfloop>
</cfoutput>

<!-- Bottombar Starts-->
<style>
body { padding-bottom: 0px; }
</style>
<nav class="navbar navbar-default" role="navigation">
  <!-- Collect the nav links, forms, and other content for toggling -->
  <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" style='margin-left:400px'>
    
    <p class="navbar-text">Copyright &copy; 2014 CF</p>

  </div><!-- /.navbar-collapse -->
</nav>
	
<!-- Bottambar Ends-->

</body>

