output "service_account_name" {
  description = "ID сервисного аккаунта"
  value       = yandex_iam_service_account.k8s-demo-sa.name
}

output "service_account_id" {
  description = "ID сервисного аккаунта"
  value       = yandex_iam_service_account.k8s-demo-sa.id
}

output "kubernetes_cluster_name" {
  description = "ID созданного Kubernetes кластера"
  value       = yandex_kubernetes_cluster.k8s-demo-cluster.name
}

output "kubernetes_cluster_id" {
  description = "ID созданного Kubernetes кластера"
  value       = yandex_kubernetes_cluster.k8s-demo-cluster.id
}

output "container_registry_name" {
  description = "ID контейнерного реестра"
  value       = yandex_container_registry.day-2.name
}

output "container_registry_id" {
  description = "ID контейнерного реестра"
  value       = yandex_container_registry.day-2.id
}

output "folder_name" {
  description = "Имя текущей папки в Yandex Cloud"
  value       = data.yandex_resourcemanager_folder.current.name
}

output "folder_id" {
  description = "ID текущей папки в Yandex Cloud"
  value       = data.yandex_resourcemanager_folder.current.id
}

output "node_group_characteristics" {
  description = "Characteristics of the VMs in the Kubernetes node group"
  value = {
    node_group_name    = yandex_kubernetes_node_group.demo-node-group.name
    version            = yandex_kubernetes_node_group.demo-node-group.version
    size               = yandex_kubernetes_node_group.demo-node-group.scale_policy[0].fixed_scale[0].size
    platform_id        = yandex_kubernetes_node_group.demo-node-group.instance_template[0].platform_id
    subnet_ids         = yandex_kubernetes_node_group.demo-node-group.instance_template[0].network_interface[0].subnet_ids
    security_group_ids = yandex_kubernetes_node_group.demo-node-group.instance_template[0].network_interface[0].security_group_ids
    memory = yandex_kubernetes_node_group.demo-node-group.instance_template[0].resources[0].memory
    cores = yandex_kubernetes_node_group.demo-node-group.instance_template[0].resources[0].cores
  }
}