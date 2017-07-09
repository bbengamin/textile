<footer>


<div class="vidget-callback">
  <a class='call'> <i class="fa fa-phone" aria-hidden="true"></i></a> 
  <a class='up'> <i class="fa fa-angle-up" aria-hidden="true"></i></a> 
</div>

<!-- modal-call-back-header -->
<div id="modal-call-back-header" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <a class="close" data-dismiss="modal">
  				<i class="fa fa-times" aria-hidden="true"></i>
  			</a>
        <h4 class="modal-title">Заполните форму<br> и мы Вам перезвоним!</h4>
      </div>
      <div class="modal-body">
        <div class="form-box">
          <form id="form-call-back-header">
            <div class="input-field">
              <input type='text' placeholder='Ваше имя...' name='name'>
            </div>
            <div class="input-field">
              <input type='text' placeholder='+38(0__)___-__-__' name='phone'>
            </div>
            <div class="input-field">
              <button type='submit' id="submit-call-back-header">Перезвонить</button>
            </div>
          </form>
          <h4 class='modal-thanks'>Спасибо за заявку, мы свяжемся с Вами в ближайшее время</h4>
        </div>
      </div>
    </div>

  </div>
</div>

<!-- modal-sale -->
<div id="modal-sale" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class='left-side'>
          <div class='first-line'>Хочешь скидку<span>10%</span></div>
          <div class='second-line'>Активируй таймер и получи скидку на весь ассортимент* на 10 минут.</div>
          <div class='small-line'>* - скидка действует только на НЕ акционные позиции</div>
          <div class='buttons-block'>
            <a id='get-sale-btn'>Активировать скидку!</a>
            <a class='no-sale' data-dismiss="modal">Нет, спасибо</a>
          </div>
        </div>
        <div class='right-side'>
          <img src='/catalog/view/theme/default/image/sale-tag.png'/>
        </div>
      </div>
    </div>

  </div>
</div>

<!-- modal-quick-buy -->
<div id="modal-quick-buy" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <a class="close" data-dismiss="modal">
  				<i class="fa fa-times" aria-hidden="true"></i>
  			</a>
        <h4 class="modal-title">Покупка в один клик</h4>
      </div>
      <div class="modal-body">
        <div class="form-box">
          <form id="form-quick-buy">
            <div class="input-field">
              <input type='hidden' name='product_id' value=''>
              <input type='hidden' name='quantity' value='1'>
              <input type='text' placeholder='Ваше имя...' name='name' required>
            </div>
            <div class="input-field">
              <input type='text' placeholder='+38(067)465-65-78' name='phone' required>
            </div>
            <div class="input-field">
              <input type='text' placeholder='Email...' name='email' required>
            </div>
            <div class="input-field">
              <button type='submit' id="submit-call-back-header">Отправить</button>
            </div>
            
          </form>
          <h4 class='modal-thanks'>Спасибо за заявку, мы свяжемся с Вами в ближайшее время</h4>
        </div>
      </div>
    </div>

  </div>
</div>

<!-- Modal after-->
<div class="modal" id="modal-after" tabindex="-1" role="dialog" aria-labelledby="call-back-modal-Label" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<a class="close" data-dismiss="modal">
				<i class="fa fa-times" aria-hidden="true"></i>
			</a>
			<div class="modal-body" id="modal-after-body">
        <div id="circularG">
        	<div id="circularG_1" class="circularG"></div>
        	<div id="circularG_2" class="circularG"></div>
        	<div id="circularG_3" class="circularG"></div>
        	<div id="circularG_4" class="circularG"></div>
        	<div id="circularG_5" class="circularG"></div>
        	<div id="circularG_6" class="circularG"></div>
        	<div id="circularG_7" class="circularG"></div>
        	<div id="circularG_8" class="circularG"></div>
        </div>
			</div>
		</div>
	</div>
</div>

<!-- Modal quick-view -->
<div class="modal" id="modal-quick-views" tabindex="-1" role="dialog" aria-labelledby="call-back-modal-Label" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<a class="close" data-dismiss="modal">
				<i class="fa fa-times" aria-hidden="true"></i>
			</a>
			<div class="modal-body" id="quick-view-body-box">
        <div id="circularG">
        	<div id="circularG_1" class="circularG"></div>
        	<div id="circularG_2" class="circularG"></div>
        	<div id="circularG_3" class="circularG"></div>
        	<div id="circularG_4" class="circularG"></div>
        	<div id="circularG_5" class="circularG"></div>
        	<div id="circularG_6" class="circularG"></div>
        	<div id="circularG_7" class="circularG"></div>
        	<div id="circularG_8" class="circularG"></div>
        </div>
			</div>
		</div>
	</div>
</div>

<!-- Modal last-chance -->
<div class="modal" id="modal-last-chance" tabindex="-1" role="dialog" aria-labelledby="call-back-modal-Label" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<a class="close" data-dismiss="modal">
				<i class="fa fa-times" aria-hidden="true"></i>
			</a>
			<div class="modal-body" id="quick-view-body-box">
        <?php echo $last_chance; ?>
			</div>
		</div>
	</div>
</div>


</footer>

<script type="text/javascript" src="catalog/view/javascript/ajax-product-page-loader.js"></script>
<script src="catalog/view/javascript/jquery/jquery.elevateZoom-3.0.8.min.js" type="text/javascript" defer></script>
<script src="catalog/view/javascript/jquery/jquery.maskedinput.min.js" type="text/javascript" defer></script>

<script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript" defer></script>

<link href="catalog/view/javascript/jquery/jquery-ui.min.css" rel="stylesheet" media="screen" />
<script src="catalog/view/javascript/jquery/jquery-ui.min.js" type="text/javascript" defer></script>

<link href="catalog/view/javascript/jquery/fancybox/jquery.fancybox.min.css" rel="stylesheet" media="screen" />
<script src="catalog/view/javascript/jquery/fancybox/jquery.fancybox.min.js" type="text/javascript" defer></script>

<link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href="catalog/view/javascript/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
<script src="catalog/view/javascript/select2/js/select2.full.min.js" type="text/javascript" defer></script>


<script src="catalog/view/javascript/common.js" type="text/javascript" defer></script>
<?php foreach ($styles as $style) { ?>
<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>


<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>

<?php foreach ($scripts2 as $script) { ?>
<script src="<?php echo $script; ?>" type="text/javascript" defer></script>
<?php } ?>

<?php foreach ($scripts as $script) { ?>
<script src="<?php echo $script; ?>" type="text/javascript" defer></script>
<?php } ?>

<script src="catalog/view/javascript/etimer.js" defer></script>
<script>

  $(document).ready(function() {
    $(".eTimer").eTimer({
      etType: 0, etDate: "15.07.2017.0.0", etTitleText: "До окончания акции осталось:", etTitleSize: 20, etShowSign: 1, etSep: ":", etFontFamily: "Impact", etTextColor: "white", etPaddingTB: 15, etPaddingLR: 15, etBackground: "black", etBorderSize: 0, etBorderRadius: 2, etBorderColor: "white", etShadow: " 0px 0px 10px 0px #333333", etLastUnit: 4, etNumberFontFamily: "Impact", etNumberSize: 35, etNumberColor: "white", etNumberPaddingTB: 0, etNumberPaddingLR: 8, etNumberBackground: "#f8b969", etNumberBorderSize: 0, etNumberBorderRadius: 5, etNumberBorderColor: "white", etNumberShadow: "inset 0px 0px 10px 0px rgba(0, 0, 0, 0.5)"
    });
    
     function startTimer(){
        var currentTime = new Date();
        var year = 1900 + parseInt(currentTime.getYear());
        var day = currentTime.getDate();
        var mounth = 1 + parseInt(currentTime.getMonth());
        var hours = currentTime.getHours();
        var minutes = currentTime.getMinutes();
        var seconds = currentTime.getSeconds();
        $.get('/index.php?route=common/footer/timer&hours=' + hours + "&minutes=" + minutes + '&seconds=' + seconds + '&day=' + day + '&mounth=' + mounth + '&year=' + year, function(data){
          var json = JSON.parse(data);
          if(json['timer']){
            $(".eTimer2").eTimer({
  			      etType: 0, etDate: json['timer'], etTitleText: "Скидка 10%", etTitleSize: 20, etShowSign: 1, etSep: ":", etFontFamily: "Trebuchet MS", etTextColor: "white", etPaddingTB: 0, etPaddingLR: 0, etBackground: "#f8b969", etBorderSize: 0, etBorderRadius: 0, etBorderColor: "white", etShadow: " 0px 0px 0px 0px #333333", etLastUnit: 4, etNumberFontFamily: "Impact", etNumberSize: 35, etNumberColor: "white", etNumberPaddingTB: 0, etNumberPaddingLR: 0, etNumberBackground: "transparent", etNumberBorderSize: 0, etNumberBorderRadius: 0, etNumberBorderColor: "transparent", etNumberShadow: "inset 0px 0px 10px 0px transparent"
  		      });
          }
          if(json['reload']){
        		location.reload();
          }
        });
    }
    
    
    <?php if(!$timer) { ?>
      setTimeout(function(){
          $('#modal-sale').modal('show');
      },1000);
    <?php } else { ?>
      startTimer();
    <?php } ?>
    
    $('#get-sale-btn').on('click', function(e) {
        e.preventDefault();
         
        startTimer();
         
        return false;
    });
    
    
    
  });
  

  
  $(window).on('load', function (e) {
    $('body').removeClass('no-scroll-body');
    //$('#first-screen .background').css('background-image','url(/catalog/view/theme/default/image/main_image.jpg)');
    $('#preloader').detach();
  });
</script>
<div id="load_more" style="display:none;">
	<div class="row text-center">
		<a href="#" class="load_more"><?php echo $loadmore_button; ?></a>
	</div>
</div>
</body></html>