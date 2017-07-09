<?php
class ControllerProductAjax extends Controller {
	public function mainProducts($settings){
		$data = array();
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');
		
		
		if(isset($settings['category_id'])){
			$category_id = $settings['category_id']; 
		}else{
			$category_id = 0;
		}
		
		$this->load->model('catalog/product');
		$this->load->model('catalog/category');
		$this->load->model('tool/image');
		
		$data['categories_top'] = array();

		$categories = $this->model_catalog_category->getCategories(0);

		foreach ($categories as $category) {
			if ($category['top']) {
				// Level 2
				$children_data = array();

				$children = $this->model_catalog_category->getCategories($category['category_id']);

				foreach ($children as $child) {
					$filter_data = array(
						'filter_category_id'  => $child['category_id'],
						'filter_sub_category' => true
					);

					$children_data[] = array(
						'name'  => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
						'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
					);
				}

				// Level 1
				$data['categories_top'][] = array(
					'category_id'     => $category['category_id'],
					'name'     => $category['name'],
					'children' => $children_data,
					'column'   => $category['column'] ? $category['column'] : 1,
					'href'     => $this->url->link('product/category', 'path=' . $category['category_id'])
				);
			}
		}
	
		
		$limit = 30;
		$categories = $this->model_catalog_category->getCategories($category_id);
		$category_name_q = $this->db->query("SELECT name FROM oc_category_description WHERE language_id='" . (int)$this->config->get('config_language_id') . "' AND category_id=" . $category_id);

		$data['name'] = $category_name_q->row['name'];
		$data['category_id'] = $category_id;
		if($categories){
			$data['categories'] = array();
			foreach ($categories as $category) {
				$data_filter = array(
					'filter_category_id' => $category['category_id'],
					'start' => 0,
					'limit' => $limit
				);
				
				$results = $this->model_catalog_product->getProducts($data_filter);
				
				$products = array();
				foreach ($results as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
					
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
		
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
						$saved = $this->currency->format($result['price'] - $result['special']);
						$percent = ceil($saved * 100 / $result['price']);
					} else {
						$special = false;
						$saved = false;
						$percent = false;
					}
		
					$products[] = array(
						'product_id'  => $result['product_id'],
						'thumb'       => $image,
						'name'        => $result['name'],
						'bestseller'  => $result['bestseller'],
						'latest'      => $result['latest'],
						'sale'        => $result['sale'],
						'price'       => $price,
						'special'     => $special,
						'saved'     => $saved,
						'percent'     => $percent,
						'minimum'     => 1,
						'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
					);
				}
				
				
				$data['categories'][] = array(
					'category_id' => $category['category_id'],
					'name' => $category['name'],
					'products' => $products
				);
			}
		}else{
			$data_filter = array(
				'filter_category_id' => $category_id,
				'start' => 0,
				'limit' => $limit
			);
			
			$results = $this->model_catalog_product->getProducts($data_filter);
			$data['products'] = array();
			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
				}
				
				$images = array();
				
	
				$results_img = $this->model_catalog_product->getProductImages($result['product_id']);
		
				foreach ($results_img as $result_img) {
					$images[] = array(
						'popup' => $this->model_tool_image->resize($result_img['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')),
						'thumb' => $this->model_tool_image->resize($result_img['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height'))
					);
				}
	
				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$price = false;
				}
	
				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					$saved = $this->currency->format($result['price'] - $result['special']);
					$percent = ceil($saved * 100 / $result['price']);
				} else {
					$special = false;
					$saved = false;
					$percent = false;
				}
	
				$data['products'][] = array(
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'images'       => $images,
					'name'        => $result['name'],
					'bestseller'  => $result['bestseller'],
					'latest'      => $result['latest'],
					'sale'        => $result['sale'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
					'price'       => $price,
					'special'     => $special,
					'saved'     => $saved,
					'percent'     => $percent,
					'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
					'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
				);
			}
		}
		
		
	/*	
		$category_name_q = $this->db->query("SELECT name FROM oc_category_description WHERE language_id='" . (int)$this->config->get('config_language_id') . "' AND category_id=" . $category_id);
		$data['name'] = $category_name_q->row['name'];
		
		$results = $this->model_catalog_product->getProducts($data_filter);
		$data['products'] = array();
		foreach ($results as $result) {
			if ($result['image']) {
				$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
			} else {
				$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
			}
			
			$images = array();
			

			$results_img = $this->model_catalog_product->getProductImages($result['product_id']);
	
			foreach ($results_img as $result_img) {
				$images[] = array(
					'popup' => $this->model_tool_image->resize($result_img['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')),
					'thumb' => $this->model_tool_image->resize($result_img['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height'))
				);
			}

			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$price = false;
			}

			if ((float)$result['special']) {
				$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
				$saved = $this->currency->format($result['price'] - $result['special']);
				$percent = ceil($saved * 100 / $result['price']);
			} else {
				$special = false;
				$saved = false;
				$percent = false;
			}

			$data['products'][] = array(
				'product_id'  => $result['product_id'],
				'thumb'       => $image,
				'images'       => $images,
				'name'        => $result['name'],
				'bestseller'  => $result['bestseller'],
				'latest'      => $result['latest'],
				'sale'        => $result['sale'],
				'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
				'price'       => $price,
				'special'     => $special,
				'saved'     => $saved,
				'percent'     => $percent,
				'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
				'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
			);
		}
		*/
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/products_home.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/product/products_home.tpl', $data);
		} else {
			return $this->load->view('default/template/product/products_home.tpl', $data);
		}
	}
}
