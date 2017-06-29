<?php
class ControllerModuleParser extends Controller {
	private $error = array();

	public function index() {
		error_reporting(E_ALL);
		ini_set('display_errors', TRUE);
		ini_set('display_startup_errors', TRUE);


		$this->document->setTitle("Парсер продуктов");

		$this->load->model('extension/module');

		$data['error_warning'] = false;
		if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
			$count = $this->parseFile();

			$data['error_warning'] = "Обработано " . $count . " строк";
			//$this->response->redirect($this->url->link('extension/module/parser', 'token=' . $this->session->data['token'], true));
		}
		$data['heading_title'] = "Парсер продуктов";

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'] . '&type=module', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => "Парсер продуктов",
			'href' => $this->url->link('module/parser', 'token=' . $this->session->data['token'], true)
		);
		

		$data['action'] = $this->url->link('module/parser', 'token=' . $this->session->data['token'], true);
		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'] . '&type=module', true);


		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/parser.tpl', $data));
	}

	private function parseFile() {
		
		require_once DIR_SYSTEM . 'phpexcel/PHPExcel/IOFactory.php';

		
		$objPHPExcel = PHPExcel_IOFactory::load($_FILES['parse_file']['tmp_name']);


		foreach ($objPHPExcel->getWorksheetIterator() as $worksheet) {
		    $data = $worksheet->toArray();
		}
		unset($data[0]);
		$dd = 0;
		foreach ($data as $row) {
		
		
			// PRODUCT
			$category_row = $row[0];
			$model = $row[1];
			$main_image = $row[5];
			$price = (float)((float)$row[3] * 1.2);
			$name = $row[2];
			$description = $row[4];
			
			$in_db = $this->db->query("SELECT product_id FROM oc_product WHERE model='" . $model . "'");
			
			if($in_db->num_rows){
				$product_id = $in_db->row['product_id'];

				$this->db->query("UPDATE oc_product SET price=" . (int)$price . " WHERE product_id='" . (int)$product_id . "' ");
			} else {
				$ext_arr = explode('.', $main_image);
				$ext = end($ext_arr);
				$db_image_name = "catalog/products/" . strtolower($this->translit($model)) . "/" . md5($main_image) . "." . $ext;
				$model_folder = DIR_IMAGE . "catalog/products/" . strtolower($this->translit($model)) . "/";
				$new_image_name = DIR_IMAGE . $db_image_name;
			
				if (!file_exists($model_folder)) {
				    mkdir($model_folder, 0777, true);
				}
				copy($main_image, $new_image_name);
				
				
				$this->db->query("INSERT INTO oc_product SET model='" . $model . "', quantity='100', price='" . $price . "', manufacturer_id='0', image='" . $db_image_name . "', status=1 ");

				$product_id = $this->db->getLastId();
			}

		
			$this->db->query("DELETE FROM oc_product_description WHERE product_id = '" . (int)$product_id . "'");
			$this->db->query("INSERT INTO oc_product_description SET product_id='" . $product_id . "', language_id='2', name='" . $this->db->escape($name) . "', description='" . $this->db->escape($description) . "', meta_title='" . $this->db->escape($name) . "'");

			
			$this->db->query("DELETE FROM oc_product_to_layout WHERE product_id = '" . (int)$product_id . "'");
			$this->db->query("INSERT INTO oc_product_to_layout SET product_id='" . $product_id . "', store_id='0', layout_id='0'");

			$this->db->query("DELETE FROM oc_product_to_store WHERE product_id = '" . (int)$product_id . "'");
			$this->db->query("INSERT INTO oc_product_to_store SET product_id='" . $product_id . "', store_id='0'");
			
			$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'product_id=" . (int)$product_id . "'");
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'product_id=" . (int)$product_id . "', keyword = '" . $this->db->escape(strtolower($this->translit($model))) . "'");


			
			// PRODUCT_CATEGORYS	
			$this->db->query("DELETE FROM oc_product_to_category WHERE product_id = '" . (int)$product_id . "'");							
			$categories = explode('/', $category_row);
			$path_a = array();
			$category_id = 0;
			foreach ($categories as $category) {
				$category_q = $this->db->query("SELECT category_id FROM oc_category_description WHERE name='" . $category . "'");

				if($category_q->num_rows){
					$category_id = $category_q->row['category_id'];
					$path_a[] = $category_id;
				}else{
					if(!empty($path_a)){
						$parent_id = array_values(array_slice($path_a, -1))[0];
					}else{
						$parent_id = 0;
					}
					$this->db->query("INSERT INTO oc_category SET parent_id=" . $parent_id . ", status=1");

					$category_id = $this->db->getLastId();

					$this->db->query("INSERT INTO oc_category_description SET category_id='" . $category_id . "', language_id='2', name='" . $category . "', meta_title='" . $category . "'");

					$this->db->query("INSERT INTO oc_category_to_layout SET category_id='" . $category_id . "', store_id='0', layout_id='0'");
					$this->db->query("INSERT INTO oc_category_to_store SET category_id='" . $category_id . "', store_id='0'");
					
					$path_a[] = $category_id;

					foreach ($path_a as $i => $path) {
						$this->db->query("INSERT INTO oc_category_path SET category_id='" . $category_id . "', path_id='" . $path . "', level='" . $i . "'");
					}

				}

				$this->db->query("INSERT INTO oc_product_to_category SET product_id='" . $product_id . "', category_id='" . $category_id . "'");
			}
			$dd++;
		}
		return count($data);	
	}
	
	private function translit($text){
		$ru = explode('-', "А-а-Б-б-В-в-Ґ-ґ-Г-г-Д-д-Е-е-Ё-ё-Є-є-Ж-ж-З-з-И-и-І-і-Ї-ї-Й-й-К-к-Л-л-М-м-Н-н-О-о-П-п-Р-р-С-с-Т-т-У-у-Ф-ф-Х-х-Ц-ц-Ч-ч-Ш-ш-Щ-щ-Ъ-ъ-Ы-ы-Ь-ь-Э-э-Ю-ю-Я-я"); 
		$en = explode('-', "A-a-B-b-V-v-G-g-G-g-D-d-E-e-E-e-E-e-ZH-zh-Z-z-I-i-I-i-I-i-J-j-K-k-L-l-M-m-N-n-O-o-P-p-R-r-S-s-T-t-U-u-F-f-H-h-TS-ts-CH-ch-SH-sh-SCH-sch---Y-y---E-e-YU-yu-YA-ya");

	 	$res = str_replace($ru, $en, $text);
		$res = preg_replace("/[\s]+/ui", '-', $res);
		$res = strtolower(preg_replace("/[^0-9a-zа-я\-]+/ui", '', $res));
	    return $res;  
	}
	
}