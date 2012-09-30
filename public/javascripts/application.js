$(function () {
//  $('#products_search input').keyup(function () {
//    $.get($('#products_search').attr('action'), $('#products_search').serialize(), null, 'script');
//      return false;
//  });
  $("#from").datepicker();
  $("#to").datepicker();
});
jQuery(document).ready(function() {

    jQuery(".get-postbox").live('click', function () {
        var obj = jQuery(this);
        jQuery.ajax({
            url:obj.attr('href'),
            type:"GET",
            data:{},
            dataType: 'json',
            beforeSend:function () {
                jQuery("#loading").show();
            },
            complete:function (data) {
                jQuery("#loading").hide();
                jQuery("#postbox").html(data.response);
            }
        });
        return false;
    });





});
