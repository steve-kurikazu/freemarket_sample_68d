$(function(){

  var array = []
  //プレビューのhtmlを定義
  function buildHTML(count) {
    var html = `<div class="preview-box" id="preview-box__${count}">
                  <div class="upper-box">
                    <img src="" alt="preview">
                  </div>
                  <div class="lower-box">
                    <div class="delete-box" id="delete_btn_${count}">
                      <span>削除</span>
                    </div>
                  </div>
                </div>`
    return html;
  }

  var count = $('.preview-box').length;
  if (count == 5) { 
    $('.label-content').hide();
  }
  $('.label-box').attr({id: `label-box--${count}`,for: `item_images_attributes_${count}_photo`})
  
  // ラベルのwidth操作
  function setLabel() {
    //プレビューボックスのwidthを取得し、maxから引くことでラベルのwidthを決定
    var prevContent = $('.label-content').prev();
    labelWidth = $(prevContent).css('width').replace(/[^0-9]/g, '');
  }

  // プレビューの追加
  $(document).on('change', '.hidden-field', function() {
    setLabel();
    //hidden-fieldのidの数値のみ取得
     var id = $(this).attr('id').replace(/[^0-9]/g, '');
    //labelボックスのidとforを更新
      $('.label-box').attr({id: `label-box--${id}`,for: `item_images_attributes_${id}_photo`});
    //選択したfileのオブジェクトを取得
    var file = this.files[0];
    var reader = new FileReader();
    //readAsDataURLで指定したFileオブジェクトを読み込む
    reader.readAsDataURL(file);
    //読み込み時に発火するイベント
    reader.onload = function() {
      var image = this.result;
      //プレビューが元々なかった場合はhtmlを追加
      if ($(`#preview-box__${id}`).length == 0) {
        var count = $('.preview-box').length;
        var html = buildHTML(id);
        //ラベルの直前のプレビュー群にプレビューを追加
        var prevContent = $('.label-content').prev();
        $(prevContent).append(html);
      }
      //イメージを追加
      $(`#preview-box__${id} img`).attr('src', `${image}`);
      var count = $('.preview-box').length;
      //プレビューが5個あったらラベルを隠す 
      if (count == 5) { 
        $('.label-content').hide();
      }
      //ラベルのidとforの値を変更
      if(count < 5){
        //プレビューの数でラベルのオプションを更新する
        $('.label-box').attr({id: `label-box--${count}`,for: `item_images_attributes_${count}_photo`});
      }
      if (array.length >= 1) {
        array.shift(id);
      }
      $(".image-error").hide();
    }
  });

  // 画像の削除
  $(document).on('click', '.delete-box', function() {
    
    var count = $('.preview-box').length;
    setLabel(count);
    //item_images_attributes_${id}_image から${id}に入った数字のみを抽出
    var id = $(this).attr('id').replace(/[^0-9]/g, '');
    //取得したidに該当するプレビューを削除
    $(`#preview-box__${id}`).remove();
    //フォームの中身を削除 
    
    $(`#item_images_attributes_${id}_photo`).val("");

    //削除時のラベル操作
    var count = $('.preview-box').length;
    //5個めが消されたらラベルを表示
    if (count == 4) {
      $('.label-content').show();
    }
    
    array.push(id);
    setLabel(count);

    if(id < 5){
      //削除された際に、空っぽになったfile_fieldをもう一度入力可能にする
      var num = Math.min.apply(null, array.map(Number));
      $('.label-box').attr({id: `label-box--${num}`,for: `item_images_attributes_${num}_photo`});
    }
  });

  
  $(".new-product__form").on('submit',function(){
    var count = $('.preview-box').length;
    if ( count == 0) {
      $(".image-error").css('display','block');
      $('html, body').scrollTop(100);
      return  false;
    }
  }); 
  
});