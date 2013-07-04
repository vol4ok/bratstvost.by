(function() {
  var Application, Collection, Model, MyApp, UIModal, UINewsList, UIPage, UIPictureModal, UIPictureNewsView, UITextNewsView, UIVideoModal, UIVideoNewsView, UIView, _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

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

    Application.prototype.bindEvent = function(src, trg) {
      var $$, event, method, srcObj, t, trgObj, _ref, _ref1;

      $$ = Backbone.getObjectByName;
      _ref = (t = src.split(' ')).length === 1 ? [this, t[0]] : [$$(t[0]), t[1]], srcObj = _ref[0], event = _ref[1];
      _ref1 = (t = trg.split(' ')).length === 1 ? [this, t[0]] : [$$(t[0]), t[1]], trgObj = _ref1[0], method = _ref1[1];
      return srcObj.on(event, trgObj[method]);
    };

    Application.prototype.bindEvents = function(events) {
      var src, trg, _results;

      if (!events) {
        return;
      }
      _results = [];
      for (src in events) {
        trg = events[src];
        _results.push(this.bindEvent(src, trg));
      }
      return _results;
    };

    function Application() {
      this.__on_laoded = __bind(this.__on_laoded, this);
      this.__on_load = __bind(this.__on_load, this);
      this.initAutoloadObjects = __bind(this.initAutoloadObjects, this);
      this.bindEvents = __bind(this.bindEvents, this);
      this.bindEvent = __bind(this.bindEvent, this);
      var _ref;

      if ((_ref = this.cid) == null) {
        this.cid = "app";
      }
      Application.__super__.constructor.apply(this, arguments);
      Backbone.registerObject(this.cid, this);
      window.$trigger = _.bind(this.trigger, this);
      this.load = false;
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
        el.removeAttribute("data-class");
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
      "click .modal-view": "on_modalClick"
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
      $trigger("modal-show", this);
      return typeof callback === "function" ? callback() : void 0;
    };

    UIModal.prototype.hide = function(callback) {
      this.$el.removeClass("active");
      this.trigger("hide");
      $trigger("modal-hide", this);
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

  UIVideoNewsView = (function(_super) {
    __extends(UIVideoNewsView, _super);

    UIVideoNewsView.registerClass(UIVideoNewsView.name);

    UIVideoNewsView.prototype.events = {
      "click": "on_click"
    };

    function UIVideoNewsView() {
      this.on_click = __bind(this.on_click, this);      UIVideoNewsView.__super__.constructor.apply(this, arguments);
      this.videoId = this.model.video.id;
    }

    UIVideoNewsView.prototype.on_click = function() {
      return this.trigger("show-video", this);
    };

    return UIVideoNewsView;

  })(UIView);

  UITextNewsView = (function(_super) {
    __extends(UITextNewsView, _super);

    function UITextNewsView() {
      _ref = UITextNewsView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    UITextNewsView.registerClass(UITextNewsView.name);

    return UITextNewsView;

  })(UIView);

  UIPictureNewsView = (function(_super) {
    __extends(UIPictureNewsView, _super);

    UIPictureNewsView.registerClass(UIPictureNewsView.name);

    UIPictureNewsView.prototype.events = {
      "click": "on_click"
    };

    function UIPictureNewsView() {
      this.on_click = __bind(this.on_click, this);      UIPictureNewsView.__super__.constructor.apply(this, arguments);
    }

    UIPictureNewsView.prototype.on_click = function() {
      return this.trigger("show-picture", this);
    };

    return UIPictureNewsView;

  })(UIView);

  UINewsList = (function(_super) {
    __extends(UINewsList, _super);

    UINewsList.registerClass(UINewsList.name);

    function UINewsList() {
      UINewsList.__super__.constructor.apply(this, arguments);
      this.items = {};
      this._initNews();
    }

    UINewsList.prototype._initNews = function() {
      var $el, el, klass, model, nv, _i, _len, _ref1, _results,
        _this = this;

      _ref1 = this.$el.children();
      _results = [];
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        el = _ref1[_i];
        $el = $(el);
        klass = $el.data("class");
        if (!klass) {
          continue;
        }
        model = null;
        if ($el.data("model")) {
          model = JSON.parse(Base64.decode($el.data("model")));
          el.removeAttribute("data-model");
          $el.removeData('model');
        }
        el.removeAttribute("data-class");
        $el.removeData('class');
        nv = new (Backbone.getClassByName(klass))({
          el: el,
          model: model
        });
        nv.on("show-video", function(view) {
          return _this.trigger("show-video", view);
        });
        nv.on("show-picture", function(view) {
          return _this.trigger("show-picture", view);
        });
        _results.push(this.items[nv.id] = nv);
      }
      return _results;
    };

    return UINewsList;

  })(UIView);

  UIVideoModal = (function(_super) {
    __extends(UIVideoModal, _super);

    UIVideoModal.registerClass(UIVideoModal.name);

    UIVideoModal.prototype.template = "#picture-video-template";

    function UIVideoModal() {
      this.on_close = __bind(this.on_close, this);
      this.show = __bind(this.show, this);      UIVideoModal.__super__.constructor.apply(this, arguments);
      this.template = _.template(this.$(this.template).text());
      this.on("close", this.on_close);
    }

    UIVideoModal.prototype.show = function(view) {
      if (this.currentId !== view.model._id) {
        this.$el.empty().html(this.template(view.model));
        this.currentId = view.model._id;
      }
      return UIVideoModal.__super__.show.apply(this, arguments);
    };

    UIVideoModal.prototype.on_close = function() {
      return this.hide();
    };

    return UIVideoModal;

  })(UIModal);

  UIPictureModal = (function(_super) {
    __extends(UIPictureModal, _super);

    UIPictureModal.registerClass(UIPictureModal.name);

    UIPictureModal.prototype.template = "#picture-modal-template";

    function UIPictureModal() {
      this.on_close = __bind(this.on_close, this);
      this.show = __bind(this.show, this);      UIPictureModal.__super__.constructor.apply(this, arguments);
      this.template = _.template(this.$(this.template).text());
      this.on("close", this.on_close);
    }

    UIPictureModal.prototype.show = function(view) {
      if (this.currentId !== view.model._id) {
        this.$el.empty().html(this.template(view.model));
        this.$('#slider').flexslider({
          animation: "slide",
          controlNav: false,
          slideshow: false
        });
        this.currentId = view.model._id;
      }
      return UIPictureModal.__super__.show.apply(this, arguments);
    };

    UIPictureModal.prototype.on_close = function() {
      return this.hide();
    };

    return UIPictureModal;

  })(UIModal);

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
      return $(".event-short").click(function(e) {
        $(this).parent().find(".event-more").toggleClass("active");
        return $(this).find(".event-state").removeClass("new");
      });
    };

    MyApp.prototype.on_loaded = function() {
      return this.bindEvents({
        "news-list show-video": "video-modal show",
        "news-list show-picture": "picture-modal show",
        "modal-show": "page blur",
        "modal-hide": "page unblur"
      });
    };

    return MyApp;

  })(Application);

  window.app = new MyApp;

}).call(this);
