
@companyForm =
  find_and_inject_template: ->
    timestamp = new Date().valueOf()
    actions_div = $(this).parent()
    template = actions_div.find('.template').html().replace(/_ID_/g, timestamp)
    $(template).insertBefore(actions_div)
    $('.input.select select, .input.grouped_select select').chosen()

  remove_or_mark_for_destruction: ->
    _this = $(this)
    # are we removing a dynamically created record?
    if _this.attr('id').search(/_new$/) > -1 # yes? delete it from the DOM so it's ignored
      _this.remove()
    else # no? mark the _destroy field so the old record is deleted
      _this.find("input[type='hidden'].destroy").val('true')
      _this.find("input[required]").removeAttr('required')

  init: ->
    $(".market .service_area").on 'change', 'input.destroy', (event)->
      inputs = $(this).parents('li.service_area').find('.radio_buttons')
      if this.checked
        inputs.show()
      else
        inputs.hide()

    $('input[id^="company_insured_"]').click ->
      val = this.value
      console.log
      if val == 'true'
        $(this).parents('ul').find('.insurance_fields').show()
      else
        $(this).parents('ul').find('.insurance_fields').hide()

    $("#market_selection_add_market").change ->
      if this.value != ''
        $("#market_#{this.value}").show().scrollTo()
      this.selectedIndex = 0 # reset it back to the blank entry
      $(this).trigger("liszt:updated") # tell chosen to update from the selectedIndex

    $('.input.radio_buttons').buttonset()

    $('#category_selection_add_category').change ->
      if this.value != '' # check that something was actually selected
        sub_category = $("#sub_category_#{this.value}")
        sub_category.parents('div.category').show()
        sub_category.show().effect('highlight', {}, 2000)
        sub_category.find("input[type='hidden'].destroy").val('false')
      this.selectedIndex = 0 # reset it back to the blank entry
      $(this).trigger("liszt:updated") # tell chosen to update from the selectedIndex

    $('#service_areas .market').on 'click', 'a.collapse', (event)->
      $(this).siblings('.expand').show()
      $(this).hide()
      market = $(this).parents('.market')
      areas = market.find(".service_area").map ->
        if $(this).find('input.destroy').get()[0].checked
          [
            $(this).find('label.name').text(),
            if $(this).find('.partial_only > span.radio > input[value="true"]').get()[0].checked then '*' else ''
          ].join('')
      market.find('ul.service_areas').hide()
      market.find('.collapsed_summary > span').html(areas.get().join(', ') || 'nothing selected').parent().show()

    $('#service_areas .market').on 'click', 'a.expand', (event)->
      $(this).siblings('.collapse').show()
      $(this).hide()
      market = $(this).parents('.market')
      market.find('.collapsed_summary').hide()
      market.find('ul.service_areas').show()

    $('#licenses, #business_filing').on 'click', '.raw_data_message a', (event)->
      $(this).parents('.data')
        .find('tbody.raw, tbody.parsed').toggle()
        .find(':visible').scrollTo()
      alt_text = $(this).data('alternate_text')
      $(this).data 'alternate_text', $(this).text()
      $(this).text alt_text

    $('#service_categories').on 'click', 'a.remove', (event)->
      $(this).parents('li.sub_category')
        .hide()
        .find("input[type='hidden'].destroy").val('true').end()
        .parents('.category').toggle(category.find('li.sub_category:visible').length is 0)

    $('#locations, #certifications, #affiliations, #associations, #licenses').on 'click', 'a.add', this.find_and_inject_template

    $('#locations').on 'click', 'a.remove', (event)->
      _this = $(this).parents('ul.location')
      _this.hide()
      window.companyForm.remove_or_mark_for_destruction.call(_this)

    $('#business_filing').on 'click', 'a.add', (event)->
      window.companyForm.find_and_inject_template.call(this)
      $(this).slideUp()

    $('#licenses, #business_filing').on 'click', 'a.remove', (event)->
      _this = $(this).parents('.personal_license, .business_license, .business_filing').first()
      _this.slideUp()
      _this.siblings('.actions').find('a.add').slideDown()
      window.companyForm.remove_or_mark_for_destruction.call(_this)


    $('.market').on 'click', 'a.remove', (event)->
      _this = $(this).parents('.market')
      _this.slideUp()
      _this.find('.service_area input.destroy').each ->
          this.checked = false # uncheck the box
          $(this).change() # this is so the ui-button notices the previous change

    $('#certifications, #affiliations, #associations').on 'click', 'a.remove', (event)->
      _this = $(this).parents('.certification, .affiliation, .association').first()
      _this.slideUp()
      window.companyForm.remove_or_mark_for_destruction.call(_this)

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

@popup =
  init: ->
    self = this
    self.bind()  if $(".popup a").length isnt 0

  bind: ->
    $(".popup, .what_is_this").on 'click', 'a.hint', (event)->
      $(this)
        .siblings(".content").slideDown().end()
        .remove()

$(document).ready =>
  $('.input.select select, .input.grouped_select select').chosen({include_group_label_in_selected: true})
  $("input[type='checkbox']").button()
  $('time.timeago').timeago()

  @companyForm.init() if $('#content').hasClass('companies')
  @searchPage.init()  if $('#content').hasClass('search')
  @popup.init()

