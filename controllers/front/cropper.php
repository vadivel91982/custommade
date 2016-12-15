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

class CustomMadeCropperModuleFrontController extends ModuleFrontController
{
    //public $php_self = 'product';

    /** @var Product */
    protected $product;

    /** @var Category */
    protected $category;

    public function __construct()
    {
        $this->auth = true;
        parent::__construct();
        $this->context = Context::getContext();
        $this->custommadeObj = new Custommade();
        $this->custModuleFolderName = Tools::getHttpHost(true) . __PS_BASE_URI__ . 'modules/' . $this->custommadeObj->name . '/views/img/';
    }

    /**
     * Initialize product controller
     * @see FrontController::init()
     */
    public function init()
    {
        $action = Tools::getValue('action');
        if ($action == 'setdata') {
            $this->setCropDataToSession();
        }
        if ($action == 'removedata') {
            $this->removeCropDataFromSession();
        }
        if ($action == 'savecropdata') {
            $this->updateCropDataToOrder();
        }
        if ($action == 'savecartid') {
            $this->saveUserCartIdToSession();
        }

        die;
    }

    public function setCropDataToSession()
    {
        //to write
        if (trim(Tools::getValue('pid')) != '') {
            $cookie = new Cookie('crop_data'); //make your own cookie
            //unset($cookie->product_crop_data);
            if ($cookie->product_crop_data != '') {
                $oldRecords = unserialize($cookie->product_crop_data);
            } else {
                $oldRecords = array();
            }
            $oldRecords[Tools::getValue('pid')] = Tools::getValue('data');
            //$cookie->setExpire(time() + 20 * 60); // 20 minutes for example
            $cookie->setExpire(0);
            $cookie->product_crop_data = serialize($oldRecords);
            $cookie->write();
        }
    }

    public function saveUserCartIdToSession()
    {
        //to write
        $cookie = new Cookie('crop_data'); //make your own cookie
        //$cookie->setExpire(time() + 20 * 60); // 20 minutes for example
        $cookie->setExpire(0);
        $cookie->user_cart_id = $this->context->cookie->id_cart;
        $cookie->write();
    }

    public function removeCropDataFromSession()
    {
        $cookie = new Cookie('crop_data');
        unset($cookie->product_crop_data);
    }

    public function updateCropDataToOrder()
    {
        $cookie = new Cookie('crop_data');
        $cropSessionData = unserialize($cookie->product_crop_data);
        $cartId = (int) ($cookie->user_cart_id);
        $id_order = Order::getOrderByCartId($cartId);
        $order = new Order($id_order);
        $products = $order->getProducts();

        foreach ($products as $row) {
            $orderId = $row['id_order'];
            $productId = $row['id_product'];
            if (isset($cropSessionData[$productId])) {
                $options = $cropSessionData[$productId];
                $insertOption = "insert into "._DB_PREFIX_."options set "
                        . "order_id     =   '".$orderId."',"
                        . "product_id   =   '".$productId."',"
                        . "options      =   '".$options."'";
                DB::getInstance()->Execute($insertOption);
            }
        }
        $this->removeCropDataFromSession();
    }
}
