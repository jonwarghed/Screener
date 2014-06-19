// Generated by CoffeeScript 1.7.1
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(["knockout", "moment"], function(ko, moment) {
    var ClockViewModel;
    return ClockViewModel = (function() {
      function ClockViewModel() {
        this.updateClock = __bind(this.updateClock, this);
        this.now = ko.observable(moment());
        this.hour = ko.computed((function(_this) {
          return function() {
            return _this.now().format('HH:mm:ss');
          };
        })(this));
        this.date = ko.computed((function(_this) {
          return function() {
            return _this.now().format('dddd MMMM DD YYYY');
          };
        })(this));
        setInterval(this.updateClock, 999);
      }

      ClockViewModel.prototype.updateClock = function() {
        return this.now(moment());
      };

      return ClockViewModel;

    })();
  });

}).call(this);

//# sourceMappingURL=clock.map
