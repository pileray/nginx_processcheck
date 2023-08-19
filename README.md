# nginx_processcheck
## 要件
- centos7にてNginxの動作監視
- 停止時は再起動
- cronで5分に1回実行させる

## テスト証跡
### Nginx起動時
```
[vagrant@localhost script]$ systemctl status nginx
● nginx.service - nginx - high performance web server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; vendor preset: disabled)
   Active: active (running) since 水 2022-02-23 12:31:30 UTC; 3min 26s ago
     Docs: http://nginx.org/en/docs/
  Process: 12484 ExecStop=/bin/sh -c /bin/kill -s TERM $(/bin/cat /var/run/nginx.pid) (code=exited, status=0/SUCCESS)
  Process: 12572 ExecStart=/usr/sbin/nginx -c /etc/nginx/nginx.conf (code=exited, status=0/SUCCESS)
 Main PID: 12573 (nginx)
   CGroup: /system.slice/nginx.service
           ├─12573 nginx: master process /usr/sbin/nginx -c /etc/nginx/nginx.conf
           └─12574 nginx: worker process
[vagrant@localhost script]$ sudo sh ./process_check.sh
nginx process 2
nginx is not running.
nginx is running.
```

### Nginx停止時
```
[vagrant@localhost script]$ systemctl status nginx
● nginx.service - nginx - high performance web server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; vendor preset: disabled)
   Active: inactive (dead) since 水 2022-02-23 12:36:02 UTC; 5s ago
     Docs: http://nginx.org/en/docs/
  Process: 12845 ExecStop=/bin/sh -c /bin/kill -s TERM $(/bin/cat /var/run/nginx.pid) (code=exited, status=0/SUCCESS)
  Process: 12572 ExecStart=/usr/sbin/nginx -c /etc/nginx/nginx.conf (code=exited, status=0/SUCCESS)
 Main PID: 12573 (code=exited, status=0/SUCCESS)
[vagrant@localhost script]$ sudo sh ./process_check.sh
nginx process 0
nginx is not running.
nginx is running.
```

### cron実行ログ
```
[root@localhost script]# cat /var/log/cron | grep process_check.sh
Feb 23 07:53:01 localhost CROND[7258]: (root) CMD (sudo /home/vagrant/local-directory/script/process_check.sh)
Feb 23 07:54:01 localhost CROND[7319]: (root) CMD (sudo /home/vagrant/local-directory/script/process_check.sh)
Feb 23 07:55:01 localhost CROND[7375]: (root) CMD (sudo /home/vagrant/local-directory/script/process_check.sh)
Feb 23 07:56:01 localhost CROND[7429]: (root) CMD (sudo /home/vagrant/local-directory/script/process_check.sh)
Feb 23 07:57:01 localhost CROND[7503]: (root) CMD (sudo /home/vagrant/local-directory/script/process_check.sh)
Feb 23 07:58:01 localhost CROND[7561]: (root) CMD (sudo /home/vagrant/local-directory/script/process_check.sh)
Feb 23 07:59:01 localhost CROND[7616]: (root) CMD (sudo /home/vagrant/local-directory/script/process_check.sh)
Feb 23 08:00:01 localhost CROND[7672]: (root) CMD (sudo /home/vagrant/local-directory/script/process_check.sh)
Feb 23 08:01:01 localhost CROND[7731]: (root) CMD (sudo /home/vagrant/local-directory/script/process_check.sh)
Feb 23 08:02:01 localhost CROND[7797]: (root) CMD (sudo /home/vagrant/local-directory/script/process_check.sh)
Feb 23 08:03:01 localhost CROND[7853]: (root) CMD (sudo /home/vagrant/local-directory/script/process_check.sh)
Feb 23 08:04:01 localhost CROND[7908]: (root) CMD (sudo /home/vagrant/local-directory/script/process_check.sh)
Feb 23 08:05:01 localhost CROND[7990]: (root) CMD (sudo /home/vagrant/local-directory/script/process_check.sh)
Feb 23 08:06:01 localhost CROND[8045]: (root) CMD (sudo /home/vagrant/local-directory/script/process_check.sh)
Feb 23 08:07:01 localhost CROND[8100]: (root) CMD (sudo /home/vagrant/local-directory/script/process_check.sh)
Feb 23 08:08:01 localhost CROND[8160]: (root) CMD (sudo /home/vagrant/local-directory/script/process_check.sh)
Feb 23 08:09:01 localhost CROND[8239]: (root) CMD (sudo /home/vagrant/local-directory/script/process_check.sh)
Feb 23 08:10:01 localhost CROND[8334]: (root) CMD (sudo sh /home/vagrant/local-directory/script/process_check.sh)
Feb 23 08:11:01 localhost CROND[8419]: (root) CMD (sudo sh /home/vagrant/local-directory/script/process_check.sh)
Feb 23 12:40:01 localhost CROND[13084]: (root) CMD (sudo sh /home/vagrant/local-directory/script/process_check.sh)
Feb 23 12:45:01 localhost CROND[13364]: (root) CMD (sudo sh /home/vagrant/local-directory/script/process_check.sh)
```

## 参考
https://qiita.com/zayarwinttun/items/0dae4cb66d8f4bd2a337
Vagrant環境構築(mac)
https://wiki.adachin.me/archives/360
