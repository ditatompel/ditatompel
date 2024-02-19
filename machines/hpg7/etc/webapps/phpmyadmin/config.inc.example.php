<?php
/**
 * phpMyAdmin sample configuration, you can use it as base for
 * manual configuration. For easier setup you can use setup/
 *
 * All directives are explained in documentation in the doc/ folder
 * or at <https://docs.phpmyadmin.net/>.
 */
declare(strict_types=1);

// add your servers to $myCfg['servers'] then place this file to
// `/etc/webapps/phpmyadmin/config.inc.php`
$myCfg = [
    'servers' => [
        [
            'name' => '127.0.0.1 (local)', // passed to $cfg['Servers'][$i]['verbose']
            'user' => 'root',
            'pass' => '',
            'host' => '127.0.0.1',
        ],
        // ...
    ],
];

/**
 * This is needed for cookie based authentication to encrypt the cookie.
 * Needs to be a 32-bytes long string of random bytes. See FAQ 2.10.
 */
$cfg['blowfish_secret'] = ''; /* YOU MUST FILL IN THIS FOR COOKIE AUTH! */

foreach ($myCfg['servers'] as $sKey => $server) {
    $sKey++;
    $cfg['Servers'][$sKey]['verbose'] = $server['name'] ?? $server['host'];
    $cfg['Servers'][$sKey]['host'] = $server['host'];
    $cfg['Servers'][$sKey]['auth_type'] = 'cookie';
    $cfg['Servers'][$sKey]['compress'] = false;
    $cfg['Servers'][$sKey]['AllowNoPassword'] = false;
     if ($_SERVER["REMOTE_ADDR"] == '127.0.0.1') {
         $cfg['Servers'][$sKey]['auth_type'] = 'config';
         $cfg['Servers'][$sKey]['user'] = $server['user']; 
         $cfg['Servers'][$sKey]['password'] = $server['pass'];
     }
}
/**
 * End of servers configuration
 */

/**
 * Directories for saving/loading files from server
 */
$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';

$cfg['TempDir'] = '/tmp/phpmyadmin';

// vim: ft=php sw=4 sts=4
