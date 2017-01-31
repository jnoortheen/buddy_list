import Ember from 'ember';
export default Ember.Controller.extend({
  session: Ember.inject.service(),
  sessionAccount: Ember.inject.service(),
  actions: {
    authenticate() {
      let { email, password } = this.getProperties('email', 'password');
      this.get('session')
      .authenticate('authenticator:oauth2', email, password)
      .then(() => {
        this.get('sessionAccount').loadCurrentUser();
      }).catch((reason) => {
        this.set('errorMessage', `Invalid email or password ${reason}`);
      });
    }
  }
});