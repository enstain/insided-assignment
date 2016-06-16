controllers = angular.module('controllers')
controllers.controller('UserOverviewCtrl', ['$scope', 'Users', 'Filters',
  ($scope, Users, Filters)-> 

    $scope.currentPage = 1;
    $scope.pageSize = 10;

    $scope.usersFactory = Users;
    $scope.filtersFactory = Filters.createFor(Users);

    $scope.$watch(
      ()-> return $scope.filtersFactory.filteredCollection
      (newVal, oldVal)->
        if (typeof newVal != 'undefined')
          $scope.filteredUsers = newVal
          return
    );
    return
]);