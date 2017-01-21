# docker-cordova

Контейнер для сборки андроид приложения


Собираем образ:

```sell
docker build --tag android-23 .
```

в итоге он чуть меньще 3Гб

Дальше можно делать что-то такое:

```shell
docker run -ti --rm -v /path/to/project:/opt/project --workdir /opt/project android-23 cordova <cmd>
```
