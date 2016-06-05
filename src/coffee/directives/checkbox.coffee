directives = angular.module('directives')
directives.directive('input', ()->
  return {
    restrict: 'E',
    link: (scope,element,attrs)->
      if (attrs.type == "checkbox")
        element.wrap('<label class="checkbox"></label>')
  }
);