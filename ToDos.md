# ToDos:

## Backend:
- [x] ability to create users 
	- [x] create user model with reference to friends
		- [x] specs for user model
	- [x] added db seed
	- [x] implement jwt authentication
		- [x] create jwt library
		- [x] write test jwt lib
		- [x] signin return auth token
		- [x] use authentication in all controller actions
			- index 
			- show 
			- update
			- delete
		- [x] update user controller specs
- [ ] supports adding/remove friends by email
		 to: action@deploy-sendgrid.com
	- [x] implement griddler
	- [x] add tests to email_processor and its post endpoint
	- [x] adding friends	 
		 if user_1 wants to add user_2 as friend, it need to send a mail from its registered mail with below format
		 	from: user1@mail.com
			subject: add <user2's registered mail ID>
	- [x] removing friends
		format
			from: user1@mail.com
			subject: remove <user2's registered mail>
	-[x] write tests
	-[ ] configure with sendgrid and deploy

- ability to return user information along with friends list

## FrontEnd:   
- [x] emberjs getting started
- [x] installing and configuring ember-cli-rails
- [x] using pgsql instead of sqlite
- [x] implement ember simple auth 
	- [x] singup
	 - [ ] capybara test - upon successful signup redirects to index page and has user mail id in content
	- [x] singin page
	 - [ ] capybara test - upon successful signin redirects to index page and has user mail id in content
- [ ] user goes to home page
	- [x] if not authenticated redirected to login page
		- [ ] capybara test
	- [x] if authenticated then show user information, friends list, other users
		- [x] click on friends to unfriend - open mail dialog
		- [x] click on others to friend - open mail dialog
		- [ ] capybara test

## Mailers:
- add/remove friends using mail
