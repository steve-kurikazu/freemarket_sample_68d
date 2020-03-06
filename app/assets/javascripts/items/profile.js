$(function(){

  var html = `<img src="" id="user-icon">`
  // htmlまたは変数を使う時バックスラッシュ。ifの上の方

  $(document).on('change',".profile-hidden",function(){
      var file =  this.files[0];
      // thisは.profile-image
      var reader = new FileReader();
      reader.readAsDataURL(file);
      // readerにurlが入る
      reader.onload = function(){
      var image = this.result;
      // thisはreader.onload、resultで読み込んだ結果を返す
      if($("#user-icon-box").length == 1){
        // idのボックスが１つある時
        $("#user-icon-box").html(html)
        // imagetagがないため、<img src="" id="user-icon">を入れる
        $("#user-icon").attr('src',`${image}`);
        // <img src="" id="user-icon">に画像を入れる
      }else{
        $(".profile-tag").attr('src',`${image}`);

      }
      $(".profile-submit").click();
      // クリックするclick()メソッド
      }
      $(".profile-submit").prop("disabled", false);
      // 連続押しても大丈夫なようにfalseにする

  });

});
