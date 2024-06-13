variable "zone" {
  description = "Зона для размещения ресурсов, например 'ru-central1-a'"
  type        = string
  default     = "ru-central1-a"
}

variable "yc_folder_name" {
  description = "Название папки в Yandex Cloud"
  type        = string
}