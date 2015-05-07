# Karma configuration
# Generated on Thu Apr 16 2015 03:54:44 GMT+0300 (EEST)

module.exports = (config) ->
  config.set
    #base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: ''
    # frameworks to use
    # available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: ['jasmine']


    #list of files / patterns to load in the browser
    files: [
        "bower_components/threejs/build/three.js"
        "bower_components/lodash/lodash.js"
        "bower_components/angularjs/angular.js"
        "bower_components/angular-route/angular-route.js"
        "bower_components/angular-cookies/angular-cookies.js"
        "js/libs/angular-mocks.js"
        "app/client/app.coffee"
        "app/client/units/unit.coffee"
        "app/client/units/tree.coffee"
        "app/client/units/forest.coffee"
        "app/client/services/sector.coffee"
        "app/client/services/basicSectorSpawner.coffee"
        "app/client/services/sectorsManager.coffee"
        "specs/sector.coffee"
        "specs/sectorsManager.coffee"
    ]


    #list of files to exclude
    exclude: []


    # preprocess matching files before serving them to the browser
    # available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors:
      '**/*.coffee': ['coffee']

    coffeePreprocessor:
      #// options passed to the coffee compiler
      options: 
        bare: true
        sourceMap: false
      #// transforming the filenames
      transformPath: (path) ->
        return path.replace(/\.coffee$/, '.js')

    # test results reporter to use
    # possible values: 'dots', 'progress'
    # available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['progress']


    # web server port
    port: 9876


    #enable / disable colors in the output (reporters and logs)
    colors: true


    # level of logging
    # possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO


    #enable / disable watching file and executing tests whenever any file changes
    autoWatch: true


    # // start these browsers
    # // available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: ['Chrome']


    # // Continuous Integration mode
    # // if true, Karma captures browsers, runs the tests and exits
    singleRun: false
