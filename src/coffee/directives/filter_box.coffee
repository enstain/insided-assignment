directives = angular.module('directives')
directives.directive('filterBox', ['COMPARATORS', 
  (COMPARATORS)->
    link = (scope, element, attrs)->
      scope.comparators = COMPARATORS
    return {
      restrict: "E",
      link: link,
      templateUrl: 'templates/directives/filter_box.html'
    }
]);