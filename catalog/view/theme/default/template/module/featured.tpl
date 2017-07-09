<h1 class='category-h1'>Популярные товары</h1>
<div class="row">
  <?php foreach ($products as $product) { ?>
    <div class="product-layout product-grid col-xs-12 col-sm-6 col-md-4">
      <div class="product-thumb">
        <div class="images-box-category">
            <div class="image">
              <div class="marks-box">
                <?php if($product['bestseller']) { ?>
                  <span class='marks hit-mark'>Хит продаж</span>
                <?php } ?>
                <?php if($product['sale']) { ?>
                  <span class='marks special-mark'>Акция</span>
                <?php } ?>
                <?php if($product['latest']) { ?>
                  <span class='marks latest-mark'>Новинка</span>
                <?php } ?>
              </div>
              <?php if($product['percent']) { ?>
              <div class=right-top-product>
                <span class='percent'>-<?php echo $product['percent']; ?>%</span>
              </div>
              <?php } ?>
              <a class='quick-view' data-id="<?php echo $product['product_id']; ?>">
              <div class="view-more"><i class="fa fa-search" aria-hidden="true"></i>Подробнее</div>
              <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
              </a>
            </div>
        </div>
        <h4><a class='quick-view' data-id="<?php echo $product['product_id']; ?>"><?php echo $product['name']; ?></a></h4>
        <div>
          <div class="caption">
            <?php if ($product['price']) { ?>
            <div class="price">
              <?php if (!$product['special']) { ?>
                <span class='price-value'><?php echo $product['price']; ?></span>
              <?php } else { ?>
                <span class="price-old"><?php echo $product['price']; ?></span>
                <span class='price-new'><?php echo $product['special']; ?></span>
              <?php } ?>
            </div>
            <?php if($product['saved']) { ?>
              <span class='saved'><span class='saved-wp'><?php echo $product['saved']; ?></span>экономия</span>
            <?php } ?>
            <?php } ?>
          </div>
          <div class="button-group-category">
            <div class='cart-add-btn' onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');"><i class="fa fa-shopping-cart" aria-hidden="true"></i><span class="">Добавить в корзину</span></div>
            <div class='fast-order-btn' data-id="<?php echo $product['product_id']; ?>"><i class="fa fa-clock-o" aria-hidden="true"></i><span class="">Купить в 1 клик</span></div>
          </div>
        </div>
      </div>
    </div>                                                    
<?php } ?>
</div>
