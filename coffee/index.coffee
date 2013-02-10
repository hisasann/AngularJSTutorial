(($) ->
  $ ->
    prettyPrint()

    do () ->

) jQuery

do () ->
  # Angular controller
  window.controller1 = ($scope) ->
    $scope.users = [
      name: "hisasann"
      score: 10000
    ,
      name: "rastaman"
      score: 20000
    ,
      name: "bar"
      score: 50000
    ,
      name: "foo"
      score: 40000
    ,
      name: "hoge"
      score: 30000
    ]

    $scope.today = new Date

    $scope.shops = []

    $scope.$on 'action', (event, args) ->
      $scope.showUser = args.showUser
      console.log event.targetScope.showUser

    $scope.appendUser = () ->
      if this.shop.name
        this.shops.push this.shop

do () ->
  modal = $('#modal')

  window.controller2 = ($scope) ->
    $scope.childName = 'controller2'

    $scope.show = () ->
      $scope.showUser = this.user.name
      $scope.$emit 'action', showUser: this.user.name
      modal.modal({backdrop: true})

do () ->
  window.controller3 = ($scope, $http, $templateCache) ->
    $scope.method = 'GET'
    $scope.url = 'http://localhost/~yhisamatsu/index.json'

    $scope.name = ''
    $scope.siteUrl = ''

    $scope.fetch = () ->
      $http(
        method: $scope.method
        url: $scope.url
        cache: $templateCache # or false
      ).success((data, status) ->
        $scope.status = status
        $scope.data = data

        $scope.name = data.name
        $scope.siteUrl = data.url
      ).error (data, status) ->
        $scope.data = data || "Request failed"
        $scope.status = status

do () ->
  angular.module('controller4Module', []).factory('controller4Service', () ->
    message: 'controller4Message'
  )

  window.controller4 = ($scope, controller4Service, $http) ->
    $scope.message = controller4Service.message;

  window.controller4.$inject = ['$scope', 'controller4Service']

do () ->
  window.controller5 = ($scope) ->

  angular.module('controller5Module', [])
    .directive('controller5Directive', () ->
      (scope, element, attrs) ->
        scope.hello = 'controller5'
    )

do () ->
  window.controller6 = ($scope) ->

  angular.module('controller6Module', [])
    .directive('controller6Directive', () ->
      (scope, element, attrs) ->
        scope.hello = 'controller6'

        jqElem = angular.element(element)
        jqElem.find('#fadeOut').bind('click', () ->
          $(jqElem).fadeOut attrs.duration
        )
    )

do () ->
  window.controller7 = ($scope) ->
    $scope.note = 'default note'

    $scope.showMessage = (kind) ->
      window.alert kind

  angular.module('controller7Module', [])
    .directive('controller7Directive', () ->
      template: '<p>Hello World! {{name}} {{note}}</p>' +
                '<p>以下を入力してからalertを押してください</p>' +
                '<p><input type="text" ng-model="kind"></p>' +
                '<p><button class="btn btn-primary" ng-click="alertMessage({kindKey: kind})">alert</button></p>'   # or templateUrl: ""
      replace: false
      #      E - Element name: <my-directive></my-directive>
      #      A - Attribute: <div my-directive="exp"> </div>
      #      C - Class: <div class="my-directive: exp;"></div>
      #      M - Comment: <!-- directive: my-directive exp -->
      restrict: "A"
      scope: # use "@", "=", or "&"
        name: '@'   # bind attribute
        note: '='   # parent scope
        alertMessage: '&'   # Expression
      link: (scope, element, attr) ->
        scope.$watch(
          'kind'
          (newValue, oldValue) ->
            console.log newValue, ' ', oldValue
        )

        setTimeout(->
            scope.name = 'rastaman'
            scope.$digest()   # fire all the watches
          , 2000)
    )

# directiveのscopeはdirectiveをまたいで共有される
angular.module('tutorial', ['controller4Module', 'controller5Module', 'controller6Module', 'controller7Module'])
