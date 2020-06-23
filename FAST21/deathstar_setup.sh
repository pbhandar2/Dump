sudo apt-get update 

## Docker setup ##
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
    
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   
sudo apt-get update 
sudo apt-get install docker-ce docker-ce-cli containerd.io

## Docker Compose setup ##
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

## libssl-dev, libz-dev, luarocks, luasocket setup ##
sudo apt-get install libssl-dev
sudo apt-get install libz-dev
sudo apt-get install luarocks
sudo luarocks install luasocket
