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

    EventsSvc.prototype.create = function(doc) {
      var deffered,
        _this = this;
      deffered = this.$q.defer();
      this.$http.post('/api/events', doc).success(function(data, status, headers, config) {
        return deffered.resolve(data);
      }).error(function(data, status, headers, config) {
        return deffered.reject();
      });
      return deffered.promise;
    };

    EventsSvc.prototype.save = function(doc) {
      var deffered,
        _this = this;
      deffered = this.$q.defer();
      this.$http.put('/api/events', doc).success(function(data, status, headers, config) {
        return deffered.resolve(data);
      }).error(function(data, status, headers, config) {
        return deffered.reject();
      });
      return deffered.promise;
    };

    EventsSvc.prototype["delete"] = function(id) {
      var deffered,
        _this = this;
      deffered = this.$q.defer();
      this.$http["delete"]('/api/events', id).success(function(data, status, headers, config) {
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
      this.$scope.data.isNew = false;
      return this.$scope.data.currentEvent = ev;
    };

    EventEditorCtrl.prototype.createEvent = function() {
      this.$scope.data.isNew = true;
      return this.$scope.data.currentEvent = {
        _id: uuid.v4(),
        date: moment().add(1, 'd').format("YYYY-MM-DD"),
        title: "",
        body: "",
        event_time: "",
        event_place: "",
        meeting_time: "",
        meeting_place: "",
        organizer: "",
        phone: "",
        cost: "",
        published: true,
        updated: moment().toISOString(),
        created: moment().toISOString(),
        type: "event"
      };
    };

    EventEditorCtrl.prototype.saveCurrentEvent = function() {
      var ev,
        _this = this;
      console.log(this.$scope.data.currentEvent);
      ev = this.$scope.data.currentEvent;
      if (!ev._id) {
        this.$scope.data.isNew = true;
      }
      if (ev._id == null) {
        ev._id = uuid.v4();
      }
      if (ev.updated == null) {
        ev.updated = moment().toISOString();
      }
      if (ev.created == null) {
        ev.created = moment().toISOString();
      }
      if (ev.type == null) {
        ev.type = "event";
      }
      if (ev.custom_field == null) {
        ev.custom_field = [];
      }
      if (this.$scope.data.isNew) {
        this.$eventsSvc.create(ev).then(function(resp) {
          return console.log(resp);
        });
      } else {
        this.$eventsSvc.save(ev).then(function(resp) {
          return console.log(resp);
        });
      }
      return this.$scope.data.events[ev._id] = ev;
    };

    function EventEditorCtrl($scope, $eventsSvc) {
      var _this = this;
      this.$scope = $scope;
      this.$eventsSvc = $eventsSvc;
      this.saveCurrentEvent = __bind(this.saveCurrentEvent, this);
      this.createEvent = __bind(this.createEvent, this);
      this.selectEvent = __bind(this.selectEvent, this);
      this.$scope.data = {};
      this.$scope.selectEvent = this.selectEvent;
      this.$scope.createEvent = this.createEvent;
      this.$scope.saveCurrentEvent = this.saveCurrentEvent;
      this.$eventsSvc.all().then(function(events) {
        var ev, _i, _len, _results;
        _this.$scope.data.events = {};
        _results = [];
        for (_i = 0, _len = events.length; _i < _len; _i++) {
          ev = events[_i];
          _results.push(_this.$scope.data.events[ev._id] = ev);
        }
        return _results;
      });
      this.$scope.$watch("data.currentEvent._id", function() {
        console.log('$watch "data.currentEvent._id"');
        return _this.$scope.data.currentEventJSON = JSON.stringify(_this.$scope.data.currentEvent, null, "  ");
      });
      this.$scope.$watch("data.currentEventJSON", function() {
        console.log('$watch "data.currentEventJSON"');
        try {
          return _this.$scope.data.currentEvent = JSON.parse(_this.$scope.data.currentEventJSON);
        } catch (_error) {

        }
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
