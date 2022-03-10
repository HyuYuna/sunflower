
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
        $(window).scroll(function() {
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
    

var delay=200, setTimeoutNavi, setTimeoutFocus, setTimeoutNaviout, barmoveInterval;
var pcGnbOpen = false;
var stickyState = null;
var basicGNB = true;
var focusAction = false;
function gnbInit(){
    if( basicGNB == true ){
        $('#gnb').append('<span class="navBar"></span>');
    }
    // GNB
    delay = 0;
    $('#gnb>ul> li > a').on({
        'mouseover focusin': function(e){
            clearTimeout(setTimeoutNavi);
            var target = $(this).parent();
            if( pcGnbOpen == false ){
                setTimeoutNavi = setTimeout( function(){oneDepthOver( target );}, delay);
            } else {
                setTimeoutNavi = setTimeout( function(){oneDepthOver( target );}, delay*0.5);
            }
        },
        'mouseout focusout': function(e){
            clearTimeout(setTimeoutNavi);
        }
    });
    
    $('#header').on({
        'mouseleave': function(e){
            setTimeoutNaviout = setTimeout( function(){naviOut();}, delay*2);
        },
        'mouseenter': function(e){
            $('#header').addClass('init');
            clearInterval( barmoveInterval );
            clearTimeout(setTimeoutNaviout);
        }
    });
    barmoveInterval = setInterval( function(){barMove()}, delay );
    gnbActiveDisplay();
}
function barMove(){
    var target; 
    if( $('#gnb ul>li.on').length > 0 ){
        target = $('#gnb ul>li.on');
    } else {
        target = $('#gnb ul>li.active');
    }
    if( $(target).length > 0 ){
        var barL = $(target).offset().left;
        var barW = $(target).outerWidth();
        $('#gnb .navBar').css({"left":barL + barW*0.5, "width":barW});
    } else {
        $('#gnb .navBar').css({"width":0});
    }
}

function oneDepthOver(target){
    if( basicGNB == true ){
        $('#gnb ul > li .subArea').hide();
        $('#gnb ul > li').removeClass('on');
        if( pcGnbOpen == false ){
            $(target).addClass('on');
            $(target).find('.subArea').slideDown(300,'easeInOutQuad');
        } else {
            $(target).addClass('on');
            $(target).find('.subArea').show();
        }
        barMove();
    } else {
        $('#header').addClass('gnbOpen');
        $('#gnb').find('.subArea').slideDown(300,'easeInOutQuad');
        if( focusAction == true ){
            $('#gnb').find('.subArea a').first().focus();
        }
    }
    pcGnbOpen = true;
}
setTimeout(function(){barMove();},300);


function gnbActiveDisplay(){
    if( basicGNB == true ){
        $('#gnb .active').addClass('on');
        barMove();
        pcGnbOpen = false;
    } else {
        $('#gnb .active').addClass('on');
        barMove();
    }
}

function naviOut(){
}



$(function(){
  LayoutGo2Top.init();
  gnbInit();
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
    if(sTop > 85){
      $("#header").addClass("onFixed");
    }else{
      $("#header").removeClass("onFixed");
    }
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
