var app = angular.module('tokiponaTranslator', ['ngSanitize', 'offClick']);

app.controller('translationController', ['$scope', 'analysis', 'documentAnalysis', 'tokiponaEnglish', function($scope, analysis, documentAnalysis, tokiponaEnglish) {
    var translation = this;
    this.doc = documentAnalysis;
    this.analysis = analysis;
    console.log(analysis);
    console.log(this.doc)

    this.mappings = tokiponaEnglish.mappings(analysis, documentAnalysis)

}]);

app.factory('heads', function() {
    service = {};
    service.each = function(collection, callback) {
        if (_.isArray(collection)) {
            _.each(collection, function(element) {
                service.each(element, callback);
            });
        } else if (_.isObject(collection)) {
            _.each(collection, function(subcollection, k) {
                if (k === 'head') {
                    callback(subcollection, collection);
                } else if (_.isArray(subcollection) || _.isObject(subcollection)) {
                    service.each(subcollection, callback)
                }
            });
        }
    };
    return service;
})

app.directive('translation', function() {
    return {
        restrict: 'E',
        template:
            '<div class="syntax-highlight">\
                <sentence-pair ng-repeat="mapping in translation.mappings track by $index"></sentence-pair>\
            </div>'
    }
});

app.directive('sentencePair', function() {
    return {
        restrict: 'E',
        template:
            '<div class="sentence-pair">\
                <tp-sentence sen="mapping.tp"></tp-sentence>\
                <div class="english-sentence">\
                    <translation-fragment ng-repeat="fragment in mapping.fragments track by $index"></translation-fragment>\
                </div>\
            </div> '
    };
});

app.directive('translationFragment', function() {

    return {
        restrict: 'E',
        template:
            '<span class="translation-fragment" ng-class="{highlighted: fragment.highlighted}" id="fragment-{{$parent.$index}}-{{$index}}" off-click="fragment.stopEditing()" off-click-if="fragment.editing">\
                {{ fragment.translated() }}\
                <span class="english-phrase-picker" ng-show="fragment.editing">\
                    <div ng-repeat="(role, phrases) in fragment.phrasesByRole">\
                        {{ role }}:<br>\
                        <span ng-repeat="phrase in phrases">{{ phrase.base_form }} </span>\
                    </div>\
                </span>\
            </span>',
        link: function(scope, el, attrs) {
                var fragment = scope.fragment;
                el.bind('mouseenter', function() {
                    fragment.highlightCounterpart();
                    scope.$apply();
                });
                el.bind('mouseleave', function() {
                    fragment.endHighlight();
                    scope.$apply();
                });
                el.bind('dblclick', function(e) {
                    e.preventDefault();
                    fragment.startEditing();
                    scope.$apply();
                });
            }
        };
});