import Ember from 'ember';
export default Ember.Controller.extend({
  session: Ember.inject.service(),
  sessionAccount: Ember.inject.service(),
  ajax: Ember.inject.service(),
  actions: {
    register() {
      let userData = {data:
                        {type: 'users',
                        attributes:
                        {
                          full_name: this.get('full_name'),
                          email: this.get('email'),
                          password: this.get('password')
                        }}
                      };
      this.get('ajax').post('/users', { data: userData })
      .then(() => {
        let { email, password } = this.getProperties('email', 'password');
        this.get('session').authenticate('authenticator:oauth2', email, password)
        .then(() => {
          this.get('sessionAccount').loadCurrentUser();
        });
      }).catch(() => {
        this.set('errorMessage', 'An error occurred, please try again');
      });
    }
  }
});