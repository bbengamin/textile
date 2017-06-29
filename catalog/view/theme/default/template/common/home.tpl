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
    <div id="content" class="<?php echo $class; ?>">
    <div id='main-products-block' class='main-products'>
    </div>
    <?php echo $content_top; ?>
    <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>

<script src="catalog/view/javascript/etimer.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".eTimer").eTimer({
			etType: 0, etDate: "30.06.2017.0.0", etTitleText: "До окончания акции осталось:", etTitleSize: 20, etShowSign: 1, etSep: ":", etFontFamily: "Impact", etTextColor: "white", etPaddingTB: 15, etPaddingLR: 15, etBackground: "black", etBorderSize: 0, etBorderRadius: 2, etBorderColor: "white", etShadow: " 0px 0px 10px 0px #333333", etLastUnit: 4, etNumberFontFamily: "Impact", etNumberSize: 35, etNumberColor: "white", etNumberPaddingTB: 0, etNumberPaddingLR: 8, etNumberBackground: "#f8b969", etNumberBorderSize: 0, etNumberBorderRadius: 5, etNumberBorderColor: "white", etNumberShadow: "inset 0px 0px 10px 0px rgba(0, 0, 0, 0.5)"
		});
	});
</script>
<?php echo $footer; ?>