ui_page 'html/index.html'

client_scripts {
	'utils.lua',
	'client/main.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
	'utils.lua',
	'server/main.lua'
}

files {
	'html/index.html',
	'html/assets/images/blindfold.png',
	'html/assets/css/style.css',
	'html/assets/js/jquery.js',
	'html/assets/js/init.js',
}