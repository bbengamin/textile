<?php

class ControllerModuleTestimonial extends Controller
{
    public function index($setting)
    {
        static $module = 0;
        $data['heading_title'] = html_entity_decode($setting['module_description'][$this->config->get('config_language_id')]['title'], ENT_QUOTES, 'UTF-8');

        $data['button_all_text'] = html_entity_decode($setting['module_description'][$this->config->get('config_language_id')]['all_text'], ENT_QUOTES, 'UTF-8');
        $data['layout'] = (int)$setting['layout_id'];

        $data['button_all'] = (int)$setting['button_all'];
        $data['keyword'] = $this->url->link('testimonial/testimonial');

        $this->load->model('module/testimonial');

        $results = $this->model_module_testimonial->getModuleReviews(0, $setting['limit'], $setting['order']);

        if ($results) {
            foreach ($results as $result) {
                $data['reviews'][] = array(
                    'review_id' => $result['review_id'],
                    'text' => strip_tags(html_entity_decode($result['text'], ENT_QUOTES, 'UTF-8')),
                    'rating' => (int)$result['rating'],
                    'author' => $result['author'],
                    'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
                );
            }

            $data['module'] = 'sr' . $module++;

            if(substr(VERSION, 0, 7) > '2.1.0.2'){
                return $this->load->view('module/testimonial', $data);
            }else{
                if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/testimonial.tpl')) {
                    return $this->load->view($this->config->get('config_template') . '/template/module/testimonial.tpl', $data);
                } else {
                    return $this->load->view('default/template/module/testimonial.tpl', $data);
                }
            }
        }
    }
}