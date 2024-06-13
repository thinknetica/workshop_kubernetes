
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

## День 2

### Поднятие инфраструктуры

```bash
☁ cd infra/envs/day-2
```
Следуем инструкциям в [README.md](infra/envs/day-2/README.md), кроме шага про удаление инфраструктуры.

После сборки переходим обратно в корневой каталог репозитория.

### Сборка образа
```bash
☁ bin/build_image 0.0.1
export IMAGE=cr.yandex/crpihjptomdo51spscdp/hello-rails:0.0.1
bin/push_image $IMAGE
```

# Разворачиваение деплоймента

Ознакомимся c файлами манифестов

```bash
./k8s
├── config-rails-app.yaml - Файл с ConfigMap
├── deployment-rails-app.yaml - Файл c Deployment
├── job-rails-app-migrate.yaml - Файл с Job для миграций
├── secret-rails-app.yaml - Файл с Secret
└── service-rails-app.yaml - Файл с Service
```

Убедимся что IMAGE доступен как env переменная
```bash
☁ echo $IMAGE
cr.yandex/crpihjptomdo51spscdp/hello-rails:0.0.1
```

Выполним по шагам применение манифестов
```bash
☁ kubectl apply -f k8s/config-rails-app.yaml
☁ kubectl apply -f k8s/secret-rails-app.yaml
☁ envsubst < k8s/job-rails-app-migrate.yaml | kubectl apply -f -
☁ kubectl wait --for=condition=complete --timeout=600s job/job-rails-app-migrate
☁ envsubst < k8s/job-rails-app-migrate.yaml | kubectl delete -f -
☁ envsubst < k8s/deployment-rails-app.yaml | kubectl apply -f -
☁ kubectl apply -f k8s/service-rails-app.yaml
```

Проверим что приложение работает используя команды
```bash
☁ kubectl get deployments
☁ kubectl logs service/rails-app-service
☁ kubectl get pods
☁ kubectl logs <pod-name>
```

Зайдем в контейнер с нашим приложением и убедимся что наши ENV переменные пристутствуют
```bash
☁ kubectl get pods
☁ kubectl exec -it <pod-name> -- bash
☁ echo $RAILS_ENV
☁ echo $SECRET_KEY_BASE
☁ echo $FOO_KEY
```

Проверим работу приложения пробросив порт с сервиса на localhost

```bash
☁ kubectl port-forward service/rails-app-service 3000:3000
```

Откроем браузер по ссылке http://localhost:3000

# Удаление инфраструктуры
Переходим обратно в папку infra/envs/day-2
Выполняем шаги "Удаление инфраструктуры" из [README.md](infra/envs/day-2/README.md)

### Ссылки на ресурсы использованные в проекте

- https://kubernetes.io/docs/concepts/configuration/configmap/
- https://kubernetes.io/docs/concepts/workloads/controllers/deployment/
- https://kubernetes.io/docs/concepts/workloads/controllers/job/
- https://kubernetes.io/docs/concepts/configuration/secret/
- https://kubernetes.io/docs/concepts/services-networking/service/

