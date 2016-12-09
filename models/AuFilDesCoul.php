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

class AuFilDesCoul extends ObjectModel
{

    public $id_product;
    public $prod_customize;
    public $cust_height;
    public $cust_width;
    public $sq_meter_price;
    public $cust_delivery;

    public static $definition = array(
        'table'     => 'aufildes',
        'primary'   => 'id_afdc',
        'multilang' => false,
        'fields' => array(
            'id_product' => array(
                'type' => parent::TYPE_INT
            ),
            'prod_customize' => array(
                'type' => parent::TYPE_INT,
                'required' => true
            ),
            'cust_height' => array(
                'type' => parent::TYPE_STRING
            ),
            'cust_width' => array(
                'type' => parent::TYPE_STRING
            ),
            'sq_meter_price' => array(
                'type' => parent::TYPE_STRING
            ),
            'cust_delivery' => array(
                'type' => parent::TYPE_INT
            ),
        )
    );

    public static function getAuFilDes($id_product = null)
    {
        $sql = '
            SELECT `'.self::$definition['primary'].'`
            FROM `'._DB_PREFIX_.self::$definition['table'].'` AS a
            '.Shop::addSqlAssociation(self::$definition['primary'], 'a').'
            WHERE 1 ';

        if (is_null($id_product) === false) {
            $sql .= " AND a.id_product = '".(int)$id_product."' ";
        }
            //$sql .= " AND a.prod_customize = '".(int)$id_product."' ";

        $objs_ids = Db::getInstance()->ExecuteS($sql);

        $objs = array();

        if ($objs_ids && count($objs_ids)) {

            foreach ($objs_ids as $obj_id) {
                $objs[] = new AuFilDesCoul($obj_id[self::$definition['primary']]);
            }
        }

        return $objs;
    }

    /**
     * Get by id_product
     * @param  int $id_product ID Product
     * @return AuFilDesCouleurs Instanciation of this class
     */
    public static function getAuFilDesByIDProduct($id_product)
    {
        $object = self::getAuFilDes($id_product);

        return ($object && count($object) ? current($object) : new AuFilDesCoul());
    }

    public static function getUniversImage()
    {
        $query = 'SELECT * FROM `'._DB_PREFIX_.'universe` WHERE `active` = 1 ORDER BY id_universe ASC';
        return Db::getInstance()->executeS($query);
    }

}
