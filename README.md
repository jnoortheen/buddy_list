# Buddy List
Simple Rails5 + EmberJS full-stack app using JWT for user authentication. Using Ember-cli-rails helped to keep both side of  application together.

**Note** Ruby version of 2.2 or above is needed.

## Database
 - using postgres as the backend db
 - Run `bin/rake db:setup` to create a database for the application`
 - Run `bin/rake db:seed` to generate random data
  
## Testing

- inside the project directory run `rspec` to check all project specs.
- run `bin/rake ember:test` to run ember test suit

## How to use
- clone the repository
- run `npm install` and `bundle install`
- start the server in any of the development/test/production mode

## Deployment to heroku
Refer deployment instructions [here](https://github.com/thoughtbot/ember-cli-rails#heroku) and [here](https://devcenter.heroku.com/articles/getting-started-with-rails5)
