
@companyForm =
  init: ->
    $('input[id^="company_insured_"]').click ->
      val = this.value
      console.log
      if val == 'true'
        $(this).parents('ul').find('.insurance_fields').show()
      else
        $(this).parents('ul').find('.insurance_fields').hide()


    $(".market .service_area input.destroy").change ->
      inputs = $(this).parents('li.service_area').find('.radio_buttons input')
      if this.checked
        inputs.removeAttr('disabled')
      else
        inputs.attr('disabled', true)

    $("#market_selection_add_market").change ->
      if this.value != ''
        $("#market_#{this.value}").show().scrollTo()
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
      $(this).siblings('.expand').show()
      $(this).hide()
      market = $(this).parents('.market')
      areas = market.find(".service_area").map ->
        if $(this).find('input.destroy').get()[0].checked
          [
            $(this).find('label.name').text(),
            if $(this).find('.input.partial_only input[value="true"]').get()[0].checked then '*' else ''
          ].join('')
      market.find('ul.service_areas').hide()
      market.find('.collapsed_summary > span').html(areas.get().join(', ') || 'nothing selected').parent().show()

    $('#service_areas .market a.expand').click ->
      $(this).siblings('.collapse').show()
      $(this).hide()
      market = $(this).parents('.market')
      market.find('.collapsed_summary').hide()
      market.find('ul.service_areas').show()

    # REFACTOR: these are very 'wet'
    $('#locations a.add, #certifications a.add, #affiliations a.add, #associations a.add').click ->
      timestamp = new Date().valueOf()
      actions_div = $(this).parent()
      template = actions_div.find('.template').html().replace(/_ID_/g, timestamp)
      $(template).insertBefore(actions_div)
      window.removeLinks.bind()

    $('#licenses a.add').click ->
      timestamp = new Date().valueOf()
      actions_div = $(this).parent()
      template = actions_div.find('.template').html().replace(/_ID_/g, timestamp)
      $(template).insertBefore(actions_div)
      window.removeLinks.bind()

    $('#business_filing a.add').click ->
      timestamp = new Date().valueOf()
      actions_div = $(this).parent()
      template = actions_div.find('.template').html().replace(/_ID_/g, timestamp)
      $(template).insertBefore(actions_div)
      $(this).slideUp()
      window.removeLinks.bind()

    $('#licenses .raw_data_message a, #business_filing .raw_data_message a').click ->
      $(this).parents('.data').find('tbody.raw, tbody.parsed').toggle().scrollTo()
      new_text = $(this).data('alternate_text')
      $(this).data('alternate_text', $(this).text())
      $(this).text(new_text)

@searchPage =
  init: ->
    $('#company_details .tabs').tabs
        selected: -1,
        select: ->
          $(this).find('#initial.tab').hide()



    $('#col-a ul.companies .company').click ->
      _this = $(this)
      new_element = $('#company_details').html(_this.find('.details').html())
      _this.siblings('.company').removeClass('selected')
      _this.addClass('selected')
      new_element.find('.tabs').tabs({'disabled': [4]})
      new_element.find('.accordion').accordion
        active: false,
        collapsible: true,
        autoHeight: false

      return false

    # $('#col-b ul.nav li a').click ->
    #   $("#company_details").find(".profile, .capabilities, .credentials, .discounts").hide()
    #   $("#company_details .#{$(this).attr('class')}").show()
    #   return false

@removeLinks =
  init: ->
    this.bind() if $('a.remove').length isnt 0

  bind: ->
    $('.input.select select, .input.grouped_select select').chosen()

    $('#service_categories .category .sub_category a.remove').click ->
      _this = $(this).parents('li.sub_category')
      _this.hide()
      _this.find("input[type='hidden'].destroy").val('true')
      category = _this.parents('.category')
      category.hide() if category.find('li.sub_category:visible').length is 0

    $('#locations ul.location a.remove').click ->
      _this = $(this).parents('ul.location')
      _this.hide()
      if _this.attr('id') == 'location_new'
        _this.remove()
      else
        _this.find("input[type='hidden'].destroy").val('true')
        _this.find("input[required]").removeAttr('required')

    $('#licenses a.remove, #business_filing a.remove').click ->
      _this = $(this).parents('.personal_license, .business_license, .business_filing').first()
      _this.slideUp()
      _this.siblings('.actions').find('a.add').slideDown()
      # are we removing a dynamically created record?
      if _this.attr('id').search(/_new$/) > -1 # yes? delete it from the DOM so it's ignored
        _this.remove()
      else # no? mark the _destroy field so the old record is deleted
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
      # are we removing a dynamically created record?
      if _this.attr('id').search(/_new$/) > -1 # yes? delete it from the DOM so it's ignored
        _this.remove()
      else # no? mark the _destroy field so the old record is deleted
        _this.find("input[type='hidden'].destroy").val('true')
        _this.find("input[required]").removeAttr('required')

@popup =
  init: ->
    self = this
    self.bind()  if $(".popup a").length isnt 0

  bind: ->
    $(".popup a").click ->
      $(this).css({'visibility': 'hidden'}).siblings(".content").slideDown()

$(document).ready =>
  $('.input.select select, .input.grouped_select select').chosen({include_group_label_in_selected: true})

  @popup.init()
  @companyForm.init() if $('#content').hasClass('companies')
  @searchPage.init()  if $('#content').hasClass('search')
  @removeLinks.init()

  $("input[type='checkbox']").button()
  $('time.timeago').timeago()
