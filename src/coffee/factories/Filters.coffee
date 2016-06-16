factories = angular.module('factories')
factories.factory('Filters', ['$filter', 'COMPARATORS', ($filter, COMPARATORS)->

  FiltersInstance = (Collection)->
    this.show = false
    this.addedFilters = []
    this.source = Collection.get()
    this.filteredCollection = this.source
    this.filterFields = Collection.filterableFields.filter((filter)-> filter.show)

    this.toggleFiltersPanel = ()->
      this.show = !this.show
      return

    this.addNewFilterIsDisabled = ()->
      if this.addedFilters.length 
        !this.filtersAreFilled()
      else
        false

    this.filtersAreFilled = ()->
      return this.addedFilters.every(
        (filter)-> filterIsFilled(filter)
      ) && this.addedFilters.length

    filterIsFilled = (filter)->
      return !!filter.field && !!filter.comparator && !!filter.compareWith.value

    this.addNewFilter = ()->
      filter = {
        field: this.filterFields[0],
        compareWith: { value: null }
      }
      filter.comparator = COMPARATORS[filter.field.type][0];
      this.addedFilters.push(filter)
      return

    this.refreshFilter = (filter)->
      filter.comparator = COMPARATORS[filter.field.type][0]
      filter.compareWith = { value: null }
      return

    this.removeFilter = (filter)->
      index = this.addedFilters.indexOf(filter)
      this.addedFilters.splice(index,1)
      if (!this.addedFilters.length)
        this.clearFilters()
      return

    this.clearFilters = ()->
      this.addedFilters.length = 0;
      this.filteredCollection = this.source
      return

    this.applyFilters = ()->
      this.filteredCollection = $filter('advanceFilter')(this.source, this.addedFilters)
      return

    this.applyStandaloneFilter = (field_name, search_source)->
      this.show = false
      if search_source.length
        filter_field = Collection.filterableFields.filter((field)-> field.field_name == field_name)[0]
        filter = {
          field: filter_field,
          comparator: COMPARATORS[filter_field.type][0],
          compareWith: {value: search_source}
        }

        fake_filter_array = [].concat(filter)
        this.filteredCollection = $filter('advanceFilter')(this.source, fake_filter_array)
      else
        this.filteredCollection = this.source
      return

    return this

  return {
    createFor: (Collection)->
      new FiltersInstance(Collection)
  };
      
]);