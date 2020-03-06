$(function(){
  $('#category-label').hover(function(){
    // カテゴリーをホバー
    $('.parent-box').show();
    // 親を表す
    $('.parent-box').hover(function(){
      // 親のホバー
      $('.parent-box').css({"background-color":"white","color":"black"});
      // 親の３つを背景、白と色を黒色にする
      $('.children-box').hide();
      // 子が隠れる
      $('.grandchildren-box').hide();
      // 孫が隠れる
      var parentId = $(this).attr('id');
      // 変数作る、thisはparent-boxの１つ、attr('id')=、thisのid（付与していた）をとってくる
      $(`#child__${parentId}`).show();
      // 子が現れる
      $(this).css({"background-color":"red","color":"white"});
      // this=hoverのうちの１つ、親の背景が赤と色を白にする
      $('.child-box').hover(function(){
        // 子にホバー
        $('.child-box').css("background-color","white");
        // この背景が白
        $('.grandchildren-box').hide();
        // 孫が隠れる
        var childId = $(this).attr('id');
        // 変数を作る、thisはhoverのうちの１つ
        $(`#grandchild__${childId}`).show();
        // 孫が現れる
        $(this).css("background-color","rgb(235, 229, 229)");
        // chile-box.hoverの１つ、子の背景が灰色
      });
    },function(){});
  },  function(){
    // 全部隠れている
    $('.parent-box').hide();
    $('.children-box').hide();
    $('.grandchildren-box').hide();
  });
});