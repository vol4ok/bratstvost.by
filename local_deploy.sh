grunt rebuild
cd dist

sudo cp * /var/www/bratstvost.by -Rf

# First time commands:
#sudo cp ../node_modules /var/www/bratstvost.by -R
#cd /var/www/bratstvost.by;NODE_ENV=production pm2 start web.js -n bratstvost.by

pm2 restart bratstvost.by
cd ..
