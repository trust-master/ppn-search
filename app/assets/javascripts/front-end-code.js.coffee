$(document).ready ->
  dropdownMenu.init()
  $("input[type='checkbox']").button()
  $(".market .service_area input[type='checkbox']").change ->
      # inputs = $(this).parents('li.service_area').find('.radio input')
      buttonset = $(this).parents('li.service_area').find('.radio')
      if this.checked
        # inputs.removeAttr('disabled')
        # inputs.button('enable')
        buttonset.buttonset('enable')
      else
        # inputs.attr('disabled', true)
        # inputs.button('disable')
        buttonset.buttonset('disable')
      # inputs.button('refresh')

  # currentDateValue.init()
  # moreInfo.init()
  # deactivateModal.init()
  # cf = new CustomFormElements()

  # $('select#market').change ->
  #   $('#market option').each ->
  #     $($(this).val()).toggle(this.selected)
  $("#markets-selection input[type='checkbox']").change ->
    $($(this).data('market-selector')).toggle(this.checked)
  $('.market a.remove').click ->
    button = $('#market_toggle_'+$(this).data('market-id'))
    button.get()[0].checked = false
    button.change()

  $('.radio-options .radio').buttonset()
  $('.service_area .ui-buttonset').buttonset('disable')

# deactivateModal =
#   init: ->
#     self = this
#     self.bind()  if $(".deactivate").length isnt 0

#   bind: ->
#     $(".deactivate").click ->
#       $("#deactivate-account").dialog title: "Deactivate Account"
#       false

dropdownMenu = init: ->
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
