// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery.jscroll.min.js
//= require popper
//= require bootstrap-sprockets
//= require cocoon
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
/* global $*/

// 無限スクロール
$(window).on('scroll', function() {
  var scrollHeight = $(document).height();
  var scrollPosition = $(window).height() + $(window).scrollTop();
  if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
    $('.jscroll').jscroll({
      contentSelector: '.jscroll',
      nextSelector: 'span.next a'
    });
  }
});

// アイテム追加時のプレビュー機能
$(document).on('change', '.item-hidden-field', function() {
  // 選択した部分のみの.add-item-image-btnにidを与える
  var item_id = $(this).attr('id').replace(/[^0-9]/g, '');
  $(this).parent().last().attr({id: `prev-target-${item_id}`});
  // FileReaderオブジェクトを作成
  var file = this.files[0];
  var reader = new FileReader();
  reader.readAsDataURL(file);
  reader.onload = function() {
    // 上で与えられたidを持つprev-targetの画像を変更
    var item_image = this.result;
    $(`#prev-target-${item_id} img`).attr({src: `${item_image}`});
  };
});

$(document).on('turbolinks:load', function() {

  // オーバーレイを表示
  $('.mynotice').on('click',function() {
    $('.mynotice-menu').toggleClass('active');
  });

  $('.mypage').on('click',function() {
    $('.mypage-menu').toggleClass('active');
  });

  // オーバーレイを非表示
  $(document).on('click', function(e) {
    if (!$(e.target).closest('.mynotice').length) {
      $('.mynotice-menu').removeClass('active');
    }
    if (!$(e.target).closest('.mypage').length) {
      $('.mypage-menu').removeClass('active');
    }
  });

  // 投稿詳細のサムネイル変更
  $('.subImg img').on('click', function() {
    // クリックした画像のurlを取得
    var subimg = $(this).attr('src');
    // mainImgをフェードアウト後、クリックしたsubImgを表示する
    $('.mainImg img').fadeOut(50, function() {
      $('.mainImg img').attr('src', subimg).on('load', function() {
        $(this).fadeIn();
      });
    });
  });

    // 編集ページの場合、既存の画像をpreview表示する
  if (window.location.href.match(/\/posts\/[0-9]+\/edit/)){
    //プレビューにidを追加
    $('.prev-box').each(function(index, box){
      $(box).attr('id', `prev-box__${index}`);
    });
    //削除ボタンにidを追加
    $('.delete-box').each(function(index, box){
      $(box).attr('id', `delete_btn_${index}`);
    });
    //プレビューが4個あるときは.label-contentを隠す
    var count = $('.prev-box').length;
    if (count == 4) {
      $('.label-content').hide();
    }
  }

  // 投稿画像をプレビューする場所を作成
  function buildPostHTML(count) {
    var post_html = `<div class="prev-box" id="prev-box__${count}">
                  <div class="prev-img w-100">
                    <img src="" alt="preview" class="img-fluid">
                  </div>
                  <div class="prev-menu d-flex text-center">
                    <div class="update-box bg-white text-success w-50 border">
                      <label for="post_post_images_attributes_${count}_image">変更</label>
                    </div>
                    <div class="delete-box bg-white text-danger w-50 border" id="delete_btn_${count}">
                      <span>削除</span>
                    </div>
                  </div>
                </div>`;
    return post_html;
  }

  // 投稿作成時のプレビュー機能
  $(document).on('change', '.post-hidden-field', function() {
    // .hidden-fieldのidの数値のみ取得
    var id = $(this).attr('id').replace(/[^0-9]/g, '');
    // 編集画面でのみ.check-boxのチェックマークを外す
    if (window.location.href.match(/\/posts\/[0-9]+\/edit/)){
      $(`#post_post_images_attributes_${id}__destroy`).prop('checked',false);
    }
    // .label-btnのidとforを更新
    $('.label-btn').attr({id: `label-btn-${id}`,for: `post_images_attributes_${id}_image`});
    // FileReaderオブジェクトを作成
    var file = this.files[0];
    var reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = function() {
      // 読み込んだファイルの内容を取得して変数imageに代入
      var image = this.result;
      // プレビューが元々なかった場合のみ実行
      if ($(`#prev-box__${id}`).length == 0) {
        // .label-contentの直前に変数post_htmlを追加
        var post_html = buildPostHTML(id);
        var prevContent = $('.label-content').prev();
        $(prevContent).append(post_html);
      }
      // 変数imageを表示する
      $(`#prev-box__${id} img`).attr('src', `${image}`);
      // .prev-boxが4個あったら.label-contentを隠す
      var count = $('.prev-box').length;
      if (count == 4) {
        $('.label-content').hide();
      }
      // .prev-boxの数に応じて.label-btnのforを更新する
      if(count < 4){
        $('.label-btn').attr({id: `label-btn-${count}`,for: `post_post_images_attributes_${count}_image`});
      }
    };
  });

  // .delete-boxがクリックされたら発火
  $(document).on('click', '.delete-box', function() {
    // post_post_images_attributes_${id}_image から${id}に入った数字のみ取得
    var id = $(this).attr('id').replace(/[^0-9]/g, '');
    // 取得したidに該当するプレビューの削除
    $(`#prev-box__${id}`).remove();
    $(`#post_post_images_attributes_${id}__destroy`).prop('checked',true);
    $(`#post_post_images_attributes_${id}_image`).val("");
    // 4個目の.prev-boxが削除されたら.label-contentを表示
    var count = $('.prev-box').length;
    if (count < 4) {
      $('.label-content').show();
    }
    // 削除された後に空になった.file_fieldのidとforを.labe.-btnに割り振る
    if(id < 4){
      $('.label-btn').attr({id: `label-btn-${id}`,for: `post_post_images_attributes_${id}_image`});
    }
  });

  // プロフィール画像をプレビューする場所を作成
  function buildAvatarHTML(avatar) {
    var avatar_html = `<div class="prev-target">
                  <img src="${avatar}", alt="preview" class="prev-avatar rounded-circle" width="100" height="100">
                </div>`;
    return avatar_html;
  }

  // avatar編集時のプレビュー機能
  $(document).on('change', '.avatar-hidden-field', function() {
    // FileReaderオブジェクトを作成
    var file = this.files[0];
    var reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = function() {
      // 読み込んだファイルの内容を取得して変数avatarに代入
      var avatar = this.result;
      // プレビュー画像がなければ処理を実行
      if ($('.prev-target').length == 0) {
        // 作成した.prev-targetをno-avatarの代わりに表示
        var avatar_html = buildAvatarHTML(avatar);
        $('.prev-box').prepend(avatar_html);
        $('.no-avatar').hide();
        // 既に画像がプレビューされていれば画像データのみを入れ替る
      } else {
        $('.prev-target .prev-avatar').attr({ src: avatar });
      }
    };
  });
});
