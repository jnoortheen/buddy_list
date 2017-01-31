import DS from 'ember-data';

export default DS.Model.extend({
	// id: DS.attr('string'),
	full_name: DS.attr('string'),
	// friendships: 
	email: DS.attr('string')
});
