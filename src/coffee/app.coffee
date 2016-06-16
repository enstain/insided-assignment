`
//= include ../lib/jquery/dist/jquery.min.js
//= include ../lib/bootstrap-sass/assets/javascripts/bootstrap.min.js
//= include ../lib/angular/angular.min.js
//= include ../lib/angular-route/angular-route.min.js
//= include ../lib/angular-resource/angular-resource.min.js
//= include ../lib/bootstrap-multiselect/dist/js/bootstrap-multiselect.js
`

insidedApp = angular.module('insidedApp',[
  'ngRoute',
  'ngResource',
  'constants',
  'controllers',
  'filters',
  'directives',
  'factories'
]);

insidedApp.config([ '$routeProvider', '$httpProvider',
  ($routeProvider,$httpProvider)->

    $routeProvider
      .when('/',
        templateUrl: "templates/user_overview.html"
        controller: 'UserOverviewCtrl'
      )
      .otherwise(
        redirectTo: '/'
      )
]);

constants = angular.module('constants',[])
controllers = angular.module('controllers',[])
filters = angular.module('filters',[])
directives = angular.module('directives',[])
factories = angular.module('factories',[])