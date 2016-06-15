module.exports = function(config) {
    config.set({
        basePath: '',
        frameworks: ['mocha'],
        //frameworks: ['jasmine'],

        files: [
            'bower_components/angular/angular.js',
            'bower_components/angular-route/angular-route.js',
            'bower_components/angular-mocks/angular-mocks.js',
            'bower_components/jquery/dist/jquery.min.js',
            'node_modules/chai/chai.js',
            '.dist/js/angular-src.js',
            '.dist/js/templates.js',

            'test/**/*.coffee'
        ],
        exclude       : [ ],
        preprocessors : {
            'test/**/*.coffee': ['coffee'],
            //'build-js/**/*.js': ['coverage']
        },
        reporters     : ['progress'],
        port          : 9876,
        colors        : true,
        logLevel      : config.LOG_INFO,  // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
        autoWatch     : true,            // enable / disable watching file and executing tests whenever any file changes
        browsers      : ['PhantomJS'],    //browsers: ['Chrome','PhantomJS'],
        singleRun     : true  // if true, Karma captures browsers, runs the tests and exits
    })
};