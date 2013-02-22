// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree .
//= require jquery-impromptu

$(document).ready(function()
{
    $(function()
    {
        $('.datepicker').datepicker().datepicker( "option", { dateFormat: "DD, dd MM, yy" } );
        $('.datepicker').each( function(index)
        {
            $(this).datepicker( "setDate", $.datepicker.parseDate( "DD, dd MM, yy", this.defaultValue ) );
        });
    });

    $('.focused').focus();

});

function signin()
{
    cyph = do_encrypt( $( '#session_email')[0].value + '|' + $( '#session_password')[0].value );
    $( '#session_email')[0].value = '';
    $( '#session_password')[0].value = '';
    $( '#session_cyph')[0].value = cyph;
//    alert( 'SignIn:' + cyph );
    return true;
}



