sudo ip link set dev eth1 mtu 1400

cd /home/upm/practica/rdsv-final

sudo vnx -f vnx/nfv3_home_lxc_ubuntu64.xml -t

sudo vnx -f vnx/nfv3_server_lxc_ubuntu64.xml -t

cd ..
