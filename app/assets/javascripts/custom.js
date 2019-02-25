$(function () {
  setNavigation(); 
})

function setNavigation () {
  var path = window.location.pathname; 
  path = path.replace(/\/$/,"");
  path = decodeURIComponent(path); 
  $("nav a").each(function () {
    var href = $(this).attr("href"); 
    if(path.substring(0,href.length) === href) {
      $(this).closest('li').addClass('active')
    }
  })
}

$('body').on("click", function() {
  console.log('clicked')

})


$('document').ready(function() {

  setInterval(function() {
    if ($('.staff-favorites:visible').next().length > 0) {
      $('.current-review').removeClass('current-review').next().addClass('current-review')
      $('.staff-favorites:visible').hide().next().show();
    }
    else {
      $('.staff-favorites:visible').hide()
      $('.current-review').removeClass('current-review')
      $('#0').show();
      $('.circle').first().addClass('current-review')
    }
  }, 10000)
  $('.circle').click(function() {

    $(this).addClass('current-review').siblings().removeClass('current-review')
    var requestedReview = $(this).attr("data-review-source")
    $('.staff-favorites:visible').hide()
    $(requestedReview).show(); 
  })
})
