angular.module('workshopManager')
    .controller('HomeCtrl', ['$scope', function ($scope) {
        $scope.things = ['Angular', 'Rails 4.1', 'Working', 'Together!!'];
    }]);
