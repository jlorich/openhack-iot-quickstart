# install jq for json parsing
apt install jq -y

# Create and publish the simulator executable
mkdir -p /usr/bin/dlpsvc;
git clone https://github.com/Azure-Samples/azure-iot-samples-csharp.git ~/devicestreams;
sed -i 's/netcoreapp2.0/netcoreapp3.1/g' ~/devicestreams/iot-hub/Quickstarts/device-streams-proxy/device/DeviceLocalProxyStreamingSample.csproj 
dotnet publish ~/devicestreams/iot-hub/Quickstarts/device-streams-proxy/device/DeviceLocalProxyStreamingSample.csproj --configuration Release --output /usr/bin/dlpsvc;


# Sign in to the azure cli and register a new device
az login --identity;
DEVICE_ID=$(uuidgen)
az iot hub device-identity create -n $IOTHUB_NAME -d $DEVICE_ID
DEVICE_KEY=$(az iot hub device-identity show -n $IOTHUB_NAME -d $DEVICE_ID | jq -r '.authentication.symmetricKey.primaryKey')


# Configure the device simulator to run as a service
echo $'[Unit]\nDescription=Device Local Proxy Service\nAfter=network.target\n[Service]\nExecStart=/usr/bin/dotnet /usr/bin/dlpsvc/DeviceLocalProxyStreamingSample.dll "'"HostName=${IOTHUB_HOSTNAME};DeviceId=$DEVICE_ID;SharedAccessKey=$DEVICE_KEY;"'" localhost 22\nRestart=always\n[Install]\nWantedBy=multi-user.target' > /lib/systemd/system/dlpsvc.service;
systemctl daemon-reload;
systemctl enable dlpsvc;
systemctl start dlpsvc;