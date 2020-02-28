$(function() {
 $('.order_form').on('submit', function(){
   if($('.order-error').length >= 1){
    return false ;
   };
 });
});