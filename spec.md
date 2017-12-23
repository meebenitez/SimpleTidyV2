# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes) --> List has many Chores, List has many Invites
- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User) --> Chores belong to a list, Invites belong to a List
- [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients) --> Has_many to has_many relationship between Users and Lists with a Lists_Users join table 
- [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity) --> Added an admin column to the join table, writing to it through the List edit form through Users 
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item) --> validations included in models
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes) Scope in List.rb called :where_creator, I output this in the user show page (ex: http://localhost:3000/users/1)
- [x] Include a nested form writing to an associated model using a custom attribute writer (form URL, model name e.g. /recipe/new, Item) --> Done with both Chores and Invites
- [x] Include signup (how e.g. Devise)
- [x] Include login (how e.g. Devise)
- [x] Include logout (how e.g. Devise)
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
- [x] Include nested resource show or index (URL e.g. users/2/recipes) - This did not work for the design, I've used it for new invites and edit
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients)
- [x] Include form display of validation errors (form URL e.g. /recipes/new)

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate
