$(function(){
    $('.date_form').on("ajax:success", function(e, data, status, xhr){
      e.preventDefault();
    $(".expense_list").html(data);
    });
});