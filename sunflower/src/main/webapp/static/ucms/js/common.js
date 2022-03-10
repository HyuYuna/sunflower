
var LayoutGo2Top = function() {
  var handle = function() {
  var currentWindowPosition = $(window).scrollTop(); // current vertical position
    
    if (currentWindowPosition > 300) {
      $(".gotoTop").show();
    } else {
      $(".gotoTop").hide();
    }
  };
  return {
    init: function() {
      if (navigator.userAgent.match(/iPhone|iPad|iPod/i)) {
        $(window).on("touchend touchcancel touchleave", function(e) {
          handle();
        });
      } else {
        $(window).on('scroll',function() {
          handle();
        });
      }
      $(".gotoTop").on('click', function(e) {
        e.preventDefault();
        $("html, body").animate({
          scrollTop: 0
        }, 600);
      });
    }
  };
}();


$(function(){
  LayoutGo2Top.init();
  $('.menuNavOpener').on('click', function(){
    $(this).parent().toggleClass('menuNavOpen');
    if($(this).parent().hasClass('menuNavOpen')){
        $(this).find(".hidden").text('메뉴 닫기');    
    } else {
        $(this).find(".hidden").text('메뉴 열기');
    }
    
  });
  
  var sTop;
  function goToScroll() {
    sTop = $(window).scrollTop();
    //console.log(sTop);
    /*if(sTop > 85){
      $("#header").addClass("onFixed");
    }else{
      $("#header").removeClass("onFixed");
    }*/
  }

  $("#gotoTop").on("click", function(){
    $(window).animate({scrollTop: 0}, 500);
  })

  $(window).on("scroll", function() {
      goToScroll();
  });
  goToScroll();

  function throttle(method, scope) {
    clearTimeout(method.tId);
    method.tId= setTimeout(function(){
        method.call(scope);
    }, 50);
  }
  function resizeDiv(event){
    //모바일 경우
    if(window.innerWidth < 768){

    } else if(window.innerWidth < 1000){

    }
  }

  throttle(resizeDiv);  //초기실행
    window.onresize = function(){
    throttle(resizeDiv);
  }

})
