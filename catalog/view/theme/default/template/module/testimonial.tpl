<?php if($heading_title){ ?>
<h2 class='name-h2'><?php echo $heading_title; ?></h2>
<?php } ?>
<div class="row" id='reviews-box'>
    <?php foreach ($reviews as $review) { ?>
    <div class="review-wp">
        <div class="horizontal-sreview transition">
            <div class="caption review-caption">
                <span class="review-author"><?php echo $review['author']; ?></span>
                <span class="review-date-added"><?php echo $review['date_added']; ?></span>
                <div class="rating">
                    <?php for ($i = 1; $i <= 5; $i++) { ?>
                    <?php if ($review['rating'] < $i) { ?>
                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"
                                             style='color: #f8b969;'></i></span>
                    <?php } else { ?>
                    <span class="fa fa-stack">
                        <i class="fa fa-star fa-stack-2x" style='color: #f8b969;'></i>
                        <i class="fa fa-star-o fa-stack-2x" style='color: #f8b969;'></i>
                    </span>
                    <?php } ?>
                    <?php } ?>
                </div>
                <p><?php echo $review['text']; ?></p>
            </div>
        </div>
    </div>
    <?php } ?>
</div>
