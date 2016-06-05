directives = angular.module('directives')
directives.directive('filterValue', ()->
  link = (scope, element, attrs)->
    scope.$watch("field", ()->
      scope.contentUrl = 'templates/directives/filter_value/'+scope.field.type+'.html';
    )

  return {
    restrict: "EA",
    scope: {
      field:"=",
      compare:"="
    },
    link: link,
    template: '<span ng-include="contentUrl"></span>'
  }
);