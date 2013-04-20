var Application, MyApp, UIButton, UIPage, UIPopupDialog, UIPopupHolder, UIView, bindEvent, bindEvents,
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

UIPage = (function(_super) {
  __extends(UIPage, _super);

  UIPage.registerClass(UIPage.name);

  function UIPage(options) {
    this.unblur = __bind(this.unblur, this);
    this.blur = __bind(this.blur, this);    UIPage.__super__.constructor.apply(this, arguments);
  }

  UIPage.prototype.blur = function(callback) {
    this.$el.addClass("blur");
    this.trigger("blur");
    return typeof callback === "function" ? callback() : void 0;
  };

  UIPage.prototype.unblur = function(callback) {
    this.$el.removeClass("blur");
    this.trigger("unblur");
    return typeof callback === "function" ? callback() : void 0;
  };

  return UIPage;

})(UIView);

UIPopupHolder = (function(_super) {
  __extends(UIPopupHolder, _super);

  UIPopupHolder.registerClass(UIPopupHolder.name);

  function UIPopupHolder(options) {
    this.on_click = __bind(this.on_click, this);
    this.on_popupHide = __bind(this.on_popupHide, this);
    this.on_popupShow = __bind(this.on_popupShow, this);
    this._initPopups = __bind(this._initPopups, this);
    this.deactivate = __bind(this.deactivate, this);
    this.activate = __bind(this.activate, this);    UIPopupHolder.__super__.constructor.apply(this, arguments);
    this.popups = [];
    this.activePopups = 0;
    this._initPopups();
  }

  UIPopupHolder.prototype.activate = function(callback) {
    this.$el.addClass("active");
    this.trigger("activate");
    return typeof callback === "function" ? callback() : void 0;
  };

  UIPopupHolder.prototype.deactivate = function(callback) {
    this.$el.removeClass("active");
    this.trigger("deactivate");
    return typeof callback === "function" ? callback() : void 0;
  };

  UIPopupHolder.prototype._initPopups = function() {
    var $el, el, index, popup, _i, _len, _ref, _results;

    _ref = this.$el.children();
    _results = [];
    for (index = _i = 0, _len = _ref.length; _i < _len; index = ++_i) {
      el = _ref[index];
      $el = $(el);
      popup = new (Backbone.getClassByName($el.data('class')))({
        el: $el
      });
      popup.on("show", this.on_popupShow);
      popup.on("hide", this.on_popupHide);
      _results.push(this.popups.push(popup));
    }
    return _results;
  };

  UIPopupHolder.prototype.on_popupShow = function() {
    if (this.activePopups++ === 0) {
      return this.activate();
    }
  };

  UIPopupHolder.prototype.on_popupHide = function() {
    if (--this.activePopups === 0) {
      return this.deactivate();
    }
  };

  UIPopupHolder.prototype.on_click = function(e) {
    return this.trigger("click");
  };

  return UIPopupHolder;

})(UIView);

UIPopupDialog = (function(_super) {
  __extends(UIPopupDialog, _super);

  UIPopupDialog.registerClass(UIPopupDialog.name);

  UIPopupDialog.prototype.events = {
    "click .x": "on_close"
  };

  function UIPopupDialog(options) {
    this.on_close = __bind(this.on_close, this);
    this.hide = __bind(this.hide, this);
    this.show = __bind(this.show, this);    UIPopupDialog.__super__.constructor.apply(this, arguments);
    this.$el.find(".datepicker").datepicker({
      format: 'dd.mm.yyyy'
    });
  }

  UIPopupDialog.prototype.show = function(callback) {
    this.$el.addClass("active");
    this.trigger("show");
    return typeof callback === "function" ? callback() : void 0;
  };

  UIPopupDialog.prototype.hide = function(callback) {
    this.$el.removeClass("active");
    this.trigger("hide");
    return typeof callback === "function" ? callback() : void 0;
  };

  UIPopupDialog.prototype.on_close = function(e) {
    return this.trigger("close");
  };

  return UIPopupDialog;

})(UIView);

UIButton = (function(_super) {
  __extends(UIButton, _super);

  UIButton.registerClass(UIButton.name);

  UIButton.prototype.events = {
    "click": "on_click"
  };

  function UIButton(options) {
    UIButton.__super__.constructor.apply(this, arguments);
  }

  UIButton.prototype.on_click = function(e) {
    return this.trigger("click");
  };

  return UIButton;

})(UIView);

Application = (function(_super) {
  __extends(Application, _super);

  function Application() {
    this.__on_laoded = __bind(this.__on_laoded, this);
    this.__on_load = __bind(this.__on_load, this);
    this.initAutoloadObjects = __bind(this.initAutoloadObjects, this);    this.load = false;
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

MyApp = (function(_super) {
  __extends(MyApp, _super);

  function MyApp(options) {
    this.on_loaded = __bind(this.on_loaded, this);
    this.on_load = __bind(this.on_load, this);    MyApp.__super__.constructor.apply(this, arguments);
    this.on("load", this.on_load);
    this.on("loaded", this.on_loaded);
  }

  MyApp.prototype.on_load = function() {
    console.log("Hello");
    return this.initAutoloadObjects();
  };

  MyApp.prototype.on_loaded = function() {
    return bindEvents({
      "new-event-btn click": "new-event-popup show",
      "new-event-popup close": "new-event-popup hide",
      "popup-holder activate": "page blur",
      "popup-holder deactivate": "page unblur"
    });
  };

  return MyApp;

})(Application);

window.app = new MyApp;
