filters = angular.module('filters')
filters.filter('advanceFilter', [ 
  () ->
    (array, filters) ->

      if filters.length

        filtered_arrays = {};

        filters.forEach(
          (filter)->
            field_name = filter.field.field_name
            comparator = filter.comparator.filterFunction
            value = filter.compareWith.value

            if (!filtered_arrays[field_name])
              filtered_arrays[field_name] = []
            
            filtered_arrays[field_name] = filtered_arrays[field_name].concat(
              array.filter(
                (item)-> 
                  return comparator(item[field_name],value)
              )
            )
        );

        filtered = array.filter(
          (item)->
            return Object.keys(filtered_arrays).every(
              (key)->
                return ~filtered_arrays[key].indexOf(item)
            )
        )
        
        return filtered
      else
        return array
]);