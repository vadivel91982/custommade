<?php

/**
 * NOTICE OF LICENSE
 *
 * This source file is subject to a commercial license from 202 ecommerce
 * Use, copy, modification or distribution of this source file without written
 * license agreement from 202 ecommerce is strictly forbidden.
 *
 * @author    202 ecommerce <contact@202-ecommerce.com>
 * @copyright Copyright (c) 202 ecommerce 2014
 * @license   Commercial license
 *
 * Support <support@202-ecommerce.com>
 */
if (!defined('_PS_VERSION_')) {
    die(header('HTTP/1.0 404 Not Found'));
}

class CustomMadeGenerateimageModuleFrontController extends ModuleFrontController {

    public function __construct() {
        /*echo '----' . __LINE__ . '----' . __FILE__ . '<pre>' . print_r($_POST, true) . '</pre>';
        echo '----' . __LINE__ . '----' . __FILE__ . '<pre>' . print_r(Tools::getValue('type'), true) . '</pre>';
        die;*/
        parent::__construct();
        $options = array();
        //$options['hd_image_url'] = 'http://localhost/afdc/wallpapper.jpg';
        //$options['hd_image_url'] = 'http://www.wallpapereast.com/static/images/HD-Wallpaper-D5D.jpg';
        if (!empty(Tools::getValue('imageUrl')))
            $options['hd_image_url'] = Tools::getValue('imageUrl');
        if (!empty(Tools::getValue('x')))
            $options['crop_x'] = Tools::getValue('x');
        else
            $options['crop_x'] = 0;
        if (!empty(Tools::getValue('y')))
            $options['crop_y'] = Tools::getValue('y');
        else
            $options['crop_y'] = 0;
        if (!empty(Tools::getValue('width')))
            $options['width'] = Tools::getValue('width');
        else
            $options['width'] = 300;
        if (!empty(Tools::getValue('height')))
            $options['height'] = Tools::getValue('height');
        else
            $options['height'] = 300;
        if (!empty(Tools::getValue('rotate')))
        {
            $options['rotate_degree'] = Tools::getValue('rotate');
            /*if($options['rotate_degree'] < 0){
                $options['rotate_degree'] = $options['rotate_degree'] * -1;
            }*/
        }
        else
            $options['rotate_degree'] = 0;
        if (Tools::getValue('mirror') == '1')
            $options['mirror_effect'] = TRUE;
        else
            $options['mirror_effect'] = FALSE;
        if (!empty(Tools::getValue('stripe')))
            $options['stripe_filename'] = Tools::getValue('stripe');
        else
            $options['stripe_filename'] = FALSE;
        //if (!empty(Tools::getValue('output_file')))
            $options['output_filename'] = 'ex-cropped.png';


        $this->generateFinalImage($options);
    }

    private function generateFinalImage($config) {
        if (isset($config['hd_image_url']) && filter_var($config['hd_image_url'], FILTER_VALIDATE_URL)) {
            $imageData = file_get_contents($config['hd_image_url']);
            //echo '----' . __LINE__ . '----' . __FILE__ . $imageData;
            //echo '----' . __LINE__ . '----' . __FILE__ . '<pre>' . print_r($config, true) . '</pre>';
            $tmpFileName = 'tmp_image.jpg';
            file_put_contents($tmpFileName, $imageData);
            //$size = 200;
            $im = imagecreatefromjpeg($tmpFileName);
            /*imagealphablending($im, true);
            $transparentcolour = imagecolorallocate($im, 255, 255, 255);
            imagecolortransparent($im, $transparentcolour);*/
            //$size = min(imagesx($im), imagesy($im));


            /* Start : Crop Image */
            $im = imagecrop($im, ['x' => $config['crop_x'], 'y' => $config['crop_y'], 'width' => $config['width'], 'height' => $config['height']]);
            /* Stop : Crop Image */
            /* Start : Rotate Image */
            $im = imagerotate($im, $config['rotate_degree'], 0);
            /* Stop : Rotate Image */

            /* Start : Flip Image (Mirror effect) */
            if ($config['mirror_effect']) {
                imageflip($im, IMG_FLIP_HORIZONTAL);
            }
            /* Stop : Flip Image (Mirror effect) */

            /* Start : Merge Stripe */
            if (isset($config['stripe_filename']) && trim($config['stripe_filename']) != '') {

                $sim = imagecreatefrompng($config['stripe_filename']);
                imagecopyresampled($im, $sim, $config['crop_x'], $config['crop_y'], 0, 0, $config['width'], $config['height'], $config['width'], $config['height']);
            }
            /* Stop : Merge Stripe */
            //generate final output image
            if ($im !== FALSE) {
                imagepng($im, $config['output_filename']);
                echo $config['output_filename'];
                die;
            }
            return false;
        } else {
            die('invalid image url');
        }
    }

}
