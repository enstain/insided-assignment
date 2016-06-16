factories = angular.module('factories')
factories.factory('Users',['$resource', ($resource)->

  Users = {};

  usergroupSource = [
    {id: 1, name: "Colonel"},
    {id: 2, name: "Captain"},
    {id: 3, name: "General"},
    {id: 4, name: "Lieutenant"},
    {id: 5, name: "Officer"}
  ];

  usersResource = $resource('json/dummy.json', {}, {
    'query': {method: 'GET', isArray: true}
  });

  Users.get = usersResource.query;

  Users.usergroups = usergroupSource;

  Users.fields = [
    { id:1, name:"Username",  fieldName:"name", type:"string", filterable:true, showFilter:false, showComparators:true },
    { id:2, name:"Email",  fieldName:"email", type:"string", filterable:false },
    { id:3, name:"Replies", fieldName:"replies", type:"number", filterable:true, showFilter:true, showComparators:true},
    { id:4, name:"Topics", fieldName:"topics", type:"number", filterable:true, showFilter:true ,showComparators:true},
    { id:5, name:"Solved", fieldName:"solved", type:"number", filterable:true, showFilter:true ,showComparators:true},
    { id:6, name:"Usergroup", fieldName:"usergroup", type:"collection", source:usergroupSource, filterable:true, showFilter:true ,showComparators:false},
    { id:7, name:"Registration date", fieldName:"registered", type:"date", filterable:true, showFilter:true ,showComparators:true},
    { id:8, name:"Last login", fieldName:"last_login", type:"date", filterable:true, showFilter:true ,showComparators:true},
  ];

  Users.selectedUsers = [];

  Users.selectUser = (user)->
    index = this.selectedUsers.indexOf(user)
    if (~index)
      this.selectedUsers.splice(index,1)
    else
      this.selectedUsers.push(user)

  Users.selectAll = ()->
    console.log('select all users')

  Users.isSelected = (user)->
    return ~this.selectedUsers.indexOf(user)

  return Users;
]);