/**
 * Created with JetBrains RubyMine.
 * User: omid
 * Date: 8/4/12
 * Time: 4:44 PM
 */

$(document).ready( function()
{
    $("#search").click( function()
    {
    });

    $("#query").click( function()
    {
        if (this.value == 'search' )
        {
            this.value = '';
        }
    });

    $("#query")
        .val("Search...")
        .css("color", "#ccc")
        .focus(function()
        {
            $(this).css("color", "black");
            if($(this).val() == "Search...")
            {
                $(this).val("");
            }
        })
        .blur(function()
        {
            $(this).css("color", "#ccc");
            if($(this).val() == "")
            {
                $(this).val("Search...");
            }
        });

});

