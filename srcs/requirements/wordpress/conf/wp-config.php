<?php

define( 'DB_NAME', getenv('WORDPRESS_DB_NAME') );
define( 'DB_USER', getenv('WORDPRESS_DB_USER') );
define( 'DB_PASSWORD', getenv('WORDPRESS_DB_PASSWORD') );
define( 'DB_HOST', 'mariadb:3306' );
define( 'DB_CHARSET', 'utf8mb4' );
define( 'DB_COLLATE', '' );

define( 'AUTH_KEY',         'q8W0P<sYB6u@8.}2M*(wCsHfl.dV7vyD`]m}LJG6!]?BERe24(' );
define( 'SECURE_AUTH_KEY',  '1T~:*O[.liqHcmZk|2HUDl~9eQH8#/u{D0BZgK/vDjHYqX~!~A' );
define( 'LOGGED_IN_KEY',    'QsG8q+vX66YfX^gB£!{O=9?|LWY?y}8+oM)IQvsgb5fk1ES15y' );
define( 'NONCE_KEY',        '|A1{yYVE£[Dw^"DNB+ko.8*PN!vOY8#E$4W@Qi^/!8f£!(DW1f' );
define( 'AUTH_SALT',        'Ij-0>)@D8FE8{Hce@`A=cym9a\p-7F\aq0+mJCPBmmC<dcG^%u' );
define( 'SECURE_AUTH_SALT', 'cK._UG/!x1yNO5XMKnn5-F}e9ka|02N0hz=$jg!k9|.D,{6F-"' );
define( 'LOGGED_IN_SALT',   'wLQ*>zum}D-B+-7&£00uiy=F1o\&T1}G£p$\qa=z|Gn=9^1^]A' );
define( 'NONCE_SALT',       '=69C9D!$wgssA2?ThT!A=Sit?^TGsV<XjB;wu|R4jv1Z0/@zoN' );

$table_prefix = 'wp_';

define( 'WP_DEBUG', false );

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';
