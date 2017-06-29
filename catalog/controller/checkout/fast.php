<?php
class ControllerCheckoutFast extends Controller {

    public function fastorder() {
		$json = array();

		if(!isset($this->request->post['name']) || strlen($this->request->post['name']) == 0){
			$json['error']['name'] = "Введите корректное имя";
		}

		if(!isset($this->request->post['phone']) || strlen($this->request->post['phone']) == 0){
			$json['error']['phone'] = "Введите корректный телефон";
		}
		
		if(!isset($this->request->post['email']) || strlen($this->request->post['email']) == 0){
			$json['error']['email'] = "Введите корректный email";
		}
		if(!$json){
			
			$cur_state = $this->cart->getProducts();
			foreach ($cur_state as $product) {
				$this->cart->remove($product['cart_id']);
			}
			
			$this->cart->add($this->request->post['product_id'], $this->request->post['quantity'], array(), 0);
	
			$method_data = array();
	
			$this->load->model('extension/extension');
			$temp = array(
				'country_id' => "220",
				'zone_id' => "4224"
			);
			$method_data = array();
	
			$this->load->model('extension/extension');
	
			$results = $this->model_extension_extension->getExtensions('shipping');
	
			foreach ($results as $result) {
				if ($this->config->get($result['code'] . '_status')) {
					$this->load->model('shipping/' . $result['code']);
	
					$quote = $this->{'model_shipping_' . $result['code']}->getQuote($temp);
	
					if ($quote) {
						$method_data[$result['code']] = array(
							'title'      => $quote['title'],
							'quote'      => $quote['quote'],
							'sort_order' => $quote['sort_order'],
							'error'      => $quote['error']
						);
					}
				}
			}
	
			$sort_order = array();
	
			foreach ($method_data as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}
	
			array_multisort($sort_order, SORT_ASC, $method_data);
	
	
		
			$this->session->data['shipping_method'] = $method_data["flat"]['quote']["flat"];
	
			$order_data['totals'] = array();
			$total = 0;
			$taxes = $this->cart->getTaxes();
	
			$this->load->model('extension/extension');
	
			$sort_order = array();
	
			$results = $this->model_extension_extension->getExtensions('total');
	
			foreach ($results as $key => $value) {
				$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
			}
	
			array_multisort($sort_order, SORT_ASC, $results);
	
			foreach ($results as $result) {
				if ($this->config->get($result['code'] . '_status')) {
					$this->load->model('total/' . $result['code']);
	
					$this->{'model_total_' . $result['code']}->getTotal($order_data['totals'], $total, $taxes);
				}
			}
	
			$sort_order = array();
	
			foreach ($order_data['totals'] as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}
	
			array_multisort($sort_order, SORT_ASC, $order_data['totals']);
	
			$this->load->language('checkout/checkout');
	
			$order_data['invoice_prefix'] = $this->config->get('config_invoice_prefix');
			$order_data['store_id'] = $this->config->get('config_store_id');
			$order_data['store_name'] = $this->config->get('config_name');
	
			if ($order_data['store_id']) {
				$order_data['store_url'] = $this->config->get('config_url');
			} else {
				if ($this->request->server['HTTPS']) {
					$order_data['store_url'] = HTTPS_SERVER;
				} else {
					$order_data['store_url'] = HTTP_SERVER;
				}
			}
	
			$order_data['customer_id'] = $this->customer->getId();
			$order_data['customer_group_id'] = 1;
			$order_data['firstname'] = $this->request->post['name'];
			$order_data['lastname'] = "";
			$order_data['email'] = $this->request->post['email'];
			$order_data['telephone'] = $this->request->post['phone'];
			$order_data['fax'] = "";
			$order_data['custom_field'] = array();
				
			$order_data['payment_firstname'] = $this->request->post['name'];
			$order_data['payment_lastname'] = "";
			$order_data['payment_company'] = "";
			$order_data['payment_address_1'] = "";
			$order_data['payment_address_2'] = "";
			$order_data['payment_city'] = "";
			$order_data['payment_postcode'] = "";
			$order_data['payment_zone'] = "Харьков";
			$order_data['payment_zone_id'] = 4224;
			$order_data['payment_country'] = "Украина";
			$order_data['payment_country_id'] = 220;
			$order_data['payment_address_format'] = "";
			$order_data['payment_custom_field'] = array();
				
			$order_data['payment_method'] = 'Оплата наложеным платежем';
			$order_data['payment_code'] = 'cod';
	
			$order_data['shipping_firstname'] = $this->request->post['name'];
			$order_data['shipping_lastname'] = '';
			$order_data['shipping_company'] = '';
			$order_data['shipping_address_1'] = '';
			$order_data['shipping_address_2'] = '';
			$order_data['shipping_city'] = '';
			$order_data['shipping_postcode'] = '';
			$order_data['shipping_zone'] = "Харьков";
			$order_data['shipping_zone_id'] = 4224;
			$order_data['shipping_country'] = "Украина";
			$order_data['shipping_country_id'] = 220;
			$order_data['shipping_address_format'] = '';
			$order_data['shipping_custom_field'] = array();
			$order_data['shipping_method'] = $method_data["flat"]['title'];
			$order_data['shipping_code'] = "flat";
	
			$order_data['products'] = array();
	
			foreach ($this->cart->getProducts() as $product) {
				$option_data = array();
	
				foreach ($product['option'] as $option) {
					$option_data[] = array(
						'product_option_id'       => $option['product_option_id'],
						'product_option_value_id' => $option['product_option_value_id'],
						'option_id'               => $option['option_id'],
						'option_value_id'         => $option['option_value_id'],
						'name'                    => $option['name'],
						'value'                   => $option['value'],
						'type'                    => $option['type']
					);
				}
	
				$order_data['products'][] = array(
					'product_id' => $product['product_id'],
					'name'       => $product['name'],
					'model'      => $product['model'],
					'option'     => $option_data,
					'download'   => $product['download'],
					'quantity'   => $product['quantity'],
					'subtract'   => $product['subtract'],
					'price'      => $product['price'],
					'total'      => $product['total'],
					'tax'        => $this->tax->getTax($product['price'], $product['tax_class_id']),
					'reward'     => $product['reward']
				);
			}
	
			$order_data['vouchers'] = array();
	
			$order_data['comment'] = "Быстрый заказ";
			$order_data['total'] = $total;
	
			$order_data['affiliate_id'] = 0;
			$order_data['commission'] = 0;
			$order_data['marketing_id'] = 0;
			$order_data['tracking'] = '';
	
			$order_data['language_id'] = $this->config->get('config_language_id');
			$order_data['currency_id'] = $this->currency->getId($this->session->data['currency']);
			$order_data['currency_code'] = $this->session->data['currency'];
			$order_data['currency_value'] = $this->currency->getValue($this->session->data['currency']);
			$order_data['ip'] = $this->request->server['REMOTE_ADDR'];
	
			if (!empty($this->request->server['HTTP_X_FORWARDED_FOR'])) {
				$order_data['forwarded_ip'] = $this->request->server['HTTP_X_FORWARDED_FOR'];
			} elseif (!empty($this->request->server['HTTP_CLIENT_IP'])) {
				$order_data['forwarded_ip'] = $this->request->server['HTTP_CLIENT_IP'];
			} else {
				$order_data['forwarded_ip'] = '';
			}
	
			if (isset($this->request->server['HTTP_USER_AGENT'])) {
				$order_data['user_agent'] = $this->request->server['HTTP_USER_AGENT'];
			} else {
				$order_data['user_agent'] = '';
			}
	
			if (isset($this->request->server['HTTP_ACCEPT_LANGUAGE'])) {
				$order_data['accept_language'] = $this->request->server['HTTP_ACCEPT_LANGUAGE'];
			} else {
				$order_data['accept_language'] = '';
			}
	
			$this->load->model('checkout/order');
	
			$this->session->data['order_id'] = $this->model_checkout_order->addOrder($order_data);
			$this->model_checkout_order->addOrderHistory($this->session->data['order_id'], $this->config->get('cod_order_status_id'));
			$json['success'] = 'success';
			
			$this->cart->clear();
			foreach ($cur_state as $product) {
				$this->cart->add($product['product_id'], $product['quantity'], array(), 0);
			}
		}

		$this->response->setOutput(json_encode($json));
	}
	
	public function callback(){

		$this->load->language('checkout/fast');
		$json = array();

		if(!isset($this->request->post['name']) || strlen($this->request->post['name']) == 0){
			$json['error']['name'] = "Введите корректное имя";
		}

		if(!isset($this->request->post['phone']) || strlen($this->request->post['phone']) == 0){
			$json['error']['phone'] = "Введите корректный телефон";
		}

		if(!$json){
			$text = "Обратный звонок" . "\n\n";
			$text .= "Имя:" . $this->request->post['name'] . "\n";
			$text .= "Телефон:" .  $this->request->post['phone'];

			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
			$mail->smtp_username = $this->config->get('config_mail_smtp_username');
			$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
			$mail->smtp_port = $this->config->get('config_mail_smtp_port');
			$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

			$mail->setTo($this->config->get('config_email'));
			$mail->setFrom($this->config->get('config_email'));
			$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
			$mail->setSubject(html_entity_decode("Обратный звонок", ENT_QUOTES, 'UTF-8'));
			$mail->setText($text);
			$mail->send();

			// Send to additional alert emails
			$emails = explode(',', $this->config->get('config_mail_alert'));

			foreach ($emails as $email) {
				if ($email && preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $email)) {
					$mail->setTo($email);
					$mail->send();
				}
			}

			$json['success'] = 'success';
		}
		$this->response->setOutput(json_encode($json));
	}
}
?>