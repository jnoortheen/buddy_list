import Ember from 'ember';

export default Ember.Service.extend({
  session: Ember.inject.service(),
  store: Ember.inject.service(),
  loadCurrentUser() {
    if (this.get('session.isAuthenticated')) {
      this.get('store')
      .queryRecord('user', { who: 'me' })
      .then((user) => {
        this.set('currentUser', user);
      });
    }
  }
});
