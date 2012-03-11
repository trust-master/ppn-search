jQuery.fn.scrollTo = ->
  jQuery('html,body').animate({ scrollTop: this.offset().top - 100 }, { duration: 'slow', easing: 'swing'});
  return this