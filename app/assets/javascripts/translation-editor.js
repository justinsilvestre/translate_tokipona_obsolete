var app = angular.module('tokiponaTranslator', ['ngSanitize']);

app.controller('translationController', function(translationData) {
	this.skeleton = translationData.skeleton
	this.highlighted = syntaxHighlight(this.skeleton)
});

app.directive('translationSegment', function() {
	return {
		restrict: 'E',
		template: '<p class="syntax-highlight" ng-bind-html="translation.highlighted"></p>'
	}
})