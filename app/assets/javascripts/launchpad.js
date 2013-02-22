
$(document).ready(function()
{
//    $.prompt( txt,
//        { callback: alert,
////            buttons: { 'Roll Out': true, Cancel: false },
//            opacity: 0.7
//        });

//    $('#launchpad').corner('20px');
//    // $('#launchpad').corner('10px');
//    $("#menu").jSlickmenu({
//        speed : 120,
//        fadeopacity : 0.1,
//        infomargin : 10,
//        leftmargin : 80,
//        css3rotate : false,
//        css3shadow : '#999 5px 10px 10px',
//        css3borderradius : 11,
//        borderneutral : 2,
//        borderhover : 3,
//        aligntop : true,
//        centercontent: true
//    });
});


function launchpad()
{
//    $('#launchpad').fadeToggle( 300 );

    $.prompt( appList,
    {
      callback: clear,
      opacity: 0.87,
      persistent: false,
      prefix: 'lp'
    });

    /*
    $( '#launchpadDlg' ).html(appList).dialog({
        modal: true,
        draggable: false,
        width: '100%',
        resizable: false,
        dialogClass: 'launchpad',
        position: { my: "center", at: "center", of: window },
        buttons: {
            Close: function() {
                $( this ).dialog( "close" );
            }
        }
    }).siblings('.ui-dialog-titlebar').remove();
    */

    $('#launchpad').corner('20px');
    // $('#launchpad').corner('10px');
    $("#menu").jSlickmenu({
        speed : 120,
        fadeopacity : 0.1,
        infomargin : 10,
        leftmargin : 80,
        css3rotate : false,
        css3shadow : '#999 5px 10px 10px',
        css3borderradius : 11,
        borderneutral : 2,
        borderhover : 3,
        aligntop : true,
        centercontent: true
    });

//    $('#launchpad').toggle( function(){
//        $('#launchpad').animate( { height: '100%' }, "slow" );
//        $('#launchpad').animate( { width: '100%' }, "slow" );
//    }, function(){
//        $('#launchpad').animate( { height: 0 }, "slow" );
//        $('#launchpad').animate( { width: 0 }, "slow" );
//    });
}

function clear( a, b, c, d )
{
    $('#jqibox').remove();
}

