'use strict';

var subnamespace = [
    require( 'osgShader/node/skinning' ),
    require( 'osgShader/node/morph' ),
    require( 'osgShader/node/data' ),
    require( 'osgShader/node/textures' ),
    require( 'osgShader/node/functions' ),
    require( 'osgShader/node/lights' ),
    require( 'osgShader/node/operations' )
];

var lib = {};

// add all sub component to root level of the lib
subnamespace.forEach( function ( component /*, index */ ) {

    for ( var key in component ) {
        var element = component[ key ];

        if ( this[ key ] !== undefined ) { // if exist throw exception
            throw 'duplicate entry in node library';
        }

        this[ key ] = element;
    }

}, lib );

module.exports = lib;
