src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.10/angular.min.js"
function BreweriesController($scope, $http) {
    $http.get('breweries.json').success( function(data, status, headers, config) {
    	$scope.breweries = data;
    });
    $scope.order = 'name';

    $scope.click = function (order) {
    	$scope.order = order;
    	console.log(order);
    }
}