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

  Users.filterableFields = [
    { id:1, name:"Replies", field_name:"replies", type:"number", show:true ,show_comparators:true},
    { id:2, name:"Topics", field_name:"topics", type:"number", show:true ,show_comparators:true},
    { id:3, name:"Solved", field_name:"solved", type:"number", show:true ,show_comparators:true},
    { id:4, name:"Usergroup", field_name:"usergroup", type:"collection", source:usergroupSource ,show:true ,show_comparators:false},
    { id:5, name:"Registration date", field_name:"registered", type:"date", show:true ,show_comparators:true},
    { id:6, name:"Last login", field_name:"last_login", type:"date", show:true ,show_comparators:true},
    { id:6, name:"Name", field_name:"name", type:"string", show:false ,show_comparators:true},
  ];

  Users.selectedUsers = [];

  Users.selectUser = (user)->
    index = this.selectedUsers.indexOf(user)
    if (~index)
      this.selectedUsers.splice(index,1)
    else
      this.selectedUsers.push(user)

  Users.isSelected = (user)->
    return ~this.selectedUsers.indexOf(user)

  return Users;
]);