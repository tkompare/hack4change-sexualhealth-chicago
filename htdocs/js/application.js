// Generated by CoffeeScript 1.6.2
(function() {
  var AdviceTree, Clinic, User,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  AdviceTree = (function() {
    function AdviceTree() {
      this.relevant_to_gender || (this.relevant_to_gender = ['male', 'female']);
      this.relevant_to_oritentation || (this.relevant_to_oritentation = ['gay', 'straight', 'bisexual']);
    }

    return AdviceTree;

  })();

  window.AdviceTree = AdviceTree;

  Clinic = (function() {
    function Clinic(data) {
      this.location = data.location;
      this.name = data.name;
    }

    Clinic.fetch = function() {
      return $.getJSON('https://data.cityofchicago.org/resource/ajzs-akmm.json', function(data) {
        return console.log(data);
      });
    };

    return Clinic;

  }).call(this);

  window.Clinic = Clinic;

  User = (function() {
    function User(data) {
      this.location = __bind(this.location, this);      this.age = data.age;
      this.sex = data.sex;
    }

    User.prototype.location = function(data, cb) {
      var _this = this;

      return navigator.geoLocation.getCurrentPosition(function() {
        _this.location = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };
        if (cb != null) {
          return cb(_this);
        }
      });
    };

    return User;

  })();

  window.User = User;

}).call(this);
