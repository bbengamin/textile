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


var points = [];
var markers = [];
var deliveryPoints = [];
var infowindow;
var service;
var delayTimer;

$(document).ready(function() {

/*cart*/
	$('#buy-form').on("click", ".minus" ,function(){
        var count = parseInt($(this).next().val());
        $(this).next().val(count-1);
        if(count <= 1 || isNaN(count)){
            $(this).next().val(1);
        }
        $(this).next().trigger('change');
    });
    
    $('#buy-form').on("click", ".plus" ,function(){
        var count = parseInt($(this).prev().val());
        $(this).prev().val(count+1);
        $(this).prev().trigger('change');
    });
    
    $('#buy-form').on('change', '.quantity-input',function() {
        $.ajax({
            url: 'index.php?route=checkout/buy/editMy',
            type: 'post',
            data: $(this),
            dataType: 'json',
            success: function(json) {
                $('#buy-form').load('index.php?route=checkout/buy #buy-load');
            }
        });
        
    });
    
    $(document).on('click', '.point-selector', function(){
        var ref = $(this).attr('data-ref');
        map.setZoom(17);
        map.panTo(points[ref]);
        new google.maps.event.trigger( markers[ref], 'click' );
    });
    
    $(document).on('click', '#input-payment-address-1', function() {
        var ref = $('#input-payment-city').attr('data-ref');
        if(ref){
            for (var i = 0; i < markers.length; i++) {
              markers[i].setMap(null);
            }
            markers = [];
            points = [];
            deliveryPoints = [];
            $('.point-selector-wrapper').empty();
            
            infowindow = new google.maps.InfoWindow();
            service = new google.maps.places.PlacesService(map);
            
            $.ajax({
                url: 'index.php?route=checkout/buy/getMap&ref=' + ref,
                type: 'get',
                data: $(this),
                dataType: 'json',
                success: function(json) {
                    $.each(json['points'], function(i, point){
                        var html = "<div class='point-selector' data-ref='" + point.id + "'><span>" + point.name + "</span></div>";
                        $('.point-selector-wrapper').append(html);
                        
                        var myLatLng = {lat: parseFloat(point.latitude), lng: parseFloat(point.longitude)};
                        var myPoint = new google.maps.Marker({
                            position: myLatLng,
                            map: map
                          });
                        points[point.id] = myLatLng;
                        markers[point.id] = myPoint;
                        deliveryPoints[point.id] = point;
                        google.maps.event.addListener(myPoint, 'click', (function(myPoint, i) {
                            return function() {
                                infowindow.setContent('<div class=\'map-pop-title\'>' + point.name + '</div><a class=\'at-map-link\' data-ref=\'' + point.id + '\'>Доставить сюда</a>');
                                infowindow.open(map, myPoint);
                            }
                        })(myPoint, 0));
                        
                    });
                    
                    map.setZoom(11);
                    map.panTo(points[Object.keys(points)[0]]);
                    
                    $('#modal-delivery').modal('show');
                    google.maps.event.trigger(map, "resize");
                }
            });
        }
    });
    $(document).on('click', '.at-map-link', function() {
       var ref = $(this).attr('data-ref');
       var point = deliveryPoints[ref];
       infowindow.close();
       $('#input-payment-address-1').val(point.name);
       $('#modal-delivery').modal('hide');
    });
    
    $(document).on('keyup', '#input-payment-city', function() {
        self = $(this);
        clearTimeout(delayTimer);
        delayTimer = setTimeout(function() {
    		var value = self.val();
    		if(value){
        		$.ajax({
        			url: 'index.php?route=checkout/buy/citySearch',
        			type: 'get',
        			data: 'text=' + value,
        			dataType: 'json',
        			success: function(json) {
        			    var cities = "";
        			    $.each(json['cities'], function(key, val) {
        			        cities += "<div class='city-element' data-id='" + val.id + "'>" + val.name + "</div>"
                        });
        				$('#cities-dropdown').html(cities);
    				    $('#cities-dropdown').removeClass('hidden');
        			}
        		});
    		}
        }, 300);
    });
    
    $(document).on('click', '.city-element', function() {
        $('#input-payment-city').val($(this).text());
        $('#input-payment-city').attr('data-ref', $(this).attr('data-id'));
        $('#input-payment-address-1').trigger('click');
        $('#cities-dropdown').addClass('hidden');
    });
/*cart*/

    $('#reviews-box').owlCarousel({
        items: 2,
        center: true,
        autoPlay: false,
        navigation: true,
        navigationText: ['<i class="fa fa-chevron-left fa-5x"></i>', '<i class="fa fa-chevron-right fa-5x"></i>'],
        pagination: false
    });
    function screenHeight() {
        var nav_height = 0;
        if ($(window).width() > 1024) {
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
                if (json['error']) {
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
    $('#form-quick-buy').on('submit', function(e) {
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
                if (json['error']) {
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
    $(document).on('click', '.quick-view', function() {
        $('#modal-quick-views').modal('show');
        $('#quick-view-body-box').addClass('loading');
        var product_id = $(this).attr('data-id');
        $.ajax({
            url: 'index.php?route=product/quickview',
            type: 'get',
            data: 'product_id=' + product_id,
            dataType: 'html',
            success: function(data) {
                $('#quick-view-body-box').html(data);
                $('#quick-view-body-box').removeClass('loading');
            }
        });
    });
    $('#modal-quick-views').on('hidden.bs.modal', function() {
        $('.zoomContainer').detach();
    })
    $('#nav-bar ul.cat-nav li').on('click', function(e) {
        e.preventDefault();
        $('#nav-bar ul.cat-nav li').removeClass('active');
        $(this).addClass('active');
        $(this).append($('#white-feather').detach());
        var id = $(this).attr('data-id');
        $('#main-products-block').addClass('loading');
        $.ajax({
            url: 'index.php?route=product/ajax/mainProducts',
            type: 'get',
            data: 'category_id=' + id,
            dataType: 'html',
            success: function(data) {
                if (!firstTime) {
                    $('html, body').animate({
                        scrollTop: $('#first-screen .background').height()
                    }, 'fast');
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
    if (id > 0) {
        $('#nav-bar ul.cat-nav li[data-id="' + id + '"]').trigger("click");
    } else {
        $('#nav-bar ul.cat-nav li:nth-child(' + level + ')').trigger("click");
    }
    $(document).on('click', '.category-tabs a', function(e) {
        e.preventDefault();
        $('.category-tabs a').removeClass('active');
        $('.category-tab').removeClass('active');
        $(this).addClass('active');
        $($(this).attr('href')).addClass('active');
        return false;
    })
    $(window).scroll(function(e) {
        e.preventDefault();
        if ($(window).width() > 1024) {
            if ($(window).scrollTop() >= $('#first-screen').height()) {
                $('#nav-bar').addClass('fixed');
                $('#content').addClass('fixed');
            } else if ($('#nav-bar').hasClass('fixed')) {
                $('#nav-bar').removeClass('fixed');
                $('#content').removeClass('fixed');
            }
            if ($(window).scrollTop() >= $('#first-screen').height() - 500) {
                $('#footer-nav-fixed').removeClass('hidden');
            } else {
                $('#footer-nav-fixed').addClass('hidden');
            }
        }
        if ($(window).scrollTop() >= 100) {
            if (!$(".vidget-callback").is(':visible')) {
                $(".vidget-callback").fadeOut("slow", function() {
                    $(this).show();
                });
            }
        } else {
            if ($(".vidget-callback").is(':visible')) {
                $(".vidget-callback").fadeOut("slow", function() {
                    $(this).hide();
                });
            }
        }
        return false;
    });
    $(window).resize(function() {
        screenHeight();
    });
    setTimeout(function() {
        $(window).trigger('scroll');
        if ($(window).scrollTop() == 0) {
            $("#white-feather").animate({
                marginLeft: -65,
                bottom: 30
            }, {
                duration: 2000,
                complete: function() {
                    $('#white-feather').addClass("category-mode");
                },
                specialEasing: {
                    marginLeft: "linear",
                    bottom: "swing"
                }
            });
        } else {
            $('#white-feather').addClass("category-mode");
        }
    }, 1000)
    $(window).trigger('resize');
    $('.vidget-callback a.up').on('click', function() {
        $('html, body').animate({
            scrollTop: 0
        }, 'fast');
    });
    $('.vidget-callback a.call, .call-back-top-btn, .call-back-top-btn-mob, #footer-nav-fixed .footer-callback').on('click', function() {
        $('#modal-call-back-header').modal('show');
    });
    $('.text-danger').each(function() {
        var element = $(this).parent().parent();
        if (element.hasClass('form-group')) {
            element.addClass('has-error');
        }
    });
    $('#currency .currency-select').on('click', function(e) {
        e.preventDefault();
        $('#currency input[name=\'code\']').attr('value', $(this).attr('name'));
        $('#currency').submit();
    });
    $('#language a').on('click', function(e) {
        e.preventDefault();
        $('#language input[name=\'code\']').attr('value', $(this).attr('href'));
        $('#language').submit();
    });
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
    $('#menu .dropdown-menu').each(function() {
        var menu = $('#menu').offset();
        var dropdown = $(this).parent().offset();
        var i = (dropdown.left + $(this).outerWidth()) - (menu.left + $('#menu').outerWidth());
        if (i > 0) {
            $(this).css('margin-left', '-' + (i + 5) + 'px');
        }
    });
    $('#list-view').click(function() {
        $('#content .product-grid > .clearfix').remove();
        $('#content .row > .product-grid').attr('class', 'product-layout product-list col-xs-12');
        localStorage.setItem('display', 'list');
    });
    $('#grid-view').click(function() {
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
    $(document).on('keydown', '#collapse-checkout-option input[name=\'email\'], #collapse-checkout-option input[name=\'password\']', function(e) {
        if (e.keyCode == 13) {
            $('#collapse-checkout-option #button-login').trigger('click');
        }
    });
});
var cart = {
    'add': function(product_id, quantity) {
        $.ajax({
            url: 'index.php?route=checkout/cart/add',
            type: 'post',
            data: 'product_id=' + product_id + '&quantity=' + (typeof (quantity) != 'undefined' ? quantity : 1),
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
                    setTimeout(function() {
                        $('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
                    }, 100);
                    $('html, body').animate({
                        scrollTop: 0
                    }, 'slow');
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
            data: 'key=' + key + '&quantity=' + (typeof (quantity) != 'undefined' ? quantity : 1),
            dataType: 'json',
            beforeSend: function() {
                $('#cart > button').button('loading');
            },
            complete: function() {
                $('#cart > button').button('reset');
            },
            success: function(json) {
                setTimeout(function() {
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
                setTimeout(function() {
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
    'add': function() {},
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
                setTimeout(function() {
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
                $('html, body').animate({
                    scrollTop: 0
                }, 'slow');
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    },
    'remove': function() {}
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
                    $('html, body').animate({
                        scrollTop: 0
                    }, 'slow');
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    },
    'remove': function() {}
}
$(document).delegate('.agree', 'click', function(e) {
    e.preventDefault();
    $('#modal-agree').remove();
    var element = this;
    $.ajax({
        url: $(element).attr('href'),
        type: 'get',
        dataType: 'html',
        success: function(data) {
            html = '<div id="modal-agree" class="modal">';
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
(function($) {
    $.fn.autocomplete = function(option) {
        return this.each(function() {
            this.timer = null;
            this.items = new Array();
            $.extend(this, option);
            $(this).attr('autocomplete', 'off');
            $(this).on('focus', function() {
                this.request();
            });
            $(this).on('blur', function() {
                setTimeout(function(object) {
                    object.hide();
                }, 200, this);
            });
            $(this).on('keydown', function(event) {
                switch (event.keyCode) {
                case 27:
                    this.hide();
                    break;
                default:
                    this.request();
                    break;
                }
            });
            this.click = function(event) {
                event.preventDefault();
                value = $(event.target).parent().attr('data-value');
                if (value && this.items[value]) {
                    this.select(this.items[value]);
                }
            }
            this.show = function() {
                var pos = $(this).position();
                $(this).siblings('ul.dropdown-menu').css({
                    top: pos.top + $(this).outerHeight(),
                    left: pos.left
                });
                $(this).siblings('ul.dropdown-menu').show();
            }
            this.hide = function() {
                $(this).siblings('ul.dropdown-menu').hide();
            }
            this.request = function() {
                clearTimeout(this.timer);
                this.timer = setTimeout(function(object) {
                    object.source($(object).val(), $.proxy(object.response, object));
                }, 200, this);
            }
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


cart.remove = function(key) {
    $.ajax({
        url: 'index.php?route=checkout/cart/remove',
        type: 'post',
        data: 'key=' + key,
        dataType: 'json',
        success: function(json) {
            location.reload();
        }
    });
}
$('#checkout-form select[name=\'country_id\']').on('change', function() {
    $.ajax({
        url: 'index.php?route=checkout/checkout/country&country_id=' + this.value,
        dataType: 'json',
        beforeSend: function() {
            $('#checkout-form #payment-zone').before('<span class="form-control-feedback"><i class="fa fa-circle-o-notch fa-spin"></i></span>');
        },
        complete: function() {
            $('#checkout-form #payment-zone .form-control-feedback').remove();
        },
        success: function(json) {
            if (json['postcode_required'] == '1') {
                $('#checkout-form input[name=\'postcode\']').parent().addClass('required');
            } else {
                $('#checkout-form input[name=\'postcode\']').parent().removeClass('required');
            }

            html = '<option value=""> --- Please Select --- </option>';

            if (json['zone']) {
                for (i = 0; i < json['zone'].length; i++) {
                    html += '<option value="' + json['zone'][i]['zone_id'] + '"';
                    
                    html += '>' + json['zone'][i]['name'] + '</option>';
                }
            } else {
                html += '<option value="0" selected="selected"> --- None --- </option>';
            }

            var zone_id = $('#checkout-form [name=\'zone_id\']').val();
            if (zone_id) {
                updateShM(zone_id);
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
});

$('#checkout-form select[name=\'country_id\']').trigger('change');
function updateShM(zone_id) {
    $('#shipping_methods').load('index.php?route=checkout/buy/getShippingMethods&zone_id=' + zone_id, function() {
        $('#shm_loading').empty();
        selectShipping();
    });
    $('#payment_methods').load('index.php?route=checkout/buy/getPaymentMethods&zone_id=' + zone_id, function() {
        $('#pay_loading').empty();
    });
}
function getPaymentForm(code, callback) {
    $.ajax({
        async: false,
        cache: false,
        url: 'index.php?route=checkout/buy/getPaymentForm',
        type: 'post',
        data: 'code=' + code.split('.')[0] + '&payment_method=' + code,
        dataType: 'json',
        success: function(json) {
            $('#payment_form2').html(json['output']);
            callback();
        }
    });
}
$('#button-order').click(function() {
    $.ajax({
        url: 'index.php?route=checkout/buy/save',
        type: 'post',
        data: $('#checkout-form input[type=\'text\'], #checkout-form input[type=\'checkbox\']:checked, #checkout-form select, #checkout-form input[type=\'radio\']:checked, #checkout-form textarea, #checkout-form input[type=\'hidden\']'),
        dataType: 'json',
        success: function(json) {
            $('.error').remove();
            $('.warning').remove();
            if (json['redirect']) {
                location = json['redirect'];
            }
            if (json['error']) {
                $('#checkout-form .has-error').removeClass('has-error');
                $('#checkout-form .text-danger').remove();
                if (json['error']['warning']) {
                    addWarning(json['error']['warning']);
                }
                if (json['error']['firstname']) {
                    addError('#input-payment-firstname', json['error']['firstname']);
                }
                if (json['error']['lastname']) {
                    addError('#input-payment-lastname', json['error']['lastname']);
                }
                if (json['error']['email']) {
                    addError('#input-payment-email', json['error']['email']);
                }
                if (json['error']['telephone']) {
                    addError('#input-payment-telephone', json['error']['telephone']);
                }
                if (json['error']['fax']) {
                    addError('#input-payment-fax', json['error']['fax']);
                }
                if (json['error']['company']) {
                    addError('#input-payment-company', json['error']['company']);
                }
                if (json['error']['country']) {
                    addError('#input-payment-country', json['error']['country']);
                }
                if (json['error']['zone']) {
                    addError('#input-payment-zone', json['error']['zone']);
                }
                if (json['error']['city']) {
                    addError('#input-payment-city', json['error']['city']);
                }
                if (json['error']['postcode']) {
                    addError('#input-payment-postcode', json['error']['postcode']);
                }
                if (json['error']['address_1']) {
                    addError('#input-payment-address-1', json['error']['address_1']);
                }

                $('.wait').remove();
            } else {
                $.ajax({
                    url: 'index.php?route=checkout/buy/confirm',
                    type: 'get',
                    dataType: 'json',
                    success: function() {
                        var code = $('#checkout-form input[name=\'payment_method\']:checked').val();
                        getPaymentForm(code, function() {

                            if ($('p,h1,h2,h3,input[type=text],input[type=radio],input[type=checkbox],input[type=password],select', $('#payment-form')).length > 0) {
                                $('#payment-form').css('display', 'block');
                            } else {
                                var payment_form = $('#payment-form form#payment');

                                if (payment_form.length) {
                                    payment_form.submit();
                                } else {
                                    var href = $('#payment-form div.buttons a').attr('href');
                                    if (typeof href != 'undefined' && href != '' && href != '#') {
                                        location = href;
                                    } else {
                                        $('#payment-form div.buttons a,#payment-form div.buttons input[type=button],#payment-form div.buttons input[type=submit],#payment-form form input[type=submit]').click();
                                    }
                                }
                            }
                        });
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError);
                    }
                });
            }
        }
    });
});
function getPaymentForm(code, callback) {
    $.ajax({
        async: false,
        cache: false,
        url: 'index.php?route=checkout/buy/getPaymentForm',
        type: 'post',
        data: 'code=' + code.split('.')[0] + '&payment_method=' + code,
        dataType: 'json',
        success: function(json) {
            $('#payment-form').html(json['output']);
            callback();
        }
    });
}
function addWarning(text) {
    $('#checkout-form .alert').remove();
    $('#checkout-form').before('<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>' + text + '</div>');
    $('html, body').animate({
        scrollTop: $("#checkout-form").offset().top - 15
    }, {
        duration: 500,
        complete: function() {
            $('#checkout-form .alert').animate({opacity: 0}, 100).animate({opacity: 1}, 100);
        }
    });

}
function addError(el, text) {
    $(el).parent().addClass('has-error');
    $(el).after('<div class="text-danger">' + text + '</div>');
}
function selectShipping(){
    if(typeof($('input[name="shipping_method"]')) !== 'undefined'){
        $.ajax({
            async: false,
            cache: false,
            url: 'index.php?route=checkout/buy/selectShipping',
            type: 'post',
            data: 'code='+$('input[name="shipping_method"]:checked').val(),
            dataType: 'json',
            success: function(json) {
                if(json['totals']){
                    var container = $('.total-item').closest('table');
                    container.children('tbody').children('.total-item').remove();
                    container.children('tbody').append(json['totals']);
                }
            }
        });
    }
}