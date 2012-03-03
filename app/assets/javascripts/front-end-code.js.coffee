$(document).ready =>
  @dropdownMenu.init()
  @removeLinks.init()

  # $("input[type='checkbox']").button()

  $(".market .service_area input.destroy").change ->
      inputs = $(this).parents('li.service_area').find('.radio_buttons input')
      buttonset = $(this).parents('li.service_area').find('.radio_buttons')
      if this.checked
        inputs.removeAttr('disabled')
        buttonset.buttonset('enable')
      else
        inputs.attr('disabled', true)
        buttonset.buttonset('disable')

  # currentDateValue.init()
  # moreInfo.init()
  # deactivateModal.init()
  # cf = new CustomFormElements()

  $("#company_markets_add_market").change ->
    if this.value != ''
      $("#market_#{this.value}")
        .show()

  # $('.radio_buttons').buttonset()
  # $('.service_area:not(:has(.destroy[checked])) .radio_buttons').buttonset('disable')

  $('#company_category_add_category').change ->
    if this.value != ''
      li = $("#sub_category_#{this.value}")
      li.show()
      li.parents('div.category').show()
      li.find("input[type='hidden'].destroy").val('false')

  $('#service_areas .market a.collapse').click ->
    market = $(this).parents('.market')
    areas = market.find(".service_area").map ->
      if $(this).find('input.destroy').get()[0].checked
        [
          $(this).find('label.name').text(),
          if $(this).find('.input.partial_only input[value="true"]').get()[0].checked then '*' else ''
        ].join('')

    market.find('.collapsed_summary span').html(areas.get().join(', ')).parent().show()
    market.find('ul.service_areas').hide()
    $(this).siblings('.expand').show()
    $(this).hide()

  $('#service_areas .market a.expand').click ->
    market = $(this).parents('.market')
    market.find('.collapsed_summary').hide()
    market.find('ul.service_areas').show()
    $(this).siblings('.collapse').show()
    $(this).hide()

@removeLinks =
  init: ->
    this.bind() if $('a.remove').length isnt 0

  bind: ->
    $('#service_categories .category .sub_category a.remove').click ->
      $(this).parents('li.sub_category')
        .hide()
        .find("input[type='hidden'].destroy").val('true')

    $('#locations ul.location a.remove').click ->
      $(this).parents('ul.location')
        .hide()
        .find("input[type='hidden'].destroy").val('true')

    $('#licenses ul li a.remove').click ->
      $(this).parents('li')
        .hide()
        .find("input[type='hidden'].destroy").val('true')

    $('.market a.remove').click ->
      market = $(this).parents('.market')
      market
        .hide()
        .find('.service_area input.destroy').each ->
          this.checked = false
          $(this).change()


# @deactivateModal =
#   init: ->
#     self = this
#     self.bind()  if $(".deactivate").length isnt 0

#   bind: ->
#     $(".deactivate").click ->
#       $("#deactivate-account").dialog title: "Deactivate Account"
#       false

@dropdownMenu =
  init: ->
    $("ul.account-links li").hover (->
      $(this).addClass('hover')
      #$('ul:first',this).css('visibility', 'visible')
    ), ->
      $(this).removeClass('hover')
      #$('ul:first',this).css('visibility', 'hidden')

# currentDateValue =
#   init: ->
#     self = this
#     self.bind()  if $(".date").length isnt 0

#   bind: ->
#     $(".date").datepicker showOn: "both"
#     date = new Date()
#     month = date.getMonth() + 1
#     currentDate = month + "/" + date.getDate() + "/" + date.getFullYear()
#     $(".date").val currentDate  if $(".date").val("")

# moreInfo =
#   init: ->
#     self = this
#     self.bind()  if $(".more-info").length isnt 0

#   bind: ->
#     $(".more-info").click ->
#       $(this).parent("li").children(".tooltip").show()
#       $(".tooltip-close").click ->
#         $(this).parents(".tooltip").hide()
#         false

#       false
