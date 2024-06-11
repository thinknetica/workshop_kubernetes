### Проверим сборку нашего образа

```bash
☁ cd app
☁ bin/build_image 0.0.1
```
Запустим докер контейнер и убедимся что все работает

```bash
☁ docker run -d --name ruby_worker $IMAGE ruby worker.rb
☁ docker run -d --name ruby_rackup -p 3000:3000 $IMAGE bundle exec rackup --host 0.0.0.0 --port 3000
```

Запушим наш образ в yandex registry

```bash
☁ IMAGE=cr.yandex/crp7r0r719t2qkhkume1/hello-ruby:0.0.1
☁ bin/push_image $IMAGE
```

Запустим поды через kubectl run

```bash
☁ kubectl run demo-ruby-app --image=$IMAGE --expose --port=3000 --env="RACK_ENV=production" --command -- bundle exec rackup --host 0.0.0.0 --port 3000
☁ kubectl run demo-ruby-worker --image=$IMAGE --command -- ruby worker.rb
```

Проверим что все успешно запустилось
```bash
☁ kubectl get pods
☁ kubectl logs demo-ruby-app
☁ kubectl logs demo-ruby-worker
```
Зафорвардим порт с нашего пода чтобы посмотреть что приложение работает

```bash
☁ kubectl port-forward pod/demo-ruby-app 3000:3000
```
Откроем браузер на localhost:3000

Удалим наши поды

```bash
☁ kubectl delete pod demo-ruby-app
☁ kubectl delete pod demo-ruby-worker
```

### Деплой через деплойменты вместо подов
В файлах
- k8s/deployment-app.yaml
- k8s/deployment-worker.yaml
В секции `image:` вставим свое название образа cr.yandex/crppn3qqjifklea565bo/hello-ruby:0.0.1
Применим все через kubectl
```bash
☁ kubectl apply -f k8s/deployment-app.yaml
☁ kubectl apply -f k8s/deployment-worker.yaml
☁ kubectl apply -f k8s/app-service.yaml
```

Посмотрим логи через 
```bash
☁ kubectl get pods
☁ kubectl get logs <pod-name>
```

Зафорвардим порт с нашего сервиса чтобы посмотреть что приложение работает

```bash
☁ kubectl port-forward service/demo-ruby-app 3000:3000
```

### Использование envsubst чтобы не прописывать вручную IMAGE в файлах yaml
В файлах 
- k8s/deployment-app.yaml
- k8s/deployment-worker.yaml
Поменяем название образа c
cr.yandex/crppn3qqjifklea565bo/hello-ruby:0.0.2 на ${IMAGE_NAME}
```bash
☁ export IMAGE_NAME=cr.yandex/crppn3qqjifklea565bo/hello-ruby:0.0.1
# проверяем выводы
☁ envsubst < k8s/deployment-app.yaml
```
Если все значения подставляются, передадим вывод для kubectl

```bash
☁ envsubst < k8s/deployment-app.yaml | kubectl apply -f -
☁ envsubst < k8s/deployment-worker.yaml | kubectl apply -f -
```

Удалим наши деплойменты
```bash
☁ envsubst < k8s/deployment-app.yaml | kubectl delete -f -
☁ envsubst < k8s/deployment-worker.yaml | kubectl delete -f -
```