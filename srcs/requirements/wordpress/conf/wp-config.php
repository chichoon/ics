<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', getenv('MYSQL_DB'));

/** Database username */
define( 'DB_USER', getenv('MYSQL_USER'));

/** Database password */
define( 'DB_PASSWORD', getenv('MYSQL_PW') );

/** Database hostname */
define( 'DB_HOST', getenv('MYSQL_HOST') );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '0C=lD5ybU<a[5Ir@iin.>%(+KSx8LE0 Z&.90Kq[VIs5wi}=CkE22x+pSYnNZV(Z');
define('SECURE_AUTH_KEY',  'L#5`WjyPd.au}|@WRJ/h-+6Y!.o|5:UziLuLg?B0H_Lo?NX7qRxFhF@2_2J-]A;&');
define('LOGGED_IN_KEY',    'cYIrId)^k oId!8UD5?[O`^AnWG~o#qK_Hx{>CtUq_8?,Fd7e*@Q7Bsy-Dw0c+,D');
define('NONCE_KEY',        '*-(h=c;V%da-U<nU:}McP?8y<hfPh6s Al)h!0H!=@|Z}u|S04?:ao>,fr5=7(R$');
define('AUTH_SALT',        'aim8c[ar/yqES$-Wuha!}EM6PLyU*i=e:TqB~nGI+kTC!~ksCBCxV!e?`}{~.TG|');
define('SECURE_AUTH_SALT', '*fbs-22RuF.[{=+`Dc;t+y{pfiUs/BBdV$2_|~VTB],:#~.nVE`rnGM{|h|7b z`');
define('LOGGED_IN_SALT',   'rto{l((,tJLGJXABDt:<-m]~Hv8*JJ]IqQNHN*yp3)fa# 1th[Yy}J_+0r1u}tH2');
define('NONCE_SALT',       'A +cYP/:((zb2Y$re_swAt%;t,aLx@AfQJICpkW^k-:~K[U+*&e zV4`6|++-~9Q');

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
