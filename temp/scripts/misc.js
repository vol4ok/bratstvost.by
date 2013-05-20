(function() {
  var Application, Collection, Model, UIView, bindEvent, bindEvents,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Backbone.__classes = {};

  Backbone.__objects = {};

  Backbone.registerClass = Backbone.View.registerClass = function(name, klass) {
    if (klass == null) {
      klass = this;
    }
    return Backbone.__classes[name] = klass;
  };

  Backbone.getClassByName = function(name) {
    return Backbone.__classes[name];
  };

  Backbone.registerObject = Backbone.View.prototype.registerObject = function(name, obj) {
    if (obj == null) {
      obj = this;
    }
    return Backbone.__objects[name] = obj;
  };

  Backbone.getObjectByName = Backbone.View.prototype.getObjectByName = function(name) {
    return Backbone.__objects[name];
  };

  bindEvent = function(src, trg) {
    var $$, event, method, srcObj, t, trgObj, _ref, _ref1;

    $$ = Backbone.getObjectByName;
    _ref = (t = src.split(' ')).length === 1 ? [this, t[0]] : [$$(t[0]), t[1]], srcObj = _ref[0], event = _ref[1];
    _ref1 = (t = trg.split(' ')).length === 1 ? [this, t[0]] : [$$(t[0]), t[1]], trgObj = _ref1[0], method = _ref1[1];
    return srcObj.on(event, trgObj[method]);
  };

  bindEvents = function(events) {
    var src, trg, _results;

    if (!events) {
      return;
    }
    _results = [];
    for (src in events) {
      trg = events[src];
      _results.push(bindEvent(src, trg));
    }
    return _results;
  };

  UIView = (function(_super) {
    __extends(UIView, _super);

    function UIView() {
      UIView.__super__.constructor.apply(this, arguments);
      this.registerObject(this.id || this.$el.attr("id") || this.cid);
    }

    return UIView;

  })(Backbone.View);

  Application = (function(_super) {
    __extends(Application, _super);

    function Application() {
      this.__on_laoded = __bind(this.__on_laoded, this);
      this.__on_load = __bind(this.__on_load, this);
      this.initAutoloadObjects = __bind(this.initAutoloadObjects, this);      this.load = false;
      this.laoded = false;
      $(this.__on_load);
    }

    Application.prototype.initAutoloadObjects = function() {
      return $(".autoload").each(function(index, el) {
        var $el;

        $el = $(el);
        new (Backbone.getClassByName($el.data('class')))({
          el: $el
        });
        $el.removeClass("autoload");
        return $el.removeData("class");
      });
    };

    Application.prototype.on = function(eventname, callback) {
      if (this.load && eventname === "load") {
        callback();
      }
      if (this.loaded && eventname === "loaded") {
        callback();
      }
      return Application.__super__.on.apply(this, arguments);
    };

    Application.prototype.__on_load = function() {
      this.load = true;
      this.trigger("load", this);
      return _.defer(this.__on_laoded);
    };

    Application.prototype.__on_laoded = function() {
      this.loaded = true;
      return this.trigger("loaded", this);
    };

    return Application;

  })(Backbone.Router);

  Model = Backbone.Model;

  Collection = Backbone.Collection;

  Backbone.sync = function(method, model, options) {
    var sock;

    console.log("sync", method.toUpperCase, model, options);
    sock = io.connect('http://vol4ok.com:3000' + _.result(model, 'url'));
    return sock.emit(method, model, function(err, data) {
      console.log("sync-complete", err, data);
      if (!err) {
        return options.success(data);
      } else {
        return options.error(data);
      }
    });
  };

}).call(this);

(function() {
  String.prototype.capitalize = function() {
    return this.substr(0, 1).toUpperCase() + this.substr(1).toLowerCase();
  };

  String.prototype.translit = (function() {
    var L, k, r;

    L = {
      "А": "A",
      "а": "a",
      "Б": "B",
      "б": "b",
      "В": "V",
      "в": "v",
      "Г": "G",
      "г": "g",
      "Д": "D",
      "д": "d",
      "Е": "E",
      "е": "e",
      "Ё": "Yo",
      "ё": "yo",
      "Ж": "Zh",
      "ж": "zh",
      "З": "Z",
      "з": "z",
      "И": "I",
      "и": "i",
      "Й": "Y",
      "й": "y",
      "К": "K",
      "к": "k",
      "Л": "L",
      "л": "l",
      "М": "M",
      "м": "m",
      "Н": "N",
      "н": "n",
      "О": "O",
      "о": "o",
      "П": "P",
      "п": "p",
      "Р": "R",
      "р": "r",
      "С": "S",
      "с": "s",
      "Т": "T",
      "т": "t",
      "У": "U",
      "у": "u",
      "Ф": "F",
      "ф": "f",
      "Х": "H",
      "х": "h",
      "Ц": "Ts",
      "ц": "ts",
      "Ч": "Ch",
      "ч": "ch",
      "Ш": "Sh",
      "ш": "sh",
      "Щ": "Sch",
      "щ": "sch",
      "Ъ": "\"",
      "ъ": "\"",
      "Ы": "Y",
      "ы": "y",
      "Ь": "'",
      "ь": "'",
      "Э": "E",
      "э": "e",
      "Ю": "Yu",
      "ю": "yu",
      "Я": "Ya",
      "я": "ya"
    };
    r = "";
    for (k in L) {
      r += k;
    }
    r = new RegExp("[" + r + "]", "g");
    k = function(a) {
      if (a in L) {
        return L[a];
      } else {
        return "";
      }
    };
    return function() {
      return this.replace(r, k);
    };
  })();

}).call(this);
