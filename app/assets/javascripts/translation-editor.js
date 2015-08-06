var app = angular.module('translationEditor', []);

app.controller('translationController', function(translationData) {
	this.translationData = translationData;
});

app.directive('translationSegment', function() {
	return {
		restrict: 'E',
		template: '<p class="syntax-highlight"> {{ translation.translationData }}</p>'
	}
})