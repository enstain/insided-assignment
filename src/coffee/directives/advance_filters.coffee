directives = angular.module('directives')
directives.directive('advanceFilters', ()->
  return {
    restrict: "E",
    templateUrl: 'templates/directives/advance_filters.html'
  }
);