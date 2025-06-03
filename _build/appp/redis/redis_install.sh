##########

silent() { "$@" >/dev/null 2>&1; }

echo "Installing Dependencies"
silent apt-get update -y
silent apt-get install -y curl sudo mc apt-transport-https gpg lsb-release
echo "Installed Dependencies"

echo "Installing Redis"
wget -qO- https://packages.redis.io/gpg | gpg --dearmor >/usr/share/keyrings/redis-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" >/etc/apt/sources.list.d/redis.list
silent apt-get update
silent apt-get install -y redis
sed -i 's/^bind .*/bind 0.0.0.0/' /etc/redis/redis.conf
systemctl enable -q --now redis-server.service
echo "Installed Redis"

echo "Cleaning up"
silent apt-get -y autoremove
silent apt-get -y autoclean
echo "Cleaned"

##########