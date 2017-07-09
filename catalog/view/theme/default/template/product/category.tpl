<?php echo $header; ?>
<div class="container">
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div class='filter-box'>
      <div class='filter-title'>
        Фильтр товаров
      </div>
      <?php echo $content_top; ?>
    </div>
    
    <div id="content" class="<?php echo $class; ?>">
      <h1 class='category-h1'><?php echo $heading_title; ?></h1>
      <?php if ($products) { ?>
      <div class="row">
        <div class="col-md-6 text-right">
          <label class="control-label category-laber" for="input-sort"><?php echo $text_sort; ?></label>
        </div>
        <div class="col-md-3">
          <select id="input-sort" class="form-control select2" onchange="location = this.value;">
            <?php foreach ($sorts as $sorts) { ?>
            <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
            <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
            <?php } ?>
            <?php } ?>
          </select>
        </div>
        <div class="col-md-1 text-right">
          <label class="control-label category-laber" for="input-limit"><?php echo $text_limit; ?></label>
        </div>
        <div class="col-md-2">
          <select id="input-limit" class="form-control select2" onchange="location = this.value;">
            <?php foreach ($limits as $limits) { ?>
            <?php if ($limits['value'] == $limit) { ?>
            <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
            <?php } ?>
            <?php } ?>
          </select>
        </div>
      </div>
      <br />
      <div class="row" >
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
      <div class="row">
        <div class="col-sm-12 text-center"><?php echo $pagination; ?></div>
      </div>
      <?php } ?>
      <?php if (!$products) { ?>
      <p>По заданым парараметрам ничего не найдено!</p>
      <?php } ?>
      </div>
      <?php echo $content_bottom; ?>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>
