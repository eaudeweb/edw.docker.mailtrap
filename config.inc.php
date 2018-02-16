<?php
$config = array();
$config['db_dsnw'] = 'sqlite:////var/www/db/sqlite.db';
$config['default_host'] = 'localhost';
$config['smtp_server'] = 'localhost';
$config['smtp_port'] = 25;
$config['smtp_user'] = '';
$config['smtp_pass'] = '';
$config['support_url'] = '';
$config['product_name'] = 'Roundcube MailTrap';
$config['des_key'] = '###DES_KEY###';
$config['plugins'] = array(
    'archive',
    'zipdownload',
);
$config['skin'] = 'larry';
$config['disabled_actions'] = array('addressbook.index','mail.compose','mail.reply','mail.reply-all','mail.forward');

// store draft message is this mailbox
// leave blank if draft messages should not be stored
// NOTE: Use folder names with namespace prefix (INBOX. on Courier-IMAP)
$config['drafts_mbox'] = '';
// store spam messages in this mailbox
// NOTE: Use folder names with namespace prefix (INBOX. on Courier-IMAP)
$config['junk_mbox'] = '';
// store sent message is this mailbox
// leave blank if sent messages should not be stored
// NOTE: Use folder names with namespace prefix (INBOX. on Courier-IMAP)
$config['sent_mbox'] = '';
// move messages to this folder when deleting them
// leave blank if they should be deleted directly
// NOTE: Use folder names with namespace prefix (INBOX. on Courier-IMAP)
$config['trash_mbox'] = '';

// protect the default folders from renames, deletes, and subscription changes
$config['protect_default_folders'] = true;
