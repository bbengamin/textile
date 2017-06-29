<?php if ($error_warning) { ?>
<div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($payment_methods) { ?>
<p><strong>Выберите способ оплаты</strong></p>
<?php foreach ($payment_methods as $payment_method) { ?>
<div class="radio new-input-box">
  
    <?php if ($payment_method['code'] == $code || !$code) { ?>
    <?php $code = $payment_method['code']; ?>
    <input type="radio" name="payment_method" id='<?php echo $payment_method["code"]; ?>' value="<?php echo $payment_method['code']; ?>" checked="checked" />
    <?php } else { ?>
    <input type="radio" name="payment_method" id='<?php echo $payment_method["code"]; ?>' value="<?php echo $payment_method['code']; ?>" />
    <?php } ?>
    <label for='<?php echo $payment_method["code"]; ?>'>
    <?php echo $payment_method['title']; ?>
    </label>
</div>
<?php } ?>
<?php } ?>
