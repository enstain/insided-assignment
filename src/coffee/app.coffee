#@prepros-prepend ../lib/jquery/dist/jquery.min.js
#@prepros-prepend ../lib/bootstrap-sass/assets/javascripts/bootstrap.min.js
#@prepros-prepend ../lib/angular/angular.min.js
#@prepros-prepend ../lib/angular-route/angular-route.min.js
#@prepros-prepend ../lib/angular-resource/angular-resource.min.js
#@prepros-prepend ../lib/bootstrap-multiselect/dist/js/bootstrap-multiselect.js

insidedApp = angular.module('insidedApp',[
  'ngRoute',
  'ngResource',
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

controllers = angular.module('controllers',[])
filters = angular.module('filters',[])
directives = angular.module('directives',[])
factories = angular.module('factories',[])

#@prepros-append controllers/**/*.coffee
#@prepros-append filters/**/*.coffee
#@prepros-append directives/**/*.coffee
#@prepros-append factories/**/*.coffee