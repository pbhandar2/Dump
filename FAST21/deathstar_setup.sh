apt-get update 

## Docker setup ##
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
    
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   
apt-get update 
apt-get install -y docker-ce docker-ce-cli containerd.io

## Docker Compose setup ##
curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

## libssl-dev, libz-dev, luarocks, luasocket setup ##
apt-get install libssl-dev
apt-get install libz-dev -y
apt-get install luarocks -y
luarocks install luasocket 

## 'make' might not be installed, although not in the repo guideline ##
apt install make 
