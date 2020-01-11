# IoT OpenHack Quickstart (Challenges 1 and 2)

This repo provies scripts to pave down everything needed for challenges 1 and 2.  

### Prerequisites
- `Azure CLI`
- `Azure CLI IoT Extension`
- `terraform`
- `ansible`
- `jq`

### Instructions

If you are signed into the Azure CLI and have all necessary prerequisites installed in a Linux environment, running `./provision.sh` will do the following:

 - Create a resource group
 - Create an IoT Hub
 - Create a device in IoT Hub
 - Create a VM that runs the device streaming proxy device application which is connected the IoT Hub as the created device
 - Create a Device Provisioning Service
 - Create an Enrollment Group in DPS with symmetric key support
 
 *Note: Please be sure to customize the name paramater in variables.sh to something unique so there will not be conflicts with others running the same script*