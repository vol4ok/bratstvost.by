/*!
 * Copyright (c) 2010 Caolan McMahon 
 * Copyright (c) 2012 Andrew Volkov <hello@vol4ok.net>
 */

(function(_){

  var noop = function(){};

  _.asyncEach = function (object, iterator, callback) {
    callback = callback || noop;
    var i
      , items = _.isArray(object) ? object : _.values(object)
      , len = items.length
      , completed = 0;
    if (!len) return callback();
    for (i = 0; i < len; i++) {
      iterator(items[i], function (err) {
        if (err) {
          callback(err);
          callback = noop;
        } else if (++completed === len)
          callback();
      });
    }
  };

  _.syncEach = function (object, iterator, callback) {
    callback = callback || noop;
    var iterate
      , items = _.isArray(object) ? object : _.values(object)
      , len = items.length
      , i = 0;
    (iterate = function() {
      iterator(items[i], function (err) {
        if (err) {
          callback(err);
          callback = noop;
        } else if (++i === len)
          callback();
        else 
          iterate();
      });
    })();
  };

  var asyncMap, syncMap;

  asyncMap = _.asyncMap = function (object, iterator, callback) {
    callback = callback || noop;
    var completed = 0
      , results = _.isArray(object) ? [] : {};
    if (_.isEmpty(object)) return callback(null, results)
    _.each(object, function(val, key) {
      completed++;
      iterator(val, function (err, result) {
        if (err) {
          callback(err, results);
          callback = noop
        } else {
          results[key] = result
          if (--completed === 0)
            callback(null, results);
        }
      });
    });
  };

  syncMap = _.syncMap = function (object, iterator, callback) {
    callback = callback || noop;
    var iterate, items, len
      , i = 0
      , results = _.isArray(object) ? [] : {};
    items = _.map(object, function(val, key) { 
      return {key: key, val: val} 
    });
    len = items.length;
    if (!len) return callback(null, results);
    (iterate = function() {
      iterator(items[i].val, function(err, result) {
        if (err) {
          callback(err);
          callback = noop;
        } else {
          results[items[i].key] = result
          if (++i === len)
            callback(null, results);
          else 
            iterate();
        }
          
      });
    })();
  }

  _.parallel = function (tasks, callback) {
    asyncMap(tasks, function(task, callback){
      task(function(err) {
        var args = _.slice.call(arguments, 1);
        if (args.length <= 1) args = args[0];
        callback.call(null, err, args);
      });
    }, callback);
  };

  _.series = function (tasks, callback) {
    syncMap(tasks, function(task, callback){
      task(function(err) {
        var args = _.slice.call(arguments, 1);
        if (args.length <= 1) args = args[0];
        callback.call(null, err, args);
      });
    }, callback);
  };

  _.chain = function() {

    var tasks
    , args = []
    , error = noop;
    if(arguments.length === 3) {
      args  = _.isArray(arguments[0]) ? arguments[0] : [arguments[0]];
      tasks = arguments[1];
      error = arguments[2];
    } else if(arguments.length === 2) {
      if (_.isArray(arguments[1])) {
        args  = _.isArray(arguments[0]) ? arguments[0] : [arguments[0]];
        tasks = arguments[1];
      } else {
        tasks = arguments[0];
        error = arguments[1];
      }
    } else if(arguments.length === 1) {
      args = []
      tasks = arguments[0];
      error = noop;
    } else 
      return false;

    var iterate, len
      , i = 0;

    tasks = _.map(tasks, function(task, key) { 
      return {key: key, task: task};
    });
    len = tasks.length;
    (iterate = function() {
      if (++i > len) return;
      var args = _.slice.call(arguments);
      try {
        tasks[i-1].task.apply(this, args.concat([iterate]));
      } catch(err) {
        error(err);
      }
    }).apply(this, args);
  };  

})(_);