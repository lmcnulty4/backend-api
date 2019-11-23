These are the directories that we are actively using in the development:

+ [controllers](https://github.com/BoxOfficeInitiative/backend-api/tree/master/controllers): The controllers do the business logic and expose the server API.
+ [models](https://github.com/BoxOfficeInitiative/backend-api/tree/master/models): Uses the [Entity Framework Core](https://docs.microsoft.com/en-us/ef/core/) (EF Core) object-relational mapper (ORM) to work with the database using objects instead of database specific queries.

### frontend / www
None, this is a API-only web application, so no CSS nor JS.

### frontend / server
Content:

* models /
* controllers /

None of these modules should be accessible to the outside world. The only one that can call them is the user interface.

#### Models

With EF Core, data access is performed using a model. A model is made up of entity classes and a context object that represents a session with the database, allowing you to query and save data.

You can generate a model from an existing database, hand code a model to match your database, or use [EF Migrations](https://docs.microsoft.com/en-us/ef/core/managing-schemas/migrations/index) to create a database from your model, and then evolve it as your model changes over time.

[Here is more info about the EF Core technology](https://docs.microsoft.com/en-us/ef/core/)

#### Controllers
The controllers are where the decisions are made. The controller uses the models to make decisions, and never call the database directly. This way, we avoid having separate controllers for each module of the project.
