wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb;
sudo dpkg -i packages-microsoft-prod.deb;
sudo add-apt-repository universe;
sudo apt-get update;
sudo apt-get install apt-transport-https -y;
sudo dpkg --purge packages-microsoft-prod && sudo dpkg -i packages-microsoft-prod.deb;
sudo apt-get update;
sudo apt-get install dotnet-sdk-3.1 -y;