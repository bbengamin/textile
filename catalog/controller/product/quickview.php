<?php
class ControllerProductQuickview extends Controller {

	public function index() {
		if (isset($this->request->get['product_id'])) {
			$product_id = (int)$this->request->get['product_id'];
		} else {
			$product_id = 0;
		}

		$this->load->model('catalog/product');

		$product_info = $this->model_catalog_product->getProduct($product_id);

		if ($product_info) {
			$data['heading_title'] = $product_info['name'];
			$data['name'] = $product_info['name'];
			$data['href'] = $this->url->link('product/product', "product_id=" . $product_id);

			$data['product_id'] = (int)$this->request->get['product_id'];
			$data['model'] = $product_info['model'];
			$data['description'] = html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8');
			$data['sale'] = $product_info['sale'];
			$data['latest'] = $product_info['latest'];
			$data['bestseller'] = $product_info['bestseller'];

			$this->load->model('tool/image');

			$data['images'] = array();
			
			if ($product_info['image']) {
				$data['popup'] = $this->model_tool_image->resize($product_info['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));
			} else {
				$data['popup'] = '';
			}

			if ($product_info['image']) {
				$data['thumb'] = $this->model_tool_image->resize($product_info['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));
			} else {
				$data['thumb'] = '';
			}
			
			$results = $this->model_catalog_product->getProductImages($this->request->get['product_id']);

			foreach ($results as $result) {
				$data['images'][] = array(
					'popup' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')),
					'thumb' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height'))
				);
			}

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

			$data['minimum'] = 1;

			$data['reviews'] = $this->url->link('product/product', "product_id=" . $product_id . "&review=open#review");

			$this->response->setOutput($this->load->view('default/template/product/quickview.tpl', $data));
		}
	}
	
	public function lastChance() {
		if (isset($this->request->get['product_id'])) {
			$product_id = (int)$this->request->get['product_id'];
		} else {
			$product_id = 0;
		}

		$this->load->model('catalog/product');

		$product_info = $this->model_catalog_product->getProduct($product_id);

		if ($product_info) {
			$data['heading_title'] = $product_info['name'];
			$data['name'] = $product_info['name'];
			$data['href'] = $this->url->link('product/product', "product_id=" . $product_id);

			$data['product_id'] = (int)$this->request->get['product_id'];
			$data['model'] = $product_info['model'];
			$data['description'] = html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8');
			$data['sale'] = $product_info['sale'];
			$data['latest'] = $product_info['latest'];
			$data['bestseller'] = $product_info['bestseller'];

			$this->load->model('tool/image');

			$data['images'] = array();
			
			if ($product_info['image']) {
				$data['popup'] = $this->model_tool_image->resize($product_info['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));
			} else {
				$data['popup'] = '';
			}

			if ($product_info['image']) {
				$data['thumb'] = $this->model_tool_image->resize($product_info['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));
			} else {
				$data['thumb'] = '';
			}
			
			$results = $this->model_catalog_product->getProductImages($this->request->get['product_id']);

			foreach ($results as $result) {
				$data['images'][] = array(
					'popup' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')),
					'thumb' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height'))
				);
			}

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

			$data['minimum'] = 1;

			$data['reviews'] = $this->url->link('product/product', "product_id=" . $product_id . "&review=open#review");

			$this->response->setOutput($this->load->view('default/template/product/quickview.tpl', $data));
		}
	}
	


}
