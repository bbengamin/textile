<div class="modal-with-this-box">
    <h2 class="modal-main-messege-text hidden-sm hidden-md hidden-lg visible-xs"><i class="fa fa-check" aria-hidden="true"></i>Товар добавлен в корзину</h2>
    <div class="abou-your-product-box">
        <div class="img-products-box">
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
             <img src="<?php echo $thumb; ?>" alt="<?php echo $name; ?>" class='img-responsive'>
        </div>
        <div class="text-products-box">
            <h2 class="modal-main-messege-text hidden-xs"><i class="fa fa-check" aria-hidden="true"></i> Товар добавлен в корзину</h2>
            <div class="product-name-with-box">
                <?php echo $name; ?>
            </div>
            <div class="with-this-modal-price-box">
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
            </div>
            <div class="with-this-modal-btns-box hidden-xs">
                <a href="<?php echo $checkout; ?>" class="make-it-order">Оформить заказ</a>
                <a href="" data-dismiss="modal" class="make-it-shopping">Продолжить покупки</a>
            </div>
        </div>
        </div>
    </div>
    <div class="with-this-modal-btns-box visible-xs hidden-sm hidden-md hidden-lg">
        <a href="/cart" class="make-it-order">Оформить заказ</a>
        <a href="" class="make-it-shopping">Продолжить покупки</a>
    </div>
</div>
