# $(document).ready ->
#   companiesEditForm.init()
#   companiesIndex.init()
#   companiesNew.init()
#   companiesSearch.init()
#   companyCategoryNew.init()
#   datePickers.init()
#   deleteLinks.init()
#   usersEdit.init()
#   usersLogin.init()
#   usersNew.init()

# deleteLinks = init: ->
#   $("a.delete").live "click", (event) ->
#     rootObject = $(this)
#     if confirm("Are you sure you want to delete this?")
#       $.ajax
#         url: @href.replace("/delete", "")
#         type: "post"
#         data:
#           _method: "delete"

#         success: ->
#           rootObject.closest("tr, .object_container").fadeOut 1000

#         error: (data) ->
#           alert data.responseText
#     false

# affiliationForm =
#   submissionCallback: null
#   init: ->
#     if $(".affiliation_form").length isnt 0
#       @initCurrentMember()
#       @initSubmission()
#       @initValidation()

#   initCurrentMember: ->
#     $(".affiliation_form input[type=\"checkbox\"]").change ->
#       $this = $(this)
#       if $this.attr("checked")
#         $(".affiliation_form option").removeAttr "selected"
#         $(".affiliation_form select").find("option:first").attr "selected", "selected"
#         $(".affiliation_form select").attr "disabled", "disabled"
#       else
#         $(".affiliation_form select").removeAttr "disabled"

#   initSubmission: ->
#     rootObject = this
#     uri = $(".affiliation_form").attr("action")
#     $(".affiliation_form").ajaxForm
#       dataType: "json"
#       url: uri
#       success: (data) ->
#         if data.success
#           (if not rootObject.submissionCallback? then alert("No callback specified.") else rootObject.submissionCallback())
#         else
#           alert "An error occured during your submission.  We have been notified."

#       type: "POST"

#   initValidation: ->
#     $(".affiliation_form input[type=\"submit\"]").attr "disabled", true
#     $(".affiliation_form").bind "change keyup", ->
#       if $(this).validate().checkForm()
#         $(".affiliation_form input[type=\"submit\"]").attr "disabled", false
#       else
#         $(".affiliation_form input[type=\"submit\"]").attr "disabled", true

#     date_required = (element) ->
#       $("#affiliation_current_member").is(":checked").length isnt 0

#     $(".affiliation_form").validate
#       rules:
#         "affiliation[name]":
#           required: true

#         "affiliation[title]":
#           required: true

#         "affiliation[start_month]":
#           required: date_required

#         "affiliation[start_year]":
#           required: date_required

#         "affiliation[end_month]":
#           required: date_required

#         "affiliation[end_year]":
#           required: date_required

#         "affiliation[uri]":
#           url: true

#         "affiliation[description]":
#           required: true

#       onkeyup: false

# associationForm =
#   submissionCallback: null
#   init: ->
#     if $(".association_form").length isnt 0
#       @initCurrentMember()
#       @initSubmission()
#       @initValidation()

#   initCurrentMember: ->
#     $(".association_form input[type=\"checkbox\"]").change ->
#       $this = $(this)
#       if $this.attr("checked")
#         $(".association_form option").removeAttr "selected"
#         $(".association_form select").find("option:first").attr "selected", "selected"
#         $(".association_form select").attr "disabled", "disabled"
#       else
#         $(".association_form select").removeAttr "disabled"

#   initSubmission: ->
#     rootObject = this
#     uri = $(".association_form").attr("action")
#     $(".association_form").ajaxForm
#       dataType: "json"
#       url: uri
#       success: (data) ->
#         if data.success
#           (if not rootObject.submissionCallback? then alert("No callback specified.") else rootObject.submissionCallback())
#         else
#           alert "An error occured during your submission.  We have been notified."

#       type: "POST"

#   initValidation: ->
#     $(".association_form input[type=\"submit\"]").attr "disabled", true
#     $(".association_form").bind "change keyup", ->
#       if $(this).validate().checkForm()
#         $(".association_form input[type=\"submit\"]").attr "disabled", false
#       else
#         $(".association_form input[type=\"submit\"]").attr "disabled", true

#     date_required = (element) ->
#       $("#association_current_member").is(":checked").length isnt 0

#     $(".association_form").validate
#       rules:
#         "association[name]":
#           required: true

#         "association[title]":
#           required: true

#         "association[start_month]":
#           required: date_required

#         "association[start_year]":
#           required: date_required

#         "association[end_month]":
#           required: date_required

#         "association[end_year]":
#           required: date_required

#         "association[uri]":
#           url: true

#         "association[description]":
#           required: true

#       onkeyup: false

# certificationForm =
#   submissionCallback: null
#   init: ->
#     if $(".certification_form").length isnt 0
#       @initSubmission()
#       @initValidation()

#   initSubmission: ->
#     rootObject = this
#     uri = $(".certification_form").attr("action")
#     $(".certification_form").ajaxForm
#       dataType: "json"
#       url: uri
#       success: (data) ->
#         if data.success
#           (if not rootObject.submissionCallback? then alert("No callback specified.") else rootObject.submissionCallback())
#         else
#           alert "An error occured during your submission.  We have been notified."

#       type: "POST"

#   initValidation: ->
#     $(".certification_form input[type=\"submit\"]").attr "disabled", true
#     $(".certification_form").validate
#       rules:
#         "certification[name]":
#           required: true

#         "certification[title]":
#           required: true

#         certificate_file:
#           required: true

#         "certification[description]":
#           required: true

#       onkeyup: false

#     $(".certification_form").bind "change keyup", ->
#       if $(this).validate().checkForm()
#         $(".certification_form input[type=\"submit\"]").attr "disabled", false
#       else
#         $(".certification_form input[type=\"submit\"]").attr "disabled", true

# companyCategoryNew =
#   init: ->
#     if $(".company_category_new").length isnt 0
#       @initSubmission()
#       @initToggling()

#   initSubmission: ->
#     $(".company_category_new input[type=\"submit\"]").click ->
#       if $("#company_category_name").val() is ""
#         alert "Please fill in a name for the new category"
#         false
#       else
#         $.ajax
#           type: "POST"
#           url: "/company_categories/"
#           data:
#             "company_category[name]": $("#company_category_name").val()

#           success: (data) ->
#             if data.success
#               category_select = $("#company_company_category_id")
#               category_select.find("option").attr "selected", ""
#               $("<option value=\"" + data.company_category_id + "\" selected=\"selected\">" + data.company_category_name + "</option>").appendTo category_select
#               $("#company_category_name").val ""
#               $(".company_category_new").hide()
#             else
#               alert "There was an issue adding your category."

#           dataType: "json"

#         false

#   initToggling: ->
#     $(".add_category").click ->
#       $(".company_category_new").show()
#       $(".company_category_new_toggle").hide()
#       false

#     $(".cancel_add_category").click ->
#       $(".company_category_new").hide()
#       $(".company_category_new_toggle").show()
#       $("#company_category_name").val ""
#       false

# companyShow =
#   init: ->
#     @initTabs()  if $(".company_show_tabs").length isnt 0

#   initTabs: ->
#     $(".company_show_tabs a").click ->
#       target_tab = $(this).attr("target_tab")
#       if not target_tab? or target_tab is ""
#         console.log "No target tab!"
#         return
#       $(".target_tab").hide()
#       $("." + target_tab).show()
#       false

# companiesEditForm =
#   init: ->
#     if $(".company_form_nav").length isnt 0 and $(".new_company").length is 0
#       @initAffiliations()
#       @initAssociations()
#       @initCertifications()
#       @initDiscounts()
#       @initSubmission()
#       @initTabs()
#       @initValidation()

#   initAffiliations: ->
#     companyId = $("#company_id").val()
#     $(".affiliations_index").load "/affiliations/?company_id=" + companyId
#     $(".affiliation_new").click ->
#       dialog = $("#affiliation_new_dialog")
#       if dialog.length is 0
#         dialog = $("<div id=\"affiliation_new_dialog\" class=\"hidden\"></div>")
#         dialog.appendTo $("body")
#       dialog.load "/affiliations/new?company_id=" + companyId, ->
#         dialog.dialog modal: true
#         affiliationForm.submissionCallback = ->
#           dialog.dialog "close"
#           $(".affiliations_index").load "/affiliations/?company_id=" + companyId

#       false

#   initAssociations: ->
#     companyId = $("#company_id").val()
#     $(".associations_index").load "/associations/?company_id=" + companyId
#     $(".association_new").click ->
#       dialog = $("#association_new_dialog")
#       if dialog.length is 0
#         dialog = $("<div id=\"association_new_dialog\" class=\"hidden\"></div>")
#         dialog.appendTo $("body")
#       dialog.load "/associations/new?company_id=" + companyId, ->
#         dialog.dialog modal: true
#         associationForm.submissionCallback = ->
#           dialog.dialog "close"
#           $(".associations_index").load "/associations/?company_id=" + companyId

#       false

#   initCertifications: ->
#     companyId = $("#company_id").val()
#     $(".certifications_index").load "/certifications/?company_id=" + companyId
#     $(".certification_new").click ->
#       dialog = $("#certification_new_dialog")
#       if dialog.length is 0
#         dialog = $("<div id=\"certification_new_dialog\" class=\"hidden\"></div>")
#         dialog.appendTo $("body")
#       dialog.load "/certifications/new?company_id=" + companyId, ->
#         dialog.dialog modal: true
#         certificationForm.submissionCallback = ->
#           dialog.dialog "close"
#           $(".certifications_index").load "/certifications/?company_id=" + companyId

#       false

#   initDiscounts: ->
#     companyId = $("#company_id").val()
#     $(".discounts_index").load "/discounts/?company_id=" + companyId, ->
#       $(".discounts_index .edit").click ->
#         dialog = $("#discount_edit_dialog")
#         if dialog.length is 0
#           dialog = $("<div id=\"discount_edit_dialog\" class=\"hidden\"></div>")
#           dialog.appendTo $("body")
#         dialog.load $(this).attr("href"), ->
#           dialog.dialog
#             modal: true
#             width: 960

#           discountForm.submissionCallback = ->
#             dialog.dialog "close"
#             $(".discounts_index").load "/discounts/?company_id=" + companyId

#         false

#     $(".discount_new").click ->
#       dialog = $("#discount_new_dialog")
#       if dialog.length is 0
#         dialog = $("<div id=\"discount_new_dialog\" class=\"hidden\"></div>")
#         dialog.appendTo $("body")
#       dialog.load "/discounts/new?company_id=" + companyId, ->
#         dialog.dialog
#           modal: true
#           width: 960

#         discountForm.submissionCallback = ->
#           dialog.dialog "close"
#           $(".discounts_index").load "/discounts/?company_id=" + companyId

#       false

#   initSubmission: ->
#     rootObject = this
#     uri = $("#form_destination").val()
#     $("<input type=\"hidden\" name=\"_method\" value=\"put\"/>").appendTo "form"
#     $(".company_form_step_1_form, .company_form_step_2_form, .company_form_step_3_form").ajaxForm
#       url: uri
#       success: (data) ->
#         if data.success
#           rootObject.showSuccess()
#           $(".certificate_of_insurance_filename").text data.certificate_of_insurance_filename
#         else
#           alert "There was an issue updating your company."

#       type: "POST"
#       dataType: "json"

#   initTabs: ->
#     $(".company_form_nav a").click ->
#       target_tab = $(this).attr("target_tab")
#       if not target_tab? or target_tab is ""
#         console.log "No target tab!"
#         return
#       $(".target_tab").hide()
#       $("." + target_tab).show()
#       false

#   initValidation: ->
#     $("input[type=\"submit\"]").attr "disabled", true
#     @initValidationStep1()
#     @initValidationStep2()
#     @initValidationStep3()

#   initValidationStep1: ->
#     $(".company_form_step_1_form").bind "change keyup", ->
#       if $(this).validate().checkForm()
#         $(".company_form_step_1_form input[type=\"submit\"]").attr "disabled", false
#       else
#         $(".company_form_step_1_form input[type=\"submit\"]").attr "disabled", true

#     $(".company_form_step_1_form").validate
#       rules:
#         "company[name]":
#           required: true

#         "company[email_address]":
#           required: true
#           email: true

#         "company[main_phone_number]":
#           required: true
#           phoneUS: true

#         "company[address_1]":
#           required: true

#         "company[city]":
#           required: true

#         "company[state]":
#           required: true

#         "company[web_site]":
#           url: true

#         "company[zip_code]":
#           required: true
#           digits: true

#       onkeyup: false

#   initValidationStep2: ->
#     $(".company_form_step_2_form input[type=\"submit\"]").attr "disabled", false

#   initValidationStep3: ->
#     $(".company_form_step_3_form input[type=\"submit\"]").attr "disabled", false

#   showSuccess: ->
#     notifications = $(".notifications")
#     $("<div class=\"success\">Your company info has been successfully saved.</div>").appendTo notifications
#     notifications.fadeIn(500).fadeOut 3000, ->
#       notifications.empty()

# companiesIndex =
#   init: ->
#     @initDeleteLinks()  if $(".companies_index").length isnt 0

#   initDeleteLinks: ->
#     $("a.delete").live "click", (event) ->
#       rootObject = $(this)
#       if confirm("Are you sure you want to delete this?")
#         $.ajax
#           url: @href.replace("/delete", "")
#           type: "post"
#           data:
#             _method: "delete"

#           success: ->
#             rootObject.closest("tr").fadeOut 1000

#           error: (data) ->
#             alert data.responseText
#       false

# companiesNew =
#   init: ->
#     if $(".new_company").length isnt 0
#       @initSubmission()
#       @initTabs()
#       @initValidation()

#   initSubmission: ->
#     uri = $("#form_destination").val()
#     $(".company_form_step_1_form").ajaxForm
#       url: uri
#       success: (data) ->
#         if data.success
#           window.location = "/companies/" + data.company_id + "/edit"
#         else
#           alert "There was an issue adding your company."

#       type: "POST"

#   initTabs: ->
#     $(".company_form_nav a:first").addClass("active").click ->
#       false

#     $(".company_form_nav a").not(".active").click ->
#       alert "You must fill out and save the basic info before you may continue."
#       false

#   initValidation: ->
#     $(".company_form_step_1 input[type=\"submit\"]").attr "disabled", true
#     $(".company_form_step_1_form").bind "change keyup", ->
#       if $(this).validate().checkForm()
#         $(".company_form_step_1_form input[type=\"submit\"]").attr "disabled", false
#       else
#         $(".company_form_step_1_form input[type=\"submit\"]").attr "disabled", true

#     $(".company_form_step_1_form").validate
#       rules:
#         "company[name]":
#           required: true

#         "company[email_address]":
#           required: true
#           email: true

#         "company[main_phone_number]":
#           required: true
#           phoneUS: true

#         "company[address_1]":
#           required: true

#         "company[city]":
#           required: true

#         "company[state]":
#           required: true

#         "company[web_site]":
#           url: true

#         "company[zip_code]":
#           required: true
#           digits: true

#       onkeyup: false

# companiesSearch =
#   searchTimer: null
#   init: ->
#     if $(".companies_search").length isnt 0
#       @initCompanyDisplay()
#       @initSearchBox()

#   initCompanyDisplay: ->
#     $company_show = $(".company_show")
#     $company_show.empty()
#     $(".company_show_no_data_template .no_data").clone().appendTo $company_show
#     $(".company").click ->
#       $this = $(this)
#       id = $this.find(".company_id").val()
#       $company_show.html "<img src=\"/images/loading_small.gif\" alt=\"Loading...\"/>"
#       $company_show.load "/companies/" + id
#       $this.addClass "active"

#   initSearchBox: ->
#     $search_box = $(".companies_search input[type=\"text\"]")
#     search = ->
#       $(".loading_graphic").show()
#       clearTimeout companiesSearch.searchTimer  if companiesSearch.searchTimer?
#       companiesSearch.searchTimer = setTimeout("companiesSearch.performSearch();", 300)

#     $search_box.keypress search
#     $search_box.change ->
#       search()  if $(this).val() is ""

#     search()
#     $search_box.watermark "Provider Name"

#   performSearch: ->
#     $.ajax
#       url: $(".companies_search").attr("action")
#       type: "post"
#       data:
#         company_name: $("#company_name").val()

#       success: (data) ->
#         $companies_index = $(".companies_index_search")
#         $(".loading_graphic").hide()
#         unless data.success
#           alert "There was an error running your search.  Please try again later."
#           console.log data.message
#           return false
#         $companies_index.empty()
#         if data.companies.length > 0
#           $("#company_template").tmpl(data.companies).appendTo $companies_index
#         else
#           $(".companies_index_search_no_data_template .no_data").clone().appendTo $companies_index
#         companiesSearch.initCompanyDisplay()

# datePickers =
#   submissionCallback: null
#   init: ->
#     $(".datepicker").datepicker()

# discountForm =
#   submissionCallback: null
#   init: ->
#     if $(".discount_form").length isnt 0
#       @initImageDestroyLinks()
#       @initSubmission()
#       @initValidation()

#   initImageDestroyLinks: ->
#     $(".discount_form .remove_image a").click ->
#       rootObject = $(this)
#       if confirm("Are you sure you want to delete this?")
#         $.ajax
#           url: @href
#           type: "post"
#           success: (data) ->
#             unless data.success
#               alert "There was an error removing your image.  Message was " + data.message
#               return false
#             rootObject.fadeOut()
#             $(".uploaded_filename").fadeOut()
#             $(".discount_image").attr "src", "/images/fpo-default-discount.jpeg"
#       false

#   initSubmission: ->
#     rootObject = this
#     uri = $(".discount_form").attr("action")
#     $(".discount_form").ajaxForm
#       dataType: "json"
#       url: uri
#       success: (data) ->
#         if data.success
#           (if not rootObject.submissionCallback? then alert("No callback specified.") else rootObject.submissionCallback())
#         else
#           alert "An error occured during your submission.  We have been notified."

#       type: "POST"

#   initValidation: ->
#     $(".discount_form input[type=\"submit\"]").attr "disabled", true
#     $(".discount_form").validate
#       rules:
#         "discount[type_id]":
#           required: true

#         "discount[description]":
#           required: true

#         image_file:
#           required: true

#         "discount[market]":
#           required: true

#         "discount[start_date]":
#           required: true

#         "discount[end_date]":
#           required: true

#       onkeyup: false

#     $(".discount_form").bind "change keyup", ->
#       if $(this).validate().checkForm()
#         $(".discount_form input[type=\"submit\"]").attr "disabled", false
#       else
#         $(".discount_form input[type=\"submit\"]").attr "disabled", true

# usersEdit =
#   originalEmailAddress: null
#   init: ->
#     if $(".edit_user").length isnt 0
#       @initPasswordChanging()
#       @initValidation()

#   initPasswordChanging: ->
#     $(".change_password").hide()
#     $("#user_change_password").change ->
#       if $(this).attr("checked")
#         $(".change_password").slideDown()
#       else
#         $(".change_password").slideUp()
#         $(".change_password input[type=\"password\"]").val("").removeClass "error"
#         $(".change_password label.error").remove()

#   initValidation: ->
#     rootObject = this
#     @originalEmailAddress = $(".edit_user #user_email_address").val()
#     $(".edit_user").bind "change keyup", ->
#       if $(this).validate().checkForm()
#         $(".edit_user input[type=\"submit\"]").attr "disabled", false
#       else
#         $(".edit_user input[type=\"submit\"]").attr "disabled", true

#     jQuery.extend jQuery.validator.messages,
#       remote: "Email address in use.  Please choose a different email address."

#     $(".edit_user").validate rules:
#       "user[email_address]":
#         required: true
#         email: true

#       "user[first_name]":
#         required: true

#       "user[last_name]":
#         required: true

#       "user[password_confirm]":
#         equalTo: "#user_password"

#     $(".edit_user #user_email_address").change ->
#       $this = $(this)
#       if $this.val() is rootObject.originalEmailAddress
#         $this.rules "remove", "remote"
#       else
#         $this.rules "add",
#           remote: "/users/validate_email_is_unique"

# usersLogin =
#   init: ->
#     @initValidation()  if $(".login_user").length isnt 0

#   initValidation: ->
#     $(".login_user input[type=\"submit\"]").attr "disabled", true
#     $(".login_user").bind "change keyup", ->
#       if $(this).validate().checkForm()
#         $(".login_user input[type=\"submit\"]").attr "disabled", false
#       else
#         $(".login_user input[type=\"submit\"]").attr "disabled", true

#     $(".login_user").validate
#       rules:
#         "user[email_address]":
#           required: true
#           email: true

#         "user[password]":
#           required: true

#       onkeyup: false

# usersNew =
#   init: ->
#     @initValidation()  if $(".new_user").length isnt 0

#   initValidation: ->
#     $(".new_user input[type=\"submit\"]").attr "disabled", true
#     $(".new_user").bind "change keyup", ->
#       if $(this).validate().checkForm()
#         $(".new_user input[type=\"submit\"]").attr "disabled", false
#       else
#         $(".new_user input[type=\"submit\"]").attr "disabled", true

#     jQuery.extend jQuery.validator.messages,
#       remote: "Email address in use.  Please choose a different email address."

#     $(".new_user").validate
#       rules:
#         "user[email_address]":
#           required: true
#           email: true
#           remote: "/users/validate_email_is_unique"

#         "user[first_name]":
#           required: true

#         "user[last_name]":
#           required: true

#         "user[password]":
#           required: true

#         "user[password_confirm]":
#           required: true
#           equalTo: "#user_password"

#       onkeyup: false
