$(function () {
  $('#products_search input').keyup(function () {
    $.get($('#products_search').attr('action'), $('#products_search').serialize(), null, 'script');
      return false;
  });
});