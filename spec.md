# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes)

      User has many dealings(transactions).
      User has many inverse_dealings. (where the user is on the receiving end of a transaction.)

- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User)

      A dealing belongs to a sender (someone who initiated the transaction.)

      A dealing belongs to a recipient (someone who is on the receiving end of a transaction.)

- [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients)

      A user has many recipients through the dealings. (i.e. A user has sent a request for money, or has sent money to another user.)

      A user has many inverse_recipients through inveser dealings. (A user is on the receiving end of a transaction, i.e. the current user was sent money from another user, or the current user receives a request to send money over to another user.)

      A dealing has many tags through dealing_tags, and a tag has many dealings through dealing_tags.

- [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity)

      A dealing (which bridges a user to another user in a transaction) is created by a user where the user specifies the amount, the recipient, the description of the transaction, and whehter the user is paying/requesting payment from another user.

- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)

      User login is validated via Devise.
      User cannot send money or approve a transaction if the the user has insufficient funds.
      A transaction must include a recipient.
      A transaction must include a non-zero and non-negative amount.
      A transaction cannot exceed $2000.
      A transaction must include a description.
      A transaction's description cannot be longer than 35 characters.
      A transaction choice of Pay or Request must be chosen.
      A transaction's "pay" and "request" values can't be tampered with via console


- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)

      There are several class level ActiveRecord scope methods employeed in this app.

        User.contacts(current_user)
          queries users who are not the current user.

        Tag.completed_by_name
          queries tags that include completed transactions and orders them alphabetically.

        Dealing.all_with_tags_completed(tag)
          queries completed transactions that include a certain tag, and sorts them by update date.

        Dealing.newest_first
          queries all completed transactions and sorts them by update date.


- [x] Include a nested form writing to an associated model using a custom attribute writer (form URL, model name e.g. /recipe/new, Item)

      When creating a transaction, a user can optionally create tags that the transaction categorizes (hashtags) under.  The custom #tags_attributes writer takes the tags that the user provides and finds or creates new tag instances and stores them under the newly created transaction.

- [x] Include signup (how e.g. Devise)
- [x] Include login (how e.g. Devise)
- [x] Include logout (how e.g. Devise)
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)

      Devise has been incorporated to handle login/signin logic. Users can also access their account by logging into through Facebook.


- [x] Include nested resource show or index (URL e.g. users/2/recipes)

      When a user clicks on the "Pay or Request" on another user's show page, it takes them to a nested route of /users/:id/dealings/new with the contact already pre-selected.

- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients)
- [ ] Include form display of validation errors (form URL e.g. /recipes/new)

Confirm:
- [ ] The application is pretty DRY
- [ ] Limited logic in controllers
- [ ] Views use helper methods if appropriate
- [ ] Views use partials if appropriate
