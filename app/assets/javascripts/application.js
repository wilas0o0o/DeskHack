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

$(document).on('turbolinks:load', function() {
  $(function(){
    $(".mynotice").click(function(){
    $(".mynotice-menu").toggleClass("mynotice-active");
    });

    $(".mypage").click(function(){
    $(".mypage-menu").toggleClass("mypage-active");
    });
  });

  $(document).on('click', function(e) {
    if (!$(e.target).closest('.mynotice').length) {
      $('.mynotice-menu').removeClass('mynotice-active');
    }
  });

  $(document).on('click', function(e) {
    if (!$(e.target).closest('.mypage').length) {
      $('.mypage-menu').removeClass('mypage-active');
    }
  });
});


