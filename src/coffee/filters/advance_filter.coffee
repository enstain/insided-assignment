filters = angular.module('filters')
filters.filter('advanceFilter', [ 
  () ->
    (sourceArray, filters) ->

      if filters.length

        filteredArrays = {};

        filters.forEach(
          (filter)->
            fieldName = filter.field.fieldName
            comparator = filter.comparator.filterFunction
            value = filter.compareWith.value

            if (!filteredArrays[fieldName])
              filteredArrays[fieldName] = []
            
            filteredArrays[fieldName] = filteredArrays[fieldName].concat(
              sourceArray.filter(
                (item)-> 
                  return comparator(item[fieldName],value)
              )
            )
        );

        filteredResult = sourceArray.filter(
          (item)->
            return Object.keys(filteredArrays).every(
              (key)->
                return ~filteredArrays[key].indexOf(item)
            )
        )
        
        return filteredResult
      else
        return sourceArray
]);