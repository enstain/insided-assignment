constants = angular.module('constants',[])
constants.constant('COMPARATORS', 
  {
    "string": [
      {id:1,label:"Contains",filterFunction: (string, substring)-> (~string.indexOf(substring))}
    ]
    "number": [
      {id:1,label:"Is greater than",filterFunction: (a,b)-> (+a > +b)},
      {id:2,label:"Is smaller than",filterFunction: (a,b)-> (+a < +b)},
      {id:3,label:"Equals",filterFunction: (a,b)-> (+a == +b)}
    ],
    "date": [
      {id:1,label:"Before",filterFunction: (a,b)-> (new Date(a).setHours(0,0,0,0,0) < new Date(b).setHours(0,0,0,0,0))},
      {id:2,label:"After",filterFunction: (a,b)-> (new Date(a).setHours(0,0,0,0,0) > new Date(b).setHours(0,0,0,0,0))},
      {id:3,label:"Exact date",filterFunction: (a,b)-> (new Date(a).setHours(0,0,0,0,0) == new Date(b).setHours(0,0,0,0,0))}
    ],
    "collection": [
      {id:1,label:"In",filterFunction: (item,array)-> (~array.indexOf(item))}
    ]
  }
);