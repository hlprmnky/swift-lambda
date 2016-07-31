var exec = require( 'child_process' ).exec; // provided by AWS Î runtime

var options = {
  env: {
    'LD_LIBRARY_PATH': __dirname + '/lib'
  }
};
exports.handler = function( event, context )
{
  var errorHandler = function( error )
  {
    context.done( error, 'Swift process error T_T' );
  };
  proc = exec( './request_handler', options, errorHandler );
  // simple pass-through of stdout / stderr
  proc.stdout.on( 'data', console.log );
  proc.stderr.on( 'data', console.error );
};
