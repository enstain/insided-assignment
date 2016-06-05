controllers = angular.module('controllers')
controllers.controller('UserOverviewCtrl', ['$scope', '$filter', 'Users',
  ($scope, $filter, Users)-> 

    $scope.currentPage = 1;
    $scope.pageSize = 10;

    $scope.added_filters = [];
    $scope.show_filters = false;
    $scope.username_scope = "";

    $scope.usersFactory = Users;
    $scope.filtered = $scope.users = Users.get();
    $scope.filter_fields = Users.filterable_fields.filter((filter)-> filter.show)
      

    $scope.toggleFiltersPanel = ()->
      $scope.show_filters = !$scope.show_filters;

    $scope.addNewFilter = ()->
      filter = {
        field: $scope.filter_fields[0],
        compareWith: { value: null }
      }
      filter.comparator = $scope.comparators[filter.field.type][0];

      $scope.added_filters.push(filter)

    $scope.refreshFilter = (filter)->
      filter.comparator = $scope.comparators[filter.field.type][0]
      filter.compareWith = { value: null }

    $scope.applyFilters = ()->
      $scope.filtered = $filter('advanceFilter')($scope.users, $scope.added_filters)

    $scope.applyStandaloneFilter = (field_name, search_source)->
      $scope.show_filters = false
      if search_source.length
        filter_field = Users.filterable_fields.filter((field)-> field.field_name == field_name)[0]
        filter = {
          field: filter_field,
          comparator: $scope.comparators[filter_field.type][0],
          compareWith: {value: search_source}
        }

        fake_filter_array = [].concat(filter)
        $scope.filtered = $filter('advanceFilter')($scope.users, fake_filter_array)
      else
        $scope.filtered = $scope.users

    $scope.removeFilter = (filter)->
      index = $scope.added_filters.indexOf(filter)
      $scope.added_filters.splice(index,1)
      if (!$scope.added_filters.length)
        $scope.clearFilters()

    $scope.clearFilters = ()->
      $scope.added_filters.length = 0;
      $scope.filtered = $scope.users

    filterIsFilled = (filter)->
      return !!filter.field && !!filter.comparator && !!filter.compareWith.value

    $scope.filtersAreFilled = ()->
      return $scope.added_filters.every(
        (filter)-> filterIsFilled(filter)
      ) && $scope.added_filters.length

    $scope.comparators = {
      "string": [
        {id:1,label:"Contains",filterFunction: (string, substring)-> (~string.indexOf(substring))}
      ]
      "number": [
        {id:1,label:"Is greater than",filterFunction: (a,b)-> (+a > +b)},
        {id:2,label:"Is smaller than",filterFunction: (a,b)-> (+a < +b)},
        {id:3,label:"Equals",filterFunction: (a,b)-> (+a == +b)}
      ],
      "date": [
        {id:1,label:"Before",filterFunction: (a,b)-> (new Date(a).setHours(0,0,0,0,0) < new Date(b).setHours(0,0,0,0,0))},
        {id:2,label:"After",filterFunction: (a,b)-> (new Date(a).setHours(0,0,0,0,0) > new Date(b).setHours(0,0,0,0,0))},
        {id:3,label:"Exact date",filterFunction: (a,b)-> (new Date(a).setHours(0,0,0,0,0) == new Date(b).setHours(0,0,0,0,0))}
      ],
      "collection": [
        {id:1,label:"In",filterFunction: (item,array)-> (~array.indexOf(item))}
      ]
    }

    

]);