terraform apply --auto-approve;

FACTORYMONITOR_IP=`terraform output factorymonitor_ip`;
USERNAME=`terraform output username`;
PASSWORD=`terraform output password`;
IOTHUB_HOSTNAME=`terraform output iothub_hostname`;
IOTHUB_NAME=`terraform output iothub_name`;

ssh-keygen -R $FACTORYMONITOR_IP
ssh-keyscan $FACTORYMONITOR_IP >> ~/.ssh/known_hosts

ansible-playbook -i $FACTORYMONITOR_IP, -e "ansible_user=$USERNAME ansible_ssh_pass=$PASSWORD ansible_become_pass=$PASSWORD iothub_hostname='$IOTHUB_HOSTNAME' iothub_name='$IOTHUB_NAME'" playbook.yml