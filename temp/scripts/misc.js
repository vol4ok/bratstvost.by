(function() {
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
