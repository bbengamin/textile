<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content= "<?php echo $keywords; ?>" />
<?php } ?>
<script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
<script src="catalog/view/javascript/jquery/jquery.elevateZoom-3.0.8.min.js" type="text/javascript"></script>
<script src="catalog/view/javascript/jquery/jquery.maskedinput.min.js" type="text/javascript"></script>
<link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
<script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>

<link href="catalog/view/javascript/jquery/jquery-ui.min.css" rel="stylesheet" media="screen" />
<script src="catalog/view/javascript/jquery/jquery-ui.min.js" type="text/javascript"></script>

<link href="catalog/view/javascript/jquery/fancybox/jquery.fancybox.min.css" rel="stylesheet" media="screen" />
<script src="catalog/view/javascript/jquery/fancybox/jquery.fancybox.min.js" type="text/javascript"></script>

<link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href='https://fonts.googleapis.com/css?family=Fira Sans' rel='stylesheet'>
<link href="catalog/view/theme/default/stylesheet/stylesheet.css" rel="stylesheet">
<script src="catalog/view/javascript/common.js" type="text/javascript"></script>
<?php foreach ($styles as $style) { ?>
<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>


<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>

<?php foreach ($scripts as $script) { ?>
<script src="<?php echo $script; ?>" type="text/javascript"></script>
<?php } ?>

<?php foreach ($analytics as $analytic) { ?>
<?php echo $analytic; ?>
<?php } ?>

</head>
<body class="<?php echo $class; ?>">

<div id='first-screen'>
  <div class='top-line'>
    <div class='container-top'>
      <div class='col-lg-4 col-md-4 col-xs-12 logo'>
        <a href='/'><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" /></a>
      </div>
      <div class='top-text col-lg-4 col-md-4 col-xs-12'>
        <a href='/'>
        <div>Интернет-магазин постельного</div>
        <div>от производителя №1 в Украине</div>
        </a>
      </div>
      
      <div class='col-lg-4 col-md-4 col-xs-12 text-right'>
        <div class='col-lg-6 col-xs-12 right-block'>
           <div><a href='tel:<?php echo $telephone; ?>'><?php echo $telephone; ?></a></div>
           <div><a href='tel:<?php echo $telephone2; ?>'><?php echo $telephone2; ?></a></div>
        </div>
        <div class='col-lg-3 col-xs-12'>
          <a id='top-cart' href='/cart'>
            <span id='top-cart-total' class='hidden-xs hidden-sm hidden-md'><?php echo $cart; ?></span>
            <i class="fa fa-shopping-bag " aria-hidden="true"></i>
            <span class='hidden-lg'>Корзина покупок</span></a>
        </div>
        <div class='col-lg-3 col-xs-12'>
          <a class='call-back-top-btn hidden-xs hidden-sm hidden-md'><i class="fa fa-phone" aria-hidden="true"></i></a>
          <a class='call-back-top-btn-mob hidden-lg'><i class="fa fa-phone" aria-hidden="true"></i>Перезвоните мне</a>
        </div>
      </div>
    </div>
  </div>
  <?php if($class=='common-home') { ?>
  <div class='background'></div>
  <div class='middle-block'>
    <h2>Скидки на последние комплекты постельного белья</h2>
    <div class='sale'>до 50% </div>
    <div class="eTimer"></div>
  </div>
  <?php } ?>
</div>
<?php if($class=='common-home') { ?>
<div id='nav-bar'>
  <div id='white-feather'></div>
  <?php if ($categories) { ?>
    <ul class='cat-nav'>
    <?php foreach ($categories as $category) { ?>
       <li data-id='<?php echo $category["category_id"]; ?>'><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
    <?php } ?>
    </ul>
  <?php } ?>
</div>
<?php } ?>

<div id='footer-nav-fixed' class='hidden'>
  <div class='container'>
    <div class='col-lg-3'>
      <a class='footer-callback'><i class="fa fa-phone" aria-hidden="true"></i>Перезвоните мне</a>
    </div>
    <div class='telephone-footer col-lg-3'>
      <a href='tel:<?php echo $telephone; ?>'><?php echo $telephone; ?></a>
    </div>
    <div class='telephone-footer col-lg-3'>
      <a href='tel:<?php echo $telephone2; ?>'><?php echo $telephone2; ?></a>
    </div>
    <div class='col-lg-3' id='footer-cart'>
      <a href='/cart'>
        <i class="fa fa-shopping-bag" aria-hidden="true"></i>
        <span id='footer-cart-total'>Товаров: <span id='footer-cart-total-value'><?php echo $cart; ?></span></span>
      </a>
    </div>
  </div>
</div>
<script>
$(document).ready(function() {
  <?php if(isset($level1)) { ?>
      $('#nav-bar ul.cat-nav li[data-id="<?php echo $level1; ?>"]').trigger("click");
  <?php } else { ?>
      $('#nav-bar ul.cat-nav li:nth-child(2)').trigger("click");
  <?php } ?>
});
</script>