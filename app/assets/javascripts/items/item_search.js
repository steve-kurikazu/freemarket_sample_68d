$(function(){
  // 価格設定の自動入力
  $('#price').change(function(){
    let price_range = $('#price option:selected').val();
    let price_split = price_range.split('-');
    $('#q_price_gteq').val(price_split[0]);
    $('#q_price_lteq').val(price_split[1]);
  })
  // チェックボックスの全選択、全消去（商品の状態）
  $('#condition_btn_all').change(function(){
    if($(this).prop('checked')) {
      $('input[name="q[condition_eq_any][]"]').prop('checked', true);
    } else {
      $('input[name="q[condition_eq_any][]"]').prop('checked', false);
    }
  })
  // チェックボックスの全選択、全消去（配送料の負担）
  $('#delivery_btn_all').change(function(){
    if($(this).prop('checked')) {
      $('input[name="q[delivery_fee_eq_any][]"]').prop('checked', true);
    } else {
      $('input[name="q[delivery_fee_eq_any][]"]').prop('checked', false);
    }
  })
  // チェックボックスの全選択、全消去（販売状況）
  $('#status_btn_all').change(function(){
    if($(this).prop('checked')) {
      $('input[name="q[status_eq_any][]"]').prop('checked', true);
    } else {
      $('input[name="q[status_eq_any][]"]').prop('checked', false);
    }
  })
  // 入力フォーム、チェックボックスの全消去
  $('#form_btn__search--clear').on('click',function(e){
    e.preventDefault();
    $('input[type="search"]').val("");
    $('#search_parent_category').val("");
    $('#childen_wrapper').remove();
    $('#grandchilden_wrapper').remove();
    $('#price').val("");
    $('input[type="number"]').val("");
    $('input[type="checkbox"]').prop('checked', false);
  })
});

$(function(){
  // カテゴリーセレクトボックスのオプションを作成
  function appendOption(category){
    var html = '';
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  // カテゴリーチェックボックスのオプションを作成
  function appendCheckBox(category){
  var html = '';
  html = `<label class='form_group__check_box__form' for="${category.id}">
            <input type="checkbox" name="q[category_id_eq_any][]" value="${category.id}" class="search_grandchild_category" for="${category.id}"></input>
            <span>${category.name}</span>
          </label>`;
  return html;
  }
  // 子カテゴリーの表示作成
  function appendChidrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<div class='listing-select-wrapper__added' id= 'children_wrapper'>
                        <div class='listing-select-wrapper__box'>
                          <select class="listing-select-wrapper__box--select" id="search_child_category" name="q[category_id_eq_any][]">
                            <option value="--" data-category="--">--</option>
                            ${insertHTML}
                          <select>
                        </div>
                      </div>`;
    $('.search_listing-product-detail__category').append(childSelectHtml);
  }
  // 孫カテゴリーの表示作成
  function appendGrandChidrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class='listing-select-wrapper__added' id= 'grandchildren_wrapper'>
                              <div class='form_group__check_box'>
                                ${insertHTML}
                              </div>
                            </div>`;
    $('.search_listing-product-detail__category__check_box').append(grandchildSelectHtml);
  }
  // 親カテゴリー選択後のイベント
  $('#search_parent_category').on('change', function(){
    var parentCategory = $('#search_parent_category').get(0).value;
    if (parentCategory != ""){ //親カテゴリーが初期値でないことを確認
      $.ajax({
        url: 'get_category_children',
        type: 'GET',
        data: { parent_name: parentCategory },
        dataType: 'json'
      })
      .done(function(children){
        $('#children_wrapper').remove(); //親が変更された時、子以下を削除するする
        $('#grandchildren_wrapper').remove();
        // $('#size_wrapper').remove();
        // $('#brand_wrapper').remove();
        var insertHTML = '';
        
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChidrenBox(insertHTML);
      })
      .fail(function(){
        
      })
    }else{
      $('#children_wrapper').remove(); //親カテゴリーが初期値になった時、子以下を削除するする
      $('#grandchildren_wrapper').remove();
      // $('#size_wrapper').remove();
      // $('#brand_wrapper').remove();
    }
  });
  // 子カテゴリー選択後のイベント
  $('.search_listing-product-detail__category').on('change', '#search_child_category', function(){
    var childId = $('#search_child_category option:selected').data('category');
    
    //選択された子カテゴリーのidを取得
    if (childId != "--"){ //子カテゴリーが初期値でないことを確認
      $.ajax({
        url: 'get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#search_parent_category').attr('name', 'category_id'); //子が選択された時、親の名前を削除（データの重複回避）
          $('#grandchildren_wrapper').remove(); //子が変更された時、孫以下を削除する
          var insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendCheckBox(grandchild);
          });
          appendGrandChidrenBox(insertHTML);
        }
      })
      .fail(function(){
      })
    }else{
      $('#search_parent_category').attr('name', 'q[category_id_eq_any][]'); //子がない時、親の名前を追加（データの重複回避）
      $('#grandchildren_wrapper').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
    }
  });
  // 孫カテゴリー選択状況の監視
  $(document).on("change", '.search_grandchild_category', function(){
    if($('input[class="search_grandchild_category"]').prop('checked')) {
      $('#search_child_category').attr('name', 'category_id'); //孫のチェックボックスがある時、子の名前を削除（データの重複回避）
    } else {
      $('#search_child_category').attr('name', 'q[category_id_eq_any][]'); //孫のチェックボックスがない時、子の名前を追加（データの重複回避）
    }
  })
});