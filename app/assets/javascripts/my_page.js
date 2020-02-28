$(function(){
  // var tab_a = $("#past").css(['background-color', 'color', 'cursor', 'border-top']);
  // var tab_b = $("#during-trading").css(['background-color', 'color', 'cursor', 'border-top']);

  var list_reset = {'color':'rgb(102, 100, 100)', 'background-color':'rgb(247, 250, 252)', 'font-weight':'300','pointer-events':'auto' };
  var list_add = {'color':'rgb(102, 100, 100)', 'background-color':'rgb(170, 250, 250)', 'font-weight':'900','pointer-events':'none' };
  var cards = $(".card-box").length
  var buildErorr = `<h2>登録クレジットカード情報</h2>
                    <p class="card__error-message">
                      カードが登録されていません。
                    </p>
                    <a class="card-btn" href="/cards/new">
                      カード登録する
                    </a>`

   
  // $("#past").click(function(){
  //   $("#during-trading").css(tab_a);
  //   $(this).css(tab_b);
  //   $(".during-trading-boxs").css('display','none');
  //   $(".past-boxs").css('display','block');
  // });

  // $("#during-trading").click(function(){
  //   $("#past").css(tab_a);
  //   $(this).css(tab_b);
  //   $(".past-boxs").css('display','none');
  //   $(".during-trading-boxs").css('display','block');
  // });



  $('.my_page-list').click(function(){
    $('.my_page-list').css(list_reset);
    $(this).css(list_add);
  });

  $("#a").click(function(){
    $(".main").css("display","none");
    $(" .my_page__main__item-lists").css('display','block');
  });
  
  $("#m").click(function(){
    $(".main").css("display","none");
    $(".my_page__main__logout").css('display','block');
  });

  $("#l").click(function(){
    $(".main").css("display","none");
    $(".my_page__main__credit").css('display','block');
  });
  $(".delete-btn").click(function(){
    var id = $(this).attr('id');
    cards = cards - 1;
    $(`#card-${id}`).hide();
    if(cards == 0){
      $(".my_page__main__credit").html(buildErorr)
    }
  });

  // $("#d").click(function(){
  //   $(".main").css("display","none");
  //   $(" .my_page__main__item-lists").css('display','block');
  // });
});
