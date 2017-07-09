<div class="quick-view-product-box">
    <h1>Последний шанс!</h1>
    <h1><?php echo $name; ?></h1>
  <div class='row'>
    <div class='col-lg-6 col-xs-12'>
        <?php if ($thumb || $images) { ?>
          <div class="image">
            <div class="marks-box">
              <?php if($bestseller) { ?>
                <span class='marks hit-mark'>Хит продаж</span>
              <?php } ?>
              <?php if($sale) { ?>
                <span class='marks special-mark'>Акция</span>
              <?php } ?>
              <?php if($latest) { ?>
                <span class='marks latest-mark'>Новинка</span>
              <?php } ?>
            </div>
            <?php if($percent) { ?>
              <div class=right-top-product>
                <span class='percent'>-<?php echo $percent; ?>%</span>
              </div>
              <?php } ?>
            <?php if ($thumb) { ?>
                <a data-fancybox="gallery" href="<?php echo $popup; ?>"><img data-zoom-image='<?php echo $popup; ?>' src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" class='img-responsive' id='zoomed' /></a>
            <?php } ?>
          </div>
        <?php } ?>
    </div>
    <div class='col-lg-6 col-xs-12'>
      
      <div class='short-description'><?php echo $description; ?></div>
      <div class="caption">
        <?php if ($price) { ?>
        <div class="price">
          <?php if (!$special) { ?>
            <span class='price-value'><?php echo $price; ?></span>
          <?php } else { ?>
            <span class="price-old"><?php echo $price; ?></span>
            <span class='price-new'><?php echo $special; ?></span>
          <?php } ?>
        </div>
          <?php if($saved) { ?>
            <span class='saved'><span class='saved-wp'><?php echo $saved; ?></span>экономия</span>
          <?php } ?>
        <?php } ?>
      </div>
      <div class="button-group-category">
        <div class='cart-add-btn' onclick="cart.add('<?php echo $product_id; ?>', '<?php echo $product['minimum']; ?>');"><i class="fa fa-shopping-cart" aria-hidden="true"></i><span class="">Добавить в корзину</span></div>
        <div class='fast-order-btn' data-id="<?php echo $product_id; ?>"><i class="fa fa-clock-o" aria-hidden="true"></i><span class="">Купить в 1 клик</span></div>
      </div>
    </div>
  </div>
</div>

<script>
  $(document).ready(function(){
    if($(window).width() > 1024){
      $("#zoomed").elevateZoom({ zoomType	: "lens", lensShape : "round", lensSize : 300 });
    }
    if($('.short-description').height() > 332){
      $('.short-description').addClass('short');
      $('.short-description').after('<a class="show-more-text">Читать дальше...</a>');
    }
    $('.show-more-text').on('click',function(){
      $('.show-more-text').prev().removeClass('short');
      $(this).detach();
    })
    
  })
</script>