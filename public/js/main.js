(function() {
  var Application, Collection, Model, MyApp, UIButton, UIModal, UIPage, UIVideoModal, UIView, bindEvent, bindEvents, _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

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

  UIPage = (function(_super) {
    __extends(UIPage, _super);

    UIPage.registerClass(UIPage.name);

    function UIPage(options) {
      this.unblur = __bind(this.unblur, this);
      this.blur = __bind(this.blur, this);      UIPage.__super__.constructor.apply(this, arguments);
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

  UIModal = (function(_super) {
    __extends(UIModal, _super);

    UIModal.registerClass(UIModal.name);

    UIModal.prototype.events = {
      "click .x": "on_close",
      "click": "on_click",
      "click .modal": "on_modalClick"
    };

    function UIModal(options) {
      this.on_modalClick = __bind(this.on_modalClick, this);
      this.on_click = __bind(this.on_click, this);
      this.on_close = __bind(this.on_close, this);
      this.hide = __bind(this.hide, this);
      this.show = __bind(this.show, this);      UIModal.__super__.constructor.apply(this, arguments);
    }

    UIModal.prototype.show = function(callback) {
      this.$el.addClass("active");
      this.trigger("show");
      return typeof callback === "function" ? callback() : void 0;
    };

    UIModal.prototype.hide = function(callback) {
      this.$el.removeClass("active");
      this.trigger("hide");
      return typeof callback === "function" ? callback() : void 0;
    };

    UIModal.prototype.on_close = function(e) {
      return this.trigger("close");
    };

    UIModal.prototype.on_click = function() {
      return this.trigger("close");
    };

    UIModal.prototype.on_modalClick = function(e) {
      return e.stopPropagation();
    };

    return UIModal;

  })(UIView);

  UIVideoModal = (function(_super) {
    __extends(UIVideoModal, _super);

    function UIVideoModal() {
      _ref = UIVideoModal.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    UIVideoModal.registerClass(UIVideoModal.name);

    return UIVideoModal;

  })(UIModal);

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

  MyApp = (function(_super) {
    __extends(MyApp, _super);

    function MyApp(options) {
      this.on_loaded = __bind(this.on_loaded, this);
      this.on_load = __bind(this.on_load, this);      MyApp.__super__.constructor.apply(this, arguments);
      this.on("load", this.on_load);
      this.on("loaded", this.on_loaded);
    }

    MyApp.prototype.on_load = function() {
      console.log("Hello");
      this.initAutoloadObjects();
      moment.lang("ru");
      $(".event-short").click(function(e) {
        $(this).parent().find(".event-more").toggleClass("active");
        return $(this).find(".event-state").removeClass("new");
      });
      console.log("laoding fancybox");
      return $(".fb").fancybox({
        maxWidth: 800,
        maxHeight: 600,
        fitToView: false,
        width: '70%',
        height: '70%',
        autoSize: false,
        closeClick: false,
        openEffect: 'none',
        closeEffect: 'none'
      });
    };

    MyApp.prototype.on_loaded = function() {
      return bindEvents({
        "new-button click": "modal-1 show",
        "modal-1 close": "modal-1 hide",
        "modal-1 show": "page blur",
        "modal-1 hide": "page unblur"
      });
    };

    return MyApp;

  })(Application);

  window.app = new MyApp;

}).call(this);
