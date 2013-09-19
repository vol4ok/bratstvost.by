grunt dist
cd dist
git add .
git ci -a -m "up "`date +"%d.%m.%Y-%H:%M:%S"`
git push
ssh root@vol4ok.com << 'ENDSSH'
cd /var/www/bratstvost
git pull
forever restartall
ENDSSH%
cd ..