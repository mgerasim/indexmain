
cp /home/rails/projects/indexmain/indexmain.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable indexmain.service
systemctl restart indexmain.service