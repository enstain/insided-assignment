filters = angular.module('filters')
filters.filter('startFrom', [ 
  () ->
    (list, start) ->
      return list.slice(start)
]);

filters.filter('limitTo', [ 
  () ->
    (list, end) ->
      return list.slice(0,end)
])