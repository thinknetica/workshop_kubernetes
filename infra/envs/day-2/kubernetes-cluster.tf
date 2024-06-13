resource "yandex_kubernetes_cluster" "k8s-demo-cluster" {
  name               = "k8s-demo-cluster"
  cluster_ipv4_range = "10.100.0.0/16"
  service_ipv4_range = "10.102.0.0/16"
  network_id         = yandex_vpc_network.demo-net.id

  service_account_id      = yandex_iam_service_account.k8s-demo-sa.id
  node_service_account_id = yandex_iam_service_account.k8s-demo-sa.id
  depends_on = [
    yandex_resourcemanager_folder_iam_member.editor,
    yandex_resourcemanager_folder_iam_member.images-puller
  ]
  master {
    version = "1.26"
    master_location {
      zone      = yandex_vpc_subnet.demo-subnet-a.zone
      subnet_id = yandex_vpc_subnet.demo-subnet-a.id
    }

    public_ip = true

    security_group_ids = [
      yandex_vpc_security_group.k8s-main-sg.id,
      yandex_vpc_security_group.k8s-master-whitelist.id
    ]

    master_logging {
      enabled      = true
      log_group_id = yandex_logging_group.group-demo.id

      kube_apiserver_enabled     = true
      cluster_autoscaler_enabled = true
      events_enabled             = true
      audit_enabled              = true
    }

  }

}

resource "yandex_logging_group" "group-demo" {
  name = "test-logging-group"
}

resource "yandex_kubernetes_node_group" "demo-node-group" {
  cluster_id = yandex_kubernetes_cluster.k8s-demo-cluster.id
  name       = "demo-node-group"
  version    = "1.26"

  scale_policy {
    fixed_scale {
      size = 1
    }
  }
  instance_template {
    platform_id = "standard-v3"
    network_interface {
      nat        = true
      subnet_ids = ["${yandex_vpc_subnet.demo-subnet-a.id}"]
      security_group_ids = [
        yandex_vpc_security_group.k8s-main-sg.id,
        yandex_vpc_security_group.k8s-nodes-ssh-access.id,
        yandex_vpc_security_group.k8s-public-services.id
      ]
    }
  }
}


resource "yandex_vpc_network" "demo-net" {
  name = "demo-network"
}

resource "yandex_vpc_subnet" "demo-subnet-a" {
  name           = "demo-subnetwork"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.demo-net.id
  v4_cidr_blocks = ["10.2.0.0/16"]
}