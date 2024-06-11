variable "yc_folder_id" {
  description = "Идентификатор папки в Yandex Cloud"
  type        = string
}

variable "zone" {
  description = "Зона для размещения ресурсов, например 'ru-central1-a'"
  type        = string
  default     = "ru-central1-a"
}

