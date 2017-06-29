function getURLVar(key) {
	var value = [];

	var query = String(document.location).split('?');

	if (query[1]) {
		var part = query[1].split('&');

		for (i = 0; i < part.length; i++) {
			var data = part[i].split('=');

			if (data[0] && data[1]) {
				value[data[0]] = data[1];
			}
		}

		if (value[key]) {
			return value[key];
		} else {
			return '';
		}
	}
}
var firstTime = true;
var phoneMask = "+38(099)999-99-99";
var phoneMaskMobile = "+380999999999";
$(document).ready(function() {
	function screenHeight(){
		var nav_height = 0;
		if($(window).width() > 1024){
			nav_height = $('#nav-bar').height();
		}
		$('#first-screen .background').css('height', ($(window).height() - nav_height));
	}
	
	if ($(window).width() < 768) {
        $('input[name="phone"]').mask(phoneMaskMobile);
        $('input[name="telephone"]').mask(phoneMaskMobile);
    } else {
        $('input[name="phone"]').mask(phoneMask);
        $('input[name="telephone"]').mask(phoneMask);
    }
    
	$('#form-call-back-header').on('submit', function(e) {
		e.preventDefault();
		$('#form-call-back-header input').removeClass('red_error');
		$('#form-call-back-header .error').detach();
		$.ajax({
			url: 'index.php?route=checkout/fast/callback',
			type: 'post',
			data: $('#form-call-back-header input'),
			dataType: 'json',
			success: function(json) {
				$('#form-call-back-header .error');
				if(json['error']){
					if (json['error']['name']) {
						$('#form-call-back-header input[name="name"]').after('<span class="error">' + json['error']['name'] + '</span>');
						$('#form-call-back-header input[name="name"]').addClass('red_error');
					}
					if (json['error']['phone']) {
						$('#form-call-back-header input[name="phone"]').after('<span class="error">' + json['error']['phone'] + '</span>');
						$('#form-call-back-header input[name="phone"]').addClass('red_error');
					}
				}

				if (json['success']) {
					$('#form-call-back-header').hide();
					$('#form-call-back-header').next().show();
				}
			}
		});

		return false;
	});
	
	$(document).on('click', '.fast-order-btn', function(e) {
	    e.preventDefault();
		
		var id = $(this).attr('data-id');
		$('#modal-quick-buy').find('input[name="product_id"]').val(id);
			
	    $('#modal-quick-buy').modal('show');
	    $('#modal-quick-views').modal('hide');
			   
	    return false;
	});
	
	$('#form-quick-buy').on('submit',function(e){
		e.preventDefault();
		$('#form-quick-buy input').removeClass('red_error');
		$('#form-quick-buy .error').detach();
		$.ajax({
			url: 'index.php?route=checkout/fast/fastorder',
			type: 'post',
			data: $('#form-quick-buy input'),
			dataType: 'json',
			success: function(json) {
				$('#form-quick-buy .error');
				if(json['error']){
					if (json['error']['name']) {
						$('#form-quick-buy input[name="name"]').after('<span class="error">' + json['error']['name'] + '</span>');
						$('#form-quick-buy input[name="name"]').addClass('red_error');
					}
					if (json['error']['phone']) {
						$('#form-quick-buy input[name="phone"]').after('<span class="error">' + json['error']['phone'] + '</span>');
						$('#form-quick-buy input[name="phone"]').addClass('red_error');
					}
						if (json['error']['email']) {
						$('#form-quick-buy input[name="email"]').after('<span class="error">' + json['error']['email'] + '</span>');
						$('#form-quick-buy input[name="email"]').addClass('red_error');
					}
				}

				if (json['success']) {
					$('#form-quick-buy').hide();
					$('#form-quick-buy').next().show();
				}
			}
		});
		return false;
	});
	
	$(document).on('click', '.quick-view', function () {
		$('#modal-quick-views').modal('show');
		$('#quick-view-body-box').addClass('loading');
    	var product_id = $(this).attr('data-id');
    	$.ajax({
			url: 'index.php?route=product/quickview',
			type: 'get',
			data: 'product_id=' + product_id ,
			dataType: 'html',
			success: function(data) {
				$('#quick-view-body-box').html(data);
				$('#quick-view-body-box').removeClass('loading');
			}
		});
    });
    
    
	$('#modal-quick-views').on('hidden.bs.modal', function () {
	    $('.zoomContainer').detach();
	})
		
	$('#nav-bar ul.cat-nav li').on('click', function(e) {
	    e.preventDefault();
		
		$('#nav-bar ul.cat-nav li').removeClass('active');
		$(this).addClass('active');
		$(this).append($('#white-feather').detach());
	 //   $('#white-feather').addClass("category-mode");
	    
	    var id = $(this).attr('data-id');
	    $('#main-products-block').addClass('loading');
    	$.ajax({
			url: 'index.php?route=product/ajax/mainProducts',
			type: 'get',
			data: 'category_id=' + id,
			dataType: 'html',
			success: function(data) {
			    if(!firstTime){
			    	$('html, body').animate({ scrollTop: $('#first-screen .background').height() }, 'fast');
			    	$('#white-feather').addClass("category-mode");
			    }
			    firstTime = false;
				$('#main-products-block').html(data);
				$('#main-products-block').removeClass('loading');
				
				$('.category-tabs a').first().trigger('click');
			}
		});
	    
	    return false;
	});
	
	$(document).on('click', '.category-tabs a', function(e) {
	    e.preventDefault();
	    
	    $('.category-tabs a').removeClass('active');
	    $('.category-tab').removeClass('active');
	    
	    $(this).addClass('active');
	    $($(this).attr('href')).addClass('active');
	    
	    return false;
	})
	
	$(window).scroll(function(e){
		e.preventDefault();
		
		if($(window).width() > 1024){
			if($(window).scrollTop() >= $('#first-screen').height()){
				$('#nav-bar').addClass('fixed');
				$('#content').addClass('fixed');
				
			}else if($('#nav-bar').hasClass('fixed')){
				$('#nav-bar').removeClass('fixed');
				$('#content').removeClass('fixed');
			}
			
			if($(window).scrollTop() >= $('#first-screen').height() - 500){
				$('#footer-nav-fixed').removeClass('hidden');
			}else{
				$('#footer-nav-fixed').addClass('hidden');
			}
		}
		
		
		
		if($(window).scrollTop() >= 100){
			if(!$(".vidget-callback").is(':visible')){
				$(".vidget-callback").fadeOut("slow", function() {
				    $(this).show();
				});
			}
		}else{
			if($(".vidget-callback").is(':visible')){
				$(".vidget-callback").fadeOut("slow", function() {
				    $(this).hide();
				});
			}
		}
	
		return false;
	});
	$(window).resize(function(){
		screenHeight();
	});
	setTimeout(function(){
		$(window).trigger('scroll');
		if($(window).scrollTop() == 0){
			$("#white-feather")
				.animate({
					marginLeft: -65,
					bottom: 30
				}, { duration: 2000,
				    complete: function(){
			      		$('#white-feather').addClass("category-mode");
				    },
					specialEasing: {
				      marginLeft: "linear",
				      bottom: "swing"
				    }
				});
		}else{
			$('#white-feather').addClass("category-mode");
		}
	}, 1000)
	//$('#nav-bar ul.cat-nav li:nth-child(2)').trigger("click");
	
	$(window).trigger('resize');
	
	$('.vidget-callback a.up').on('click', function(){
		$('html, body').animate({ scrollTop: 0 }, 'fast');
	});
	
	$('.vidget-callback a.call, .call-back-top-btn, .call-back-top-btn-mob, #footer-nav-fixed .footer-callback').on('click', function(){
		$('#modal-call-back-header').modal('show');
	});
	
	// Highlight any found errors
	$('.text-danger').each(function() {
		var element = $(this).parent().parent();

		if (element.hasClass('form-group')) {
			element.addClass('has-error');
		}
	});

	// Currency
	$('#currency .currency-select').on('click', function(e) {
		e.preventDefault();

		$('#currency input[name=\'code\']').attr('value', $(this).attr('name'));

		$('#currency').submit();
	});

	// Language
	$('#language a').on('click', function(e) {
		e.preventDefault();

		$('#language input[name=\'code\']').attr('value', $(this).attr('href'));

		$('#language').submit();
	});

	/* Search */
	$('#search input[name=\'search\']').parent().find('button').on('click', function() {
		url = $('base').attr('href') + 'index.php?route=product/search';

		var value = $('header input[name=\'search\']').val();

		if (value) {
			url += '&search=' + encodeURIComponent(value);
		}

		location = url;
	});

	$('#search input[name=\'search\']').on('keydown', function(e) {
		if (e.keyCode == 13) {
			$('header input[name=\'search\']').parent().find('button').trigger('click');
		}
	});

	// Menu
	$('#menu .dropdown-menu').each(function() {
		var menu = $('#menu').offset();
		var dropdown = $(this).parent().offset();

		var i = (dropdown.left + $(this).outerWidth()) - (menu.left + $('#menu').outerWidth());

		if (i > 0) {
			$(this).css('margin-left', '-' + (i + 5) + 'px');
		}
	});

	// Product List
	$('#list-view').click(function() {
		$('#content .product-grid > .clearfix').remove();

		//$('#content .product-layout').attr('class', 'product-layout product-list col-xs-12');
		$('#content .row > .product-grid').attr('class', 'product-layout product-list col-xs-12');

		localStorage.setItem('display', 'list');
	});

	// Product Grid
	$('#grid-view').click(function() {
		// What a shame bootstrap does not take into account dynamically loaded columns
		cols = $('#column-right, #column-left').length;

		if (cols == 2) {
			$('#content .product-list').attr('class', 'product-layout product-grid col-lg-6 col-md-6 col-sm-12 col-xs-12');
		} else if (cols == 1) {
			$('#content .product-list').attr('class', 'product-layout product-grid col-lg-4 col-md-4 col-sm-6 col-xs-12');
		} else {
			$('#content .product-list').attr('class', 'product-layout product-grid col-lg-3 col-md-3 col-sm-6 col-xs-12');
		}

		 localStorage.setItem('display', 'grid');
	});

	if (localStorage.getItem('display') == 'list') {
		$('#list-view').trigger('click');
	} else {
		$('#grid-view').trigger('click');
	}

	// Checkout
	$(document).on('keydown', '#collapse-checkout-option input[name=\'email\'], #collapse-checkout-option input[name=\'password\']', function(e) {
		if (e.keyCode == 13) {
			$('#collapse-checkout-option #button-login').trigger('click');
		}
	});

});

// Cart add remove functions
var cart = {
	'add': function(product_id, quantity) {
		$.ajax({
			url: 'index.php?route=checkout/cart/add',
			type: 'post',
			data: 'product_id=' + product_id + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
			dataType: 'json',
			beforeSend: function() {
				$('#cart > button').button('loading');
			},
			complete: function() {
				$('#cart > button').button('reset');
			},
			success: function(json) {
				$('.alert, .text-danger').remove();

				if (json['redirect']) {
					location = json['redirect'];
				}
				
				if (json['form']) {
					$('#top-cart-total').html(json['total']);
					$('#footer-cart-total-value').html(json['total']);
					
					$('#modal-after-body').html(json['form']);
					$('#modal-quick-views').modal('hide');
					$('#modal-after').modal('show');
				}

				if (json['success']) {
					$('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');

					// Need to set timeout otherwise it wont update the total
					setTimeout(function () {
						$('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
					}, 100);

					$('html, body').animate({ scrollTop: 0 }, 'slow');

					$('#cart > ul').load('index.php?route=common/cart/info ul li');
				}
			},
	        error: function(xhr, ajaxOptions, thrownError) {
	            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	        }
		});
	},
	'update': function(key, quantity) {
		$.ajax({
			url: 'index.php?route=checkout/cart/edit',
			type: 'post',
			data: 'key=' + key + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
			dataType: 'json',
			beforeSend: function() {
				$('#cart > button').button('loading');
			},
			complete: function() {
				$('#cart > button').button('reset');
			},
			success: function(json) {
				// Need to set timeout otherwise it wont update the total
				setTimeout(function () {
					$('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
				}, 100);

				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
					location = 'index.php?route=checkout/cart';
				} else {
					$('#cart > ul').load('index.php?route=common/cart/info ul li');
				}
			},
	        error: function(xhr, ajaxOptions, thrownError) {
	            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	        }
		});
	},
	'remove': function(key) {
		$.ajax({
			url: 'index.php?route=checkout/cart/remove',
			type: 'post',
			data: 'key=' + key,
			dataType: 'json',
			beforeSend: function() {
				$('#cart > button').button('loading');
			},
			complete: function() {
				$('#cart > button').button('reset');
			},
			success: function(json) {
				// Need to set timeout otherwise it wont update the total
				setTimeout(function () {
					$('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
				}, 100);

				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
					location = 'index.php?route=checkout/cart';
				} else {
					$('#cart > ul').load('index.php?route=common/cart/info ul li');
				}
			},
	        error: function(xhr, ajaxOptions, thrownError) {
	            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	        }
		});
	}
}

var voucher = {
	'add': function() {

	},
	'remove': function(key) {
		$.ajax({
			url: 'index.php?route=checkout/cart/remove',
			type: 'post',
			data: 'key=' + key,
			dataType: 'json',
			beforeSend: function() {
				$('#cart > button').button('loading');
			},
			complete: function() {
				$('#cart > button').button('reset');
			},
			success: function(json) {
				// Need to set timeout otherwise it wont update the total
				setTimeout(function () {
					$('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
				}, 100);

				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
					location = 'index.php?route=checkout/cart';
				} else {
					$('#cart > ul').load('index.php?route=common/cart/info ul li');
				}
			},
	        error: function(xhr, ajaxOptions, thrownError) {
	            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	        }
		});
	}
}

var wishlist = {
	'add': function(product_id) {
		$.ajax({
			url: 'index.php?route=account/wishlist/add',
			type: 'post',
			data: 'product_id=' + product_id,
			dataType: 'json',
			success: function(json) {
				$('.alert').remove();

				if (json['redirect']) {
					location = json['redirect'];
				}

				if (json['success']) {
					$('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				}

				$('#wishlist-total span').html(json['total']);
				$('#wishlist-total').attr('title', json['total']);

				$('html, body').animate({ scrollTop: 0 }, 'slow');
			},
	        error: function(xhr, ajaxOptions, thrownError) {
	            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	        }
		});
	},
	'remove': function() {

	}
}

var compare = {
	'add': function(product_id) {
		$.ajax({
			url: 'index.php?route=product/compare/add',
			type: 'post',
			data: 'product_id=' + product_id,
			dataType: 'json',
			success: function(json) {
				$('.alert').remove();

				if (json['success']) {
					$('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');

					$('#compare-total').html(json['total']);

					$('html, body').animate({ scrollTop: 0 }, 'slow');
				}
			},
	        error: function(xhr, ajaxOptions, thrownError) {
	            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	        }
		});
	},
	'remove': function() {

	}
}

/* Agree to Terms */
$(document).delegate('.agree', 'click', function(e) {
	e.preventDefault();

	$('#modal-agree').remove();

	var element = this;

	$.ajax({
		url: $(element).attr('href'),
		type: 'get',
		dataType: 'html',
		success: function(data) {
			html  = '<div id="modal-agree" class="modal">';
			html += '  <div class="modal-dialog">';
			html += '    <div class="modal-content">';
			html += '      <div class="modal-header">';
			html += '        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>';
			html += '        <h4 class="modal-title">' + $(element).text() + '</h4>';
			html += '      </div>';
			html += '      <div class="modal-body">' + data + '</div>';
			html += '    </div';
			html += '  </div>';
			html += '</div>';

			$('body').append(html);

			$('#modal-agree').modal('show');
		}
	});
});

// Autocomplete */
(function($) {
	$.fn.autocomplete = function(option) {
		return this.each(function() {
			this.timer = null;
			this.items = new Array();

			$.extend(this, option);

			$(this).attr('autocomplete', 'off');

			// Focus
			$(this).on('focus', function() {
				this.request();
			});

			// Blur
			$(this).on('blur', function() {
				setTimeout(function(object) {
					object.hide();
				}, 200, this);
			});

			// Keydown
			$(this).on('keydown', function(event) {
				switch(event.keyCode) {
					case 27: // escape
						this.hide();
						break;
					default:
						this.request();
						break;
				}
			});

			// Click
			this.click = function(event) {
				event.preventDefault();

				value = $(event.target).parent().attr('data-value');

				if (value && this.items[value]) {
					this.select(this.items[value]);
				}
			}

			// Show
			this.show = function() {
				var pos = $(this).position();

				$(this).siblings('ul.dropdown-menu').css({
					top: pos.top + $(this).outerHeight(),
					left: pos.left
				});

				$(this).siblings('ul.dropdown-menu').show();
			}

			// Hide
			this.hide = function() {
				$(this).siblings('ul.dropdown-menu').hide();
			}

			// Request
			this.request = function() {
				clearTimeout(this.timer);

				this.timer = setTimeout(function(object) {
					object.source($(object).val(), $.proxy(object.response, object));
				}, 200, this);
			}

			// Response
			this.response = function(json) {
				html = '';

				if (json.length) {
					for (i = 0; i < json.length; i++) {
						this.items[json[i]['value']] = json[i];
					}

					for (i = 0; i < json.length; i++) {
						if (!json[i]['category']) {
							html += '<li data-value="' + json[i]['value'] + '"><a href="#">' + json[i]['label'] + '</a></li>';
						}
					}

					// Get all the ones with a categories
					var category = new Array();

					for (i = 0; i < json.length; i++) {
						if (json[i]['category']) {
							if (!category[json[i]['category']]) {
								category[json[i]['category']] = new Array();
								category[json[i]['category']]['name'] = json[i]['category'];
								category[json[i]['category']]['item'] = new Array();
							}

							category[json[i]['category']]['item'].push(json[i]);
						}
					}

					for (i in category) {
						html += '<li class="dropdown-header">' + category[i]['name'] + '</li>';

						for (j = 0; j < category[i]['item'].length; j++) {
							html += '<li data-value="' + category[i]['item'][j]['value'] + '"><a href="#">&nbsp;&nbsp;&nbsp;' + category[i]['item'][j]['label'] + '</a></li>';
						}
					}
				}

				if (html) {
					this.show();
				} else {
					this.hide();
				}

				$(this).siblings('ul.dropdown-menu').html(html);
			}

			$(this).after('<ul class="dropdown-menu"></ul>');
			$(this).siblings('ul.dropdown-menu').delegate('a', 'click', $.proxy(this.click, this));

		});
	}
})(window.jQuery);
