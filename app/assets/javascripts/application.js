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
//= require jquery
//= require rails-ujs
//= require popper
//= require bootstrap-sprockets
//= require moment
//= require fullcalendar
//= require activestorage
//= require turbolinks
//= require_tree .

// top画面bg-slider
$(window).load(function() {
  $('.bg-slider').bgSwitcher({
    images: ['assets/angel-luciano-LATYeZyw88c-unsplash.jpg', 'assets/pauline-loroy-U3aF7hgUSrk-unsplash.jpg', 'assets/anna-dudkova-urs_y9NwFcc-unsplash.jpg', 'assets/jamie-street-wcO2PWLuQ3U-unsplash.jpg'], // 切り替える背景画像を指定
    interval: 7000, // 背景画像を切り替える間隔を指定 3000=3秒
    loop: true, // 切り替えを繰り返すか指定 true=繰り返す　false=繰り返さない
    shuffle: true, // 背景画像の順番をシャッフルするか指定 true=する　false=しない
    effect: "fade", // エフェクトの種類をfade,blind,clip,slide,drop,hideから指定
    duration: 2000, // エフェクトの時間を指定します。
    easing: "swing" // エフェクトのイージングをlinear,swingから指定

  });

});