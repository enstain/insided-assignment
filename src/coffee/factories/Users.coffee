factories = angular.module('factories')
factories.factory('Users',['$resource', ($resource)->

  Users = {};

  usergroups_source = [
    {id: 1, name: "Colonel"},
    {id: 2, name: "Captain"},
    {id: 3, name: "General"},
    {id: 4, name: "Lieutenant"},
    {id: 5, name: "Officer"}
  ];

  users_resource = $resource('json/dummy.json', {}, {
    'query': {method: 'GET', isArray: true}
  });

  Users.get = users_resource.query;

  Users.usergroups = usergroups_source;

  Users.filterable_fields = [
    {id:1,name:"Replies",field_name:"replies",type:"number",show:true,show_comparators:true},
    {id:2,name:"Topics",field_name:"topics",type:"number",show:true,show_comparators:true},
    {id:3,name:"Solved",field_name:"solved",type:"number",show:true,show_comparators:true},
    {id:4,name:"Usergroup",field_name:"usergroup",type:"collection",source:usergroups_source,show:true,show_comparators:false},
    {id:5,name:"Registration date",field_name:"registered",type:"date",show:true,show_comparators:true},
    {id:6,name:"Last login",field_name:"last_login",type:"date",show:true,show_comparators:true},
    {id:6,name:"Name",field_name:"name",type:"string",show:false,show_comparators:true},
  ];

  Users.selected_users = [];

  Users.selectUser = (user)->
    index = this.selected_users.indexOf(user)
    if (~index)
      this.selected_users.splice(index,1)
    else
      this.selected_users.push(user)

  Users.isSelected = (user)->
    return ~this.selected_users.indexOf(user)

  return Users;
]);