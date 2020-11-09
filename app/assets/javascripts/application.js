// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery_ujs
//= require turbolinks
//= require sortable_tree/initializer
//= require_tree .

$( function(){
    $("table").tablesorter({debug: true});

    //绑定添加链接的click事件
    $('.add_name').click(function() {
        _remove_add_form();
        //给表格添加一行
        $('#tr_' + $(this).attr('parent_id')).after( "<tr class='tr_add_name'><td colspan='4'>" + "</td></tr>" );
        $('#new_calendar').appendTo('.tr_add_name td');
        //预填写表单
        $("#form_datum").val($(this).attr("datum"));
        $("#form_parent_id").val($(this).attr("parent_id"));
        return false;
    });

    //绑定编辑链接的click事件
    $('.update_name').click(function() {
        _remove_add_form();
        //给表格添加一行
        $('#tr_' + $(this).attr('id')).after( "<tr class='tr_update_name'><td colspan='4'>" + "</td></tr>" );
        $('#update_calendar').appendTo('.tr_update_name td');
        //预填写表单
        $("#form_id").val($(this).attr("id"));
        $("#form_name").val($(this).attr("name"));
        return false;
    });
    var targets = $( '[rel~=tooltip]' ),
        target  = false,
        tooltip = false,
        title   = false;

    targets.bind( 'mouseenter', function()
    {
        target  = $( this );
        tip     = target.attr( 'title' );
        tooltip = $( '<div id="tooltip"></div>' );

        if( !tip || tip == '' )
            return false;

        target.removeAttr( 'title' );
        tooltip.css( 'opacity', 0 )
            .html( tip )
            .appendTo( 'body' );

        var init_tooltip = function()
        {
            if( $( window ).width() < tooltip.outerWidth() * 1.5 )
                tooltip.css( 'max-width', $( window ).width() / 2 );
            else
                tooltip.css( 'max-width', 340 );

            var pos_left = target.offset().left + ( target.outerWidth() / 2 ) - ( tooltip.outerWidth() / 2 ),
                pos_top  = target.offset().top - tooltip.outerHeight() - 20;

            if( pos_left < 0 )
            {
                pos_left = target.offset().left + target.outerWidth() / 2 - 20;
                tooltip.addClass( 'left' );
            }
            else
                tooltip.removeClass( 'left' );

            if( pos_left + tooltip.outerWidth() > $( window ).width() )
            {
                pos_left = target.offset().left - tooltip.outerWidth() + target.outerWidth() / 2 + 20;
                tooltip.addClass( 'right' );
            }
            else
                tooltip.removeClass( 'right' );

            if( pos_top < 0 )
            {
                var pos_top  = target.offset().top + target.outerHeight();
                tooltip.addClass( 'top' );
            }
            else
                tooltip.removeClass( 'top' );

            tooltip.css( { left: pos_left, top: pos_top } )
                .animate( { top: '+=10', opacity: 1 }, 50 );
        };

        init_tooltip();
        $( window ).resize( init_tooltip );

        var remove_tooltip = function()
        {
            tooltip.animate( { top: '-=10', opacity: 0 }, 50, function()
            {
                $( this ).remove();
            });

            target.attr( 'title', tip );
        };

        target.bind( 'mouseleave', remove_tooltip );
        tooltip.bind( 'click', remove_tooltip );
    });
});

// 删除已存在的修改表单
function _remove_add_form() {
    $('#new_calendar'   ).appendTo('#form_add_name_box');
    $('#update_calendar').appendTo('#form_add_name_box');
    $("#services_table .tr_add_name"   ).remove();
    $("#services_table .tr_update_name").remove();
}
