directives = angular.module('directives')
directives.directive('pagination', [ 'PAGINATION', '$parse',
  (PAGINATION, $parse)->
    link = (scope, element, attrs)->

      scope.currentPage = 1
      scope.prevButtonsDisabled = true
      scope.nextButtonsDisabled = false
      scope.pageSizes = PAGINATION.size
      scope.pageSize = PAGINATION.size[0].value

      scope.$watch(attrs.collectionSize, (newVal)->
        scope.collectionSize = newVal
        calculatePages()
      )

      scope.$watch("pageSize", (newVal)->
        calculatePages()
      )

      scope.$watch("currentPage", (newVal)->
        enableNavigation()
      )

      scope.$watch("totalPages", (newVal)->
        enableNavigation()
      )

      calculatePages = ()->
        scope.totalPages = Math.ceil(scope.collectionSize / scope.pageSize)
        scope.currentPage = 1
        return

      enableNavigation = ()->
        scope.prevButtonsDisabled = (scope.currentPage == 1)
        scope.nextButtonsDisabled = (scope.currentPage == scope.totalPages)
        return

      scope.toFirstPage = ()->
        scope.currentPage = 1
        return

      scope.toLastPage = ()->
        scope.currentPage = scope.totalPages
        return

      scope.toPreviousPage = ()->
        --scope.currentPage

      scope.toNextPage = ()->
        ++scope.currentPage
      

    return {
      restrict: "EA",
      link: link,
      templateUrl: 'templates/directives/pagination.html'
    }
]);