// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.turbolinks
//= require_tree .

//クリック時に要素切り替え
$(window).on("load", function() {
  $(".change").on("click", function() {
    $(".change.selected").removeClass("selected");
    $(this).addClass("selected");
    $(".contents div").hide(); // 二つの要素を非表示にする
    var selected = "." + this.id;
    $(selected).show();
    $(selected + " div").show(); // クリックされたボタンに対応する要素を表示する

    if($('#tab-title').text()=="さんの投稿一覧"){
      $('#tab-title').text("さんの支援一覧");
    }else{
      $('#tab-title').text("さんの投稿一覧");
    }


  });
});

//送信ボタン送信時
function _submit(){
  //var inputs = $('#talk_talk').val();
  //alert(inputs);
  $('#talk_talk').submit();
  $("#talk_talk").val("");
}
