
# Репозиторий для воркшопа "Kubernetes для Rails-разработчиков"


## Предварительные требования

- Учетная запись в Yandex Cloud.
- Установленный Terraform (версия 0.12 или выше).
- Инициализированный `yc` CLI (Yandex Cloud CLI).

Убедитесь что все утилиты работают корректно:
```bash
☁️ yc --version
☁️ terraform --version
☁️ kubectl version --client
☁️ docker --version
☁️ docker run hello-world
```

## День 1
Следуйте инструкциям в файлах:
- [docs/step_1.md](docs/step_1.md) - Разворачивание окружения в Yandex Cloud
- [docs/step_2.md](docs/step_2.md) - Сборка и деплой приложения
- [docs/step_3.md](docs/step_3.md) - Удаление инфраструктуры