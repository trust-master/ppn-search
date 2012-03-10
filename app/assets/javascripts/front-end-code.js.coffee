$(document).ready =>
  # @dropdownMenu.init() # don't do this, for now... CSS should be plenty
  # currentDateValue.init()
  @popup.init()
  # deactivateModal.init()
  cf = new CustomFormElements()
  @removeLinks.init()
  @companyForm.init() if $('#content').hasClass('companies')

  $("input[type='checkbox']").button()

@companyForm =
  init: ->
    $(".market .service_area input.destroy").change ->
      inputs = $(this).parents('li.service_area').find('.radio_buttons input')
      # buttonset = $(this).parents('li.service_area').find('.radio_buttons')
      if this.checked
        inputs.removeAttr('disabled')
        # buttonset.buttonset('enable')
      else
        inputs.attr('disabled', true)
        # buttonset.buttonset('disable')

    $("#market_selection_add_market").change ->
      if this.value != ''
        $("#market_#{this.value}").show()
      this.selectedIndex = 0 # reset it back to the blank entry

    # $('.radio_buttons').buttonset()
    # $('.service_area:not(:has(.destroy[checked])) .radio_buttons').buttonset('disable')

    $('#category_selection_add_category').change ->
      if this.value != ''
        sub_category = $("#sub_category_#{this.value}")
        sub_category.parents('div.category').show()
        sub_category.show().effect('highlight', {}, 2000)
        sub_category.find("input[type='hidden'].destroy").val('false')
      this.selectedIndex = 0 # reset it back to the blank entry

    $('#service_areas .market a.collapse').click ->
      market = $(this).parents('.market')
      areas = market.find(".service_area").map ->
        if $(this).find('input.destroy').get()[0].checked
          [
            $(this).find('label.name').text(),
            if $(this).find('.input.partial_only input[value="true"]').get()[0].checked then '*' else ''
          ].join('')

      $(this).hide()
      market.find('ul.service_areas').hide()
      market.find('.collapsed_summary > span').html(areas.get().join(', ') || 'nothing selected').parent().show()
      $(this).siblings('.expand').show()

    $('#service_areas .market a.expand').click ->
      market = $(this).parents('.market')
      $(this).siblings('.collapse').show()
      market.find('.collapsed_summary').hide()
      market.find('ul.service_areas').show()
      $(this).hide()

    $('#locations a.add, #certifications a.add, #affiliations a.add, #associations a.add').click ->
      timestamp = new Date().valueOf()
      $(this).parent().before(
        $(this).siblings('.template').html().replace(/_ID_/g, timestamp)
      )
      window.removeLinks.bind()

    $('#licenses a.add, #business_filing a.add').click ->
      timestamp = new Date().valueOf()
      $(this).parent().before(
        $(this).siblings('.template').html().replace(/_ID_/g, timestamp)
      )
      window.removeLinks.bind()

    $('#licenses .raw_data_message a, #business_filing .raw_data_message a').click ->
      $(this).parents('.data').find('tbody.raw, tbody.parsed').toggle()
      new_text = $(this).data('alternate_text')
      $(this).data('alternate_text', $(this).text())
      $(this).text(new_text)


@removeLinks =
  init: ->
    this.bind() if $('a.remove').length isnt 0

  bind: ->
    $('#service_categories .category .sub_category a.remove').click ->
      _this = $(this).parents('li.sub_category')
      _this.hide()
      _this.find("input[type='hidden'].destroy").val('true')
      category = _this.parents('.category')
      category.hide() if category.find('li.sub_category:visible').length is 0

    $('#locations ul.location a.remove').click ->
      _this = $(this).parents('ul.location')
      _this.hide()
      _this.find("input[type='hidden'].destroy").val('true')

    $('#licenses a.remove').click ->
      _this = $(this).parents('.personal_license, .business_license, .business_filing').first()
      _this.slideUp()
      _this.find("input[type='hidden'].destroy").val('true')
      _this.find("input[required]").removeAttr('required')

    $('.market a.remove').click ->
      _this = $(this).parents('.market')
      _this.slideUp()
      _this.find('.service_area input.destroy').each ->
          this.checked = false # uncheck the box
          $(this).change() # this is so the ui-button notices the previous change

    $('#certifications a.remove, #affiliations a.remove, #associations a.remove').click ->
      _this = $(this).parents('.certification, .affiliation, .association').first()
      _this.slideUp()
      _this.find('input[type="hidden"].destroy').val('true')

@popup =
  init: ->
    self = this
    self.bind()  if $(".popup a").length isnt 0

  bind: ->
    $(".popup a").click ->
      $(this).siblings(".content").slideToggle()








# @dropdownMenu =
#   init: ->
#     $("ul.account-links li").hover (->
#       $(this).addClass('hover')
#     ), ->
#       $(this).removeClass('hover')

# @deactivateModal =
#   init: ->
#     self = this
#     self.bind()  if $(".deactivate").length isnt 0

#   bind: ->
#     $(".deactivate").click ->
#       $("#deactivate-account").dialog title: "Deactivate Account"
#       false


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

