# Удаление инфраструктуры

Перейдем в папку `infra/envs/demo` и переключимся на профиль с которым разворачивали терраформ
```bash
☁ cd infra/envs/demo
yc config profiles activate sa-demo-terraform
```

Удалим всю инфраструктуру
```bash
☁ export YC_TOKEN=$(yc iam create-token)
☁ export YC_CLOUD_ID=$(yc config get cloud-id)
☁ export YC_FOLDER_ID=$(yc config get folder-id)
☁ terraform destroy
```

Удалим созданный Container Registry

```bash
☁ yc config profile activate default
☁ CR_NAME=yc-demo-cr
☁ yc container registry delete $CR_NAME
```

Так же Container Registry можно удалить через UI в https://console.yandex.cloud/