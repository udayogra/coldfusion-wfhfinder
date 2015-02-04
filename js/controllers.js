
	var app = angular.module('downloadControllers',  ['ng','ngGrid','checklist-model']);
    
   
app.controller('FbanalyzerCtrl', function($scope,$http,$rootScope) {

   

    $scope.bugreportdata = []; 
	$scope.formdata = [];
	
	$scope.formdata.type = 'error'; 
	
	
var templateWithTooltip = '<div class="ngCellText" ng-class="col.colIndex()"><a tooltip="What am I doing wrong with the tooltip?" ng-cell-text>{{row.getProperty(col.field)}}</a></div>';
 
	$scope.coldef = [{field:'id', displayName:'Id'},{field:'task', displayName:'Task'},{field:'type', displayName:'Type'}];

    $scope.reportgrid = { 
        data: 'bugreportdata',
  	    columnDefs: $scope.coldef
    };
	


	$scope.stats = '';
	
	$scope.getstats = function() {
		 $http({
            method: "GET",
            url: 'server.cfc?method=getdata',
			params : $scope.formdata,
             }).success(function (data) {
				if(data.status == 'error')
					alert('There was an error - ' + data.errormessage);
					else
				 $scope.bugreportdata = data.data;
          }).error(function (data) {
                      popupmsg('Some error occured. Please try later',true);
          });
		}

	
     
	 $scope.formdata.roles = [];
     $scope.formdata.user = {
       roles: []
     };

	 $scope.readrules = function() {
		 $http({
             method: "GET",
             url: "files/codeanalyzerrules.json",
			 cache:false
			  }).success(function (data) {
				  $scope.formdata.roles[0] = {};
				 $scope.formdata.roles[0].name = data.rules[0].security[0].name;
				  $scope.formdata.roles[0].title = data.rules[0].security[0].description.title;
				 
				  $scope.formdata.roles[1] = {};
				 $scope.formdata.roles[1].name = data.rules[0].security[1].name;
                   $scope.formdata.roles[1].title = data.rules[0].security[1].description.title;

          }).error(function (data) {
                      popupmsg('Some error occured. Please try later',true);
          });
	 }

     $scope.checkAll = function() {
       $scope.formdata.user.roles = $scope.formdata.roles.map(function(item) { return item.name; });
     };

	  $scope.deletetasks = function() {
       $scope.bugreportdata = [];
     };

	 $scope.addtask = function() {
		 $http({
            method: "GET",
            url: 'server.cfc?method=adddata',
			params : $scope.formdata,
             }).success(function (data) {
				if(data.status == 'error')
					alert('There was an error - ' + data.errormessage);
					else
				data = [{"id" : 5,"task" : "this is a new task","type" : "minor"}];
                $scope.bugreportdata=  $scope.bugreportdata.concat(data);
		
          }).error(function (data) {
                      popupmsg('Some error occured. Please try later',true);
          });
     };
  
     $scope.uncheckAll = function() {
       $scope.formdata.user.roles = [];
     };
     
	 $scope.checkFirst = function() {
       $scope.formdata.user.roles.splice(0, $scope.formdata.user.roles.length); 
       $scope.formdata.user.roles.push(1);
     };

   
   

});

