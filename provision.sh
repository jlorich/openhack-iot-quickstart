# Pave down the infrastrcture
terraform apply --auto-approve;

# Get Infrastructure details
FACTORYMONITOR_IP=`terraform output factorymonitor_ip`;
USERNAME=`terraform output username`;
PASSWORD=`terraform output password`;
IOTHUB_HOSTNAME=`terraform output iothub_hostname`;
IOTHUB_NAME=`terraform output iothub_name`;
DPS_NAME=`terraform output dps_name`;
RG_NAME=`terraform output resource_group_name`;

# Allow SSH to VM
ssh-keygen -R $FACTORYMONITOR_IP
ssh-keyscan $FACTORYMONITOR_IP >> ~/.ssh/known_hosts

# Configure the device VM
ansible-playbook -i $FACTORYMONITOR_IP, -e "ansible_user=$USERNAME ansible_ssh_pass=$PASSWORD ansible_become_pass=$PASSWORD iothub_hostname='$IOTHUB_HOSTNAME' iothub_name='$IOTHUB_NAME'" playbook.yml

# Create an enrollment group for DPS
#  -- note, this will NOT enabl3e edge devices.  That is not currently part of the CLI.  Edge must be turned on in the portal.
az iot dps enrollment-group create -g $RG_NAME --dps-name $DPS_NAME --enrollment-id openhack_devices
