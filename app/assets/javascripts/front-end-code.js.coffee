$(document).ready ->
  dropdownMenu.init()
  $(".checkbox").button()
  currentDateValue.init()
  moreInfo.init()
  deactivateModal.init()
  cf = new CustomFormElements(selectWidth: 192)

deactivateModal =
  init: ->
    self = this
    self.bind()  if $(".deactivate").length isnt 0

  bind: ->
    $(".deactivate").click ->
      $("#deactivate-account").dialog title: "Deactivate Account"
      false

dropdownMenu = init: ->
  $(".account-links li a").hover (->
    $(this).parent().children(".dropdown").show()
  ), ->
    $(this).parent().children(".dropdown").hide()

currentDateValue =
  init: ->
    self = this
    self.bind()  if $(".date").length isnt 0

  bind: ->
    $(".date").datepicker showOn: "both"
    date = new Date()
    month = date.getMonth() + 1
    currentDate = month + "/" + date.getDate() + "/" + date.getFullYear()
    $(".date").val currentDate  if $(".date").val("")

moreInfo =
  init: ->
    self = this
    self.bind()  if $(".more-info").length isnt 0

  bind: ->
    $(".more-info").click ->
      $(this).parent("li").children(".tooltip").show()
      $(".tooltip-close").click ->
        $(this).parents(".tooltip").hide()
        false

      false
