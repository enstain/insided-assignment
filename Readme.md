# Assignment
There is a single page with user list and filters.

1. Page header includes:
- Page title: User overview
- Multi­select dropdown to filter on user group (values: Captain, Colonel, General, Lieutenant, Officer)
- Search
- Advanced filter (triggers an advanced filter panel) 
- Primary button

2. Table includes:
- Table labels (static)
- Checkbox, selecting a row will change the color of the row 
- Image
- Icon
- Text values (dummy data)

3. Advanced filter panel. This panel appears when the ‘Advanced filter’ button in the page header is clicked. Table for the dropdown options:

|First dropdown|Second dropdown|Value|
|---|---|---|
|Replies, Topics, Solved|Type single select: Is greater than, Is smaller than, Equals|Text input|
|Usergroup|Type multi select: Captain, Colonel, General, Lieutenant, Officer| - |
|Registration date, last login|Before, After, Exact date|Datepicker|

#Instructions
## Preparations
- install Ruby (and RubyGems) first and run
- `gem install slim -v '>= 3.0.2'`
- `bower install`

## Building
`gulp build`

## Run
`gulp`
