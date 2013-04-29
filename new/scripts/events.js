//@ sourceMappingURL=events.map
var Application, Collection, Event, EventList, EventsEditorApp, Model, UIEventList, UIEventView, UIView, bindEvent, bindEvents, event_full2short, event_short2full, ico2name, md2html, name2ico, strip_md_rexp, _ref,
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

Model = Backbone.Model;

Collection = Backbone.Collection;

Backbone.sync = function(method, model, options) {
  var sock;

  console.log("sync", method.toUpperCase, model, options);
  sock = io.connect('http://localhost:3000');
  return sock.emit(method, model, function(err, data) {
    console.log("sync-complete", err, data);
    if (!err) {
      return options.success(data);
    } else {
      return options.error(data);
    }
  });
};

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

md2html = (function() {
  var rexp;

  rexp = /^<p>(.*)<\/p>\s*$/;
  return function(str) {
    var md;

    console.log("md2html", str);
    md = marked(str);
    if (rexp.test(md)) {
      return RegExp.$1;
    } else {
      return md;
    }
  };
})();

strip_md_rexp = /^<p>(.*)<\/p>\s*$/;

name2ico = {
  user: "user",
  time: "time",
  place: "map-marker"
};

ico2name = {
  user: "user",
  time: "time",
  "map-marker": "place"
};

event_short2full = function(short) {
  var date, full, info, key, m, val, _ref;

  full = {
    _id: short._id || _.guid(),
    title: short.title,
    desc: marked(short.desc),
    date: false,
    verified: short.verified || false,
    archived: short.archived || false,
    published: short.published || false,
    updated: new Date,
    info: []
  };
  date = short.date || "invalid date";
  if (moment(date, "DD.MM.YY HH:mm").isValid()) {
    full.date = moment(date, "DD.MM.YY HH:mm").toDate();
    full.hasTime = true;
  } else if (moment(date, "DD.MM.YY").isValid()) {
    full.date = moment(date, "DD.MM.YY").toDate();
    full.hasTime = false;
  }
  console.log(full.date);
  _ref = short.info;
  for (key in _ref) {
    val = _ref[key];
    m = /^(user|place|time)?\s*(.*)$/.exec(key.trim());
    m[1] || (m[1] = "user");
    info = {
      icon: name2ico[m[1].toLowerCase()],
      term: m[2].capitalize(),
      desc: md2html(val)
    };
    if (strip_md_rexp.test(info.desc)) {
      info.desc = RegExp.$1;
    }
    full.info.push(info);
  }
  return full;
};

event_full2short = function(full) {
  var info, short, _i, _len, _ref;

  short = {
    title: full.title,
    desc: toMarkdown(full.desc),
    info: {},
    verified: full.verified,
    published: full.published
  };
  short.date = full.hasTime ? moment(full.date).format("DD.MM.YY HH:mm") : moment(full.date).format("DD.MM.YY");
  _ref = full.info;
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    info = _ref[_i];
    short.info["" + ico2name[info.icon] + " " + info.term] = toMarkdown(info.desc);
  }
  return short;
};

Event = (function(_super) {
  __extends(Event, _super);

  Event.prototype.url = "events";

  Event.prototype.idAttribute = "_id";

  Event.prototype.parse = function(item, options) {
    return item;
  };

  function Event(data) {
    this.parse = __bind(this.parse, this);    Event.__super__.constructor.apply(this, arguments);
  }

  return Event;

})(Model);

EventList = (function(_super) {
  __extends(EventList, _super);

  function EventList() {
    this.parse = __bind(this.parse, this);    _ref = EventList.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  EventList.prototype.model = Event;

  EventList.prototype.url = "events";

  EventList.prototype.parse = function(items, options) {
    return items;
  };

  return EventList;

})(Collection);

UIEventList = (function(_super) {
  var NEW_EVENT_TEMPLATE;

  __extends(UIEventList, _super);

  UIEventList.registerClass(UIEventList.name);

  NEW_EVENT_TEMPLATE = 'title: \ndesc: \ndate: \ninfo: \n  user Организатор: \n  time Время выезда: \nverified: no\npublished: no';

  UIEventList.prototype.events = {
    "click .create-new-btn": "on_createBtnClick",
    "click .save-btn": "on_saveBtnClick",
    "click .template-btn": "on_templateBtnClick",
    "click .reset-btn": "on_resetBtnClick"
  };

  UIEventList.prototype.on_templateBtnClick = function() {
    return this.editor.setValue(NEW_EVENT_TEMPLATE);
  };

  UIEventList.prototype.on_resetBtnClick = function() {
    return this.editor.setValue("");
  };

  function UIEventList() {
    this.on_itemClick = __bind(this.on_itemClick, this);
    this.on_saveError = __bind(this.on_saveError, this);
    this.on_saveSuccess = __bind(this.on_saveSuccess, this);
    this.on_saveBtnClick = __bind(this.on_saveBtnClick, this);
    this.on_removeItem = __bind(this.on_removeItem, this);
    this.on_updateItem = __bind(this.on_updateItem, this);
    this.on_createBtnClick = __bind(this.on_createBtnClick, this);
    this._createItem = __bind(this._createItem, this);
    this._setModalTitle = __bind(this._setModalTitle, this);
    this._saveToLS = __bind(this._saveToLS, this);
    this.on_featchError = __bind(this.on_featchError, this);
    this.on_featchSuccess = __bind(this.on_featchSuccess, this);
    this.on_resetBtnClick = __bind(this.on_resetBtnClick, this);
    this.on_templateBtnClick = __bind(this.on_templateBtnClick, this);    UIEventList.__super__.constructor.apply(this, arguments);
    this.rawMode = false;
    this.items = [];
    this.currentItem = null;
    this.$itemsEl = this.$(".active-items");
    this.$archItemsEl = this.$(".archived-items");
    this.$modalEl = this.$('.editor-modal');
    this.$modalMessage = this.$(".modal-message");
    this.editor = CodeMirror.fromTextArea(this.$(".editor")[0], {
      mode: "text/x-yaml",
      tabSize: 2,
      lineWrapping: true,
      extraKeys: {
        Tab: function(cm) {
          console.log("tab");
          if (!cm.getSelection().length) {
            return cm.replaceSelection("  ", "end");
          }
        }
      }
    });
    this.collection = new EventList;
    this.collection.fetch({
      success: this.on_featchSuccess,
      error: this.on_featchError
    });
  }

  UIEventList.prototype.on_featchSuccess = function(self, data) {
    console.log("on_featchSuccess", this.collection.models);
    return this.collection.each(this._createItem);
  };

  UIEventList.prototype.on_featchError = function() {
    return console.log("featch error");
  };

  UIEventList.prototype._saveToLS = function() {
    return localStorage["autosave"] = this.editor.getValue();
  };

  UIEventList.prototype._setModalTitle = function(title) {
    var _ref1;

    if ((_ref1 = this.$modalTitleEl) == null) {
      this.$modalTitleEl = this.$('.modal-title');
    }
    return this.$modalTitleEl.text(title);
  };

  UIEventList.prototype._createItem = function(model) {
    var item;

    item = new UIEventView({
      model: model
    });
    this.$itemsEl.append(item.render());
    item.on("dblclick", this.on_updateItem);
    item.on("update", this.on_updateItem);
    item.on("remove", this.on_removeItem);
    item.on("publish", this.on_publishItem);
    item.on("unpublish", this.on_unpublishItem);
    this.items[model.id] = item;
    return item;
  };

  UIEventList.prototype.createEvent = function() {};

  UIEventList.prototype.updateEvent = function() {};

  UIEventList.prototype.removeEvent = function(item) {};

  UIEventList.prototype.on_publishItem = function(item) {
    item.model.save({
      published: true
    }, {
      success: this.on_saveSuccess,
      error: this.on_saveError
    });
    return item.render();
  };

  UIEventList.prototype.on_unpublishItem = function(item) {
    item.model.save({
      published: false
    }, {
      success: this.on_saveSuccess,
      error: this.on_saveError
    });
    return item.render();
  };

  UIEventList.prototype.on_createBtnClick = function(e) {
    this._setModalTitle("Create event");
    this.currentItem = null;
    this.editor.setValue(localStorage["autosave"] || NEW_EVENT_TEMPLATE);
    return this.$modalEl.modal('show');
  };

  UIEventList.prototype.on_updateItem = function(item) {
    this._setModalTitle("Update event");
    this.currentItem = item;
    this.editor.setValue(jsyaml.dump(event_full2short(item.model.attributes)));
    this.$modalEl.modal('show');
    return this.editor.refresh();
  };

  UIEventList.prototype.on_removeItem = function(item) {
    console.log(item);
    item.$el.remove();
    return item.model.destroy();
  };

  UIEventList.prototype.on_saveBtnClick = function(e) {
    var ev, obj, val;

    try {
      val = this.editor.getValue();
      obj = this.rawMode ? JSON.parse(val) : event_short2full(jsyaml.load(val));
      if (this.currentItem) {
        delete obj._id;
        this.currentItem.model.save(obj, {
          success: this.on_saveSuccess,
          error: this.on_saveError
        });
        this.currentItem.render();
        return this.$modalEl.modal('hide');
      } else {
        ev = new Event(obj);
        this.currentItem = this._createItem(ev);
        ev.save({}, {
          success: this.on_saveSuccess,
          error: this.on_saveError
        });
        return this.$modalEl.modal('hide');
      }
    } catch (_error) {
      e = _error;
      return this.$modalMessage.text(e).css({
        color: "red"
      });
    }
  };

  UIEventList.prototype.on_saveSuccess = function(model, resp, options) {
    return console.log("save success", model, resp, options);
  };

  UIEventList.prototype.on_saveError = function() {
    return console.log("save error");
  };

  UIEventList.prototype.on_itemClick = function(item) {
    this.selected = item;
    this.trigger("item-select", item);
    return this.editor.setValue(jsyaml.dump(event_full2short(item.model.data)));
  };

  return UIEventList;

})(UIView);

UIEventView = (function(_super) {
  __extends(UIEventView, _super);

  UIEventView.registerClass(UIEventView.name);

  UIEventView.prototype.tagName = "tr";

  UIEventView.prototype.events = {
    "dblclick": "on_dblclick",
    "click .edit-btn": "on_editBtnClick",
    "click .remove-btn": "on_removeBtnClick",
    "click .publish-btn": "on_publishBtnClick"
  };

  UIEventView.prototype.template = "UIEventView-template";

  function UIEventView() {
    this.on_publishBtnClick = __bind(this.on_publishBtnClick, this);
    this.on_removeBtnClick = __bind(this.on_removeBtnClick, this);
    this.on_editBtnClick = __bind(this.on_editBtnClick, this);
    this.on_dblclick = __bind(this.on_dblclick, this);
    this.render = __bind(this.render, this);    UIEventView.__super__.constructor.apply(this, arguments);
    if (_.isString(this.template)) {
      this.template = _.template($("#" + this.template).html());
    }
  }

  UIEventView.prototype.render = function() {
    var args, mdate, tpl;

    mdate = moment(this.model.get("date")).lang('en');
    args = {
      title: this.model.get("title"),
      published: this.model.get("published"),
      date: this.model.get("hasTime") ? "" + (mdate.format("D MMMM")) + ", <b>" + (mdate.format("HH:mm")) + "</b>" : mdate.format("D MMMM")
    };
    tpl = this.template(args);
    this.$el.html(tpl);
    this.$el.attr("id", this.model.id);
    return this.$el;
  };

  UIEventView.prototype.on_dblclick = function(e) {
    return this.trigger("dblclick", this);
  };

  UIEventView.prototype.on_editBtnClick = function() {
    return this.trigger("update", this);
  };

  UIEventView.prototype.on_removeBtnClick = function() {
    return this.trigger("remove", this);
  };

  UIEventView.prototype.on_publishBtnClick = function(e) {
    if (this.$(".publish-btn").hasClass("active")) {
      return this.trigger("unpublish", this);
    } else {
      return this.trigger("publish", this);
    }
  };

  return UIEventView;

})(UIView);

EventsEditorApp = (function(_super) {
  __extends(EventsEditorApp, _super);

  function EventsEditorApp(options) {
    this.on_loaded = __bind(this.on_loaded, this);
    this.on_load = __bind(this.on_load, this);    EventsEditorApp.__super__.constructor.apply(this, arguments);
    this.on("load", this.on_load);
    this.on("loaded", this.on_loaded);
  }

  EventsEditorApp.prototype.on_load = function() {
    console.log("Hello");
    this.initAutoloadObjects();
    return $('#pages a').click(function(e) {
      e.preventDefault();
      return $(this).tab('show');
    });
  };

  EventsEditorApp.prototype.on_loaded = function() {};

  return EventsEditorApp;

})(Application);

window.app = new EventsEditorApp;
