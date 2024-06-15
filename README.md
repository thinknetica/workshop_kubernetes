
# Репозиторий для воркшопа "Kubernetes для Rails-разработчиков"


## Предварительные требования

- Учетная запись в Yandex Cloud.
- Установленный Terraform (версия 0.12 или выше).
- Инициализированный `yc` CLI (Yandex Cloud CLI).

Убедитесь что все утилиты работают корректно:
```bash
☁ yc --version
☁ terraform --version
☁ kubectl version --client
☁ docker --version
☁ docker run hello-world
```

## День 3

### Поднятие инфраструктуры

```bash
☁ cd infra/envs/demo
```
Следуем инструкциям в [README.md](infra/envs/day-2/README.md), кроме шага про удаление инфраструктуры.

После сборки переходим обратно в корневой каталог репозитория.


