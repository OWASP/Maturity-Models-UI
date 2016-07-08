module.exports = function(config) {
    config.set({
        basePath: '',
        frameworks: ['mocha'],

        files: [
            'bower_components/angular/angular.js',
            'bower_components/angular-route/angular-route.js',
            'bower_components/angular-mocks/angular-mocks.js',
            'bower_components/jquery/dist/jquery.min.js',
            'node_modules/chai/chai.js',

            '.dist/js/angular-src.js',
            '.dist/js/templates.js',
            './data/**/*.coffee',

            'test/**/*.coffee'
        ],
        exclude       : [ ],
        preprocessors : {
            'data/**/*.coffee': ['coffee'],
            'test/**/*.coffee': ['coffee'],
        },
        reporters     : ['progress'],
        port          : 9876,
        colors        : true,
        logLevel      : config.LOG_INFO,
        autoWatch     : true,
        browsers      : ['PhantomJS'],
        singleRun     : true
    })
};