
variable subscription_id {}
variable tenant_id {}
variable client_id {}
variable client_secret {}

# Configure the Microsoft Azure Provider
provider "azurerm" {
    subscription_id = "4e07c97e-fda4-4cf1-89a4-6fd1e7e5faf6"
    client_id       = "d555bf26-1db7-4c4f-bb4c-f76acd23a29f"
    client_secret   = "eec507c7-17db-41aa-82e3-93987e525826"
    tenant_id       = "46f9fc40-f452-48e0-9661-ca193655481f"
}

module mycompute {
    source = "Azure/compute/azurerm"
    resource_group_name = "myResourceGroup"
    location = "West Europe"
    admin_password = "ComplxP@assw0rd!"
    vm_os_simple = "WindowsServer"
    remote_port = "3389"
    nb_instances = 2
    public_ip_dns = ["unique_dns_name"]
    vnet_subnet_id = "${module.network.vnet_subnets[0]}"
}

module "network" {
    source = "Azure/network/azurerm"
    location = "West Europe"
    resource_group_name = "myResourceGroup"
}

output "vm_public_name" {
    value = "${module.mycompute.public_ip_dns_name}"
}

output "vm_public_ip" {
    value = "${module.mycompute.public_ip_address}"
}

output "vm_private_ips" {
    value = "${module.mycompute.network_interface_private_ip}"
}