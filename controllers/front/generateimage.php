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

class CustomMadeGenerateimageModuleFrontController extends ModuleFrontController
{
    public function __construct()
    {
        parent::__construct();
        //$select = "SELECT * FROM "._DB_PREFIX_."options WHERE 1 and status = 'pending' limit 5";
        $select = "SELECT * FROM "._DB_PREFIX_."options WHERE 1 and status = 'pending'";
        //$select = "SELECT * FROM " . _DB_PREFIX_ . "options WHERE 1 ORDER BY id DESC";
        $results = Db::getInstance()->ExecuteS($select);
        foreach ($results as $row) {
            $id = $row['id'];
            $productId = $row['product_id'];
            $customOptions = Tools::jsonDecode($row['options']);

            $id_image = Product::getCover($productId);
// get Image by id
            if (sizeof($id_image) > 0) {
                $image = new Image($id_image['id_image']);
                // get image full URL
                $image_url = Tools::getHttpHost(true) . _THEME_PROD_DIR_ . $image->getExistingImgPath() . ".jpg";
                $options = array();
                $options['record_id'] = $id;
                $options['hd_image_url'] = $image_url;
                $options['crop_x'] = $customOptions->x;
                $options['crop_y'] = $customOptions->y;
                $options['width'] = $customOptions->width;
                $options['height'] = $customOptions->height;
                $options['user_width'] = $customOptions->userWidth;
                $options['user_height'] = $customOptions->userHeight;
                $options['rotate_degree'] = $customOptions->rotate;
                $options['grid_size'] = $customOptions->gridSize;
                if ($customOptions->scaleX == '-1' || $customOptions->scaleY == '-1') {
                    $options['mirror_effect'] = 1;
                } else {
                    $options['mirror_effect'] = 0;
                }

                if (isset($customOptions->stripe) && $customOptions->stripe == '1') {
                    $options['stripe_filename'] = 'modules/custommade/views/img/grid-line.png';
                }
                $options['output_filename'] = 'modules/custommade/output/' . $id . '.png';
                $updateStatus = 'UPDATE ' . _DB_PREFIX_ . 'options SET status = "processing" WHERE 1 and id = "' . $id . '"';
                DB::getInstance()->Execute($updateStatus);
                if ($this->generateFinalImage($options)) {
                    $updateStatus = 'UPDATE ' . _DB_PREFIX_ . 'options SET status = "completed" WHERE 1 and id = "' . $id . '"';
                    DB::getInstance()->Execute($updateStatus);
                } else {
                    $updateStatus = 'UPDATE ' . _DB_PREFIX_ . 'options SET status = "error" WHERE 1 and id = "' . $id . '"';
                    DB::getInstance()->Execute($updateStatus);
                }
            } else {
                $updateStatus = 'UPDATE ' . _DB_PREFIX_ . 'options SET status = "image_error" WHERE 1 and id = "' . $id . '"';
                DB::getInstance()->Execute($updateStatus);
            }
            die;
        }
        /* Unlink temp images */
        $scanPath = 'modules/custommade/tmp';
        $tmpFileList = scandir($scanPath);
        //echo '----' . __LINE__ . '----' . __FILE__ . '<pre>' . print_r($tmpFileList, true) . '</pre>';
        foreach ($tmpFileList as $k => $file) {
            if ($file != '.' && $file != '..' && $file != 'index.php') {
                unlink($scanPath . '/' . $file);
            }
        }
        die;
    }

    private function generateFinalImage($config)
    {
        if (isset($config['hd_image_url']) && filter_var($config['hd_image_url'], FILTER_VALIDATE_URL)) {
            //$imageData = Tools::file_get_contents($config['hd_image_url']);
            $imageData = $this->grabImage($config['hd_image_url']);
            $tmpFileName = 'modules/custommade/tmp/tmp_image_' . $config['record_id'] . '.jpg';
            file_put_contents($tmpFileName, $imageData);

            $imageSize = getimagesize($tmpFileName);

            $bgWidth = $imageSize[0];
            $bgHeight = $imageSize[1];

            $im = imagecreatefromjpeg($tmpFileName);

            /* Stop : Rotate Image */
            $im = imagerotate($im, ($config['rotate_degree'] * -1), 0);
            /* Start : Crop Image */
            $im = imagecrop($im, ['x' => $config['crop_x'], 'y' => $config['crop_y'], 'width' => $config['width'], 'height' => $config['height']]);
            

            /* Start : Flip Image (Mirror effect) */
            if ($config['mirror_effect']) {
                imageflip($im, IMG_FLIP_HORIZONTAL);
            }
            /* Stop : Flip Image (Mirror effect) */

            /* Start : Merge Stripe */
            if (isset($config['stripe_filename']) && trim($config['stripe_filename']) != '') {
                $sim = imagecreatefrompng($config['stripe_filename']);
                //imagecopyresampled($im, $sim, 0, 0, 0, 0, $config['width'], $config['height'], $config['width'], $config['height']);
                for ($i = 0; $i <= $bgWidth; $i = $i + $config['grid_size']) {
                    for ($j = 0; $j <= $bgHeight; $j++) {
                        imagecopyresampled($im, $sim, $i, $j, 0, 1, 1, 1, 1, 1);
                    }
                }
            }
            /* Stop : Merge Stripe */
            
            //generate final output image
            if ($im !== false) {
                //imagepng($im, $config['output_filename']);
                /*Start : Resize image to user entered dimension*/
                $cmtopx = 37.795275591;
                //$im = imagecreatefrompng($config['output_filename']);
                $newWidth = $config['user_width'] * $cmtopx;
                $newHeight = $config['user_height'] * $cmtopx;
                $rsz = imagecreatetruecolor($newWidth, $newHeight);
                //echo '----' . __LINE__ . '----' . __FILE__ . $newWidth;
                // Resize
                imagecopyresampled($rsz, $im, 0, 0, 0, 0, $newWidth, $newHeight, $config['width'], $config['height']);
                imagepng($rsz, $config['output_filename']);
                /* Stop : Resize image to user entered dimension */
                return true;
            }
            return false;
        } else {
            return false;
        }
    }

    public function grabImage($url)
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.1 Safari/537.11');
        $res = curl_exec($ch);
        $rescode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);
        return $res;
    }
}
