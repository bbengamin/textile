<?php echo $header; ?>
<div class="container">
    <?php if ($attention) { ?>
        <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
    <?php } ?>
    <?php if ($error_warning) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
    <?php } ?>
    <div class="row"><?php echo $column_left; ?>
        <?php if ($column_left && $column_right) { ?>
            <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
            <?php $class = 'col-sm-9'; ?>
        <?php } else { ?>
            <?php $class = 'col-sm-12'; ?>
        <?php } ?>
        <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
            <h1>Корзина покупок</h1>
            <form action="<?php echo $action; ?>" id='buy-form' method="post" enctype="multipart/form-data">
                <div id='buy-load' >
                <div class="table-responsive hidden-xs" >
                    <table class="table table-bordered" id='marin-cart-table'>
                        <thead>
                            <tr>
                                <td class="text-center img-cart-col"><?php echo $column_image; ?></td>
                                <td class="text-center name-cart-col"><?php echo $column_name; ?></td>
                                
                                <td class="text-center quantity-cart-col"><?php echo $column_quantity; ?></td>
                                <td class="text-center price-cart-col"><?php echo $column_price; ?></td>
                                <td class="text-center total-cart-col"><?php echo $column_total; ?></td>
                                <td class="text-center delete-cart-col"></td>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($products as $product) { ?>
                                <tr>
                                    <td class="text-center img-cart-col"><?php if ($product['thumb']) { ?>
                                            <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
                                        <?php } ?></td>
                                    <td class="text-left name-cart-col"><a><?php echo $product['name']; ?></a>
                                        <?php if (!$product['stock']) { ?>
                                            <span class="text-danger">***</span>
                                        <?php } else { ?>
                                            <div class="stok-in">
                                                <span class='saved-text'>В наличии</span>
                                            </div>
                                        <?php } ?>
                                        <?php if ($product['option']) { ?>
                                            <?php foreach ($product['option'] as $option) { ?>
                                                <br />
                                                <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                                            <?php } ?>
                                        <?php } ?>
                                        <?php if ($product['reward']) { ?>
                                            <br />
                                            <small><?php echo $product['reward']; ?></small>
                                        <?php } ?>
                                        <?php if ($product['recurring']) { ?>
                                            <br />
                                            <span class="label label-info"><?php echo $text_recurring_item; ?></span> <small><?php echo $product['recurring']; ?></small>
                                        <?php } ?>
                                     </td>
                                   
                                    <td class="text-center quantity-cart-col">
                                        <div class="quanty-box" >
                                            <div class='minus'>-</div>
                                            <input type="text" class='quantity-input' name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" class="form-control" />
                                            <div class='plus'>+</div>
                                        </div>
                                        </td>
                                    <td class="text-center price-cart-col"><?php echo $product['price']; ?></td>
                                    <td class="text-center total-cart-col"><?php echo $product['total']; ?></td>
                                    <td class="text-center delete-cart-col">
                                        <div data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="cart-main-remove" onclick="cart.remove('<?php echo $product['key']; ?>');">
                                            <i class="fa fa-trash" aria-hidden="true"></i>
                                        </div>
                                    </td>
                                </tr>
                            <?php } ?>
                            </tbody>
                            </table>
                            <table class='table table-bordered' id='total-cart-table'>
                            <tbody>
                            <?php foreach ($totals as $total) { ?>
                                <tr class="total-item">
                                    <td class="text-right"><strong><?php echo $total['title']; ?>:</strong></td>
                                    <td class="text-right"><?php echo $total['text']; ?></td>
                                </tr>
                            <?php } ?>
                        </tbody>
                    </table>
                    
                    
                    
                    
                </div>
                <div class="mobile-cart-box visible-xs">
                        <div class="mobile-cart-inner">
                            <?php foreach ($products as $product) { ?>
                            <div class="mob-item-cart">
                                <div class="mob-cart-item mob-cart-item-img">
                                    <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a>
                                </div>
                                <div class="mob-cart-item mob-cart-item-text-box">
                                    <div class="mob-cart-item mob-cart-item-name"><?php echo $product['name']; ?></div>    
                                    <div class="mob-cart-item mob-cart-item-qua">
                                        <div class="quanty-box" >
                                            <div class='minus'>-</div>
                                            <input type="text" class='quantity-input' name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" class="form-control" />
                                            <div class='plus'>+</div>
                                        </div>
                                    </div>    
                                    <div class="mob-cart-item mob-cart-item-price">
                                         <?php if($product['special']) { ?>
                                            <span class="price-old"><?php echo $product['price']; ?></span>
                                            <span class='price-new'><?php echo $product['special']; ?></span>
                                        <?php } else { ?>
                                        <span class='price-value'><?php echo $product['price']; ?></span>
                                        <?php } ?>
                                    </div>    
                                </div>
                                <div data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="cart-main-remove cart-main-remove-mob" onclick="cart.remove('<?php echo $product['key']; ?>');">
                                    <i class="fa fa-trash" aria-hidden="true"></i>
                                </div>
                            </div>
                            <?php } ?>
                            
                        </div>
                        <div class="cart-total-box">
                            <ul class="totals-box list-unstyled">
                                <?php foreach ($totals as $total) { ?>
                                <li>
                                    <span class="total-item total-head-item"><strong><?php echo $total['title']; ?>:</strong></span>
                                    <span class="total-item total-not-head-item"><?php echo $total['text']; ?></span>
                                </li>
                                <?php } ?>
                            </ul>
                        </div>
                    </div>
                </div>
            </form>
            <?php if (($coupon || $voucher || $reward || $shipping) && $settings['buy_cart_modules']) { ?>
                <h2><?php echo $text_next; ?></h2>
                <p><?php echo $text_next_choice; ?></p>
                <div class="panel-group" id="accordion"><?php echo $coupon; ?><?php echo $voucher; ?><?php echo $reward; ?><?php echo $shipping; ?></div>
            <?php } ?>
            <hr />
            <h2 class="text-center h1" id="checkout-f">Оформление заказа</h2>
            <br />
            <div class="row" id="checkout-form">
                <div class="chekout-box-item col-xs-12 <?php echo $settings['buy_form_design']?'col-sm-6 col-sm-offset-3':'col-sm-6' ?>">
                    <?php if($settings['buy_form_headings']){ ?>
                    <div class="form-group">
                        <h2><?php echo $settings['buy_heading_1'.$lang]; ?></h2>
                    </div>
                    <?php } ?>
                    <div class="form-group" style="display: <?php echo (count($customer_groups) > 1 ? 'block' : 'none'); ?>;">
                        <label class="control-label"><?php echo $entry_customer_group; ?></label>
                        <?php foreach ($customer_groups as $customer_group) { ?>
                            <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
                                        <?php echo $customer_group['name']; ?></label>
                                </div>
                            <?php } else { ?>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" />
                                        <?php echo $customer_group['name']; ?></label>
                                </div>
                            <?php } ?>
                        <?php } ?>
                    </div>
                    <?php if($settings['buy_firstname_status']){ ?>
                    <div class="form-group<?php if($settings['buy_firstname_required']){ ?> required<?php } ?>">
                        <label class="control-label" for="input-payment-firstname">Имя</label>
                        <input type="text" name="firstname" value="<?php echo $firstname; ?>" placeholder="Имя" id="input-payment-firstname" class="form-control" />
                    </div>
                    <?php } ?>
                    <?php if($settings['buy_lastname_status']){ ?>
                    <div class="form-group<?php if($settings['buy_lastname_required']){ ?> required<?php } ?>">
                        <label class="control-label" for="input-payment-lastname"><?php echo $entry_lastname; ?></label>
                        <input type="text" name="lastname" value="<?php echo $lastname; ?>" placeholder="<?php echo $entry_lastname; ?>" id="input-payment-lastname" class="form-control" />
                    </div>
                    <?php } ?>
                    <?php if($settings['buy_email_status']){ ?>
                    <div class="form-group<?php if($settings['buy_email_required']){ ?> required<?php } ?>">
                        <label class="control-label" for="input-payment-email"><?php echo $entry_email; ?></label>
                        <input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-payment-email" class="form-control" />
                    </div>
                    <?php } ?>
                    <?php if($settings['buy_telephone_status']){ ?>
                    <div class="form-group<?php if($settings['buy_telephone_required']){ ?> required<?php } ?>">
                        <label class="control-label" for="input-payment-telephone"><?php echo $entry_telephone; ?></label>
                        <input type="text" name="telephone" value="<?php echo $telephone; ?>" placeholder="<?php echo $entry_telephone; ?>" id="input-payment-telephone" class="form-control" />
                    </div>
                    <?php } ?>
                    <?php if($settings['buy_fax_status']){ ?>
                    <div class="form-group<?php if($settings['buy_fax_required']){ ?> required<?php } ?>">
                        <label class="control-label" for="input-payment-fax"><?php echo $entry_fax; ?></label>
                        <input type="text" name="fax" value="<?php echo $fax; ?>" placeholder="<?php echo $entry_fax; ?>" id="input-payment-fax" class="form-control" />
                    </div>
                    <?php } ?>
                    <?php if($settings['buy_company_status']){ ?>
                    <div class="form-group<?php if($settings['buy_company_required']){ ?> required<?php } ?>">
                        <label class="control-label" for="input-payment-company"><?php echo $entry_company; ?></label>
                        <input type="text" name="company" value="<?php echo $company; ?>" placeholder="<?php echo $entry_company; ?>" id="input-payment-company" class="form-control" />
                    </div>
                    <?php } ?>
                    <?php foreach ($custom_fields as $custom_field) { ?>
                        <?php if ($custom_field['location'] == 'account') { ?>
                            <?php if ($custom_field['type'] == 'select') { ?>
                                <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                    <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                                    <select name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">
                                        <option value=""><?php echo $text_select; ?></option>
                                        <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                                            <?php if (isset($guest_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $guest_custom_field[$custom_field['custom_field_id']]) { ?>
                                                <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>" selected="selected"><?php echo $custom_field_value['name']; ?></option>
                                            <?php } else { ?>
                                                <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
                                            <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            <?php } ?>
                            <?php if ($custom_field['type'] == 'radio') { ?>
                                <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                    <label class="control-label"><?php echo $custom_field['name']; ?></label>
                                    <div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
                                        <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                                            <div class="radio">
                                                <?php if (isset($guest_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $guest_custom_field[$custom_field['custom_field_id']]) { ?>
                                                    <label>
                                                        <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
                                                        <?php echo $custom_field_value['name']; ?></label>
                                                <?php } else { ?>
                                                    <label>
                                                        <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
                                                        <?php echo $custom_field_value['name']; ?></label>
                                                <?php } ?>
                                            </div>
                                        <?php } ?>
                                    </div>
                                </div>
                            <?php } ?>
                            <?php if ($custom_field['type'] == 'checkbox') { ?>
                                <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                    <label class="control-label"><?php echo $custom_field['name']; ?></label>
                                    <div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
                                        <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                                            <div class="checkbox">
                                                <?php if (isset($guest_custom_field[$custom_field['custom_field_id']]) && in_array($custom_field_value['custom_field_value_id'], $guest_custom_field[$custom_field['custom_field_id']])) { ?>
                                                    <label>
                                                        <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
                                                        <?php echo $custom_field_value['name']; ?></label>
                                                <?php } else { ?>
                                                    <label>
                                                        <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
                                                        <?php echo $custom_field_value['name']; ?></label>
                                                <?php } ?>
                                            </div>
                                        <?php } ?>
                                    </div>
                                </div>
                            <?php } ?>
                            <?php if ($custom_field['type'] == 'text') { ?>
                                <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                    <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                                    <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($guest_custom_field[$custom_field['custom_field_id']]) ? $guest_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                                </div>
                            <?php } ?>
                            <?php if ($custom_field['type'] == 'textarea') { ?>
                                <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                    <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                                    <textarea name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php echo (isset($guest_custom_field[$custom_field['custom_field_id']]) ? $guest_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?></textarea>
                                </div>
                            <?php } ?>
                            <?php if ($custom_field['type'] == 'file') { ?>
                                <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                    <label class="control-label"><?php echo $custom_field['name']; ?></label>
                                    <br />
                                    <button type="button" id="button-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                                    <input type="hidden" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($guest_custom_field[$custom_field['custom_field_id']]) ? $guest_custom_field[$custom_field['custom_field_id']] : ''); ?>" />
                                </div>
                            <?php } ?>
                            <?php if ($custom_field['type'] == 'date') { ?>
                                <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                    <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                                    <div class="input-group date">
                                        <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($guest_custom_field[$custom_field['custom_field_id']]) ? $guest_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-format="YYYY-MM-DD" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                        </span></div>
                                </div>
                            <?php } ?>
                            <?php if ($custom_field['type'] == 'time') { ?>
                                <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                    <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                                    <div class="input-group time">
                                        <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($guest_custom_field[$custom_field['custom_field_id']]) ? $guest_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-format="HH:mm" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                        </span></div>
                                </div>
                            <?php } ?>
                            <?php if ($custom_field['type'] == 'datetime') { ?>
                                <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                    <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                                    <div class="input-group datetime">
                                        <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($guest_custom_field[$custom_field['custom_field_id']]) ? $guest_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-format="YYYY-MM-DD HH:mm" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                        </span></div>
                                </div>
                            <?php } ?>
                        <?php } ?>
                    <?php } ?>
                <?php if(!$settings['buy_form_design']){ ?>
                </div>
                <div class="chekout-box-item col-xs-12 col-sm-6">
                <?php } ?>
                    <?php if($settings['buy_form_headings']){ ?>
                    <div class="form-group">
                        <h2><?php echo $settings['buy_heading_2'.$lang]; ?></h2>
                    </div>
                    <?php } ?>
                    <?php if($settings['buy_country_status']){ ?>
                    <div class="form-group<?php if($settings['buy_country_required']){ ?> required<?php } ?>" id="payment-country">
                        <label class="control-label" for="input-payment-country"><?php echo $entry_country; ?></label>
                        <select name="country_id" id="input-payment-country" class="form-control">
                            <option value=""><?php echo $text_select; ?></option>
                            <?php foreach ($countries as $country) { ?>
                                <?php if ($country['country_id'] == $country_id) { ?>
                                    <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                                <?php } else { ?>
                                    <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                                <?php } ?>
                            <?php } ?>
                        </select>
                    </div>
                    <?php }else{ ?>
                    <div class="hidden">
                        <select name="country_id">
                            <option value="<?php echo $country_id; ?>" selected="selected"></option>
                        </select>
                    </div>
                    <?php } ?>
               
                    <input type='hidden' name="zone_id" value='4224'>
                    <?php if($settings['buy_city_status']){ ?>
                    <div class="form-group<?php if($settings['buy_city_required']){ ?> required<?php } ?>">
                        <label class="control-label" for="input-payment-city"><?php echo $entry_city; ?></label>
                        <input type="text" name="city" value="" placeholder="<?php echo $entry_city; ?>" autocomplete="off" id="input-payment-city" class="form-control" />
                        <div class='hidden' id='cities-dropdown'></div>
                    </div>
                    <?php } ?>
                    <?php if($settings['buy_postcode_status']){ ?>
                    <div class="form-group<?php if($settings['buy_postcode_required']){ ?> required<?php } ?>">
                        <label class="control-label" for="input-payment-postcode"><?php echo $entry_postcode; ?></label>
                        <input type="text" name="postcode" value="<?php echo $postcode; ?>" placeholder="<?php echo $entry_postcode; ?>" id="input-payment-postcode" class="form-control" />
                    </div>
                    <?php } ?>
                    <?php if($settings['buy_address_1_status']){ ?>
                    <div class="form-group<?php if($settings['buy_address_1_required']){ ?> required<?php } ?>">
                        <label class="control-label" for="input-payment-address-1"><?php echo $entry_address_1; ?></label>
                        <input type="text" name="address_1" value="" readonly placeholder="Нажмите для выбора отделение для доставки Новой Почтой" id="input-payment-address-1" class="form-control" />
                    </div>
                    <?php } ?>
                    <?php if($settings['buy_address_2_status']){ ?>
                    <div class="form-group<?php if($settings['buy_address_2_required']){ ?> required<?php } ?>">
                        <label class="control-label" for="input-payment-address-2"><?php echo $entry_address_2; ?></label>
                        <input type="text" name="address_2" value="<?php echo $address_2; ?>" placeholder="<?php echo $entry_address_2; ?>" id="input-payment-address-2" class="form-control" />
                    </div>
                    <?php } ?>
                    <?php foreach ($custom_fields as $custom_field) { ?>
                        <?php if ($custom_field['location'] == 'address') { ?>
                            <?php if ($custom_field['type'] == 'select') { ?>
                                <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                    <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                                    <select name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">
                                        <option value=""><?php echo $text_select; ?></option>
                                        <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                                            <?php if (isset($guest_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $guest_custom_field[$custom_field['custom_field_id']]) { ?>
                                                <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>" selected="selected"><?php echo $custom_field_value['name']; ?></option>
                                            <?php } else { ?>
                                                <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
                                            <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            <?php } ?>
                            <?php if ($custom_field['type'] == 'radio') { ?>
                                <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                    <label class="control-label"><?php echo $custom_field['name']; ?></label>
                                    <div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
                                        <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                                            <div class="radio">
                                                <?php if (isset($guest_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $guest_custom_field[$custom_field['custom_field_id']]) { ?>
                                                    <label>
                                                        <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
                                                        <?php echo $custom_field_value['name']; ?></label>
                                                <?php } else { ?>
                                                    <label>
                                                        <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
                                                        <?php echo $custom_field_value['name']; ?></label>
                                                <?php } ?>
                                            </div>
                                        <?php } ?>
                                    </div>
                                </div>
                            <?php } ?>
                            <?php if ($custom_field['type'] == 'checkbox') { ?>
                                <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                    <label class="control-label"><?php echo $custom_field['name']; ?></label>
                                    <div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
                                        <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                                            <div class="checkbox">
                                                <?php if (isset($guest_custom_field[$custom_field['custom_field_id']]) && in_array($custom_field_value['custom_field_value_id'], $guest_custom_field[$custom_field['custom_field_id']])) { ?>
                                                    <label>
                                                        <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
                                                        <?php echo $custom_field_value['name']; ?></label>
                                                <?php } else { ?>
                                                    <label>
                                                        <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
                                                        <?php echo $custom_field_value['name']; ?></label>
                                                <?php } ?>
                                            </div>
                                        <?php } ?>
                                    </div>
                                </div>
                            <?php } ?>
                            <?php if ($custom_field['type'] == 'text') { ?>
                                <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                    <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                                    <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($guest_custom_field[$custom_field['custom_field_id']]) ? $guest_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                                </div>
                            <?php } ?>
                            <?php if ($custom_field['type'] == 'textarea') { ?>
                                <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                    <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                                    <textarea name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php echo (isset($guest_custom_field[$custom_field['custom_field_id']]) ? $guest_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?></textarea>
                                </div>
                            <?php } ?>
                            <?php if ($custom_field['type'] == 'file') { ?>
                                <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                    <label class="control-label"><?php echo $custom_field['name']; ?></label>
                                    <br />
                                    <button type="button" id="button-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                                    <input type="hidden" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($guest_custom_field[$custom_field['custom_field_id']]) ? $guest_custom_field[$custom_field['custom_field_id']] : ''); ?>" />
                                </div>
                            <?php } ?>
                            <?php if ($custom_field['type'] == 'date') { ?>
                                <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                    <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                                    <div class="input-group date">
                                        <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($guest_custom_field[$custom_field['custom_field_id']]) ? $guest_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-format="YYYY-MM-DD" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                        </span></div>
                                </div>
                            <?php } ?>
                            <?php if ($custom_field['type'] == 'time') { ?>
                                <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                    <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                                    <div class="input-group time">
                                        <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($guest_custom_field[$custom_field['custom_field_id']]) ? $guest_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-format="HH:mm" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                        </span></div>
                                </div>
                            <?php } ?>
                            <?php if ($custom_field['type'] == 'datetime') { ?>
                                <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                    <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                                    <div class="input-group datetime">
                                        <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($guest_custom_field[$custom_field['custom_field_id']]) ? $guest_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-format="YYYY-MM-DD HH:mm" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                        </span></div>
                                </div>
                            <?php } ?>
                        <?php } ?>
                    <?php } ?>
               
                    <?php if($settings['buy_shipping_select']){ ?>
                    <div class="form-group">
                        <div id="shipping_methods" class='hidden'></div>
                    </div>
                    <?php }else{ ?>
                        <div class="hidden"><input type="radio" name="shipping_method" value="flat.flat" checked="checked"></div>
                    <?php } ?>
                    <br />
                    <?php if($settings['buy_payment_select']){ ?>
                    <div class="form-group">
                        <div id="payment_methods"></div>
                    </div>
                    <?php }else{ ?>
                        <div class="hidden"><input type="radio" name="payment_method" value="cod" checked="checked"></div>
                    <?php } ?>
                    <?php if($settings['buy_comment_status']){ ?>
                    <br />
                    <div class="form-group<?php if($settings['buy_comment_required']){ ?> required<?php } ?>">
                        <label class="control-label" for="input-comment"><strong><?php echo $entry_comment; ?></strong></label>
                        <textarea name="comment" rows="8" class="form-control" id="input-comment"><?php echo $comment; ?></textarea>
                    </div>
                    <?php } ?>
                    <input type="hidden" name="agree" value="1" checked="checked" />
                </div>
                
            </div>
            <?php if ($text_agree) { ?>
                <div class="buttons">
                    <div class="text-center">
                        <label style='display: none;'><?php echo $text_agree; ?>
                        <?php if ($agree) { ?>
                            <input type="checkbox" name="agree" value="1" checked="checked" />
                        <?php } else { ?>
                            <input type="checkbox" name="agree" value="1" checked="checked" />
                        <?php } ?>
                        </label>
                        <input type="button" value="<?php echo $button_order; ?>" id="button-order" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-success btn-lg" />
                    </div>
                    <div id="payment-form"></div>
                </div>
            <?php } else { ?>
                <br />
                <div class="buttons">
                    <div class="text-center">
                        <input type="button" value="<?php echo $button_order; ?>" id="button-order" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-success btn-lg" />
                    </div>
                    <div id="payment-form"></div>
                </div>
            <?php } ?>







            <?php echo $content_bottom; ?></div>
        <?php echo $column_right; ?></div>
</div>

<!-- Modal delivery -->
<div class="modal" id="modal-delivery" tabindex="-1" role="dialog" aria-labelledby="call-back-modal-Label" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<a class="close" data-dismiss="modal">
				<i class="fa fa-times" aria-hidden="true"></i>
			</a>
			<div class="modal-body" id="modal-delivery-body-box">
			    <div class='point-selector-wrapper'>
			    </div>
                <div id='map'></div>
			</div>
		</div>
	</div>
</div>
<script>
    var map = null;
    var points = [];
    var markers = [];
    var deliveryPoints = [];
    var infowindow;
    var service;
    function initMap() {
          map = new google.maps.Map(document.getElementById('map'), {
            center: {lat: 49.937924, lng: 36.38309},
            zoom: 12,
        });
    }
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB4UX_AEqWXfdoKZDJ_mZq6e_wK1gpYn_E&libraries=places&callback=initMap" async defer></script>
<script>
var delayTimer;
$(document).ready(function(){
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
        				/*if(json['cities'].length > 1 || $('#cityId').val() != ""){
        				}else{
        				    $('.city-element').trigger('click');
        				    $('#cities-dropdown').addClass('hidden');
        				}*/
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
    
});
</script>
<script type="text/javascript"><!--
    

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
                        
                        <?php if(!empty($zone_id)){ ?>
                        if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
                            html += ' selected="selected"';
                        }
                        <?php } ?>

                        html += '>' + json['zone'][i]['name'] + '</option>';
                    }
                } else {
                    html += '<option value="0" selected="selected"> --- None --- </option>';
                }

                $('#checkout-form [name=\'zone_id\']').html(html);
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
        //$('#shm_loading, #pay_loading').html(' <img src="image/loading.gif" width="43" height="11" style="margin-top:-3px;vertical-align:middle;">');
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

//--></script>
<style type="text/css">
    #checkout-form .has-feedback .form-control-feedback{top:26px;right:10px}
    #checkout-form #shipping_methods .radio, #checkout-form #payment_methods .radio{margin-left:20px}
    #checkout-form #payment-form{display:none}
</style>
<?php echo $footer; ?>