directives = angular.module('directives')
directives.directive('sortable', [
  ($parse)->
    link = (scope, element, attrs)->

      scope.$watch(attrs.collectionFactory, (newVal)->
        scope.collectionFactory = newVal
        setup()
      )

      setup = ()->
        scope.sortType       = scope.collectionFactory.fields[0].fieldName;
        scope.sortReverse    = false;

      scope.changeSortField = (fieldName)->
        scope.sortType = fieldName
        scope.sortReverse = !scope.sortReverse

      scope.$watch(
        ()-> 
          return scope.sortType
        ()->
          scope.sortReverse = false
      );

    return {
      restrict: "A",
      link: link,
      templateUrl: 'templates/directives/sortable.html'
    }
]);