$(function(){

  function buildHTML(url) {
    var html = `<img src="${url}">`
    return html;
  };

  $(".image_b").click(function(){
    var src = $(this).children('img').attr('src');
    var html = buildHTML(src);
    $(".first_image").html(html);
  })
});