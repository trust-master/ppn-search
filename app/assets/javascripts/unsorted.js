$(document).ready(function() {
	companiesEditForm.init();
	companiesIndex.init();
	companiesNew.init();
	companiesSearch.init();

	companyCategoryNew.init();
	datePickers.init();
	deleteLinks.init();

	usersEdit.init();
	usersLogin.init();
	usersNew.init();
});
var deleteLinks = {
	init: function() {
	    $('a.delete').live('click', function(event) {
			var rootObject = $(this);

			if ( confirm("Are you sure you want to delete this?") )
	            $.ajax({
	                url: this.href.replace('/delete', ''),
	                type: 'post',
	                data: { '_method': 'delete' },
	                success: function() {
						rootObject.closest('tr, .object_container').fadeOut(1000);
	                },
					error: function(data) {
						alert(data.responseText);
					}
	            });

	        return false;
	    });
	}
};
var affiliationForm = {
	submissionCallback: null,
	init: function() {
		if ($('.affiliation_form').length !== 0) {
			this.initCurrentMember();
			this.initSubmission();
			this.initValidation();
		}
	},
	initCurrentMember: function() {
		$('.affiliation_form input[type="checkbox"]').change(function() {
			var $this = $(this);
			if ($this.attr('checked')) {
				$('.affiliation_form option').removeAttr('selected');
				$('.affiliation_form select').find('option:first').attr('selected','selected');
				$('.affiliation_form select').attr('disabled', 'disabled');
			}
			else {
				$('.affiliation_form select').removeAttr('disabled');
			}
		});
	},
	initSubmission: function() {
		var rootObject = this;
		var uri = $('.affiliation_form').attr('action');

		$('.affiliation_form').ajaxForm({
			dataType: 'json',
			url: uri,
            success: function(data) {
				if (data.success) {
					rootObject.submissionCallback == null ? alert('No callback specified.') : rootObject.submissionCallback();
				} else {
					alert('An error occured during your submission.  We have been notified.');
				}
			},
            type: 'POST'
        });
	},
	initValidation: function() {
		$('.affiliation_form input[type="submit"]').attr('disabled',true);
		$('.affiliation_form').bind('change keyup', function() {
			if ($(this).validate().checkForm())
			{
				$('.affiliation_form input[type="submit"]').attr('disabled',false);
			}
			else
			{
				$('.affiliation_form input[type="submit"]').attr('disabled',true);
			}
		});
		var date_required = function(element) { return $("#affiliation_current_member").is(":checked").length !== 0;};
		$('.affiliation_form').validate({
			rules: {
				"affiliation[name]": {required: true},
				"affiliation[title]": {required: true},
				"affiliation[start_month]": {required: date_required},
				"affiliation[start_year]": {required: date_required},
				"affiliation[end_month]": {required: date_required},
				"affiliation[end_year]": {required: date_required},
				"affiliation[uri]": {url: true},
				"affiliation[description]": {required: true}
			},
			onkeyup: false
		});
	}
};
var associationForm = {
	submissionCallback: null,
	init: function() {
		if ($('.association_form').length !== 0) {
			this.initCurrentMember();
			this.initSubmission();
			this.initValidation();
		}
	},
	initCurrentMember: function() {
		$('.association_form input[type="checkbox"]').change(function() {
			var $this = $(this);
			if ($this.attr('checked')) {
				$('.association_form option').removeAttr('selected');
				$('.association_form select').find('option:first').attr('selected','selected');
				$('.association_form select').attr('disabled', 'disabled');
			}
			else {
				$('.association_form select').removeAttr('disabled');
			}
		});
	},
	initSubmission: function() {
		var rootObject = this;
		var uri = $('.association_form').attr('action');

		$('.association_form').ajaxForm({
			dataType: 'json',
			url: uri,
            success: function(data) {
				if (data.success) {
					rootObject.submissionCallback == null ? alert('No callback specified.') : rootObject.submissionCallback();
				} else {
					alert('An error occured during your submission.  We have been notified.');
				}
			},
            type: 'POST'
        });
	},
	initValidation: function() {
		$('.association_form input[type="submit"]').attr('disabled',true);
		$('.association_form').bind('change keyup', function() {
			if ($(this).validate().checkForm())
			{
				$('.association_form input[type="submit"]').attr('disabled',false);
			}
			else
			{
				$('.association_form input[type="submit"]').attr('disabled',true);
			}
		});
		var date_required = function(element) { return $("#association_current_member").is(":checked").length !== 0;};
		$('.association_form').validate({
			rules: {
				"association[name]": {required: true},
				"association[title]": {required: true},
				"association[start_month]": {required: date_required},
				"association[start_year]": {required: date_required},
				"association[end_month]": {required: date_required},
				"association[end_year]": {required: date_required},
				"association[uri]": {url: true},
				"association[description]": {required: true}
			},
			onkeyup: false
		});
	}
};
var certificationForm = {
	submissionCallback: null,
	init: function() {
		if ($('.certification_form').length !== 0) {
			this.initSubmission();
			this.initValidation();
		}
	},
	initSubmission: function() {
		var rootObject = this;
		var uri = $('.certification_form').attr('action');

		$('.certification_form').ajaxForm({
			dataType: 'json',
			url: uri,
            success: function(data) {
				if (data.success) {
					rootObject.submissionCallback == null ? alert('No callback specified.') : rootObject.submissionCallback();
				} else {
					alert('An error occured during your submission.  We have been notified.');
				}
			},
            type: 'POST'
        });
	},
	initValidation: function() {
		$('.certification_form input[type="submit"]').attr('disabled',true);
		$('.certification_form').validate({
			rules: {
				"certification[name]": {required: true},
				"certification[title]": {required: true},
				"certificate_file": {required: true},
				"certification[description]": {required: true}
			},
			onkeyup: false
		});
		$('.certification_form').bind('change keyup', function() {
			if ($(this).validate().checkForm())
			{
				$('.certification_form input[type="submit"]').attr('disabled',false);
			}
			else
			{
				$('.certification_form input[type="submit"]').attr('disabled',true);
			}
		});
	}
};
var companyCategoryNew = {
	init: function() {
		if ($('.company_category_new').length !== 0) {
			this.initSubmission();
			this.initToggling();
		}
	},
	initSubmission: function() {
		$('.company_category_new input[type="submit"]').click(function() {
			if ($('#company_category_name').val() == '')
			{
				alert('Please fill in a name for the new category');
				return false;
			}
			else
			{
				$.ajax({
					type: 'POST',
					url: '/company_categories/',
					data: {
						'company_category[name]': $('#company_category_name').val()
					},
					success: function(data) {
						if (data.success) {
							var category_select = $('#company_company_category_id');
							category_select.find('option').attr('selected','');
							$('<option value="'+data.company_category_id+'" selected="selected">'+data.company_category_name+'</option>').appendTo(category_select);
							$('#company_category_name').val('');
							$('.company_category_new').hide();
						}
						else {
							alert('There was an issue adding your category.');
						}
					},
					dataType: 'json'
				});
				return false;
			}
		});
	},
	initToggling: function() {
		$('.add_category').click(function() {
			$('.company_category_new').show();
			$('.company_category_new_toggle').hide();
			return false;
		});
		$('.cancel_add_category').click(function() {
			$('.company_category_new').hide();
			$('.company_category_new_toggle').show();
			$('#company_category_name').val('');
			return false;
		});
	}
};
var companyShow = {
	init: function() {
		if ($('.company_show_tabs').length !== 0) {
			this.initTabs();
		}
	},
	initTabs: function() {
		$('.company_show_tabs a').click(function() {
			var target_tab = $(this).attr('target_tab');
			if (target_tab == null || target_tab == '') { console.log('No target tab!'); return;}
			$('.target_tab').hide();
			$('.' + target_tab).show();
			return false;
		});
	},
};
var companiesEditForm = {
	init: function() {
		if ($('.company_form_nav').length !== 0 && $('.new_company').length == 0) {
			this.initAffiliations();
			this.initAssociations();
			this.initCertifications();
			this.initDiscounts();
			this.initSubmission();
			this.initTabs();
			this.initValidation();
		}
	},
	initAffiliations: function() {
		var companyId = $('#company_id').val();
		$('.affiliations_index').load('/affiliations/?company_id=' + companyId);

		$('.affiliation_new').click(function() {
			var dialog = $('#affiliation_new_dialog');
			if (dialog.length == 0) {
				dialog = $('<div id="affiliation_new_dialog" class="hidden"></div>');
				dialog.appendTo($('body'));
			}

			dialog.load('/affiliations/new?company_id='+companyId, function() {
				dialog.dialog({modal: true});
				affiliationForm.submissionCallback = function() {
					dialog.dialog('close');
					$('.affiliations_index').load('/affiliations/?company_id=' + companyId);
				};
			});
			return false;
		});
	},
	initAssociations: function() {
		var companyId = $('#company_id').val();
		$('.associations_index').load('/associations/?company_id=' + companyId);

		$('.association_new').click(function() {
			var dialog = $('#association_new_dialog');
			if (dialog.length == 0) {
				dialog = $('<div id="association_new_dialog" class="hidden"></div>');
				dialog.appendTo($('body'));
			}

			dialog.load('/associations/new?company_id='+companyId, function() {
				dialog.dialog({modal: true});
				associationForm.submissionCallback = function() {
					dialog.dialog('close');
					$('.associations_index').load('/associations/?company_id=' + companyId);
				};
			});
			return false;
		});
	},
	initCertifications: function() {
		var companyId = $('#company_id').val();
		$('.certifications_index').load('/certifications/?company_id=' + companyId);

		$('.certification_new').click(function() {
			var dialog = $('#certification_new_dialog');
			if (dialog.length == 0) {
				dialog = $('<div id="certification_new_dialog" class="hidden"></div>');
				dialog.appendTo($('body'));
			}

			dialog.load('/certifications/new?company_id='+companyId, function() {
				dialog.dialog({modal: true});
				certificationForm.submissionCallback = function() {
					dialog.dialog('close');
					$('.certifications_index').load('/certifications/?company_id=' + companyId);
				};
			});
			return false;
		});
	},
	initDiscounts: function() {
		var companyId = $('#company_id').val();
		$('.discounts_index').load('/discounts/?company_id=' + companyId, function() {
			$('.discounts_index .edit').click(function() {
				var dialog = $('#discount_edit_dialog');
				if (dialog.length == 0) {
					dialog = $('<div id="discount_edit_dialog" class="hidden"></div>');
					dialog.appendTo($('body'));
				}

				dialog.load($(this).attr('href'), function() {
					dialog.dialog({modal: true, width:960});
					discountForm.submissionCallback = function() {
						dialog.dialog('close');
						$('.discounts_index').load('/discounts/?company_id=' + companyId);
					};
				});
				return false;
			});
		});

		$('.discount_new').click(function() {
			var dialog = $('#discount_new_dialog');
			if (dialog.length == 0) {
				dialog = $('<div id="discount_new_dialog" class="hidden"></div>');
				dialog.appendTo($('body'));
			}

			dialog.load('/discounts/new?company_id='+companyId, function() {
				dialog.dialog({modal: true, width:960});
				discountForm.submissionCallback = function() {
					dialog.dialog('close');
					$('.discounts_index').load('/discounts/?company_id=' + companyId);
				};
			});
			return false;
		});

	},
	initSubmission: function() {
		var rootObject = this;
		var uri = $('#form_destination').val();
		$('<input type="hidden" name="_method" value="put"/>').appendTo('form');
		$('.company_form_step_1_form, .company_form_step_2_form, .company_form_step_3_form').ajaxForm({
			url: uri,
            success: function (data) {
				if (data.success) {
					rootObject.showSuccess();
					$('.certificate_of_insurance_filename').text(data.certificate_of_insurance_filename);
				}
				else {
					alert('There was an issue updating your company.');
				}
            },
            type: 'POST',
			dataType: 'json'
        });
	},
	initTabs: function() {
		$('.company_form_nav a').click(function() {
			var target_tab = $(this).attr('target_tab');
			if (target_tab == null || target_tab == '') { console.log('No target tab!'); return;}
			$('.target_tab').hide();
			$('.' + target_tab).show();
			return false;
		});
	},
	initValidation: function() {
		$('input[type="submit"]').attr('disabled',true);
		this.initValidationStep1();
		this.initValidationStep2();
		this.initValidationStep3();
	},
	initValidationStep1: function() {
		$('.company_form_step_1_form').bind('change keyup', function() {
			if ($(this).validate().checkForm())
			{
				$('.company_form_step_1_form input[type="submit"]').attr('disabled',false);
			}
			else
			{
				$('.company_form_step_1_form input[type="submit"]').attr('disabled',true);
			}
		});
		$('.company_form_step_1_form').validate({
			rules: {
				"company[name]": {required: true},
				"company[email_address]": {required: true, email: true},
				"company[main_phone_number]": {required: true, phoneUS: true},
				"company[address_1]": {required: true},
				"company[city]": {required: true},
				"company[state]": {required: true},
				"company[web_site]": {url: true},
				"company[zip_code]": { required: true, digits: true}
			},
			onkeyup: false
		});
	},
	initValidationStep2: function() {
		$('.company_form_step_2_form input[type="submit"]').attr('disabled',false);
	},
	initValidationStep3: function() {
		$('.company_form_step_3_form input[type="submit"]').attr('disabled',false);
	},
	showSuccess: function() {
		var notifications = $('.notifications');
		$('<div class="success">Your company info has been successfully saved.</div>').appendTo(notifications);
		notifications.fadeIn(500).fadeOut(3000, function() {notifications.empty();});
	}
};
var companiesIndex = {
	init: function() {
		if ($('.companies_index').length !== 0) {
			this.initDeleteLinks();
		}
	},
	initDeleteLinks: function() {
	    $('a.delete').live('click', function(event) {
			var rootObject = $(this);

			if ( confirm("Are you sure you want to delete this?") )
	            $.ajax({
	                url: this.href.replace('/delete', ''),
	                type: 'post',
	                data: { '_method': 'delete' },
	                success: function() {
						rootObject.closest('tr').fadeOut(1000);
	                },
					error: function(data) {
						alert(data.responseText);
					}
	            });

	        return false;
	    });
	}
};
var companiesNew = {
	init: function() {
		if ($('.new_company').length !== 0) {
			this.initSubmission();
			this.initTabs();
			this.initValidation();
		}
	},
	initSubmission: function() {
		var uri = $('#form_destination').val();
		$('.company_form_step_1_form').ajaxForm({
			url: uri,
            success: function (data) {
				if (data.success) {
					window.location = '/companies/'+data.company_id+'/edit';
				}
				else {
					alert('There was an issue adding your company.');
				}
            },
            type: 'POST'
        });
	},
	initTabs: function() {
		$('.company_form_nav a:first').addClass('active').click(function() { return false;});
		$('.company_form_nav a').not('.active').click(function() {
			alert('You must fill out and save the basic info before you may continue.');
			return false;
		});
	},
	initValidation: function() {
		$('.company_form_step_1 input[type="submit"]').attr('disabled',true);
		$('.company_form_step_1_form').bind('change keyup', function() {
			if ($(this).validate().checkForm())
			{
				$('.company_form_step_1_form input[type="submit"]').attr('disabled',false);
			}
			else
			{
				$('.company_form_step_1_form input[type="submit"]').attr('disabled',true);
			}
		});
		$('.company_form_step_1_form').validate({
			rules: {
				"company[name]": {required: true},
				"company[email_address]": {required: true, email: true},
				"company[main_phone_number]": {required: true, phoneUS: true},
				"company[address_1]": {required: true},
				"company[city]": {required: true},
				"company[state]": {required: true},
				"company[web_site]": {url: true},
				"company[zip_code]": { required: true, digits: true}
			},
			onkeyup: false
		});
	}
};
var companiesSearch = {
	searchTimer: null,
	init: function() {
		if ($('.companies_search').length !== 0) {
			this.initCompanyDisplay();
			this.initSearchBox();
		}
	},
	initCompanyDisplay: function() {
		var $company_show = $('.company_show');
		$company_show.empty();
		$('.company_show_no_data_template .no_data').clone().appendTo($company_show);

		$('.company').click(function() {
			var $this = $(this);
			var id = $this.find('.company_id').val();
			$company_show.html('<img src="/images/loading_small.gif" alt="Loading..."/>');
			$company_show.load('/companies/' + id);
			$this.addClass('active');
		});
	},
	initSearchBox: function() {
		var $search_box = $('.companies_search input[type="text"]');
		var search = function() {
			$('.loading_graphic').show();
			if (companiesSearch.searchTimer != null) clearTimeout(companiesSearch.searchTimer);
			companiesSearch.searchTimer = setTimeout('companiesSearch.performSearch();', 300);
		};
		$search_box.keypress(search);
		$search_box.change(function() {
			if ($(this).val() == '') search();
		});
		search(); // prepopulate
		$search_box.watermark('Provider Name');
	},
	performSearch: function() {
		$.ajax({
            url: $('.companies_search').attr('action'),
			type: 'post',
            data: { 'company_name': $('#company_name').val() },
            success: function(data) {
				$companies_index = $('.companies_index_search');
				$('.loading_graphic').hide();
				if (!data.success) { alert('There was an error running your search.  Please try again later.');console.log(data.message);return false;}
				$companies_index.empty();
				if (data.companies.length > 0)
					$("#company_template").tmpl(data.companies).appendTo($companies_index);
				else
					$('.companies_index_search_no_data_template .no_data').clone().appendTo($companies_index);
				companiesSearch.initCompanyDisplay();
            }
        });
	}
};
var datePickers = {
	submissionCallback: null,
	init: function() {
		$('.datepicker').datepicker();
	}
};
var discountForm = {
	submissionCallback: null,
	init: function() {
		if ($('.discount_form').length !== 0) {
			this.initImageDestroyLinks();
			this.initSubmission();
			this.initValidation();
		}
	},
	initImageDestroyLinks: function() {
		$('.discount_form .remove_image a').click(function() {
			var rootObject = $(this);
			if ( confirm("Are you sure you want to delete this?") )
	        	$.ajax({
	                url: this.href,
	                type: 'post',
	                success: function(data) {
						if (!data.success) { alert('There was an error removing your image.  Message was ' + data.message);return false;}
						rootObject.fadeOut();
						$('.uploaded_filename').fadeOut();
						$('.discount_image').attr('src', '/images/fpo-default-discount.jpeg');
	                }
	            });

			return false;
		});
	},
	initSubmission: function() {
		var rootObject = this;
		var uri = $('.discount_form').attr('action');

		$('.discount_form').ajaxForm({
			dataType: 'json',
			url: uri,
            success: function(data) {
				if (data.success) {
					rootObject.submissionCallback == null ? alert('No callback specified.') : rootObject.submissionCallback();
				} else {
					alert('An error occured during your submission.  We have been notified.');
				}
			},
            type: 'POST'
        });
	},
	initValidation: function() {
		$('.discount_form input[type="submit"]').attr('disabled',true);
		$('.discount_form').validate({
			rules: {
				"discount[type_id]": {required: true},
				"discount[description]": {required: true},
				"image_file": {required: true},
				"discount[market]": {required: true},
				"discount[start_date]": {required: true},
				"discount[end_date]": {required: true}
			},
			onkeyup: false
		});
		$('.discount_form').bind('change keyup', function() {
			if ($(this).validate().checkForm())
			{
				$('.discount_form input[type="submit"]').attr('disabled',false);
			}
			else
			{
				$('.discount_form input[type="submit"]').attr('disabled',true);
			}
		});
	}
};
var usersEdit = {
	originalEmailAddress: null,
	init: function() {
		if ($('.edit_user').length !== 0) {
			this.initPasswordChanging();
			this.initValidation();
		}
	},
	initPasswordChanging: function() {
		$('.change_password').hide();
		$('#user_change_password').change(function() {
			if ($(this).attr('checked'))
			{
				$('.change_password').slideDown()
			}
			else
			{
				$('.change_password').slideUp();
				$('.change_password input[type="password"]').val('').removeClass('error');
				$('.change_password label.error').remove();
			}
		});
	},
	initValidation: function() {
		var rootObject = this;
		this.originalEmailAddress = $('.edit_user #user_email_address').val();
		$('.edit_user').bind('change keyup', function() {
			if ($(this).validate().checkForm()) {
				$('.edit_user input[type="submit"]').attr('disabled',false);
			}
			else {
				$('.edit_user input[type="submit"]').attr('disabled',true);
			}
		});
		jQuery.extend(jQuery.validator.messages,
		     { remote: "Email address in use.  Please choose a different email address." });
		$('.edit_user').validate({
			rules: {
				"user[email_address]": {required: true, email: true},
				"user[first_name]": {required: true},
				"user[last_name]": {required: true},
				"user[password_confirm]": { equalTo: '#user_password'}
			}
		});
		$('.edit_user #user_email_address').change(function() {
			var $this = $(this);
			if ($this.val() == rootObject.originalEmailAddress) {
				$this.rules('remove', 'remote');
			}
			else {
				$this.rules('add', { remote: '/users/validate_email_is_unique'});
			}
		});
	}
};
var usersLogin = {
	init: function() {
		if ($('.login_user').length !== 0) {
			this.initValidation();
		}
	},
	initValidation: function() {
		$('.login_user input[type="submit"]').attr('disabled',true);
		$('.login_user').bind('change keyup', function() {
			if ($(this).validate().checkForm())
			{
				$('.login_user input[type="submit"]').attr('disabled',false);
			}
			else
			{
				$('.login_user input[type="submit"]').attr('disabled',true);
			}
		});
		$('.login_user').validate({
			rules: {
				"user[email_address]": {required: true, email: true },
				"user[password]": {required: true}
			},
			onkeyup: false
		});
	}
};
var usersNew = {
	init: function() {
		if ($('.new_user').length !== 0) {
			this.initValidation();
		}
	},
	initValidation: function() {
		$('.new_user input[type="submit"]').attr('disabled',true);
		$('.new_user').bind('change keyup', function() {
			if ($(this).validate().checkForm())
			{
				$('.new_user input[type="submit"]').attr('disabled',false);
			}
			else
			{
				$('.new_user input[type="submit"]').attr('disabled',true);
			}
		});
		jQuery.extend(jQuery.validator.messages,
		     { remote: "Email address in use.  Please choose a different email address." });
		$('.new_user').validate({
			rules: {
				"user[email_address]": {required: true, email: true, remote: "/users/validate_email_is_unique" },
				"user[first_name]": {required: true},
				"user[last_name]": {required: true},
				"user[password]": {required: true},
				"user[password_confirm]": {required: true, equalTo: '#user_password'}
			},
			onkeyup: false
		});
	}
};
