directives = angular.module('directives')
directives.directive 'multiselect', ->
  { 
    link: (scope, element, attrs) ->
      element.multiselect
        buttonClass: 'btn btn-default'
        buttonWidth: 'auto'
        buttonContainer: '<div class="btn-group '+(attrs.class || '')+'" />'
        maxHeight: false,
        nonSelectedText: attrs.placeholder || "None selected",
        numberDisplayed: 2,
        nSelectedText: ' items selected',
        onChange: (optionElement, checked) ->
          if optionElement != null
            optionElement.removeAttr 'selected'
          if checked
            optionElement.prop 'selected', 'selected'
      
      scope.$watch(
        ()->
          return element[0].length
        ()->
          scope.$applyAsync element.multiselect('rebuild')
          return
      )
      
      scope.$watch(attrs.ngModel, 
        ()->
          element.multiselect('rebuild')
          return
      )
      return
        
 }