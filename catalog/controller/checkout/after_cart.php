<?php

class ControllerCheckoutAfterCart extends Controller {

    public function index($input) {
        $data = array();
        $product_id = $input['product_id'];
        
        $this->load->model('catalog/product');
        $this->load->model('tool/image');
        
        $product_info = $this->model_catalog_product->getProduct($product_id);
        
        $data['sale']		= $product_info['sale'];
		$data['bestseller'] = $product_info['bestseller'];
		$data['latest']		= $product_info['latest'];
		
		$data['name'] = $product_info['name'];
		$data['href'] = $this->url->link('product/product', 'product_id=' . $product_id );
		$data['checkout'] = $this->url->link('checkout/buy');
		
		if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
			$data['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
		} else {
			$data['price'] = false;
		}

		if ((float)$product_info['special']) {
			$data['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
			$data['saved'] = $this->currency->format($product_info['price'] - $product_info['special']);
			$data['percent'] = ceil($data['saved'] * 100 / $product_info['price']);
		} else {
			$data['saved'] = false;
			$data['percent'] = false;
			$data['special'] = false;
		}
	
		if ($product_info['image']) {
			$data['thumb'] = $this->model_tool_image->resize($product_info['image'], $this->config->get('config_image_cart_width'), $this->config->get('config_image_cart_width'));
		} else {
			$data['thumb'] = '';
		}

		return $this->load->view('default/template/checkout/after_cart.tpl', $data);
    }

}