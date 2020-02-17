$(function(){
  var tab_a = $("#past").css(['background-color', 'color', 'cursor', 'border-top']);
  var tab_b = $("#during-trading").css(['background-color', 'color', 'cursor', 'border-top']);

  var list_reset = {'color':'rgb(102, 100, 100))', 'background-color':'rgb(247, 250, 252)', 'font-weight':'300','pointer-events':'auto' };
  var list_add = {'color':'rgb(102, 100, 100)', 'background-color':'rgb(170, 250, 250)', 'font-weight':'900','pointer-events':'none' };

  $("#past").click(function(){
    $("#during-trading").css(tab_a);
    $(this).css(tab_b);
    $(".during-trading-boxs").css('display','none');
    $(".past-boxs").css('display','block');
  });

  $("#during-trading").click(function(){
    $("#past").css(tab_a);
    $(this).css(tab_b);
    $(".past-boxs").css('display','none');
    $(".during-trading-boxs").css('display','block');
  });



  $('.my_page-list').click(function(){
    $('.my_page-list').css(list_reset);
    $(this).css(list_add);
  });

  $("#a").click(function(){
    $(".main").css("display","none");
    $(".my_page__main__product-container").css('display','block');
  });
  
  $("#m").click(function(){
    $(".main").css("display","none");
    $(".my_page__main__logout").css('display','block');
  });
});
