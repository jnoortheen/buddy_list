import DS from 'ember-data';

export default DS.Model.extend({
	full_name: DS.attr('string'),
	email: DS.attr('string'),

	// Relationships
	friends: DS.hasMany('user', {async: true})
});
