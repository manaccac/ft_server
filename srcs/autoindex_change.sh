touch etc/nginx/sites-available/temp
cp etc/nginx/sites-available/default etc/nginx/sites-available/temp
cp etc/nginx/sites-available/default_other etc/nginx/sites-available/default
cp etc/nginx/sites-available/temp etc/nginx/sites-available/default_other
rm etc/nginx/sites-available/temp
service nginx restart
