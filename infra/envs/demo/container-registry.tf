resource "yandex_container_registry" "demo" {
  name      = "demo"
  folder_id = data.yandex_resourcemanager_folder.current.id
}
