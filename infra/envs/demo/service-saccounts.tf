resource "yandex_iam_service_account" "k8s-demo-sa" {
  name        = "k8s-demo-sa"
  description = "service account to manage k8s"
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  # Сервисному аккаунту назначается роль "editor".
  folder_id = data.yandex_resourcemanager_folder.current.id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.k8s-demo-sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
  # Сервисному аккаунту назначается роль "container-registry.images.puller".
  folder_id = data.yandex_resourcemanager_folder.current.id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.k8s-demo-sa.id}"
}