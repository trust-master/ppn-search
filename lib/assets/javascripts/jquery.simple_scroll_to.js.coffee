jQuery.fn.scrollTo = ->
  jQuery('body').animate({ scrollTop: this.offset().top - 100 }, { duration: 'slow' });
  return this