resource "yandex_container_registry" "day-2" {
  name      = "day-2"
  folder_id = data.yandex_resourcemanager_folder.current.id
}
