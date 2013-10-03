(function() {
  var EventsSvc;

  EventsSvc = (function() {
    function EventsSvc($q, $http) {
      this.$q = $q;
      this.$http = $http;
    }

    EventsSvc.prototype.all = function() {
      var deffered,
        _this = this;
      deffered = this.$q.defer();
      this.$http.get('/api/events').success(function(data, status, headers, config) {
        return deffered.resolve(data);
      }).error(function(data, status, headers, config) {
        return deffered.reject();
      });
      return deffered.promise;
    };

    return EventsSvc;

  })();

  angular.module("EventsSvc", []).service("EventsSvc", ["$q", "$http", EventsSvc]);

}).call(this);

(function() {
  var EventEditorCtrl,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  EventEditorCtrl = (function() {
    EventEditorCtrl.prototype.selectEvent = function(ev) {
      console.log("selectEvent", ev);
      this.$scope.data.currentEvent = ev;
      return this.$scope.data.currentEventJSON = JSON.stringify(ev, null, "  ");
    };

    function EventEditorCtrl($scope, $eventsSvc) {
      var _this = this;
      this.$scope = $scope;
      this.$eventsSvc = $eventsSvc;
      this.selectEvent = __bind(this.selectEvent, this);
      this.$scope.data = {};
      this.$scope.selectEvent = this.selectEvent;
      this.$eventsSvc.all().then(function(events) {
        return _this.$scope.data.events = events;
      });
    }

    return EventEditorCtrl;

  })();

  angular.module("EventEditorCtrl", ["EventsSvc"]).controller("EventEditorCtrl", ["$scope", "EventsSvc", EventEditorCtrl]);

}).call(this);

(function() {
  var configure, main;

  configure = function($routeProvider, $locationProvider) {
    moment.lang('ru');
    $locationProvider.html5Mode(true);
    return $routeProvider.when("/", {
      templateUrl: "index-view"
    }).when("/events", {
      templateUrl: "events-view"
    }).when("/news", {
      templateUrl: "news-view"
    }).when("/ads", {
      templateUrl: "ads-view"
    });
  };

  main = function() {
    return console.log("initialize adminApp");
  };

  angular.module('adminApp.ctrl', ["EventEditorCtrl"]);

  angular.module('adminApp.div', []);

  angular.module('adminApp.svc', ["EventsSvc"]);

  angular.module('adminApp', ['ngSanitize', 'ngRoute', 'adminApp.ctrl', 'adminApp.svc']).config(['$routeProvider', '$locationProvider', configure]).run([main]);

}).call(this);
