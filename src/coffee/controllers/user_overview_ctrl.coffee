controllers = angular.module('controllers')
controllers.controller('UserOverviewCtrl', ['$scope', 'Users', 'Filters',
  ($scope, Users, Filters)-> 

    $scope.usersFactory   = Users;
    $scope.filtersFactory = Filters.createFor(Users);

    $scope.$watch(
      ()-> 
        return $scope.filtersFactory.filteredCollection
      (newVal)->
        if (typeof newVal != 'undefined')
          $scope.filteredUsers = newVal
          return
    );

    return
]);