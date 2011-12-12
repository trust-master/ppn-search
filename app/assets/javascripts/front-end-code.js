$(document).ready(function() {
	dropdownMenu.init();

	$( '.checkbox' ).button();

	currentDateValue.init();
	moreInfo.init();
	deactivateModal.init();

	var cf = new CustomFormElements({
			selectWidth: 192
	});

});

var deactivateModal = {
	init: function() {
		var self = this;
		if( $('.deactivate').length !==0) {
			self.bind();
		}
	},

	bind: function() {
		$('.deactivate').click(function() {
			$('#deactivate-account').dialog({
				title: 'Deactivate Account'
			});
			return false;
		});

	}
}


var dropdownMenu =  {
	init: function() {
		$('.account-links li a').hover(function() {
			$(this).parent().children('.dropdown').show();
		}, function() {
			$(this).parent().children('.dropdown').hide();
		});
	}
}

var currentDateValue = {
	init: function() {
		var self = this;
		if( $('.date').length !==0) {
			self.bind();
		}
	},

	bind: function() {

		$( ".date" ).datepicker({showOn: 'both'});
		var myDate = new Date();
	    var month = myDate.getMonth() +1;
	    var currentDate = month + '/' + myDate.getDate() + '/' + myDate.getFullYear();
	    if($('.date').val('')) {
			$(".date").val(currentDate);
		}
	}
}

var moreInfo = {
	init: function() {
		var self = this;
		if( $('.more-info').length !==0) {
			self.bind();
		}
	},

	bind: function() {

		$('.more-info').click(function() {
			$(this).parent('li').children('.tooltip').show();
			$('.tooltip-close').click(function() {
				$(this).parents('.tooltip').hide();
				return false;
			});
				return false;
		});
	}
}
