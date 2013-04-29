//@ sourceMappingURL=create.map
var Application, Collection, Event, EventList, EventsEditorApp, Model, UIEventList, UIEventView, UIView, bindEvent, bindEvents, event_full2short, event_short2full, md2html, _ref,
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
  return this.substr(0, 1).toUpperCase() + this.substr(1);
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

event_short2full = function(short) {
  var date, full, info, key, m, val, _ref;

  full = {
    _id: short._id || _.guid(),
    title: short.title,
    desc: md2html(short.desc),
    date: false,
    verified: short.verified || false,
    archived: short.archived || false,
    updated: new Date,
    info: []
  };
  date = short.date || "invalid date";
  full.date = moment(date).isValid() ? moment(date).toDate() : moment(date, "DD.MM.YY").isValid() ? moment(date, "DD.MM.YY").toDate() : moment(date, "DD.MM.YYYY").isValid() ? moment(date, "DD.MM.YYYY").toDate() : void 0;
  _ref = short.info;
  for (key in _ref) {
    val = _ref[key];
    m = /^(user|place|time)?\s*(.*)$/.exec(key.trim());
    m[1] || (m[1] = "user");
    info = {
      icon: m[1].toLowerCase(),
      term: m[2].capitalize(),
      desc: md2html(val)
    };
    full.info.push(info);
  }
  return full;
};

event_full2short = function(full) {
  var info, short, _i, _len, _ref;

  short = {
    title: full.title,
    desc: toMarkdown(full.desc),
    date: moment(full.date).format("DD.MM.YY"),
    info: {},
    verified: full.verified
  };
  _ref = full.info;
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    info = _ref[_i];
    short.info["" + info.icon + " " + info.term] = toMarkdown(info.desc);
  }
  return short;
};

Event = (function(_super) {
  __extends(Event, _super);

  Event.prototype.url = "events";

  Event.prototype.idAttribute = "_id";

  function Event(data) {
    var date, info, key, m, val, _ref;

    Event.__super__.constructor.apply(this, arguments);
    console.log("constructor", data);
    if (data._id) {
      this.data = data;
    } else {
      this.data = {
        _id: _.guid(),
        title: data.title,
        desc: md2html(data.desc),
        verified: data.verified || false,
        archived: data.archived || false,
        updated: new Date,
        info: []
      };
      date = data.date || "invalid date";
      this.data.date = moment(date).isValid() ? moment(date).toDate() : moment(date, "DD.MM.YY").isValid() ? moment(date, "DD.MM.YY").toDate() : moment(date, "DD.MM.YYYY").isValid() ? moment(date, "DD.MM.YYYY").toDate() : void 0;
      _ref = data.info;
      for (key in _ref) {
        val = _ref[key];
        m = /^(user|place|time)?\s*(.*)$/.exec(key.trim());
        m[1] || (m[1] = "user");
        info = {
          icon: m[1].toLowerCase(),
          term: m[2].capitalize(),
          desc: md2html(val)
        };
        this.data.info.push(info);
      }
    }
    this.attributes = this.data;
    console.log(this.data);
  }

  Event.prototype.uniqName = function() {
    var name;

    name = this.data.title.translit();
    name += this.data.date ? "-" + moment(this.data.date).format("DD.MM.YY") : "_" + moment(this.data.updated).format("DD.MM.YY");
    return name;
  };

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

  EventList.prototype.parse = function(data, options) {
    console.log("parse", arguments);
    return data;
  };

  return EventList;

})(Collection);

UIEventList = (function(_super) {
  __extends(UIEventList, _super);

  UIEventList.registerClass(UIEventList.name);

  UIEventList.prototype.events = {
    "click .create-new-btn": "on_createNewBtnClick",
    "click .save-btn": "on_saveBtnClick"
  };

  function UIEventList() {
    this.on_featchError = __bind(this.on_featchError, this);
    this.on_featchSuccess = __bind(this.on_featchSuccess, this);
    this.on_itemClick = __bind(this.on_itemClick, this);
    this.on_saveBtnClick = __bind(this.on_saveBtnClick, this);
    this.on_createNewBtnClick = __bind(this.on_createNewBtnClick, this);
    this._saveToLS = __bind(this._saveToLS, this);
    var _this = this;

    UIEventList.__super__.constructor.apply(this, arguments);
    this.editor = CodeMirror.fromTextArea(this.$(".editor")[0], {
      mode: "text/x-yaml",
      theme: "monokai",
      tabSize: 2,
      lineWrapping: true,
      extraKeys: {
        Tab: function(cm) {
          console.log("tab");
          if (!cm.getSelection().length) {
            return cm.replaceSelection("  ", "end");
          }
        },
        "Cmd-S": function(cm) {
          return _this._saveToLS();
        }
      }
    });
    this.editor.setValue(localStorage["autosave"] || "");
    this.items = [];
    this.itemsEl = this.$(".items");
    this.itemsEl.empty();
    this.collection = new EventList;
    this.collection.fetch({
      success: this.on_featchSuccess,
      error: this.on_featchError
    });
  }

  UIEventList.prototype._saveToLS = function() {
    return localStorage["autosave"] = this.editor.getValue();
  };

  UIEventList.prototype.on_createNewBtnClick = function(e) {
    console.log("on_createNewBtnClick");
    this.trigger("create-new");
    return this.editor.setValue('title: \ndesc: \ndate: \ninfo: \n  user Организатор: \n  time Время выезда: \nverified: false');
  };

  UIEventList.prototype.on_saveBtnClick = function(e) {
    var ev, item, obj, yaml;

    yaml = this.editor.getValue();
    obj = {};
    try {
      obj = jsyaml.load(yaml);
      this.trigger("save", obj);
      console.log(ev = new Event(obj));
      this.editor.setValue(jsyaml.dump(event_full2short(ev.data)));
      console.log(JSON.stringify(ev.data));
      ev.save();
      item = new UIEventView({
        model: ev
      });
      this.itemsEl.append(item.render());
      item.on("click", this.on_itemClick);
      return this.items.push(item);
    } catch (_error) {
      e = _error;
      return this.$(".message").text(e).css({
        color: "red"
      });
    }
  };

  UIEventList.prototype.on_itemClick = function(item) {
    this.selected = item;
    this.trigger("item-select", item);
    return this.editor.setValue(jsyaml.dump(event_full2short(item.model.data)));
  };

  UIEventList.prototype.on_featchSuccess = function(self, data) {
    var _this = this;

    console.log("on_featchSuccess", this.collection.models);
    return this.collection.each(function(model) {
      var item;

      item = new UIEventView({
        model: model
      });
      _this.itemsEl.append(item.render());
      item.on("click", _this.on_itemClick);
      return _this.items.push(item);
    });
  };

  UIEventList.prototype.on_featchError = function() {
    return console.log("featch error");
  };

  return UIEventList;

})(UIView);

UIEventView = (function(_super) {
  __extends(UIEventView, _super);

  UIEventView.registerClass(UIEventView.name);

  UIEventView.prototype.tagName = "tr";

  UIEventView.prototype.template = '<td><%= name %></td>\n<td><%= title %></td>\n<td><%= date %></td>\n<td><%- desc %></td>';

  UIEventView.prototype.events = {
    "click": "on_click"
  };

  function UIEventView() {
    this.on_click = __bind(this.on_click, this);
    this.render = __bind(this.render, this);    UIEventView.__super__.constructor.apply(this, arguments);
  }

  UIEventView.prototype.render = function() {
    var args, tpl;

    args = {
      name: this.model.uniqName(),
      title: this.model.get("title"),
      date: moment(this.model.get("date")).format("DD.MM.YY"),
      desc: md2html(this.model.get("desc"))
    };
    tpl = _.template(this.template, args);
    this.$el.html(tpl);
    return this.$el;
  };

  UIEventView.prototype.on_click = function(e) {
    return this.trigger("click", this);
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
    return this.initAutoloadObjects();
  };

  EventsEditorApp.prototype.on_loaded = function() {};

  return EventsEditorApp;

})(Application);

window.app = new EventsEditorApp;
