terraform {
    required_providers {
        yandex = {
        source = "yandex-cloud/yandex"
        }
    }
    required_version = ">= 0.13"
}

provider "yandex" {
    token     = var.yandexT 
    folder_id = var.yandexIDF
    zone      = var.YaZone
}

resource "yandex_vpc_network" "default" {
    name = "swarm-network"
}

resource "yandex_vpc_subnet" "default" {
    name           = "swarm-subnet"
    zone           = var.YaZone
    network_id     = yandex_vpc_network.default.id
    v4_cidr_blocks = ["10.0.0.0/24"]
}

resource "yandex_compute_instance" "swarm" {
    count = 3
    name  = "swarm-node-${count.index + 1}"

    resources {
        cores  = 2
        memory = 4
    }

    boot_disk {
        initialize_params {
            image_id = var.IMG # Debian
            size     = 20
        }
    }

    network_interface {
        subnet_id = yandex_vpc_subnet.default.id
        nat       = true
    }
  
    metadata = {
        user-data = "${file("/root/docker-swarm+terr/cloud-conf.yaml")}"
    }   
}    

output "node_ips" {
  value = yandex_compute_instance.swarm[*].network_interface.0.nat_ip_address
}