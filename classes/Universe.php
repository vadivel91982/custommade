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

class Universe extends ObjectModel
{
    public $universe_name;
    public $image;
    public $thump;
    public $active;

    /**
     * @see ObjectModel::$definition
     */
    public static $definition = array(
        'table' => 'universe',
        'primary' => 'id_universe',
        'fields' => array(
            'universe_name' =>  array('type' => self::TYPE_STRING, 'validate' => 'isString', 'required' => true),
            'active'        =>  array('type' => self::TYPE_BOOL),
        )
    );
}
