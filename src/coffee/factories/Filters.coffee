factories = angular.module('factories')
factories.factory('Filters', ['COMPARATORS', '$filter', (COMPARATORS, $filter)->

  FiltersInstance = (Collection)->
    this.show = false
    this.addedFilters = []
    this.source = Collection.get()
    this.filteredCollection = this.source
    this.filterableFields = Collection.fields.filter((field)-> field.filterable)
    this.filterFields = this.filterableFields.filter((field)-> field.showFilter)

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

    this.applyStandaloneFilter = (fieldName, searchSource)->
      this.show = false
      if searchSource.length
        filterField = this.filterableFields.filter((field)-> field.fieldName == fieldName)[0]
        filter = {
          field: filterField,
          comparator: COMPARATORS[filterField.type][0],
          compareWith: {value: searchSource}
        }

        fakeFilterArray = [].concat(filter)
        this.filteredCollection = $filter('advanceFilter')(this.source, fakeFilterArray)
      else
        this.filteredCollection = this.source
      return

    return this

  return {
    createFor: (Collection)->
      new FiltersInstance(Collection)
  };
      
]);