(function() {

  (function($) {
    return $(function() {
      prettyPrint();
      return (function() {})();
    });
  })(jQuery);

  (function() {
    return window.controller1 = function($scope) {
      $scope.users = [
        {
          name: "hisasann",
          score: 10000
        }, {
          name: "rastaman",
          score: 20000
        }, {
          name: "bar",
          score: 50000
        }, {
          name: "foo",
          score: 40000
        }, {
          name: "hoge",
          score: 30000
        }
      ];
      $scope.today = new Date;
      $scope.shops = [];
      $scope.$on('action', function(event, args) {
        $scope.showUser = args.showUser;
        return console.log(event.targetScope.showUser);
      });
      return $scope.appendUser = function() {
        if (this.shop.name) {
          return this.shops.push(this.shop);
        }
      };
    };
  })();

  (function() {
    var modal;
    modal = $('#modal');
    return window.controller2 = function($scope) {
      $scope.childName = 'controller2';
      return $scope.show = function() {
        $scope.showUser = this.user.name;
        $scope.$emit('action', {
          showUser: this.user.name
        });
        return modal.modal({
          backdrop: true
        });
      };
    };
  })();

  (function() {
    return window.controller3 = function($scope, $http, $templateCache) {
      $scope.method = 'GET';
      $scope.url = 'http://localhost/~yhisamatsu/index.json';
      $scope.name = '';
      $scope.siteUrl = '';
      return $scope.fetch = function() {
        return $http({
          method: $scope.method,
          url: $scope.url,
          cache: $templateCache
        }).success(function(data, status) {
          $scope.status = status;
          $scope.data = data;
          $scope.name = data.name;
          return $scope.siteUrl = data.url;
        }).error(function(data, status) {
          $scope.data = data || "Request failed";
          return $scope.status = status;
        });
      };
    };
  })();

  (function() {
    angular.module('controller4Module', []).factory('controller4Service', function() {
      return {
        message: 'controller4Message'
      };
    });
    window.controller4 = function($scope, controller4Service, $http) {
      return $scope.message = controller4Service.message;
    };
    return window.controller4.$inject = ['$scope', 'controller4Service'];
  })();

  (function() {
    window.controller5 = function($scope) {};
    return angular.module('controller5Module', []).directive('controller5Directive', function() {
      return function(scope, element, attrs) {
        return scope.hello = 'controller5';
      };
    });
  })();

  (function() {
    window.controller6 = function($scope) {};
    return angular.module('controller6Module', []).directive('controller6Directive', function() {
      return function(scope, element, attrs) {
        var jqElem;
        scope.hello = 'controller6';
        jqElem = angular.element(element);
        return jqElem.find('#fadeOut').bind('click', function() {
          return $(jqElem).fadeOut(attrs.duration);
        });
      };
    });
  })();

  (function() {
    window.controller7 = function($scope) {
      $scope.note = 'default note';
      return $scope.showMessage = function(kind) {
        return window.alert(kind);
      };
    };
    return angular.module('controller7Module', []).directive('controller7Directive', function() {
      return {
        template: '<p>Hello World! {{name}} {{note}}</p>' + '<p>以下を入力してからalertを押してください</p>' + '<p><input type="text" ng-model="kind"></p>' + '<p><button class="btn btn-primary" ng-click="alertMessage({kindKey: kind})">alert</button></p>',
        replace: false,
        restrict: "A",
        scope: {
          name: '@',
          note: '=',
          alertMessage: '&'
        },
        link: function(scope, element, attr) {
          scope.$watch('kind', function(newValue, oldValue) {
            return console.log(newValue, ' ', oldValue);
          });
          return setTimeout(function() {
            scope.name = 'rastaman';
            return scope.$digest();
          }, 2000);
        }
      };
    });
  })();

  angular.module('tutorial', ['controller4Module', 'controller5Module', 'controller6Module', 'controller7Module']);

}).call(this);
