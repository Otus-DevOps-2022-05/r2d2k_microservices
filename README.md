# Домашние задания по микросервисам

Оглавление:
<!-- MarkdownTOC autolink=true -->

- [01 - Технология контейнеризации. Введение в Docker](#01---%D0%A2%D0%B5%D1%85%D0%BD%D0%BE%D0%BB%D0%BE%D0%B3%D0%B8%D1%8F-%D0%BA%D0%BE%D0%BD%D1%82%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D0%B8-%D0%92%D0%B2%D0%B5%D0%B4%D0%B5%D0%BD%D0%B8%D0%B5-%D0%B2-docker)
- [02 - Docker-образы. Микросервисы](#02---docker-%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%D1%8B-%D0%9C%D0%B8%D0%BA%D1%80%D0%BE%D1%81%D0%B5%D1%80%D0%B2%D0%B8%D1%81%D1%8B)
- [03 - Docker: сети, docker-compose](#03---docker-%D1%81%D0%B5%D1%82%D0%B8-docker-compose)
- [04 - Устройство Gitlab CI. Построение процесса непрерывной поставки](#04---%D0%A3%D1%81%D1%82%D1%80%D0%BE%D0%B9%D1%81%D1%82%D0%B2%D0%BE-gitlab-ci-%D0%9F%D0%BE%D1%81%D1%82%D1%80%D0%BE%D0%B5%D0%BD%D0%B8%D0%B5-%D0%BF%D1%80%D0%BE%D1%86%D0%B5%D1%81%D1%81%D0%B0-%D0%BD%D0%B5%D0%BF%D1%80%D0%B5%D1%80%D1%8B%D0%B2%D0%BD%D0%BE%D0%B9-%D0%BF%D0%BE%D1%81%D1%82%D0%B0%D0%B2%D0%BA%D0%B8)
- [05 - Введение в мониторинг. Системы мониторинга.](#05---%D0%92%D0%B2%D0%B5%D0%B4%D0%B5%D0%BD%D0%B8%D0%B5-%D0%B2-%D0%BC%D0%BE%D0%BD%D0%B8%D1%82%D0%BE%D1%80%D0%B8%D0%BD%D0%B3-%D0%A1%D0%B8%D1%81%D1%82%D0%B5%D0%BC%D1%8B-%D0%BC%D0%BE%D0%BD%D0%B8%D1%82%D0%BE%D1%80%D0%B8%D0%BD%D0%B3%D0%B0)
- [06 - Логирование и распределенная трассировка](#06---%D0%9B%D0%BE%D0%B3%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-%D0%B8-%D1%80%D0%B0%D1%81%D0%BF%D1%80%D0%B5%D0%B4%D0%B5%D0%BB%D0%B5%D0%BD%D0%BD%D0%B0%D1%8F-%D1%82%D1%80%D0%B0%D1%81%D1%81%D0%B8%D1%80%D0%BE%D0%B2%D0%BA%D0%B0)
- [07 - Введение в kubernetes](#07---%D0%92%D0%B2%D0%B5%D0%B4%D0%B5%D0%BD%D0%B8%D0%B5-%D0%B2-kubernetes)
- [08 - Kubernetes. Запуск кластера и приложения. Модель безопасности](#08---kubernetes-%D0%97%D0%B0%D0%BF%D1%83%D1%81%D0%BA-%D0%BA%D0%BB%D0%B0%D1%81%D1%82%D0%B5%D1%80%D0%B0-%D0%B8-%D0%BF%D1%80%D0%B8%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F-%D0%9C%D0%BE%D0%B4%D0%B5%D0%BB%D1%8C-%D0%B1%D0%B5%D0%B7%D0%BE%D0%BF%D0%B0%D1%81%D0%BD%D0%BE%D1%81%D1%82%D0%B8)
- [09 - Kubernetes. Networks, Storages](#09---kubernetes-networks-storages)
- [10 - CI/CD в Kubernetes](#10---cicd-%D0%B2-kubernetes)

<!-- /MarkdownTOC -->

---

## 01 - Технология контейнеризации. Введение в Docker

**Задание №01-1:**
 - Создать docker host
 - Создать свой образ
 - Изучить работу с Docker Hub

**Решение №01-1:**
Работаем в каталоге `docker-monolith`.
Устанавливаем Docker по [официальной](https://docs.docker.com/engine/install/ubuntu/) документации.
Проверяем версии установленного ПО:
```console
> docker version
Client: Docker Engine - Community
 Version:           20.10.17
 API version:       1.41
 Go version:        go1.17.11
 Git commit:        100c701
 Built:             Mon Jun  6 23:02:46 2022
 OS/Arch:           linux/amd64
 Context:           default
 Experimental:      true

Server: Docker Engine - Community
 Engine:
  Version:          20.10.17
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.17.11
  Git commit:       a89b842
  Built:            Mon Jun  6 23:00:51 2022
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.6.7
  GitCommit:        0197261a30bf81f1ee8e6a4dd2dea0ef95d67ccb
 runc:
  Version:          1.1.3
  GitCommit:        v1.1.3-0-g6724737
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0

> docker compose version
Docker Compose version v2.6.0
```

Проверяем работу окружения:
```console
> docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
2db29710123e: Pull complete
Digest: sha256:7d246653d0511db2a6b2e0436cfd0e52ac8c066000264b3ce63331ac66dca625
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

Образ был скачан, запущен в контейнере, вывел сообщение и завершил работу. Вот контейнер в выключенном состоянии:
```console
> docker ps -a
CONTAINER ID   IMAGE         COMMAND    CREATED         STATUS                     PORTS     NAMES
7209dc11e9c9   hello-world   "/hello"   6 seconds ago   Exited (0) 3 seconds ago             ecstatic_tu
```

Видим, что образ присутствует в локальной системе:
```console
> docker images
REPOSITORY    TAG       IMAGE ID       CREATED         SIZE
hello-world   latest    feb5d9fea6a5   13 months ago   13.3kB
```

При каждом запуске создаётся новый контейнер, это видно по имени хоста:
```console
> docker run -it ubuntu:18.04 /bin/bash
Unable to find image 'ubuntu:18.04' locally
18.04: Pulling from library/ubuntu
e706e0a9f423: Pull complete
Digest: sha256:40b84b75884ff39e4cac4bf62cb9678227b1fbf9dbe3f67ef2a6b073aa4bb529
Status: Downloaded newer image for ubuntu:18.04
root@e0c1b582acce:/# echo 'Hello world!' > /tmp/file
root@e0c1b582acce:/# exit

> docker run -it ubuntu:18.04 /bin/bash
root@4143404d8c92:/# cat /tmp/file
cat: /tmp/file: No such file or directory
root@4143404d8c92:/# exit
```

Запустим контейнер, в котором мы создали временный файл:
```console
> docker start e0c1b582acce
e0c1b582acce
```

Проверим, на месте ли файл:
```console
> docker attach e0c1b582acce
root@e0c1b582acce:/# cat /tmp/file
Hello world!
root@e0c1b582acce:/# exit
exit
```

При использовании ключа `-d` контейнер будет запущен в фоне:
```console
> docker run -dt nginx:latest
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
bd159e379b3b: Pull complete
6659684f075c: Pull complete
679576c0baac: Pull complete
22ca44aeb873: Pull complete
b45acafbea93: Pull complete
bcbbe1cb4836: Pull complete
Digest: sha256:5ffb682b98b0362b66754387e86b0cd31a5cb7123e49e7f6f6617690900d20b2
Status: Downloaded newer image for nginx:latest
f79a4795e75acae7ada6e8ce518ea6ca2da5634c1f5024e7e8b22b1df7ea597c

> docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS     NAMES
f79a4795e75a   nginx:latest   "/docker-entrypoint.…"   6 seconds ago   Up 4 seconds   80/tcp    heuristic_elgamal
```

Из запущенного контейнера, при необходимости, можно создать образ:
```console
> docker commit e0c1b582acce r2d2k/ubuntu-tmp-file
sha256:dba315d073020223be142943876a4681aab37280aed53e105d79869c6269ac37

> docker images
REPOSITORY              TAG       IMAGE ID       CREATED         SIZE
r2d2k/ubuntu-tmp-file   latest    dba315d07302   3 seconds ago   63.1MB
nginx                   latest    5d58c024174d   4 days ago      142MB
ubuntu                  18.04     71cb16d32be4   2 weeks ago     63.1MB
test_alpine             latest    fd8e1b7c15b7   2 months ago    5.54MB
alpine                  latest    9c6f07244728   2 months ago    5.54MB
ubuntu                  latest    df5de72bdb3b   2 months ago    77.8MB
hello-world             latest    feb5d9fea6a5   13 months ago   13.3kB
```

Остановка контейнера:
```console
> docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS     NAMES
f79a4795e75a   nginx:latest   "/docker-entrypoint.…"   40 minutes ago   Up 40 minutes   80/tcp    heuristic_elgamal

> docker stop f79a4795e75a
f79a4795e75a

> docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

Проверка использования докером пространства на диске:
```console
> docker system df
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          7         3         288.3MB   146.5MB (50%)
Containers      5         0         1.227kB   1.227kB (100%)
Local Volumes   0         0         0B        0B
Build Cache     0         0         0B        0B
```

Удалим все образы незапущенных контейнеров:
```console
> docker rm $(docker ps -a -q)
f79a4795e75a
ba3de6d4e888
4143404d8c92
e0c1b582acce
7209dc11e9c9

> docker system df
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          7         0         288.3MB   288.3MB (100%)
Containers      0         0         0B        0B
Local Volumes   0         0         0B        0B
Build Cache     0         0         0B        0B
```

Пришло время собрать собственный образ, для этого подготовим четыре файла:
 - Dockerfile - инструкции для сборки нашего образа
 - mongod.conf - подготовленный конфиг для mongodb
 - db_config - содержит переменную окружения со ссылкой на mongodb
 - start.sh - скрипт запуска приложения

Содержимое: `mongod.conf`:
```yaml
# Where and how to store data.
storage:
  dbPath: /var/lib/mongodb
  journal:
    enabled: true

# where to write logging data.
systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log

# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1
```

Содержимое: `start.sh`:
```bash
#!/bin/bash

/usr/bin/mongod --fork --logpath /var/log/mongod.log --config /etc/mongodb.conf

source /reddit/db_config

cd /reddit && puma || exit
```

Содержимое: `db_config`:
```ini
DATABASE_URL=127.0.0.1
```

Собирать образ будем на базе `Ubuntu 18.04`. Обновляем списки пакетов, устанавливаем всё необходимое для работы. Клонируем репозиторий с приложением.
Копируем конфигурационные файлы приложения и скрипт для его запуска. Устанавливаем необходимые пакеты `ruby` и запускаем приложение.

Содержимое: `Dockerfile`:
```Dockerfile
FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y mongodb-server ruby-full ruby-dev build-essential git
RUN gem install bundler
RUN git clone -b monolith https://github.com/express42/reddit.git

COPY mongod.conf /etc/mongod.conf
COPY db_config /reddit/db_config
COPY start.sh /start.sh

RUN cd /reddit && rm Gemfile.lock && bundle install
RUN chmod 0777 /start.sh

CMD ["/start.sh"]
```

После подготовки файла соберём образ:
```console
> docker build -t reddit:latest .

Sending build context to Docker daemon   21.5kB
Step 1/11 : FROM ubuntu:18.04
 ---> 71cb16d32be4
Step 2/11 : RUN apt-get update
 ---> Running in 8b3c8d475755
Get:1 http://archive.ubuntu.com/ubuntu bionic InRelease [242 kB]
...
...
...
Reading package lists...
Removing intermediate container 8b3c8d475755
 ---> 8bad6f048d49
Step 3/11 : RUN apt-get install -y mongodb-server ruby-full ruby-dev build-essential git
 ---> Running in a1ad589b7de0
Reading package lists...
Building dependency tree...
...
...
...
Running hooks in /etc/ca-certificates/update.d...
done.
Removing intermediate container a1ad589b7de0
 ---> 89e6a0741d60
Step 4/11 : RUN gem install bundler
 ---> Running in ab67503c8084
Successfully installed bundler-2.3.24
Parsing documentation for bundler-2.3.24
Installing ri documentation for bundler-2.3.24
Done installing documentation for bundler after 0 seconds
1 gem installed
Removing intermediate container ab67503c8084
 ---> 75364dae8491
Step 5/11 : RUN git clone -b monolith https://github.com/express42/reddit.git
 ---> Running in 495eeebba071
Cloning into 'reddit'...
Removing intermediate container 495eeebba071
 ---> 3ca3debf38c9
Step 6/11 : COPY mongod.conf /etc/mongod.conf
 ---> 0c986fd9970a
Step 7/11 : COPY db_config /reddit/db_config
 ---> 181a55e05130
Step 8/11 : COPY start.sh /start.sh
 ---> b26b3b10a35b
Step 9/11 : RUN cd /reddit && rm Gemfile.lock && bundle install
 ---> Running in 924c75a3aeae
Your RubyGems version (2.7.6) has a bug that prevents `required_ruby_version` from working for Bundler. Any scripts that use `gem install bundler` will break as soon as Bundler drops support for your Ruby version. Please upgrade RubyGems to avoid future breakage and silence this warning by running `gem update --system 3.2.3`
...
...
...
Bundle complete! 11 Gemfile dependencies, 28 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
Removing intermediate container 924c75a3aeae
 ---> a7d6da9b92cf
Step 10/11 : RUN chmod 0777 /start.sh
 ---> Running in 9fc7dd6d1119
Removing intermediate container 9fc7dd6d1119
 ---> f3d656badaeb
Step 11/11 : CMD ["/start.sh"]
 ---> Running in 29091bf59c0a
Removing intermediate container 29091bf59c0a
 ---> 4a45f764506c
Successfully built 4a45f764506c
Successfully tagged reddit:latest
```

Вот, что у нас получилось после сборки образа:
```console
> docker images
REPOSITORY   TAG       IMAGE ID       CREATED         SIZE
reddit       latest    4a45f764506c   6 minutes ago   668MB
ubuntu       18.04     71cb16d32be4   2 weeks ago     63.1MB

> docker images -a
REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
<none>       <none>    f3d656badaeb   6 minutes ago    668MB
reddit       latest    4a45f764506c   6 minutes ago    668MB
<none>       <none>    a7d6da9b92cf   6 minutes ago    668MB
<none>       <none>    b26b3b10a35b   7 minutes ago    626MB
<none>       <none>    181a55e05130   7 minutes ago    626MB
<none>       <none>    0c986fd9970a   7 minutes ago    626MB
<none>       <none>    3ca3debf38c9   7 minutes ago    626MB
<none>       <none>    75364dae8491   7 minutes ago    626MB
<none>       <none>    89e6a0741d60   7 minutes ago    624MB
<none>       <none>    8bad6f048d49   10 minutes ago   106MB
ubuntu       18.04     71cb16d32be4   2 weeks ago      63.1MB
```

Запустим контейнер с нашим образом и проверим статус:
```console
> docker run --name reddit -d --network=host reddit:latest
082020743e90c4038b58d9a7a20bc287c3f0796aea183b2e9b036f66af70553d

> docker ps
CONTAINER ID   IMAGE           COMMAND       CREATED         STATUS         PORTS     NAMES
082020743e90   reddit:latest   "/start.sh"   9 seconds ago   Up 8 seconds
```

Проверим, что порт прослушивается:
```console
> sudo ss -nlp sport 9292
Netid  State   Recv-Q  Send-Q   Local Address:Port   Peer Address:Port  Process
tcp    LISTEN  0       1024           0.0.0.0:9292        0.0.0.0:*      users:(("ruby2.5",pid=50812,fd=8))
```

Убедимся, что наше приложение в контейнере корректно отвечает на запросы из внешнего мира:
```console
> lynx -dump http://127.0.0.1:9292

   (BUTTON) [1]Monolith Reddit
     * [2]Sign up
     * [3]Login

Menu

     * [4]All posts
     * [5]New post

References

   1. http://127.0.0.1:9292/
   2. http://127.0.0.1:9292/signup
   3. http://127.0.0.1:9292/login
   4. http://127.0.0.1:9292/
   5. http://127.0.0.1:9292/new
```

Загрузим наш образ на hub.docker.com:
```console
> docker login
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: r2d2k
Password:

Login Succeeded

> docker tag reddit:latest r2d2k/otus-reddit:1.0

> docker push r2d2k/otus-reddit:1.0
The push refers to repository [docker.io/r2d2k/otus-reddit]
587e3001e1e1: Pushed
b99c80d72085: Pushed
55f4cad4000c: Pushed
0882c02ecaec: Pushed
85d6da4ee5fe: Pushed
9293ad396c99: Pushed
bdf1ab466a1b: Pushed
bd6347d5f95e: Pushed
4fd68b6da872: Pushed
b9b23e654574: Mounted from library/ubuntu
1.0: digest: sha256:e5022562c09c608db4c507582546b3ac28d81ad81327dcbcd8bd18ceab25089b size: 2413
```

Попробуем запустить контейнер с образом из hub.docker.com. Для начала зачистим систему от старых контейненеров и образов:
```console
> docker ps
CONTAINER ID   IMAGE           COMMAND       CREATED          STATUS          PORTS     NAMES
082020743e90   reddit:latest   "/start.sh"   20 minutes ago   Up 20 minutes             reddit

> docker kill reddit
reddit

> docker ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

> docker images
REPOSITORY          TAG       IMAGE ID       CREATED          SIZE
reddit              latest    4a45f764506c   30 minutes ago   668MB
r2d2k/otus-reddit   1.0       4a45f764506c   30 minutes ago   668MB
ubuntu              18.04     71cb16d32be4   2 weeks ago      63.1MB

> docker rmi 4a45f764506c 71cb16d32be4 -f
Untagged: reddit:latest
Untagged: r2d2k/otus-reddit:1.0
Untagged: r2d2k/otus-reddit@sha256:e5022562c09c608db4c507582546b3ac28d81ad81327dcbcd8bd18ceab25089b
Deleted: sha256:4a45f764506c918f161c9e75ef0daf24c679db3ec74c3b7ff7f35bb190a96ed3
Deleted: sha256:f3d656badaebb39b425f464e267f27bf9af30c685cbbd93b0b8ef4520ff808f5
Deleted: sha256:99738d77a76ffff8e0f0ac6e9fdf3f20020a214b957dba3bbc0dbe44f6df086f
Deleted: sha256:a7d6da9b92cfa530b711b48dea28d7400bcb320736af7f804eba027a9cf18043
Deleted: sha256:fc283d09aba733709ab27d9169f6fe436ea6c1e201bcf8d2d391863345857f96
Deleted: sha256:b26b3b10a35bafbbaefd19169ccbfab22bd107df939b9098ef433392dbc37c63
Deleted: sha256:727f8d218b5cf9ad258fe1d55c4b8f2c9b5d3ea2e4c6e8a3c6edaf55ec671422
Deleted: sha256:181a55e051303e103cde2331605d9c934b42624437ec3f51544dae6c3c502bd1
Deleted: sha256:a80f1b3658d2af3c6fd0d006008e63777c376d9f862301f81cc1a5fc3058aad6
Deleted: sha256:0c986fd9970a7a01857c608fdbdab78abe398caeba8902722cf54bf46641b1f0
Deleted: sha256:2eb7ef424d76481b63fb1c1a04eb8c6d940f764e80afd659a8f200f1adcae602
Deleted: sha256:3ca3debf38c903e568611c9ce068b81cf7e364cef15b386ab8b52debacb4e9b7
Deleted: sha256:bc776045cce17acc374b0c3e7774fced1b5d2e85429ee8555c082e4ada5c1b2b
Deleted: sha256:75364dae8491a9536e559d1c4a34a249ad380db0ffe8954bac30bb349fba7e2b
Deleted: sha256:360d3102d598364913d33eb568efef5b1f20b79a5132095e6061127629be8a1b
Deleted: sha256:89e6a0741d6089e9d8bef0f98750bba57ce3acac05cd43b82d0623e80c26ec22
Deleted: sha256:d349964087d4f79bdd2394a1e76bcb7a7d731303e46e964ffe3bd17073e245bd
Deleted: sha256:8bad6f048d49edc2de6c0640edaa0df5e14b54f9fc42a668c38852f2ae96bc1b
Deleted: sha256:d6f285e235418eee01c4a50dc29ba2f07261371cf20f5ba2fde03abfe4dbf0f6
Untagged: ubuntu:18.04
Untagged: ubuntu@sha256:40b84b75884ff39e4cac4bf62cb9678227b1fbf9dbe3f67ef2a6b073aa4bb529
Deleted: sha256:71cb16d32be4a95065b4fa1c8841a6f4c0098de7be0a90e14519098412d48356
Deleted: sha256:b9b23e6545749dab77233e9c3ce2237e6705cbd30de01e11f529b0e49c155cd5

> docker images
REPOSITORY   TAG       IMAGE ID   CREATED   SIZE
```

Загружаем образ и запускаем контейнер:
```console
> docker run --name reddit -d -p 9292:9292 r2d2k/otus-reddit:1.0
Unable to find image 'r2d2k/otus-reddit:1.0' locally
1.0: Pulling from r2d2k/otus-reddit
e706e0a9f423: Pull complete
234b6057aae1: Pull complete
99f90bb6380e: Pull complete
b011cdbb40ca: Pull complete
a4962faa405a: Pull complete
6470925595eb: Pull complete
b7634723ba9b: Pull complete
ac43f38048c7: Pull complete
15c75bc10aab: Pull complete
c094e48923bf: Pull complete
Digest: sha256:e5022562c09c608db4c507582546b3ac28d81ad81327dcbcd8bd18ceab25089b
Status: Downloaded newer image for r2d2k/otus-reddit:1.0
cc1ca78072ae5db744a64fe68a29c064375b0bc4a461ca003e9efa5259b47d87

> docker ps
CONTAINER ID   IMAGE                   COMMAND       CREATED              STATUS              PORTS                                       NAMES
cc1ca78072ae   r2d2k/otus-reddit:1.0   "/start.sh"   About a minute ago   Up About a minute   0.0.0.0:9292->9292/tcp, :::9292->9292/tcp   reddit
```

Проверяем приложение:
```console
> lynx -dump http://127.0.0.1:9292

   (BUTTON) [1]Monolith Reddit
     * [2]Sign up
     * [3]Login

Menu

     * [4]All posts
     * [5]New post

References

   1. http://127.0.0.1:9292/
   2. http://127.0.0.1:9292/signup
   3. http://127.0.0.1:9292/login
   4. http://127.0.0.1:9292/
   5. http://127.0.0.1:9292/new
```

**Результат №01-1:**
 - Создана машина с docker
 - Проверена работа тестовых образов
 - Собран собственный образ с приложением
 - Образ загружен на Docker Hub

---


**Задание №01-2:** Теперь, когда есть готовый образ с приложением, можно автоматизировать поднятие нескольких инстансов в Yandex Cloud, установку на них докера и запуск там образа /otus-reddit:1.0
 - Нужно реализовать в виде прототипа в директории /docker-monolith/infra/
 - Шаблон пакера, который делает образ с уже установленным Docker;
 - Поднятие инстансов с помощью Terraform, их количество задается переменной;
 - Несколько плейбуков Ansible с использованием динамического инвентори для установки докера и запуска там образа приложения;

**Решение №01-2:**
При помощи `packer` подготовим образ виртуальной машины с установленным `docker`.
Шаблон `ubuntu-docker.json` будет выглядеть так:
```json
{
    "variables": {
        "mv_service_account_key_file": "",
        "mv_folder_id": "",
        "mv_source_image_family": ""
    },
    "builders": [
        {
            "type": "yandex",
            "service_account_key_file": "{{user `mv_service_account_key_file`}}",
            "folder_id": "{{user `mv_folder_id`}}",
            "source_image_family": "{{user `mv_source_image_family`}}",
            "image_name": "{{user `mv_image_family`}}-{{timestamp}}",
            "image_family": "{{user `mv_image_family`}}",
            "ssh_username": "ubuntu",
            "platform_id": "standard-v1",
            "use_ipv4_nat": "true"
        }
    ],
    "provisioners": [
        {
            "type": "shell",
            "pause_before": "60s",
            "script": "scripts/install_docker.sh",
            "execute_command": "sudo {{.Path}}"
        },
        {
            "type": "shell",
            "script": "scripts/cleanup.sh",
            "execute_command": "sudo {{.Path}}"
        }
    ]
}
```

Перед выполнением скрипта установки делаем паузу в 60 секунд, чтобы завершились все процессы при старте новой машины. В противном случае у нас возникнут проблемы с `apt-get`.
Работой будет заниматься скрипт `scripts\install_docker.sh`:
```bash
#!/bin/sh

# Official guide: https://docs.docker.com/engine/install/ubuntu/

apt-get update
apt-get -y upgrade
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Setup repo
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update repo
sudo apt-get update

# Install latest docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

Второй скрипт `scripts/cleanup.sh` используем для зачистки будущего образа от мусора:
```bash
#!/bin/sh

apt-get autoclean
apt-get autoremove
```

Переменные для шаблона сохраним в `variables.json`:
```json
{
    "mv_service_account_key_file": "./key.json",
    "mv_folder_id": "WYDIWYG",
    "mv_source_image_family": "ubuntu-1804-lts",
    "mv_image_family": "reddit-docker"
}
```

Проверим шаблон на ошибки:
```console
> packer validate -var-file=variables.json ubuntu-docker.json
The configuration is valid.
```

Запускаем сборку образа:
```console
> packer build -var-file=variables.json ubuntu-docker.json
yandex: output will be in this color.

==> yandex: Creating temporary RSA SSH key for instance...
==> yandex: Using as source image: fd8hvlnfb66dgavf0e1a (name: "ubuntu-18-04-lts-v20220815", family: "ubuntu-1804-lts")
==> yandex: Creating network...
==> yandex: Creating subnet in zone "ru-central1-a"...
==> yandex: Creating disk...
==> yandex: Creating instance...
==> yandex: Waiting for instance with id fhm7hfb88n2e76kg8vl3 to become active...
    yandex: Detected instance IP: 84.201.129.65
==> yandex: Using SSH communicator to connect: 84.201.129.65
==> yandex: Waiting for SSH to become available...
==> yandex: Connected to SSH!
==> yandex: Pausing 1m0s before the next provisioner...
==> yandex: Provisioning with shell script: scripts/install_docker.sh
    yandex: Hit:1 http://mirror.yandex.ru/ubuntu bionic InRelease
...
...
...
    yandex: 0 upgraded, 0 newly installed, 0 to remove and 5 not upgraded.
==> yandex: Stopping instance...
==> yandex: Deleting instance...
    yandex: Instance has been deleted!
==> yandex: Creating image: reddit-docker-1666723129
==> yandex: Waiting for image to complete...
==> yandex: Success image create...
==> yandex: Destroying subnet...
    yandex: Subnet has been deleted!
==> yandex: Destroying network...
    yandex: Network has been deleted!
==> yandex: Destroying boot disk...
    yandex: Disk has been deleted!
Build 'yandex' finished after 5 minutes 40 seconds.

==> Wait completed after 5 minutes 40 seconds

==> Builds finished. The artifacts of successful builds are:
--> yandex: A disk image was created: reddit-docker-1666723129 (id: fd8mkch2tdig66qg0edu) with family name reddit-docker

```

В результате имеем образ виртуальной машины на базе Ubuntu 18.04 с предустановленным `docker`.
Запомним реквизиты образа `reddit-docker-1666723129 (id: fd8mkch2tdig66qg0edu)`.

Поднимать виртуальные машины будем при помощи `terraform`.

Для начала опишем провайдер в файле `provider.tf`:
```hcl
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}
```

Формируем описания переменных в файле `variables.tf`:
```hcl
variable "service_account_key_file" {
  description = "Path to service account key file"
}

variable "cloud_id" {
  description = "Cloud"
}

variable "folder_id" {
  description = "Folder"
}

variable "zone" {
  description = "Zone"
  default     = "ru-central1-a"
}

variable "image_id" {
  description = "Image id for VM"
}

variable "subnet_id" {
  description = "ID for subnet"
}

variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}

variable "servers_count" {
  description = "Number of servers to create"
}
```

Значения переменных задаём в `terraform.tfvars`:
```hcl
service_account_key_file    = "key.json"
cloud_id                    = "00000000000000000000"
folder_id                   = "00000000000000000000"
zone                        = "00-00000000-0"
image_id                    = "fd8mkch2tdig66qg0edu"
subnet_id                   = "00000000000000000000"
public_key_path             = "~/.ssh/ubuntu.pub"
servers_count               = 2
```

Теперь опишем конфигурацию виртуальных машин `main.tf`:
```hcl
provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

resource "yandex_compute_instance" "docker" {
  name = "reddit-docker-${count.index}"
  zone = var.zone

  count = var.servers_count

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}
```

Вывод адресов создаваемых машин опишем в `output.tf`:
```hcl
output "external_ip_address_docker" {
  value = yandex_compute_instance.docker[*].network_interface.0.nat_ip_address
}
```

После формирования файлов инициализируем окружение:
```console
> terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of yandex-cloud/yandex...
- Installing yandex-cloud/yandex v0.81.0...
- Installed yandex-cloud/yandex v0.81.0 (unauthenticated)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

Создадим пару виртуальных машин:
```console
> terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.docker[0] will be created
  + resource "yandex_compute_instance" "docker" {
      + created_at                = (known after apply)
...
...
...
      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.docker[1] will be created
  + resource "yandex_compute_instance" "docker" {
      + created_at                = (known after apply)
...
...
...
      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  ~ external_ip_address_docker = [
      + (known after apply),
      + (known after apply),
    ]

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

yandex_compute_instance.docker[1]: Creating...
yandex_compute_instance.docker[0]: Creating...
yandex_compute_instance.docker[1]: Still creating... [10s elapsed]
yandex_compute_instance.docker[0]: Still creating... [10s elapsed]
yandex_compute_instance.docker[1]: Still creating... [20s elapsed]
yandex_compute_instance.docker[0]: Still creating... [20s elapsed]
yandex_compute_instance.docker[1]: Still creating... [30s elapsed]
yandex_compute_instance.docker[0]: Still creating... [30s elapsed]
yandex_compute_instance.docker[1]: Still creating... [40s elapsed]
yandex_compute_instance.docker[0]: Still creating... [40s elapsed]
yandex_compute_instance.docker[0]: Creation complete after 50s [id=fhmiqrg1f5k8tk7sc8v6]
yandex_compute_instance.docker[1]: Still creating... [50s elapsed]
yandex_compute_instance.docker[1]: Creation complete after 59s [id=fhmt60vocfo2mt9hkvgl]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

external_ip_address_docker = [
  "84.201.133.40",
  "84.201.134.246",
]
```

Машины созданы, адреса получены, далее запустим на этих машинах контейнер с нашим приложением.
Просят использовать `ansible`, так используем его. Подробное описание подключения динамического инвентори я делал [тут](https://github.com/Otus-DevOps-2022-05/r2d2k_infra#08---ansible-2).

Если кратко, то:
 - Клонируем репозиторий: `git clone --branch yc_compute https://github.com/st8f/community.general.git`
 - Ищем `community.general/plugins/inventory/yc_compute.py`
 - Копируем в каталог `/home/ubuntu/.ansible/plugins/inventory`
 - Читаем документацию: `ansible-doc -t inventory yc_compute`
 - Готовим `yc.yml` и `ansible.cfg`

Содержимое `yc.yml`:
```yml
plugin: yc_compute

folders:
  - ******************pp

auth_kind: serviceaccountfile

service_account_file: ./ansible-key.json

hostnames:
  - fqdn

compose:
  ansible_host: network_interfaces[0].primary_v4_address.one_to_one_nat.address

keyed_groups:
  - key: labels['group']
    prefix: ''
    separator: ''
```

Содержимое `ansible.cfg`:
```ini
[defaults]
inventory = ./yc.yml
remote_user = ubuntu
private_key_file = ~/.ssh/ubuntu
host_key_checking = False
retry_files_enabled = False

[inventory]
enable_plugins = yc_compute
```

Проверим, как всё это отработает:
```console
> ansible-inventory --list
{
    "_meta": {
        "hostvars": {
            "fhmiqrg1f5k8tk7sc8v6.auto.internal": {
                "ansible_host": "84.201.133.40"
            },
            "fhmt60vocfo2mt9hkvgl.auto.internal": {
                "ansible_host": "84.201.134.246"
            }
        }
    },
    "all": {
        "children": [
            "ungrouped"
        ]
    },
    "ungrouped": {
        "hosts": [
            "fhmiqrg1f5k8tk7sc8v6.auto.internal",
            "fhmt60vocfo2mt9hkvgl.auto.internal"
        ]
    }
}
```

Для запуска контейнера возьмём [community.docker.docker_container](https://docs.ansible.com/ansible/latest/collections/community/docker/docker_container_module.html).

Готовим простой плэйбук `deploy_docker_app.yml`:
```yml
- name: Run reddit-docker
  hosts: all
  become: true
  tasks:
    - name: Run app in container
      community.docker.docker_container:
        name: reddit-docker
        image: r2d2k/otus-reddit:1.0
        state: started
        ports:
          - "80:9292"
```

Вот, что бывает, если плохо читаем документацию:
```console
> ansible-playbook deploy_docker_app.yml

PLAY [Run reddit-docker] ********************************************************

TASK [Gathering Facts] **********************************************************
ok: [fhmt60vocfo2mt9hkvgl.auto.internal]
ok: [fhmiqrg1f5k8tk7sc8v6.auto.internal]

TASK [Run app in container] *****************************************************
fatal: [fhmt60vocfo2mt9hkvgl.auto.internal]: FAILED! => {"changed": false, "msg": "Failed to import the required Python library (Docker SDK for Python: docker (Python >= 2.7) or docker-py (Python 2.6)) on fhmt60vocfo2mt9hkvgl's Python /usr/bin/python3. Please read the module documentation and install it in the appropriate location. If the required library is installed, but Ansible is using the wrong Python interpreter, please consult the documentation on ansible_python_interpreter, for example via `pip install docker` or `pip install docker-py` (Python 2.6). The error was: No module named 'docker'"}
fatal: [fhmiqrg1f5k8tk7sc8v6.auto.internal]: FAILED! => {"changed": false, "msg": "Failed to import the required Python library (Docker SDK for Python: docker (Python >= 2.7) or docker-py (Python 2.6)) on fhmiqrg1f5k8tk7sc8v6's Python /usr/bin/python3. Please read the module documentation and install it in the appropriate location. If the required library is installed, but Ansible is using the wrong Python interpreter, please consult the documentation on ansible_python_interpreter, for example via `pip install docker` or `pip install docker-py` (Python 2.6). The error was: No module named 'docker'"}

PLAY RECAP **********************************************************************
fhmiqrg1f5k8tk7sc8v6.auto.internal : ok=1    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0
fhmt60vocfo2mt9hkvgl.auto.internal : ok=1    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0
```

Добавляем задачу по установке Docker SDK for Python, пробуем снова:
```yml
- name: Run reddit-docker
  hosts: all
  gather_facts: no
  become: yes
  tasks:

    - name: Install PIP
      apt:
        name: python3-pip
        state: present

    - name: Install Docker SDK for Python
      pip:
        name: docker
        state: present

    - name: Run app in container
      community.docker.docker_container:
        name: reddit-docker
        image: r2d2k/otus-reddit:1.0
        state: started
        ports:
          - "80:9292"
```

Внешне всё хорошо:
```console
> ansible-playbook deploy_docker_app.yml

PLAY [Run reddit-docker] ********************************************************

TASK [Install PIP] **************************************************************

changed: [fhmiqrg1f5k8tk7sc8v6.auto.internal]
changed: [fhmt60vocfo2mt9hkvgl.auto.internal]

TASK [Install Docker SDK for Python] ********************************************
changed: [fhmt60vocfo2mt9hkvgl.auto.internal]
changed: [fhmiqrg1f5k8tk7sc8v6.auto.internal]

TASK [Run app in container] *****************************************************
changed: [fhmt60vocfo2mt9hkvgl.auto.internal]
changed: [fhmiqrg1f5k8tk7sc8v6.auto.internal]

PLAY RECAP **********************************************************************
fhmiqrg1f5k8tk7sc8v6.auto.internal : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
fhmt60vocfo2mt9hkvgl.auto.internal : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

Проверяем приложение на двух хостах:
```console
> lynx -dump http://84.201.133.40
   (BUTTON) [1]Monolith Reddit
     * [2]Sign up
     * [3]Login

Menu

     * [4]All posts
     * [5]New post

References

   1. http://84.201.133.40/
   2. http://84.201.133.40/signup
   3. http://84.201.133.40/login
   4. http://84.201.133.40/
   5. http://84.201.133.40/new

> lynx -dump http://84.201.134.246
   (BUTTON) [1]Monolith Reddit
     * [2]Sign up
     * [3]Login

Menu

     * [4]All posts
     * [5]New post

References

   1. http://84.201.134.246/
   2. http://84.201.134.246/signup
   3. http://84.201.134.246/login
   4. http://84.201.134.246/
   5. http://84.201.134.246/new

```

Всё работает.
Прибираем за собой, т.е. обнуляем переменную `servers_count`, применяем конфигурацию `terraform`:
```console
>terraform apply
yandex_compute_instance.docker[0]: Refreshing state... [id=fhmiqrg1f5k8tk7sc8v6]
yandex_compute_instance.docker[1]: Refreshing state... [id=fhmt60vocfo2mt9hkvgl]
...
...
...
Plan: 0 to add, 0 to change, 2 to destroy.

Changes to Outputs:
  ~ external_ip_address_docker = [
      - "84.201.133.40",
      - "84.201.134.246",
    ]

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

yandex_compute_instance.docker[1]: Destroying... [id=fhmt60vocfo2mt9hkvgl]
yandex_compute_instance.docker[0]: Destroying... [id=fhmiqrg1f5k8tk7sc8v6]
yandex_compute_instance.docker[1]: Still destroying... [id=fhmt60vocfo2mt9hkvgl, 10s elapsed]
yandex_compute_instance.docker[0]: Still destroying... [id=fhmiqrg1f5k8tk7sc8v6, 10s elapsed]
yandex_compute_instance.docker[1]: Still destroying... [id=fhmt60vocfo2mt9hkvgl, 20s elapsed]
yandex_compute_instance.docker[0]: Still destroying... [id=fhmiqrg1f5k8tk7sc8v6, 20s elapsed]
yandex_compute_instance.docker[1]: Destruction complete after 28s
yandex_compute_instance.docker[0]: Still destroying... [id=fhmiqrg1f5k8tk7sc8v6, 30s elapsed]
yandex_compute_instance.docker[0]: Destruction complete after 33s

Apply complete! Resources: 0 added, 0 changed, 2 destroyed.

Outputs:

external_ip_address_docker = []
```

**Результат №01-2:**
 - Подготовили при помощи `packer` образ ВМ с установленным `docker`
 - Используя `terraform` развернули несколько ВМ из этого образа
 - Написали простой плэйбук для установки и запуска приложения в `docker` из созданного ранее контейнера

---

## 02 - Docker-образы. Микросервисы

**Задание №02-1:**
 - Научиться описывать и собирать Docker-образы для сервисного приложения
 - Научиться оптимизировать работу с Docker-образами
 - Запуск и работа приложения на основе Docker-образов, оценка удобства запуска контейнеров при помощи `docker run`

**Решение №02-1:**

Создаём новую ветку:
```console
> git checkout -b docker-3
Switched to a new branch 'docker-3'

> git push --set-upstream origin docker-3
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
remote:
remote: Create a pull request for 'docker-3' on GitHub by visiting:
remote:      https://github.com/Otus-DevOps-2022-05/r2d2k_microservices/pull/new/docker-3
remote:
To https://github.com/Otus-DevOps-2022-05/r2d2k_microservices.git
 * [new branch]      docker-3 -> docker-3
branch 'docker-3' set up to track 'origin/docker-3'.
```

Качаем [архив](https://github.com/express42/reddit/archive/microservices.zip), распаковываем в каталог `src`:
```console
> tree src/
src/
├── comment
│             ├── comment_app.rb
│             ├── config.ru
│             ├── docker_build.sh
│             ├── Gemfile
│             ├── Gemfile.lock
│             ├── helpers.rb
│             └── VERSION
├── post-py
│             ├── docker_build.sh
│             ├── helpers.py
│             ├── post_app.py
│             ├── requirements.txt
│             └── VERSION
├── README.md
└── ui
    ├── config.ru
    ├── docker_build.sh
    ├── Gemfile
    ├── Gemfile.lock
    ├── helpers.rb
    ├── middleware.rb
    ├── ui_app.rb
    ├── VERSION
    └── views
        ├── create.haml
        ├── index.haml
        ├── layout.haml
        └── show.haml

4 directories, 25 files
```

Каталог `src` теперь основной каталог этого домашнего задания и наше приложение состоит из трех компонентов:
 - `post-py` - сервис отвечающий за написание постов
 - `comment` - сервис отвечающий за написание комментариев
 - `ui` - веб-интерфейс, работающий с другими сервисами


Создаём `Dockerfile` для приложения `post-py`:
```Dockerfile
FROM python:3.6.0-alpine

WORKDIR /app
ADD . /app

RUN apk --no-cache --update add build-base && \
    pip install -r /app/requirements.txt && \
    apk del build-base

ENV POST_DATABASE_HOST post_db
ENV POST_DATABASE posts

ENTRYPOINT ["python3", "post_app.py"]
```

Создаём `Dockerfile` для приложения `comment`:
```Dockerfile
FROM ruby:2.2
RUN apt-get update -qq && apt-get install -y build-essential

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install
ADD . $APP_HOME

ENV COMMENT_DATABASE_HOST comment_db
ENV COMMENT_DATABASE comments

CMD ["puma"]
```

Создаём `Dockerfile` для приложения `ui`:
```Dockerfile
FROM ruby:2.2
RUN apt-get update -qq && apt-get install -y build-essential

ENV APP_HOME /app
RUN mkdir $APP_HOME

WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/
RUN bundle install
ADD . $APP_HOME

ENV POST_SERVICE_HOST post
ENV POST_SERVICE_PORT 5000
ENV COMMENT_SERVICE_HOST comment
ENV COMMENT_SERVICE_PORT 9292

CMD ["puma"]
```

Для нормальной работы приложений нужна `mongodb`:
```console
> docker pull mongo:latest
latest: Pulling from library/mongo
eaead16dc43b: Pull complete
8a00eb9f68a0: Pull complete
f683956749c5: Pull complete
b33b2f05ea20: Pull complete
3a342bea915a: Pull complete
fa956ab1c2f0: Pull complete
138a8542a624: Pull complete
acab179a7f07: Pull complete
f88335710e84: Pull complete
Digest: sha256:3b9bfc35335710340afe1e98c870491b2a969fd93b62505b4617eab73d97cec6
Status: Downloaded newer image for mongo:latest
docker.io/library/mongo:latest
```

Далее начинаем собирать наши образы:
```console
> docker build -t r2d2k/post:1.0 ./post-py
Sending build context to Docker daemon   16.9kB
Step 1/7 : FROM python:3.6.0-alpine
3.6.0-alpine: Pulling from library/python
709515475419: Pull complete
7f8ede2d2484: Pull complete
3c752c95ebfb: Pull complete
39c204c94887: Pull complete
Digest: sha256:142fc3f338b10569d08c3f3855c492c2a176b0c45af099f9ebe87f0fededb210
Status: Downloaded newer image for python:3.6.0-alpine
 ---> cb178ebbf0f2
Step 2/7 : WORKDIR /app
 ---> Running in ac54899d5936
Removing intermediate container ac54899d5936
 ---> 0bba10393d99
Step 3/7 : ADD . /app
 ---> 6a92f2a283a7
Step 4/7 : RUN apk --no-cache --update add build-base &&     pip install -r /app/requirements.txt &&     apk del build-base
 ---> Running in 186b45b7fe5f
fetch http://dl-cdn.alpinelinux.org/alpine/v3.4/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.4/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.4/community/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.4/community/x86_64/APKINDEX.tar.gz
(1/21) Upgrading musl (1.1.14-r14 -> 1.1.14-r16)
(2/21) Installing binutils-libs (2.26-r1)
(3/21) Installing binutils (2.26-r1)
(4/21) Installing gmp (6.1.0-r0)
(5/21) Installing isl (0.14.1-r0)
(6/21) Installing libgomp (5.3.0-r0)
(7/21) Installing libatomic (5.3.0-r0)
(8/21) Installing libgcc (5.3.0-r0)
(9/21) Installing pkgconf (0.9.12-r0)
(10/21) Installing pkgconfig (0.25-r1)
(11/21) Installing mpfr3 (3.1.2-r0)
(12/21) Installing mpc1 (1.0.3-r0)
(13/21) Installing libstdc++ (5.3.0-r0)
(14/21) Installing gcc (5.3.0-r0)
(15/21) Installing make (4.1-r1)
(16/21) Installing musl-dev (1.1.14-r16)
(17/21) Installing libc-dev (0.7-r0)
(18/21) Installing fortify-headers (0.8-r0)
(19/21) Installing g++ (5.3.0-r0)
(20/21) Installing build-base (0.4-r1)
(21/21) Upgrading musl-utils (1.1.14-r14 -> 1.1.14-r16)
Executing busybox-1.24.2-r13.trigger
OK: 183 MiB in 52 packages
Collecting prometheus_client==0.0.21 (from -r /app/requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/45/6d/0cc171ce82a8f284133faf12a50018501abdc4b0742e4f8f471b6b2dc81f/prometheus_client-0.0.21.tar.gz
Collecting flask==0.12.3 (from -r /app/requirements.txt (line 2))
  Downloading https://files.pythonhosted.org/packages/24/3e/1b6aa496fa9bb119f6b22263ca5ca9e826aaa132431fd78f413c8bcc18e3/Flask-0.12.3-py2.py3-none-any.whl (88kB)
Collecting pymongo==3.5.1 (from -r /app/requirements.txt (line 3))
  Downloading https://files.pythonhosted.org/packages/a8/f6/f324f5c669478644ac64594b9d746a34e185d9c34d3f05a4a6a6dab5467b/pymongo-3.5.1.tar.gz (1.3MB)
Collecting structlog==17.2.0 (from -r /app/requirements.txt (line 4))
  Downloading https://files.pythonhosted.org/packages/9c/10/6f9ba14af65179d0e1a5f281064525a45a68763736188a5a6472846e3359/structlog-17.2.0-py2.py3-none-any.whl
Collecting py-zipkin==0.13.0 (from -r /app/requirements.txt (line 5))
  Downloading https://files.pythonhosted.org/packages/85/b7/c4b46b7437f8a7dfc255169a1df46e4a1c3456926be04c26a476c93e8893/py_zipkin-0.13.0.tar.gz
Collecting requests==2.18.4 (from -r /app/requirements.txt (line 6))
  Downloading https://files.pythonhosted.org/packages/49/df/50aa1999ab9bde74656c2919d9c0c085fd2b3775fd3eca826012bef76d8c/requests-2.18.4-py2.py3-none-any.whl (88kB)
Collecting itsdangerous>=0.21 (from flask==0.12.3->-r /app/requirements.txt (line 2))
  Downloading https://files.pythonhosted.org/packages/9c/96/26f935afba9cd6140216da5add223a0c465b99d0f112b68a4ca426441019/itsdangerous-2.0.1-py3-none-any.whl
Collecting Jinja2>=2.4 (from flask==0.12.3->-r /app/requirements.txt (line 2))
  Downloading https://files.pythonhosted.org/packages/20/9a/e5d9ec41927401e41aea8af6d16e78b5e612bca4699d417f646a9610a076/Jinja2-3.0.3-py3-none-any.whl (133kB)
Collecting Werkzeug>=0.7 (from flask==0.12.3->-r /app/requirements.txt (line 2))
  Downloading https://files.pythonhosted.org/packages/f4/f3/22afbdb20cc4654b10c98043414a14057cd27fdba9d4ae61cea596000ba2/Werkzeug-2.0.3-py3-none-any.whl (289kB)
Collecting click>=2.0 (from flask==0.12.3->-r /app/requirements.txt (line 2))
  Downloading https://files.pythonhosted.org/packages/4a/a8/0b2ced25639fb20cc1c9784de90a8c25f9504a7f18cd8b5397bd61696d7d/click-8.0.4-py3-none-any.whl (97kB)
Collecting six (from structlog==17.2.0->-r /app/requirements.txt (line 4))
  Downloading https://files.pythonhosted.org/packages/d9/5a/e7c31adbe875f2abbb91bd84cf2dc52d792b5a01506781dbcf25c91daf11/six-1.16.0-py2.py3-none-any.whl
Collecting thriftpy (from py-zipkin==0.13.0->-r /app/requirements.txt (line 5))
  Downloading https://files.pythonhosted.org/packages/f4/19/cca118cf7d2087310dbc8bd70dc7df0c1320f2652873a93d06d7ba356d4a/thriftpy-0.3.9.tar.gz (208kB)
Collecting idna<2.7,>=2.5 (from requests==2.18.4->-r /app/requirements.txt (line 6))
  Downloading https://files.pythonhosted.org/packages/27/cc/6dd9a3869f15c2edfab863b992838277279ce92663d334df9ecf5106f5c6/idna-2.6-py2.py3-none-any.whl (56kB)
Collecting certifi>=2017.4.17 (from requests==2.18.4->-r /app/requirements.txt (line 6))
  Downloading https://files.pythonhosted.org/packages/1d/38/fa96a426e0c0e68aabc68e896584b83ad1eec779265a028e156ce509630e/certifi-2022.9.24-py3-none-any.whl (161kB)
Collecting chardet<3.1.0,>=3.0.2 (from requests==2.18.4->-r /app/requirements.txt (line 6))
  Downloading https://files.pythonhosted.org/packages/bc/a9/01ffebfb562e4274b6487b4bb1ddec7ca55ec7510b22e4c51f14098443b8/chardet-3.0.4-py2.py3-none-any.whl (133kB)
Collecting urllib3<1.23,>=1.21.1 (from requests==2.18.4->-r /app/requirements.txt (line 6))
  Downloading https://files.pythonhosted.org/packages/63/cb/6965947c13a94236f6d4b8223e21beb4d576dc72e8130bd7880f600839b8/urllib3-1.22-py2.py3-none-any.whl (132kB)
Collecting MarkupSafe>=2.0 (from Jinja2>=2.4->flask==0.12.3->-r /app/requirements.txt (line 2))
  Downloading https://files.pythonhosted.org/packages/bf/10/ff66fea6d1788c458663a84d88787bae15d45daa16f6b3ef33322a51fc7e/MarkupSafe-2.0.1.tar.gz
  Requested MarkupSafe>=2.0 from https://files.pythonhosted.org/packages/bf/10/ff66fea6d1788c458663a84d88787bae15d45daa16f6b3ef33322a51fc7e/MarkupSafe-2.0.1.tar.gz#sha256=594c67807fb16238b30c44bdf74f36c02cdf22d1c8cda91ef8a0ed8dabf5620a (from Jinja2>=2.4->flask==0.12.3->-r /app/requirements.txt (line 2)), but installing version None
Collecting dataclasses; python_version < "3.7" (from Werkzeug>=0.7->flask==0.12.3->-r /app/requirements.txt (line 2))
  Downloading https://files.pythonhosted.org/packages/fe/ca/75fac5856ab5cfa51bbbcefa250182e50441074fdc3f803f6e76451fab43/dataclasses-0.8-py3-none-any.whl
Collecting importlib-metadata; python_version < "3.8" (from click>=2.0->flask==0.12.3->-r /app/requirements.txt (line 2))
  Downloading https://files.pythonhosted.org/packages/a0/a1/b153a0a4caf7a7e3f15c2cd56c7702e2cf3d89b1b359d1f1c5e59d68f4ce/importlib_metadata-4.8.3-py3-none-any.whl
Collecting ply<4.0,>=3.4 (from thriftpy->py-zipkin==0.13.0->-r /app/requirements.txt (line 5))
  Downloading https://files.pythonhosted.org/packages/a3/58/35da89ee790598a0700ea49b2a66594140f44dec458c07e8e3d4979137fc/ply-3.11-py2.py3-none-any.whl (49kB)
Collecting zipp>=0.5 (from importlib-metadata; python_version < "3.8"->click>=2.0->flask==0.12.3->-r /app/requirements.txt (line 2))
  Downloading https://files.pythonhosted.org/packages/bd/df/d4a4974a3e3957fd1c1fa3082366d7fff6e428ddb55f074bf64876f8e8ad/zipp-3.6.0-py3-none-any.whl
Collecting typing-extensions>=3.6.4; python_version < "3.8" (from importlib-metadata; python_version < "3.8"->click>=2.0->flask==0.12.3->-r /app/requirements.txt (line 2))
  Downloading https://files.pythonhosted.org/packages/45/6b/44f7f8f1e110027cf88956b59f2fad776cca7e1704396d043f89effd3a0e/typing_extensions-4.1.1-py3-none-any.whl
Installing collected packages: prometheus-client, itsdangerous, MarkupSafe, Jinja2, dataclasses, Werkzeug, zipp, typing-extensions, importlib-metadata, click, flask, pymongo, six, structlog, ply, thriftpy, py-zipkin, idna, certifi, chardet, urllib3, requests
  Running setup.py install for prometheus-client: started
    Running setup.py install for prometheus-client: finished with status 'done'
  Running setup.py install for MarkupSafe: started
    Running setup.py install for MarkupSafe: finished with status 'done'
  Running setup.py install for pymongo: started
    Running setup.py install for pymongo: finished with status 'done'
  Running setup.py install for thriftpy: started
    Running setup.py install for thriftpy: finished with status 'done'
  Running setup.py install for py-zipkin: started
    Running setup.py install for py-zipkin: finished with status 'done'
Successfully installed Jinja2-3.0.3 MarkupSafe-0.0.0 Werkzeug-2.0.3 certifi-2022.9.24 chardet-3.0.4 click-8.0.4 dataclasses-0.8 flask-0.12.3 idna-2.6 importlib-metadata-4.8.3 itsdangerous-2.0.1 ply-3.11 prometheus-client-0.0.21 py-zipkin-0.13.0 pymongo-3.5.1 requests-2.18.4 six-1.16.0 structlog-17.2.0 thriftpy-0.3.9 typing-extensions-4.1.1 urllib3-1.22 zipp-3.6.0
You are using pip version 9.0.1, however version 22.3 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
(1/19) Purging build-base (0.4-r1)
(2/19) Purging make (4.1-r1)
(3/19) Purging fortify-headers (0.8-r0)
(4/19) Purging g++ (5.3.0-r0)
(5/19) Purging gcc (5.3.0-r0)
(6/19) Purging binutils (2.26-r1)
(7/19) Purging isl (0.14.1-r0)
(8/19) Purging libatomic (5.3.0-r0)
(9/19) Purging pkgconfig (0.25-r1)
(10/19) Purging pkgconf (0.9.12-r0)
(11/19) Purging libc-dev (0.7-r0)
(12/19) Purging musl-dev (1.1.14-r16)
(13/19) Purging libstdc++ (5.3.0-r0)
(14/19) Purging binutils-libs (2.26-r1)
(15/19) Purging mpc1 (1.0.3-r0)
(16/19) Purging mpfr3 (3.1.2-r0)
(17/19) Purging gmp (6.1.0-r0)
(18/19) Purging libgomp (5.3.0-r0)
(19/19) Purging libgcc (5.3.0-r0)
Executing busybox-1.24.2-r13.trigger
OK: 31 MiB in 33 packages
Removing intermediate container 186b45b7fe5f
 ---> e24df85a06fe
Step 5/7 : ENV POST_DATABASE_HOST post_db
 ---> Running in 9911da2ec3d2
Removing intermediate container 9911da2ec3d2
 ---> 33a60c62bd72
Step 6/7 : ENV POST_DATABASE posts
 ---> Running in 4cfe432333f0
Removing intermediate container 4cfe432333f0
 ---> 71898b376dfa
Step 7/7 : ENTRYPOINT ["python3", "post_app.py"]
 ---> Running in 09604c0835a3
Removing intermediate container 09604c0835a3
 ---> b438f345df77
Successfully built b438f345df77
Successfully tagged r2d2k/post:1.0
```

```console
> docker build -t r2d2k/comment:1.0 ./comment
Sending build context to Docker daemon  14.85kB
Step 1/11 : FROM ruby:2.2
2.2: Pulling from library/ruby
3d77ce4481b1: Pull complete
534514c83d69: Pull complete
d562b1c3ac3f: Pull complete
4b85e68dc01d: Pull complete
52134d825d3e: Pull complete
b2262ff3b75c: Pull complete
4d1332abe17f: Pull complete
Digest: sha256:4987b5e2f03b7086c493208ef616b711fe73228391a80faf451975f9e0195236
Status: Downloaded newer image for ruby:2.2
 ---> 6c8e6f9667b2
Step 2/11 : RUN apt-get update -qq && apt-get install -y build-essential
 ---> Running in 4efd9c42effc
Reading package lists...
Building dependency tree...
Reading state information...
The following extra packages will be installed:
  dpkg-dev fakeroot libalgorithm-diff-perl libalgorithm-diff-xs-perl
  libalgorithm-merge-perl libdpkg-perl libfakeroot libfile-fcntllock-perl
  libtimedate-perl
Suggested packages:
  debian-keyring
The following NEW packages will be installed:
  build-essential dpkg-dev fakeroot libalgorithm-diff-perl
  libalgorithm-diff-xs-perl libalgorithm-merge-perl libdpkg-perl libfakeroot
  libfile-fcntllock-perl libtimedate-perl
0 upgraded, 10 newly installed, 0 to remove and 162 not upgraded.
Need to get 2916 kB of archives.
After this operation, 5051 kB of additional disk space will be used.
Get:1 http://deb.debian.org/debian/ jessie/main libtimedate-perl all 2.3000-2 [42.2 kB]
Get:2 http://deb.debian.org/debian/ jessie/main libdpkg-perl all 1.17.27 [1075 kB]
Get:3 http://deb.debian.org/debian/ jessie/main dpkg-dev all 1.17.27 [1548 kB]
Get:4 http://deb.debian.org/debian/ jessie/main build-essential amd64 11.7 [7114 B]
Get:5 http://deb.debian.org/debian/ jessie/main libfakeroot amd64 1.20.2-1 [44.7 kB]
Get:6 http://deb.debian.org/debian/ jessie/main fakeroot amd64 1.20.2-1 [84.7 kB]
Get:7 http://deb.debian.org/debian/ jessie/main libalgorithm-diff-perl all 1.19.02-3 [51.7 kB]
Get:8 http://deb.debian.org/debian/ jessie/main libalgorithm-diff-xs-perl amd64 0.04-3+b1 [12.2 kB]
Get:9 http://deb.debian.org/debian/ jessie/main libalgorithm-merge-perl all 0.08-2 [13.5 kB]
Get:10 http://deb.debian.org/debian/ jessie/main libfile-fcntllock-perl amd64 0.22-1+b1 [36.4 kB]
debconf: delaying package configuration, since apt-utils is not installed
Fetched 2916 kB in 3s (914 kB/s)
Selecting previously unselected package libtimedate-perl.
(Reading database ... 21206 files and directories currently installed.)
Preparing to unpack .../libtimedate-perl_2.3000-2_all.deb ...
Unpacking libtimedate-perl (2.3000-2) ...
Selecting previously unselected package libdpkg-perl.
Preparing to unpack .../libdpkg-perl_1.17.27_all.deb ...
Unpacking libdpkg-perl (1.17.27) ...
Selecting previously unselected package dpkg-dev.
Preparing to unpack .../dpkg-dev_1.17.27_all.deb ...
Unpacking dpkg-dev (1.17.27) ...
Selecting previously unselected package build-essential.
Preparing to unpack .../build-essential_11.7_amd64.deb ...
Unpacking build-essential (11.7) ...
Selecting previously unselected package libfakeroot:amd64.
Preparing to unpack .../libfakeroot_1.20.2-1_amd64.deb ...
Unpacking libfakeroot:amd64 (1.20.2-1) ...
Selecting previously unselected package fakeroot.
Preparing to unpack .../fakeroot_1.20.2-1_amd64.deb ...
Unpacking fakeroot (1.20.2-1) ...
Selecting previously unselected package libalgorithm-diff-perl.
Preparing to unpack .../libalgorithm-diff-perl_1.19.02-3_all.deb ...
Unpacking libalgorithm-diff-perl (1.19.02-3) ...
Selecting previously unselected package libalgorithm-diff-xs-perl.
Preparing to unpack .../libalgorithm-diff-xs-perl_0.04-3+b1_amd64.deb ...
Unpacking libalgorithm-diff-xs-perl (0.04-3+b1) ...
Selecting previously unselected package libalgorithm-merge-perl.
Preparing to unpack .../libalgorithm-merge-perl_0.08-2_all.deb ...
Unpacking libalgorithm-merge-perl (0.08-2) ...
Selecting previously unselected package libfile-fcntllock-perl.
Preparing to unpack .../libfile-fcntllock-perl_0.22-1+b1_amd64.deb ...
Unpacking libfile-fcntllock-perl (0.22-1+b1) ...
Setting up libtimedate-perl (2.3000-2) ...
Setting up libdpkg-perl (1.17.27) ...
Setting up dpkg-dev (1.17.27) ...
Setting up build-essential (11.7) ...
Setting up libfakeroot:amd64 (1.20.2-1) ...
Setting up fakeroot (1.20.2-1) ...
update-alternatives: using /usr/bin/fakeroot-sysv to provide /usr/bin/fakeroot (fakeroot) in auto mode
Setting up libalgorithm-diff-perl (1.19.02-3) ...
Setting up libalgorithm-diff-xs-perl (0.04-3+b1) ...
Setting up libalgorithm-merge-perl (0.08-2) ...
Setting up libfile-fcntllock-perl (0.22-1+b1) ...
Removing intermediate container 4efd9c42effc
 ---> ffccdcac3a64
Step 3/11 : ENV APP_HOME /app
 ---> Running in 75e8523e1665
Removing intermediate container 75e8523e1665
 ---> 942515889cc2
Step 4/11 : RUN mkdir $APP_HOME
 ---> Running in 2b68bf830694
Removing intermediate container 2b68bf830694
 ---> 2bbd4fd7966f
Step 5/11 : WORKDIR $APP_HOME
 ---> Running in 45f52bff20e1
Removing intermediate container 45f52bff20e1
 ---> 43c09de77149
Step 6/11 : ADD Gemfile* $APP_HOME/
 ---> f70a60676ec8
Step 7/11 : RUN bundle install
 ---> Running in 1b9caed9872a
Warning: the running version of Bundler (1.16.1) is older than the version that created the lockfile (1.17.2). We suggest you upgrade to the latest version of Bundler by running `gem install bundler`.
Fetching gem metadata from https://rubygems.org/........
Fetching bson 4.3.0
Installing bson 4.3.0 with native extensions
Fetching bson_ext 1.5.1
Installing bson_ext 1.5.1 with native extensions
Using bundler 1.16.1
Fetching thread_safe 0.3.6
Installing thread_safe 0.3.6
Fetching tzinfo 1.2.5
Installing tzinfo 1.2.5
Fetching et-orbi 1.1.6
Installing et-orbi 1.1.6
Fetching raabro 1.1.6
Installing raabro 1.1.6
Fetching fugit 1.1.6
Installing fugit 1.1.6
Fetching mongo 2.6.2
Installing mongo 2.6.2
Fetching mustermann 1.0.3
Installing mustermann 1.0.3
Fetching quantile 0.2.1
Installing quantile 0.2.1
Fetching prometheus-client 0.8.0
Installing prometheus-client 0.8.0
Fetching puma 3.12.0
Installing puma 3.12.0 with native extensions
Fetching rack 2.0.6
Installing rack 2.0.6
Fetching rack-protection 2.0.4
Installing rack-protection 2.0.4
Fetching rufus-scheduler 3.5.2
Installing rufus-scheduler 3.5.2
Fetching tilt 2.0.9
Installing tilt 2.0.9
Fetching sinatra 2.0.4
Installing sinatra 2.0.4
Fetching tzinfo-data 1.2018.7
Installing tzinfo-data 1.2018.7
Bundle complete! 8 Gemfile dependencies, 19 gems now installed.
Bundled gems are installed into `/usr/local/bundle`
Removing intermediate container 1b9caed9872a
 ---> 05874bc28333
Step 8/11 : ADD . $APP_HOME
 ---> e8dd7d8edc8a
Step 9/11 : ENV COMMENT_DATABASE_HOST comment_db
 ---> Running in a1b8521ac359
Removing intermediate container a1b8521ac359
 ---> be3334b9f2b5
Step 10/11 : ENV COMMENT_DATABASE comments
 ---> Running in f9b0888174fa
Removing intermediate container f9b0888174fa
 ---> 818315914101
Step 11/11 : CMD ["puma"]
 ---> Running in 46ecd35fc8d8
Removing intermediate container 46ecd35fc8d8
 ---> 5ed27e0339a7
Successfully built 5ed27e0339a7
Successfully tagged r2d2k/comment:1.0
```

```console
> docker build -t r2d2k/ui:1.0 ./ui
Sending build context to Docker daemon  30.72kB
Step 1/13 : FROM ruby:2.2
 ---> 6c8e6f9667b2
Step 2/13 : RUN apt-get update -qq && apt-get install -y build-essential
 ---> Using cache
 ---> ffccdcac3a64
Step 3/13 : ENV APP_HOME /app
 ---> Using cache
 ---> 942515889cc2
Step 4/13 : RUN mkdir $APP_HOME
 ---> Using cache
 ---> 2bbd4fd7966f
Step 5/13 : WORKDIR $APP_HOME
 ---> Using cache
 ---> 43c09de77149
Step 6/13 : ADD Gemfile* $APP_HOME/
 ---> 7370fda28023
Step 7/13 : RUN bundle install
 ---> Running in 70de0b26eeb7
Warning: the running version of Bundler (1.16.1) is older than the version that created the lockfile (1.17.2). We suggest you upgrade to the latest version of Bundler by running `gem install bundler`.
Fetching gem metadata from https://rubygems.org/............
Fetching concurrent-ruby 1.1.4
Installing concurrent-ruby 1.1.4
Fetching i18n 1.3.0
Installing i18n 1.3.0
Fetching minitest 5.11.3
Installing minitest 5.11.3
Fetching thread_safe 0.3.6
Installing thread_safe 0.3.6
Fetching tzinfo 1.2.5
Installing tzinfo 1.2.5
Fetching activesupport 5.2.2
Installing activesupport 5.2.2
Fetching backports 3.11.4
Installing backports 3.11.4
Fetching bson 1.12.5
Installing bson 1.12.5
Fetching bson_ext 1.12.5
Installing bson_ext 1.12.5 with native extensions
Using bundler 1.16.1
Fetching et-orbi 1.1.6
Installing et-orbi 1.1.6
Fetching multipart-post 2.0.0
Installing multipart-post 2.0.0
Fetching faraday 0.15.4
Installing faraday 0.15.4
Fetching thrift 0.9.3.0
Installing thrift 0.9.3.0 with native extensions
Fetching finagle-thrift 1.4.2
Installing finagle-thrift 1.4.2
Fetching raabro 1.1.6
Installing raabro 1.1.6
Fetching fugit 1.1.6
Installing fugit 1.1.6
Fetching temple 0.8.0
Installing temple 0.8.0
Fetching tilt 2.0.9
Installing tilt 2.0.9
Fetching haml 5.0.4
Installing haml 5.0.4
Fetching multi_json 1.13.1
Installing multi_json 1.13.1
Fetching mustermann 1.0.3
Installing mustermann 1.0.3
Fetching quantile 0.2.1
Installing quantile 0.2.1
Fetching prometheus-client 0.8.0
Installing prometheus-client 0.8.0
Fetching puma 3.12.0
Installing puma 3.12.0 with native extensions
Fetching rack 2.0.6
Installing rack 2.0.6
Fetching rack-protection 2.0.4
Installing rack-protection 2.0.4
Fetching rufus-scheduler 3.5.2
Installing rufus-scheduler 3.5.2
Fetching sinatra 2.0.4
Installing sinatra 2.0.4
Fetching sinatra-contrib 2.0.4
Installing sinatra-contrib 2.0.4
Fetching sucker_punch 2.1.1
Installing sucker_punch 2.1.1
Fetching tzinfo-data 1.2018.7
Installing tzinfo-data 1.2018.7
Fetching zipkin-tracer 0.30.0
Installing zipkin-tracer 0.30.0
Bundle complete! 11 Gemfile dependencies, 33 gems now installed.
Bundled gems are installed into `/usr/local/bundle`
Post-install message from i18n:

HEADS UP! i18n 1.1 changed fallbacks to exclude default locale.
But that may break your application.

Please check your Rails app for 'config.i18n.fallbacks = true'.
If you're using I18n (>= 1.1.0) and Rails (< 5.2.2), this should be
'config.i18n.fallbacks = [I18n.default_locale]'.
If not, fallbacks will be broken in your app by I18n 1.1.x.

For more info see:
https://github.com/svenfuchs/i18n/releases/tag/v1.1.0

Post-install message from sucker_punch:
Sucker Punch v2.0 introduces backwards-incompatible changes.
Please see https://github.com/brandonhilkert/sucker_punch/blob/master/CHANGES.md#200 for details.
Removing intermediate container 70de0b26eeb7
 ---> 1371b93c5c26
Step 8/13 : ADD . $APP_HOME
 ---> ada96900535d
Step 9/13 : ENV POST_SERVICE_HOST post
 ---> Running in 8c0aa092dde7
Removing intermediate container 8c0aa092dde7
 ---> f914ee4f9740
Step 10/13 : ENV POST_SERVICE_PORT 5000
 ---> Running in d25fa37668fb
Removing intermediate container d25fa37668fb
 ---> d7c371a31dbb
Step 11/13 : ENV COMMENT_SERVICE_HOST comment
 ---> Running in fd864a53bd0a
Removing intermediate container fd864a53bd0a
 ---> 7537ff8dec53
Step 12/13 : ENV COMMENT_SERVICE_PORT 9292
 ---> Running in 30470579b4be
Removing intermediate container 30470579b4be
 ---> 78ca5da620ac
Step 13/13 : CMD ["puma"]
 ---> Running in 64a9d394f5a6
Removing intermediate container 64a9d394f5a6
 ---> dede21880119
Successfully built dede21880119
Successfully tagged r2d2k/ui:1.0
```

Статистика по собранным образам:
```console
> docker images
REPOSITORY      TAG            IMAGE ID       CREATED          SIZE
r2d2k/ui        1.0            dede21880119   3 minutes ago    772MB
r2d2k/comment   1.0            5ed27e0339a7   5 minutes ago    769MB
r2d2k/post      1.0            b438f345df77   11 minutes ago   111MB
mongo           latest         b70536aeb250   24 hours ago     695MB
ruby            2.2            6c8e6f9667b2   4 years ago      715MB
python          3.6.0-alpine   cb178ebbf0f2   5 years ago      88.6MB
```

Сборка `ui` началась не с первого шага, так как у нас уже есть слои, подготовленные при сборке предыдущего приложения. Они совпали и были использованы в работе.

Создаём отдельную сеть под приложения:
```console
> docker network create reddit
da565863ffc207b4b5096a410a689b378388a34221fe582587a422ea4989ac18

> docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
318eb18767d9   bridge    bridge    local
f9d28c74ca97   host      host      local
6a9dc35c3605   none      null      local
da565863ffc2   reddit    bridge    local
```

Создадим и запустим контейнеры с приложениями:
```console
docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db mongo:latest
docker run -d --network=reddit --network-alias=post r2d2k/post:1.0
docker run -d --network=reddit --network-alias=comment r2d2k/comment:1.0
docker run -d --network=reddit -p 9292:9292 r2d2k/ui:1.0

> docker ps
CONTAINER ID   IMAGE               COMMAND                  CREATED         STATUS         PORTS                                       NAMES
f4d33854842a   r2d2k/ui:1.0        "puma"                   2 minutes ago   Up 2 minutes   0.0.0.0:9292->9292/tcp, :::9292->9292/tcp   flamboyant_carver
6cce41e5d607   r2d2k/comment:1.0   "puma"                   2 minutes ago   Up 2 minutes                                               distracted_haslett
b2881bbc8ea9   mongo:latest        "docker-entrypoint.s…"   3 minutes ago   Up 2 minutes   27017/tcp                                   zealous_rubin
```

Мы запускали четыре контейнера, а в работе всего три. Ищем четвёртый:
```console
> docker ps -a
CONTAINER ID   IMAGE               COMMAND                  CREATED         STATUS                     PORTS                                       NAMES
f4d33854842a   r2d2k/ui:1.0        "puma"                   4 minutes ago   Up 4 minutes               0.0.0.0:9292->9292/tcp, :::9292->9292/tcp   flamboyant_carver
6cce41e5d607   r2d2k/comment:1.0   "puma"                   4 minutes ago   Up 4 minutes                                                           distracted_haslett
4aed397da8ce   r2d2k/post:1.0      "python3 post_app.py"    4 minutes ago   Exited (1) 4 minutes ago                                               suspicious_ishizaka
b2881bbc8ea9   mongo:latest        "docker-entrypoint.s…"   4 minutes ago   Up 4 minutes               27017/tcp                                   zealous_rubin
```

Смотрим, логи:
```console
> docker logs suspicious_ishizaka
Traceback (most recent call last):
  File "post_app.py", line 7, in <module>
    from flask import Flask, request, Response, abort, logging
  File "/usr/local/lib/python3.6/site-packages/flask/__init__.py", line 19, in <module>
    from jinja2 import Markup, escape
  File "/usr/local/lib/python3.6/site-packages/jinja2/__init__.py", line 8, in <module>
    from .environment import Environment as Environment
  File "/usr/local/lib/python3.6/site-packages/jinja2/environment.py", line 15, in <module>
    from markupsafe import Markup
ImportError: cannot import name 'Markup'
```

Не найден один из модулей. Изучаем лог сборки и видим, что пакет `MarkupSafe` не смог установиться. Виной всему устаревшая версия `pip`. Добавляем в `Dockerfile` шаг обновления `pip`.
```Dockerfile
FROM python:3.6.0-alpine

WORKDIR /app
ADD . /app

RUN apk --no-cache --update add build-base && \
    pip install --upgrade pip && \
    pip install -r /app/requirements.txt && \
    apk del build-base

ENV POST_DATABASE_HOST post_db
ENV POST_DATABASE posts

ENTRYPOINT ["python3", "post_app.py"]
```

После сборки образа запускаем, проверяем, что все контейнеры на месте:
```console
> docker ps
CONTAINER ID   IMAGE               COMMAND                  CREATED          STATUS          PORTS                                       NAMES
f65870a45dd4   r2d2k/post:1.0      "python3 post_app.py"    4 seconds ago    Up 2 seconds                                                objective_darwin
f4d33854842a   r2d2k/ui:1.0        "puma"                   30 minutes ago   Up 30 minutes   0.0.0.0:9292->9292/tcp, :::9292->9292/tcp   flamboyant_carver
6cce41e5d607   r2d2k/comment:1.0   "puma"                   31 minutes ago   Up 30 minutes                                               distracted_haslett
b2881bbc8ea9   mongo:latest        "docker-entrypoint.s…"   31 minutes ago   Up 31 minutes   27017/tcp                                   zealous_rubin
```

Статистика по собранным образам:
```console
> docker images
REPOSITORY      TAG            IMAGE ID       CREATED          SIZE
r2d2k/post      1.0            f5721bc9c435   3 minutes ago    121MB
r2d2k/ui        1.0            dede21880119   42 minutes ago   772MB
r2d2k/comment   1.0            5ed27e0339a7   44 minutes ago   769MB
mongo           latest         b70536aeb250   25 hours ago     695MB
ruby            2.2            6c8e6f9667b2   4 years ago      715MB
python          3.6.0-alpine   cb178ebbf0f2   5 years ago      88.6MB
```

Проверяем, что приложение отвечает на запросы.
```console
> lynx -dump http://127.0.0.1:9292
   (BUTTON) [1]Microservices Reddit in f4d33854842a container

   Can't show blog posts, some problems with the post service. [2]Refresh?

Menu

     * [3]All posts
     * [4]New post

References

   1. http://127.0.0.1:9292/
   2. http://127.0.0.1:9292/
   3. http://127.0.0.1:9292/
   4. http://127.0.0.1:9292/new
```

Выше видно ошибку "Can't show blog posts, some problems with the post service". Вызвана она тем, что мы используем слишком старый драйвер БД.
Подробности можно узнать на официальном сайте [MongoDB](https://www.mongodb.com/docs/v6.0/release-notes/6.0-compatibility/#legacy-opcodes-removed).
Попробуем запустить БД версии ниже шестой.

```console
> docker ps
CONTAINER ID   IMAGE               COMMAND                  CREATED          STATUS          PORTS                                       NAMES
9cbb73073be2   r2d2k/ui:1.0        "puma"                   11 minutes ago   Up 11 minutes   0.0.0.0:9292->9292/tcp, :::9292->9292/tcp   cool_greider
88e8909ad1cc   r2d2k/comment:1.0   "puma"                   11 minutes ago   Up 11 minutes                                               charming_tereshkova
944b15ca7947   r2d2k/post:1.0      "python3 post_app.py"    11 minutes ago   Up 11 minutes                                               pedantic_banzai
b449cbff86b3   mongo:latest        "docker-entrypoint.s…"   11 minutes ago   Up 11 minutes   27017/tcp                                   competent_satoshi

> docker rm -f b449cbff86b3
b449cbff86b3

> docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db mongo:5.0
Unable to find image 'mongo:5.0' locally
5.0: Pulling from library/mongo
eaead16dc43b: Already exists
8a00eb9f68a0: Already exists
f683956749c5: Already exists
b33b2f05ea20: Already exists
3a342bea915a: Already exists
ff038722853e: Pull complete
a1c21bd7f89a: Pull complete
1266ae82d139: Pull complete
b95aca638f91: Pull complete
Digest: sha256:26b6f0ef7e3e0dccf5c3687c5bf61ead6a60b59cc613668eabf2ca80a6fd7c75
Status: Downloaded newer image for mongo:5.0
782a6951a7363f3920a9901ec57f4ff66bbbe950e626ecfd07c4bcbbcf0c00ab
```

Прекрасно, записи добавляются без ошибок.

**Результат №02-1:**
Собраны три образа, запущены в одной сети с базой данных.
Исправлены ошибки в работе приложения

---

**Задание №02-2:**
 - Остановите контейнеры `docker kill $(docker ps -q)`
 - Запустите контейнеры с другими сетевыми алиасами
 - Адреса для взаимодействия контейнеров задаются через ENV-переменные внутри `Dockerfile`
 - При запуске контейнеров `docker run` задайте им переменные окружения соответствующие новым сетевым алиасам, не пересоздавая образ
 - Проверьте работоспособность сервиса

**Решение №02-2:**
Соберём данные по переменным окружения контейнеров.

| **Сервис** | **Значение по умолчанию** | **Новое значение** |
|:-----:|:--------------|:----------|
|ui|POST_SERVICE_HOST post|POST_SERVICE_HOST wow_post|
|ui|COMMENT_SERVICE_HOST comment|COMMENT_SERVICE_HOST wow_comment|
|post-py|POST_DATABASE_HOST post_db|POST_DATABASE_HOST wow_post_db|
|comment|COMMENT_DATABASE_HOST comment_db|COMMENT_DATABASE_HOST wow_comment_db|

Переменные передаём в контейнеры через ключ `-e`:
```console
> docker run -d --network=reddit --network-alias=wow_post_db --network-alias=wow_comment_db mongo:5.0
> docker run -d --network=reddit --network-alias=wow_post -e POST_DATABASE_HOST=wow_post_db r2d2k/post:1.0
> docker run -d --network=reddit --network-alias=wow_comment -e COMMENT_DATABASE_HOST=wow_comment_db r2d2k/comment:1.0
> docker run -d --network=reddit -p 9292:9292 -e POST_SERVICE_HOST=wow_post -e COMMENT_SERVICE_HOST=wow_comment r2d2k/ui:1.0
```

Приложение работает:
```console
> docker ps
CONTAINER ID   IMAGE               COMMAND                  CREATED          STATUS         PORTS                                       NAMES
1825f9cd5485   r2d2k/ui:1.0        "puma"                   9 seconds ago    Up 8 seconds   0.0.0.0:9292->9292/tcp, :::9292->9292/tcp   inspiring_satoshi
02c2bc5b5865   r2d2k/comment:1.0   "puma"                   9 seconds ago    Up 8 seconds                                               tender_colden
9305ac7e7bd7   r2d2k/post:1.0      "python3 post_app.py"    10 seconds ago   Up 9 seconds                                               silly_ishizaka
7d4429630943   mongo:5.0           "docker-entrypoint.s…"   10 seconds ago   Up 9 seconds   27017/tcp                                   zen_boyd
```

На запросы отвечает:
```console
> lynx -dump http://127.0.0.1:9292
   (BUTTON) [1]Microservices Reddit in 1825f9cd5485 container

Menu

     * [2]All posts
     * [3]New post

References

   1. http://127.0.0.1:9292/
   2. http://127.0.0.1:9292/
   3. http://127.0.0.1:9292/new

```

**Результат №02-2:**
Контейнеры запущены с другими сетевыми алиасами без пересборки контейнеров.
Имена соседних контейнеров передаём через переменные окружения.

---

**Результат №02-1:**
Собраны три образа, запущены в одной сети с базой данных.
Исправлены ошибки в работе приложения

---

**Задание №02-3:**
Оптимизация размера образов.

 - Попробуйте собрать образ на основе Alpine Linux
 - Придумайте еще способы уменьшить размер образа
 - Можете реализовать как только для `ui`, так и для `post`, `comment`
 - Все оптимизации проводите в Dockerfile сервиса. Дополнительные варианты решения уменьшения размера образов можете оформить в виде файла Dockerfile.<цифра> в папке сервиса

**Решение №02-3:**
Исходные данные:
```console
> docker images
REPOSITORY      TAG            IMAGE ID       CREATED             SIZE
r2d2k/post      1.0            f5721bc9c435   About an hour ago   121MB
r2d2k/ui        1.0            dede21880119   2 hours ago         772MB
r2d2k/comment   1.0            5ed27e0339a7   2 hours ago         769MB
mongo           5.0            cb51c58bc695   26 hours ago        698MB
ruby            2.2            6c8e6f9667b2   4 years ago         715MB
python          3.6.0-alpine   cb178ebbf0f2   5 years ago         88.6MB
```

Обновим `ui/Dockerfile`:
```patch
--- a/src/ui/Dockerfile
+++ b/src/ui/Dockerfile
@@ -1,5 +1,7 @@
-FROM ruby:2.2
-RUN apt-get update -qq && apt-get install -y build-essential
+FROM ubuntu:16.04
+RUN apt-get update \
+    && apt-get install -y ruby-full ruby-dev build-essential \
+    && gem install bundler --no-ri --no-rdoc

 ENV APP_HOME /app
 RUN mkdir $APP_HOME
```

Собираем образ заново, смотрим, как изменился размер:
```console
> docker build -t r2d2k/ui:2.0 ./ui
...
...
...

> docker images r2d2k/ui
REPOSITORY   TAG       IMAGE ID       CREATED         SIZE
r2d2k/ui     2.0       538bcf31c707   3 minutes ago   464MB
r2d2k/ui     1.0       dede21880119   2 hours ago     772MB
```

Переведём образ `ui` на `Alpine Linux`.
Так, как наше приложение скончается в мучениях, если мы попробуем запустить его на новой версии `ruby`, то придётся заняться археологией.
Идём изучать [пакеты Alpine Linux](https://pkgs.alpinelinux.org/packages) на предмет ruby2.3. Подходящую версию находим в `Alpine Linux v3.4`.

Готовим `Dockerfile.1`:
```patch
--- ./ui/Dockerfile     2022-10-26 19:43:40.061221284 +0000
+++ ./ui/Dockerfile.1   2022-10-26 20:24:50.443688442 +0000
@@ -1,7 +1,5 @@
-FROM ubuntu:16.04
-RUN apt-get update \
-    && apt-get install -y ruby-full ruby-dev build-essential \
-    && gem install bundler --no-ri --no-rdoc
+FROM alpine:3.4
+RUN apk update && apk add ruby-bundler ruby-json ruby-dev build-base

 ENV APP_HOME /app
 RUN mkdir $APP_HOME
```

Так как версия очень старая, то она испытывает проблемы с проверкой сертификатов. Переводим `Gemfile` с `https` на `http`.
Смотрим, что получается по размеру образов:
```console
> docker images r2d2k/ui
REPOSITORY   TAG          IMAGE ID       CREATED             SIZE
r2d2k/ui     3.0-alpine   59201283bad6   18 seconds ago      192MB
r2d2k/ui     2.0          538bcf31c707   About an hour ago   464MB
r2d2k/ui     1.0          dede21880119   3 hours ago         772MB
```

Можно выкинуть одну команду:
```patch
--- ./ui/Dockerfile.1   2022-10-26 20:48:18.903089747 +0000
+++ ./ui/Dockerfile.2   2022-10-26 20:51:59.482139742 +0000
@@ -2,7 +2,6 @@
 RUN apk update && apk add ruby-bundler ruby-json ruby-dev build-base

 ENV APP_HOME /app
-RUN mkdir $APP_HOME

 WORKDIR $APP_HOME
 ADD Gemfile* $APP_HOME/
```

После сборки образа размер не изменился:
```console
> docker images r2d2k/ui
REPOSITORY   TAG          IMAGE ID       CREATED             SIZE
r2d2k/ui     3.1-alpine   735b5108b497   2 minutes ago       192MB
r2d2k/ui     3.0-alpine   59201283bad6   5 minutes ago       192MB
r2d2k/ui     2.0          538bcf31c707   About an hour ago   464MB
r2d2k/ui     1.0          dede21880119   3 hours ago         772MB
```

Переведём `comment` на `Alpine Linux`:
```patch
--- ./comment/Dockerfile        2022-10-26 05:42:22.019148857 +0000
+++ ./comment/Dockerfile.1      2022-10-26 21:13:11.927702796 +0000
@@ -1,5 +1,5 @@
-FROM ruby:2.2
-RUN apt-get update -qq && apt-get install -y build-essential
+FROM alpine:3.4
+RUN apk update && apk add ruby-bundler ruby-json ruby-dev build-base

 ENV APP_HOME /app
 RUN mkdir $APP_HOME
```

Размер образа значительно уменьшился:
```console
> docker images r2d2k/comment
REPOSITORY      TAG          IMAGE ID       CREATED              SIZE
r2d2k/comment   2.2-alpine   e3c05b3dada6   44 seconds ago       189MB
r2d2k/comment   2.0-alpine   e0b20e2aad8e   About a minute ago   189MB
r2d2k/comment   1.0          5ed27e0339a7   4 hours ago          769MB
```

Запустим приложение:
```console
> docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db mongo:5.0
> docker run -d --network=reddit --network-alias=post r2d2k/post:1.0
> docker run -d --network=reddit --network-alias=comment r2d2k/comment:2.2-alpine
> docker run -d --network=reddit -p 9292:9292 r2d2k/ui:3.1-alpine

> docker ps
CONTAINER ID   IMAGE                      COMMAND                  CREATED          STATUS          PORTS                                       NAMES
8711fb05d8a0   r2d2k/ui:3.1-alpine        "puma"                   9 seconds ago    Up 7 seconds    0.0.0.0:9292->9292/tcp, :::9292->9292/tcp   quirky_archimedes
5fe2f10847be   r2d2k/comment:2.2-alpine   "puma"                   11 seconds ago   Up 9 seconds                                                focused_matsumoto
cb5cbe4136ff   r2d2k/post:1.0             "python3 post_app.py"    13 seconds ago   Up 11 seconds                                               reverent_franklin
d34d689c91c1   mongo:5.0                  "docker-entrypoint.s…"   18 seconds ago   Up 13 seconds   27017/tcp                                   blissful_chandrasekhar
```

Проверим, что всё работает:
```console
> lynx -dump http://127.0.0.1:9292
   (BUTTON) [1]Microservices Reddit in 8711fb05d8a0 container

Menu

     * [2]All posts
     * [3]New post

References

   1. http://127.0.0.1:9292/
   2. http://127.0.0.1:9292/
   3. http://127.0.0.1:9292/new
```

Всё работает, но список постов пуст. При перезапуске контейнера с базой данных все записи пропали.
Для постоянного хранения данных контейнера можно использовать `Docker volume`.

Создаём `Docker volume`, перезапускаем контейнер базы с ним:
```console
> docker volume create reddit_db
reddit_db

> docker rm -f d34d689c91c1
d34d689c91c1

> docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db -v reddit_db:/data/db mongo:5.0

> docker ps
CONTAINER ID   IMAGE                      COMMAND                  CREATED          STATUS          PORTS                                       NAMES
fa116790680b   mongo:5.0                  "docker-entrypoint.s…"   20 seconds ago   Up 18 seconds   27017/tcp                                   epic_galois
8711fb05d8a0   r2d2k/ui:3.1-alpine        "puma"                   8 minutes ago    Up 8 minutes    0.0.0.0:9292->9292/tcp, :::9292->9292/tcp   quirky_archimedes
5fe2f10847be   r2d2k/comment:2.2-alpine   "puma"                   8 minutes ago    Up 8 minutes                                                focused_matsumoto
cb5cbe4136ff   r2d2k/post:1.0             "python3 post_app.py"    8 minutes ago    Up 8 minutes                                                reverent_franklin
```

Создадим запись в приложении через браузер, проверим, что запись на месте:
```console
> lynx -dump http://127.0.0.1:9292
   (BUTTON) [1]Microservices Reddit in 8711fb05d8a0 container
   (BUTTON)
0
   (BUTTON)

[2]Yandex
26-10-2022
21:38

   [3]Go to the link

Menu

     * [4]All posts
     * [5]New post

References

   1. http://127.0.0.1:9292/
   2. http://127.0.0.1:9292/post/6359a8c9c4c60c000e04e36e
   3. http://yandex.ru/
   4. http://127.0.0.1:9292/
   5. http://127.0.0.1:9292/new

```

Перезапустим контейнер с базой, проверим, что запись не исчезла:
```console
> docker stop fa116790680b
fa116790680b

> docker start fa116790680b
fa116790680b

> lynx -dump http://127.0.0.1:9292
   (BUTTON) [1]Microservices Reddit in 8711fb05d8a0 container
   (BUTTON)
0
   (BUTTON)

[2]Yandex
26-10-2022
21:38

   [3]Go to the link

Menu

     * [4]All posts
     * [5]New post

References

   1. http://127.0.0.1:9292/
   2. http://127.0.0.1:9292/post/6359a8c9c4c60c000e04e36e
   3. http://yandex.ru/
   4. http://127.0.0.1:9292/
   5. http://127.0.0.1:9292/new
```

Всё работает.

**Результат №02-3:**
 - Мы уменьшили размер образа за счёт использования более компактного базового образа
 - Мы сохранили данные контейнера между перезапусками, за счёт использования `Docker volume`

---

## 03 - Docker: сети, docker-compose

**Задание №03-1:**
 - Работа с сетями в `Docker`: `none`, `host`, `bridge`
 - Использование `docker-compose`

**Решение №03-1:**

Создаём новую ветку `docker-4`, работаем в каталоге `src`. За базу берём образ `joffotron/docker-net-tools`, так как он содержит все необходимые сетевые утилиты.
Первый запуск, при этом укажем сеть в `none`:
```console
> docker run -it --rm --network none joffotron/docker-net-tools -c ifconfig
Unable to find image 'joffotron/docker-net-tools:latest' locally
latest: Pulling from joffotron/docker-net-tools
3690ec4760f9: Pull complete
0905b79e95dc: Pull complete
Digest: sha256:5752abdc4351a75e9daec681c1a6babfec03b317b273fc56f953592e6218d5b5
Status: Downloaded newer image for joffotron/docker-net-tools:latest

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
```

Видно, что `loopback` это единственный интерфейс, доступный контейнеру.
Попробуем запустить контейнер, подключив его к сети хоста:
```console
> docker run -ti --rm --network host joffotron/docker-net-tools -c ifconfig
br-da565863ffc2 Link encap:Ethernet  HWaddr 02:42:63:4F:AD:03
          inet addr:172.18.0.1  Bcast:172.18.255.255  Mask:255.255.0.0
          inet6 addr: fe80::42:63ff:fe4f:ad03%32722/64 Scope:Link
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:7289 errors:0 dropped:0 overruns:0 frame:0
          TX packets:7270 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:475691 (464.5 KiB)  TX bytes:812092 (793.0 KiB)

docker0   Link encap:Ethernet  HWaddr 02:42:6F:C8:2F:52
          inet addr:172.17.0.1  Bcast:172.17.255.255  Mask:255.255.0.0
          inet6 addr: fe80::42:6fff:fec8:2f52%32722/64 Scope:Link
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:370721 errors:0 dropped:0 overruns:0 frame:0
          TX packets:833566 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:21309396 (20.3 MiB)  TX bytes:1496060294 (1.3 GiB)

eth0      Link encap:Ethernet  HWaddr B6:70:98:38:A4:3F
          inet addr:192.168.10.96  Bcast:192.168.10.255  Mask:255.255.255.0
          inet6 addr: fe80::b470:98ff:fe38:a43f%32722/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:5056995 errors:0 dropped:161 overruns:0 frame:0
          TX packets:877421 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:3424447104 (3.1 GiB)  TX bytes:327494245 (312.3 MiB)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1%32722/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:2048 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2048 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:329008 (321.2 KiB)  TX bytes:329008 (321.2 KiB)
```

Сравним с интерфейсами на локальном хосте:
```console
> ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0@if17: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
    link/ether b6:70:98:38:a4:3f brd ff:ff:ff:ff:ff:ff link-netnsid 0
3: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default
    link/ether 02:42:6f:c8:2f:52 brd ff:ff:ff:ff:ff:ff
46: br-da565863ffc2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default
    link/ether 02:42:63:4f:ad:03 brd ff:ff:ff:ff:ff:ff
```

Видим, что все локальные интерфейсы доступны и внутри контейнера.
Попробуем несколько раз запустить контейнер с использованием сети хоста:
```console
> docker run --network host -d nginx
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
e9995326b091: Pull complete
71689475aec2: Pull complete
f88a23025338: Pull complete
0df440342e26: Pull complete
eef26ceb3309: Pull complete
8e3ed6a9e43a: Pull complete
Digest: sha256:47a8d86548c232e44625d813b45fd92e81d07c639092cd1f9a49d98e1fb5f737
Status: Downloaded newer image for nginx:latest
f75b0c9f9db9500e859873fc80caeb12b2135dfce7b539f0f625f3529a3d1e56

> docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS     NAMES
f75b0c9f9db9   nginx     "/docker-entrypoint.…"   4 seconds ago   Up 3 seconds             interesting_spence

> docker run --network host -d nginx
5e7cfb2e810accd7cc7c73ee27f4cd129c5e4d49a36feb6eacf118007a692c40

> docker run --network host -d nginx
b77474b4f4560acc3508a17d5507115f4efed447c58689f9c8c2a40310a84ca6

> docker ps -a
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS                      PORTS     NAMES
b77474b4f456   nginx     "/docker-entrypoint.…"   20 seconds ago   Exited (1) 17 seconds ago             confident_black
5e7cfb2e810a   nginx     "/docker-entrypoint.…"   22 seconds ago   Exited (1) 19 seconds ago             affectionate_keller
f75b0c9f9db9   nginx     "/docker-entrypoint.…"   29 seconds ago   Up 28 seconds                         interesting_spence
```

В работе остаётся только контейнер, который был запущен первым. Почему?
```console
> docker logs b77474b4f456
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/13/27 04:40:46 [emerg] 1#1: bind() to 0.0.0.0:80 failed (98: Address already in use)
nginx: [emerg] bind() to 0.0.0.0:80 failed (98: Address already in use)
2022/13/27 04:40:46 [emerg] 1#1: bind() to [::]:80 failed (98: Address already in use)
nginx: [emerg] bind() to [::]:80 failed (98: Address already in use)
2022/13/27 04:40:46 [notice] 1#1: try again to bind() after 500ms
2022/13/27 04:40:46 [emerg] 1#1: bind() to 0.0.0.0:80 failed (98: Address already in use)
nginx: [emerg] bind() to 0.0.0.0:80 failed (98: Address already in use)
2022/13/27 04:40:46 [emerg] 1#1: bind() to [::]:80 failed (98: Address already in use)
nginx: [emerg] bind() to [::]:80 failed (98: Address already in use)
2022/13/27 04:40:46 [notice] 1#1: try again to bind() after 500ms
2022/13/27 04:40:46 [emerg] 1#1: bind() to 0.0.0.0:80 failed (98: Address already in use)
nginx: [emerg] bind() to 0.0.0.0:80 failed (98: Address already in use)
2022/13/27 04:40:46 [emerg] 1#1: bind() to [::]:80 failed (98: Address already in use)
nginx: [emerg] bind() to [::]:80 failed (98: Address already in use)
2022/13/27 04:40:46 [notice] 1#1: try again to bind() after 500ms
2022/13/27 04:40:46 [emerg] 1#1: bind() to 0.0.0.0:80 failed (98: Address already in use)
nginx: [emerg] bind() to 0.0.0.0:80 failed (98: Address already in use)
2022/13/27 04:40:46 [emerg] 1#1: bind() to [::]:80 failed (98: Address already in use)
nginx: [emerg] bind() to [::]:80 failed (98: Address already in use)
2022/13/27 04:40:46 [notice] 1#1: try again to bind() after 500ms
2022/13/27 04:40:46 [emerg] 1#1: bind() to 0.0.0.0:80 failed (98: Address already in use)
nginx: [emerg] bind() to 0.0.0.0:80 failed (98: Address already in use)
2022/13/27 04:40:46 [emerg] 1#1: bind() to [::]:80 failed (98: Address already in use)
nginx: [emerg] bind() to [::]:80 failed (98: Address already in use)
2022/13/27 04:40:46 [notice] 1#1: try again to bind() after 500ms
2022/13/27 04:40:46 [emerg] 1#1: still could not bind()
nginx: [emerg] still could not bind()
```

Всё правильно, порт уже занят первым контейнером. Сеть хоста одна, нужно следить, чтобы порты контейнеров не пересекались.
При запуске контейнера с сетью `none` каждый раз создаётся отдельное пространство имён, чего не происходит при использовании сети `host`.

Создадим сеть с драйвером `bridge`:
```console
> docker network create reddit --driver bridge
1e340640165944261656d5af9ccc5661d98de29dd56749f197f2497d3985726e

> docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
318eb18767d9   bridge    bridge    local
f9d28c74ca97   host      host      local
6a9dc35c3605   none      null      local
1e3406401659   reddit    bridge    local
```

Образов у нас много, поэтому, чтобы не путаться, присвоим текущим образам тег `latest`:
```console
> docker images
REPOSITORY                   TAG            IMAGE ID       CREATED         SIZE
r2d2k/comment                2.2-alpine     e3c05b3dada6   8 hours ago     189MB
r2d2k/comment                2.0-alpine     e0b20e2aad8e   8 hours ago     189MB
r2d2k/ui                     3.1-alpine     735b5108b497   8 hours ago     192MB
r2d2k/ui                     3.0-alpine     59201283bad6   8 hours ago     192MB
r2d2k/ui                     2.0            538bcf31c707   9 hours ago     464MB
r2d2k/post                   1.0            f5721bc9c435   11 hours ago    121MB
r2d2k/ui                     1.0            dede21880119   11 hours ago    772MB
r2d2k/comment                1.0            5ed27e0339a7   11 hours ago    769MB
mongo                        5.0            cb51c58bc695   35 hours ago    698MB
nginx                        latest         76c69feac34e   43 hours ago    142MB
ubuntu                       18.04          71eaf13299f4   2 days ago      63.1MB
ubuntu                       16.04          b6f507652425   14 months ago   135MB
alpine                       3.4            b7c5ffe56db7   3 years ago     4.81MB
ruby                         2.2            6c8e6f9667b2   4 years ago     715MB
python                       3.6.0-alpine   cb178ebbf0f2   5 years ago     88.6MB
joffotron/docker-net-tools   latest         b97158e38a06   5 years ago     10.6MB

> docker images r2d2k/comment
REPOSITORY      TAG          IMAGE ID       CREATED        SIZE
r2d2k/comment   2.2-alpine   e3c05b3dada6   8 hours ago    189MB
r2d2k/comment   2.0-alpine   e0b20e2aad8e   8 hours ago    189MB
r2d2k/comment   1.0          5ed27e0339a7   11 hours ago   769MB

> docker tag r2d2k/comment:2.2-alpine r2d2k/comment:latest

> docker images r2d2k/ui
REPOSITORY   TAG          IMAGE ID       CREATED        SIZE
r2d2k/ui     3.1-alpine   735b5108b497   8 hours ago    192MB
r2d2k/ui     3.0-alpine   59201283bad6   8 hours ago    192MB
r2d2k/ui     2.0          538bcf31c707   9 hours ago    464MB
r2d2k/ui     1.0          dede21880119   11 hours ago   772MB

> docker tag r2d2k/ui:3.1-alpine r2d2k/ui:latest

> docker images r2d2k/post
REPOSITORY   TAG       IMAGE ID       CREATED        SIZE
r2d2k/post   1.0       f5721bc9c435   11 hours ago   121MB

> docker tag r2d2k/post:1.0 r2d2k/post:latest
```

Запустим наше приложение с использованием созданной сети:
```console
> docker run -d --network=reddit mongo:5.0
> docker run -d --network=reddit r2d2k/post:latest
> docker run -d --network=reddit r2d2k/comment:latest
> docker run -d --network=reddit -p 9292:9292 r2d2k/ui:latest
```

Проверим, что вышло:
``` console
> docker ps -a
CONTAINER ID   IMAGE                  COMMAND                  CREATED          STATUS          PORTS                                       NAMES
6dd3cdd87d1a   r2d2k/ui:latest        "puma"                   5 seconds ago    Up 3 seconds    0.0.0.0:9292->9292/tcp, :::9292->9292/tcp   optimistic_dijkstra
4684755c0cda   r2d2k/comment:latest   "puma"                   11 seconds ago   Up 9 seconds                                                boring_bhabha
13e02ac3b982   r2d2k/post:latest      "python3 post_app.py"    17 seconds ago   Up 16 seconds                                               compassionate_albattani
8154487d77e9   mongo:5.0              "docker-entrypoint.s…"   25 seconds ago   Up 24 seconds   27017/tcp                                   magical_antonelli

> lynx -dump http://127.0.0.1:9292
   (BUTTON) [1]Microservices Reddit in 6dd3cdd87d1a container

   Can't show blog posts, some problems with the post service. [2]Refresh?

Menu

     * [3]All posts
     * [4]New post

References

   1. http://127.0.0.1:9292/
   2. http://127.0.0.1:9292/
   3. http://127.0.0.1:9292/
   4. http://127.0.0.1:9292/new

```

Контейнеры запущены, но приложение не работает. Контейнеры обращаются к соседям по определённым именам, о которых процессу `docker` ничего неизвестно.

Перезапустим контейнеры с указанием имён:
```console
> bash -c 'docker rm -f $(docker ps -q -a)'

> docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db mongo:5.0
> docker run -d --network=reddit --network-alias=post r2d2k/post:latest
> docker run -d --network=reddit --network-alias=comment r2d2k/comment:latest
> docker run -d --network=reddit -p 9292:9292 r2d2k/ui:latest
> lynx -dump http://127.0.0.1:9292
   (BUTTON) [1]Microservices Reddit in fa81d2be7c57 container

Menu

     * [2]All posts
     * [3]New post

References

   1. http://127.0.0.1:9292/
   2. http://127.0.0.1:9292/
   3. http://127.0.0.1:9292/new
```

Теперь всё в порядке, контейнеры видят соседей.
Давайте сделаем так, чтобы `ui` не видели друг друга `db`, разнесём их по разным сетям.
```console
                   ┌──────────────────────────────────┐
                   │                       back_net   │
┌──────────────────┼──────────────┐                   │
│    front_net     │              │                   │
│                  │  ┌─────────┐ │                   │
│                  │  │ comment │ │                   │
│                  │  └─────────┘ │                   │
│                  │              │                   │
│   ┌────────┐     │              │        ┌──────┐   │
│   │   ui   │     │              │        │  db  │   │
│   └────────┘     │              │        └──────┘   │
│                  │   ┌──────┐   │                   │
│                  │   │ post │   │                   │
│                  │   └──────┘   │                   │
│                  │              │                   │
└──────────────────┼──────────────┘                   │
                   │                                  │
                   └──────────────────────────────────┘
```

Останавливаем все контейнеры и создаём две сети:
```console
> bash -c 'docker rm -f $(docker ps -q -a)'
> docker network create back_net --subnet=10.0.2.0/24
> docker network create front_net --subnet=10.0.1.0/24
> docker network ls
NETWORK ID     NAME        DRIVER    SCOPE
182b52db77ae   back_net    bridge    local
318eb18767d9   bridge      bridge    local
19428cd51adb   front_net   bridge    local
f9d28c74ca97   host        host      local
6a9dc35c3605   none        null      local
5e20b3a67720   reddit      bridge    local
```

Запускаем контейнеры с указанием сетей:
```config
> docker run -d --network=back_net --name=mongo_db --network-alias=post_db --network-alias=comment_db mongo:5.0
> docker run -d --network=back_net --name=post r2d2k/post:latest
> docker run -d --network=back_net --name=comment r2d2k/comment:latest
> docker run -d --network=front_net --name ui -p 9292:9292 r2d2k/ui:latest

> lynx -dump http://127.0.0.1:9292
   (BUTTON) [1]Microservices Reddit in a99ed4847758 container

   Can't show blog posts, some problems with the post service. [2]Refresh?

Menu

     * [3]All posts
     * [4]New post

References

   1. http://127.0.0.1:9292/
   2. http://127.0.0.1:9292/
   3. http://127.0.0.1:9292/
   4. http://127.0.0.1:9292/new
```

При инициализации контейнера к нему можно подключить только одну сеть. Остальные сети подключаются после старта.
```console
> docker ps
CONTAINER ID   IMAGE                  COMMAND                  CREATED          STATUS          PORTS                                       NAMES
a99ed4847758   r2d2k/ui:latest        "puma"                   29 seconds ago   Up 28 seconds   0.0.0.0:9292->9292/tcp, :::9292->9292/tcp   ui
393791b22e4f   r2d2k/comment:latest   "puma"                   37 seconds ago   Up 36 seconds                                               comment
4a210b2c1f85   r2d2k/post:latest      "python3 post_app.py"    44 seconds ago   Up 43 seconds                                               post
761672a22f37   mongo:5.0              "docker-entrypoint.s…"   53 seconds ago   Up 52 seconds   27017/tcp                                   mongo_db

> docker network connect front_net 305bfd5b67a2
> docker network connect front_net 80343670ae2b
> lynx -dump http://127.0.0.1:9292
   (BUTTON) [1]Microservices Reddit in a99ed4847758 container

Menu

     * [2]All posts
     * [3]New post

References

   1. http://127.0.0.1:9292/
   2. http://127.0.0.1:9292/
   3. http://127.0.0.1:9292/new
```

Результат получен, пара контейнеров работает в двух сетях, а `ui` и `db` разнесены.
Посмотрим поближе на сеть контейнеров, для этого нам нужен инструмент: `sudo apt install bridge-utils`.

Вот список сетей `docker` с драйвером `bridge`:
```console
)> docker network ls --filter driver=bridge
NETWORK ID     NAME        DRIVER    SCOPE
182b52db77ae   back_net    bridge    local
318eb18767d9   bridge      bridge    local
19428cd51adb   front_net   bridge    local
5e20b3a67720   reddit      bridge    local
```

А вот список бриджей локальной системы:
```console
> ip link | grep ": br-" | cut -d":" -f2
 br-5e20b3a67720
 br-182b52db77ae
 br-19428cd51adb
```

Посмотрим на эти интерфейсы более подробно:
```console
> brctl show
bridge name             bridge id               STP enabled     interfaces
br-182b52db77ae         8000.0242a04a32f1       no              vethc13f63f
                                                                vethcf98cab
                                                                vethd753d3f
br-19428cd51adb         8000.024237fcf040       no              veth7727a7b
                                                                vethbc08305
                                                                vethf8df15d
br-5e20b3a67720         8000.0242d7c4ae2a       no
docker0                 8000.02426fc82f52       no
```

Видно, что у каждого бриджа есть по три интерфейса. Один смотрит в сеть хоста, остальные в контейнеры.

Поднимемся на уровень повыше:
```console
> sudo iptables -nL -t nat
Chain PREROUTING (policy ACCEPT)
target     prot opt source               destination
DOCKER     all  --  0.0.0.0/0            0.0.0.0/0            ADDRTYPE match dst-type LOCAL

Chain INPUT (policy ACCEPT)
target     prot opt source               destination

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination
DOCKER     all  --  0.0.0.0/0           !127.0.0.0/8          ADDRTYPE match dst-type LOCAL

Chain POSTROUTING (policy ACCEPT)
target     prot opt source               destination
MASQUERADE  all  --  10.0.1.0/24          0.0.0.0/0
MASQUERADE  all  --  10.0.2.0/24          0.0.0.0/0
MASQUERADE  all  --  172.20.0.0/16        0.0.0.0/0
MASQUERADE  all  --  172.17.0.0/16        0.0.0.0/0
MASQUERADE  tcp  --  10.0.1.2             10.0.1.2             tcp dpt:9292

Chain DOCKER (2 references)
target     prot opt source               destination
RETURN     all  --  0.0.0.0/0            0.0.0.0/0
RETURN     all  --  0.0.0.0/0            0.0.0.0/0
RETURN     all  --  0.0.0.0/0            0.0.0.0/0
RETURN     all  --  0.0.0.0/0            0.0.0.0/0
DNAT       tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:9292 to:10.0.1.2:9292
```

В цепочке `POSTROUTING` видим правила для наших бриджей.
В цепочке `DOCKER` видим правила, перенаправляющие трафик внутрь контейнера.
В этом также участвуют `docker-proxy`:
```console
> ps ax | grep docker-proxy
 482048 ?        Sl     0:00 /usr/bin/docker-proxy -proto tcp -host-ip 0.0.0.0 -host-port 9292 -container-ip 10.0.1.2 -container-port 9292
 482055 ?        Sl     0:00 /usr/bin/docker-proxy -proto tcp -host-ip :: -host-port 9292 -container-ip 10.0.1.2 -container-port 9292
```

**Результат №03-1:**
 - Рассмотрели различные виды сетей
 - Использовали несколько способов организации связей между контейнерами
 - Увидели, как сети контейнеров связаны с реальными сетями хоста

---

**Задание №03-2**
 - Установить docker-compose на локальную машину
 - Собрать образы приложения reddit с помощью docker-compose
 - Запустить приложение reddit с помощью docker-compose

**Решение №03-2**

Для начала удалим следы от предыдущих экспериментов:
```console
> bash -c 'docker rm -f $(docker ps -q -a)'
a99ed4847758
393791b22e4f
4a210b2c1f85
761672a22f37

> bash -c 'docker volume rm $(docker volume ls -q)'
16b9634e7c9e63015fae0334498af00b269f9e0b69e75a4852b561a11828fb2e
793a977e33aedc9caa4706010bd16169bb8156a8f6e2b2a35f15d4a397e2d45d
74873ffc81d15f16ee620329a8991d04fee6e63ea9fb9e6e7be6525e881d64ff
a04f681d79f6049fd2385b57acd741d00275bc8240ea45dad0e4a5328cafe2f7
cd233e3af859ef9532e80968e66e5fae6eda80a17792ecb3e2ceb3a566a33aa9
da63807876f436a5c5e730f3e38c115f1642547b5a143c8cbeef3efc0a60c311
e9176854722a6e2e75bcb8fa12e72bdcffb403914cf7a167b1c515fc6d1ba1be
efb6333e7649a436a6125d47b3f0ab0207e722ad7023f44df42e84e3f64880ad
```

Проверим, что `docker-compose` у нас установлен:
```console
> docker compose version
Docker Compose version v2.6.0
```

В каталоге `src` создаём `docker-compose.yml`:
```yaml
version: '3.3'
services:
  post_db:
    image: mongo:3.2
    volumes:
      - post_db:/data/db
    networks:
      - reddit
  ui:
    build: ./ui
    image: ${USERNAME}/ui:1.0
    ports:
      - 9292:9292/tcp
    networks:
      - reddit
  post:
    build: ./post-py
    image: ${USERNAME}/post:1.0
    networks:
      - reddit
  comment:
    build: ./comment
    image: ${USERNAME}/comment:1.0
    networks:
      - reddit

volumes:
  post_db:

networks:
  reddit:
```

Экспортируем переменную окружения с нашим логином, запускаем приложение:
```console
> export USERNAME=r2d2k
> docker compose up -d
[+] Running 12/12
 ⠿ post_db Pulled                                                                                                                                               14.4s
   ⠿ a92a4af0fb9c Pull complete                                                                                                                                  2.9s
   ⠿ 74a2c7f3849e Pull complete                                                                                                                                  5.4s
   ⠿ 927b52ab29bb Pull complete                                                                                                                                  6.2s
   ⠿ e941def14025 Pull complete                                                                                                                                  6.4s
   ⠿ be6fce289e32 Pull complete                                                                                                                                  6.5s
   ⠿ f6d82baac946 Pull complete                                                                                                                                  6.7s
   ⠿ 7c1a640b9ded Pull complete                                                                                                                                  6.8s
   ⠿ e8b2fc34c941 Pull complete                                                                                                                                 12.0s
   ⠿ 1fd822faa46a Pull complete                                                                                                                                 12.1s
   ⠿ 61ba5f01559c Pull complete                                                                                                                                 12.3s
   ⠿ db344da27f9a Pull complete                                                                                                                                 12.3s
[+] Running 6/6
 ⠿ Network src_reddit       Created                                                                                                                              0.0s
 ⠿ Volume "src_post_db"     Created                                                                                                                              0.0s
 ⠿ Container src-post-1     Started                                                                                                                              2.9s
 ⠿ Container src-post_db-1  Started                                                                                                                              2.9s
 ⠿ Container src-comment-1  Started                                                                                                                              2.7s
 ⠿ Container src-ui-1       Started                                                                                                                              2.7s

> docker compose ps
NAME                COMMAND                  SERVICE             STATUS              PORTS
src-comment-1       "puma"                   comment             running
src-post-1          "python3 post_app.py"    post                running
src-post_db-1       "docker-entrypoint.s…"   post_db             running             27017/tcp
src-ui-1            "puma"                   ui                  running             0.0.0.0:9292->9292/tcp, :::9292->9292/tcp

> lynx -dump http://127.0.0.1:9292
   (BUTTON) [1]Microservices Reddit in 8284fef7b90b container

Menu

     * [2]All posts
     * [3]New post

References

   1. http://127.0.0.1:9292/
   2. http://127.0.0.1:9292/
   3. http://127.0.0.1:9292/new
```

Образы были скачаны, все необходимые объекты созданы, контейнеры запущены и отвечают на запросы.

Чтобы организовать разделение `ui` и `db` по сетям, мы приводим `docker-compose.yml` к следующему виду:
```yaml
version: '3.3'
services:
  post_db:
    image: mongo:3.2
    volumes:
      - post_db:/data/db
    networks:
      - back_net

  ui:
    build: ./ui
    image: ${USERNAME}/ui:1.0
    ports:
      - 9292:9292/tcp
    networks:
      - front_net

  post:
    build: ./post-py
    image: ${USERNAME}/post:1.0
    networks:
      - back_net
      - front_net

  comment:
    build: ./comment
    image: ${USERNAME}/comment:1.0
    networks:
      - back_net
      - front_net

volumes:
  post_db:

networks:
  front_net:
    driver: bridge
    ipam:
      config:
        - subnet: 10.0.1.0/24

  back_net:
    driver: bridge
    ipam:
      config:
        - subnet: 10.0.2.0/24
```

Запускаем, проверяем:
```console
> docker compose up -d
[+] Running 6/6
 ⠿ Network src_back_net     Created                                        0.0s
 ⠿ Network src_front_net    Created                                        0.1s
 ⠿ Container src-ui-1       Started                                        1.0s
 ⠿ Container src-post-1     Started                                        1.2s
 ⠿ Container src-comment-1  Started                                        1.4s
 ⠿ Container src-post_db-1  Started                                        1.1s

> docker compose ps
NAME                COMMAND                  SERVICE             STATUS              PORTS
src-comment-1       "puma"                   comment             running
src-post-1          "python3 post_app.py"    post                running
src-post_db-1       "docker-entrypoint.s…"   post_db             running             27017/tcp
src-ui-1            "puma"                   ui                  running             0.0.0.0:9292->9292/tcp, :::9292->9292/tcp

> lynx -dump http://127.0.0.1:9292
   (BUTTON) [1]Microservices Reddit in fb4caa51ed88 container

Menu

     * [2]All posts
     * [3]New post

References

   1. http://127.0.0.1:9292/
   2. http://127.0.0.1:9292/
   3. http://127.0.0.1:9292/new
```

Для того, чтобы не задавать переменные окружения перед запуском приложений мы можем поместить их в файл `.env`. Вынесем все используемые переменные:
```ini
USERNAME=r2d2k

# From comment image
COMMENT_DATABASE_HOST=comment_db
COMMENT_DATABASE=comments

# From post image
POST_DATABASE_HOST=post_db
POST_DATABASE=posts

# From ui image
POST_SERVICE_HOST=post
POST_SERVICE_PORT=5000
COMMENT_SERVICE_HOST=comment
COMMENT_SERVICE_PORT=9292

# Web UI Port
UI_PORT=3333
```

Для изменения порта веб-приложения введём новую переменную `UI_PORT`, внесём изменения в `docker-compose.yml`:
```patch
--- a/src/docker-compose.yml
+++ b/src/docker-compose.yml
@@ -11,7 +11,7 @@ services:
     build: ./ui
     image: ${USERNAME}/ui:1.0
     ports:
-      - 9292:9292/tcp
+      - ${UI_PORT}:9292/tcp
     networks:
       - front_net
```

Проверяем, что приложение перезапустится и будет отвечать на новом порту:
```
> docker compose down
[+] Running 6/6
 ⠿ Container src-ui-1       Removed                                                                                                                              0.5s
 ⠿ Container src-comment-1  Removed                                                                                                                              1.0s
 ⠿ Container src-post-1     Removed                                                                                                                              1.1s
 ⠿ Container src-post_db-1  Removed                                                                                                                              0.8s
 ⠿ Network src_back_net     Removed                                                                                                                              0.1s
 ⠿ Network src_front_net    Removed                                                                                                                              0.2s

> docker compose up -d
[+] Running 6/6
 ⠿ Network src_back_net     Created                                                                                                                              0.0s
 ⠿ Network src_front_net    Created                                                                                                                              0.1s
 ⠿ Container src-comment-1  Started                                                                                                                              1.2s
 ⠿ Container src-ui-1       Started                                                                                                                              0.9s
 ⠿ Container src-post_db-1  Started                                                                                                                              1.1s
 ⠿ Container src-post-1     Started                                                                                                                              1.3s

> docker compose ps
NAME                COMMAND                  SERVICE             STATUS              PORTS
src-comment-1       "puma"                   comment             running
src-post-1          "python3 post_app.py"    post                running
src-post_db-1       "docker-entrypoint.s…"   post_db             running             27017/tcp
src-ui-1            "puma"                   ui                  running             0.0.0.0:3333->9292/tcp, :::3333->9292/tcp

> lynx -dump http://127.0.0.1:3333
   (BUTTON) [1]Microservices Reddit in ff1a7ab760a4 container

Menu

     * [2]All posts
     * [3]New post

References

   1. http://127.0.0.1:3333/
   2. http://127.0.0.1:3333/
   3. http://127.0.0.1:3333/new
```

| :point_up:    | Базовое имя образа формируется из названия папки и названия контейнера. Его можно изменить при помощи переменной окружения `COMPOSE_PROJECT_NAME`, либо указать в параметре ключа `-p` при запуске `docker compose`. |
|---------------|:------------------------|

Для переопределения параметров основного файла `docker-compose.yml` можно использовать `docker-compose.override.yml`, который считывается при запуске конфигурации.
Все указанные в нём параметры объединяются с параметрами основого файла. Подготовим его:
```yaml
version: '3.3'
services:
  ui:
    command: puma --debug -w 2
    volumes:
      - ./ui:/app

  post:
    volumes:
      - ./post-py:/app

  comment:
    command: puma --debug -w 2
    volumes:
      - ./comment:/app
```

 - Мы переопределили параметры запуска конейнеров с `ruby`.
 - Мы также примонтировали каталоги с кодом внутрь контейнера, заменив установленное там приложение, получили вожможность менять код без пересборки контейнеров.

**Результат №03-2**
 - Получен опыт работы с `docker-compose`

 ---

## 04 - Устройство Gitlab CI. Построение процесса непрерывной поставки

**Задание №04-1:**
 - Подготовить инсталляцию Gitlab CI
 - Подготовить репозиторий с кодом приложения
 - Описать для приложения этапы пайплайна
 - Определить окружения

**Решение №04-1:**
Создаём новую ветку `git checkout -b gitlab-ci-1`.

Проводить изыскания будем на Gitlab CE (community edition).
Идём на [офциальный сайт](https://docs.gitlab.com/ee/install/requirements.html) Gitlab, изучаем системные требования.

Минимальная конфигурация на 500 пользователей:
 - 4 core CPU
 - 4 GB RAM
 - 2.5 GB HDD (только Gitlab)

Для себя примем конфигурацию в 2 core СPU, 4 GB RAM, 50 GB HDD.
Машину создаём в облаке Яндекс, используем `terraform`.
Сначала подготовим образ машины при помощи `packer`, за основу возьмём Ubuntu 22.04 LTS.

Содержимое `ubuntu-docker.json`:
```json
{
    "variables": {
        "mv_service_account_key_file": "",
        "mv_folder_id": "",
        "mv_source_image_family": ""
    },
    "builders": [
        {
            "type": "yandex",
            "service_account_key_file": "{{user `mv_service_account_key_file`}}",
            "folder_id": "{{user `mv_folder_id`}}",
            "source_image_family": "{{user `mv_source_image_family`}}",
            "image_name": "{{user `mv_image_family`}}-{{timestamp}}",
            "image_family": "{{user `mv_image_family`}}",
            "ssh_username": "ubuntu",
            "platform_id": "standard-v1",
            "use_ipv4_nat": "true"
        }
    ],
    "provisioners": [
        {
            "type": "shell",
            "pause_before": "60s",
            "script": "scripts/install_docker.sh",
            "execute_command": "sudo {{.Path}}"
        },
        {
            "type": "shell",
            "script": "scripts/cleanup.sh",
            "execute_command": "sudo {{.Path}}"
        }
    ]
}
```

Содержимое `variables.json`:
```json
{
    "mv_service_account_key_file": "./key.json",
    "mv_folder_id": "WYDIWYG",
    "mv_source_image_family": "ubuntu-2204-lts",
    "mv_image_family": "ubuntu-docker"
}
```

Проверяем шаблон:
```console
> packer validate -var-file=variables.json ubuntu-docker.json
The configuration is valid.
```

Я тут внезапно подумал, а почему не проверить, как работает конфиг в HCL?
Попробуем преобразовать шаблон в HCL средствами `packer`.
```console
> packer hcl2_upgrade -with-annotations ubuntu-docker.json
Successfully created ubuntu-docker.json.pkr.hcl. Exit 0
```

Что получили в итоге:
```hcl
# This file was autogenerated by the 'packer hcl2_upgrade' command. We
# recommend double checking that everything is correct before going forward. We
# also recommend treating this file as disposable. The HCL2 blocks in this
# file can be moved to other files. For example, the variable blocks could be
# moved to their own 'variables.pkr.hcl' file, etc. Those files need to be
# suffixed with '.pkr.hcl' to be visible to Packer. To use multiple files at
# once they also need to be in the same folder. 'packer inspect folder/'
# will describe to you what is in that folder.

# Avoid mixing go templating calls ( for example ```{{ upper(`string`) }}``` )
# and HCL2 calls (for example '${ var.string_value_example }' ). They won't be
# executed together and the outcome will be unknown.

# All generated input variables will be of 'string' type as this is how Packer JSON
# views them; you can change their type later on. Read the variables type
# constraints documentation
# https://www.packer.io/docs/templates/hcl_templates/variables#type-constraints for more info.
variable "mv_folder_id" {
  type    = string
  default = ""
}

variable "mv_service_account_key_file" {
  type    = string
  default = ""
}

variable "mv_source_image_family" {
  type    = string
  default = ""
}

# "timestamp" template function replacement
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
source "yandex" "autogenerated_1" {
  folder_id                = "${var.mv_folder_id}"
  image_family             = "${var.mv_image_family}"
  image_name               = "${var.mv_image_family}-${local.timestamp}"
  platform_id              = "standard-v1"
  service_account_key_file = "${var.mv_service_account_key_file}"
  source_image_family      = "${var.mv_source_image_family}"
  ssh_username             = "ubuntu"
  use_ipv4_nat             = "true"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.yandex.autogenerated_1"]

  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    execute_command  = "sudo {{ .Path }}"
    pause_before     = "1m0s"
    script           = "scripts/install_docker.sh"
  }

  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    execute_command  = "sudo {{ .Path }}"
    script           = "scripts/cleanup.sh"
  }

}
```

Причешем немного шаблон, впишем в него скрипты, которые лежали у нас в отдельных файлах.
В итоге получаем такой файл:
```hcl
# Define variables
variable "mv_folder_id" {
  type    = string
  default = ""
}

variable "mv_service_account_key_file" {
  type    = string
  default = ""
}

variable "mv_image_family" {
  type    = string
  default = ""
}

variable "mv_source_image_family" {
  type    = string
  default = ""
}

variable "mv_username" {
  type    = string
  default = ""
}

# Define functions
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "yandex" "image" {
  folder_id                = "${var.mv_folder_id}"
  image_family             = "${var.mv_image_family}"
  image_name               = "${var.mv_image_family}-${local.timestamp}"
  platform_id              = "standard-v1"
  service_account_key_file = "${path.root}/${var.mv_service_account_key_file}"
  source_image_family      = "${var.mv_source_image_family}"
  ssh_username             = "${var.mv_username}"
  use_ipv4_nat             = true
}

build {
  sources = ["source.yandex.image"]

  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    pause_before     = "30s"
    inline = [
        # Set noninteractive mode
        "echo debconf debconf/frontend select Noninteractive | sudo debconf-set-selections",
        # Official guide: https://docs.docker.com/engine/install/ubuntu/
        "sudo apt-get -y update",
        "sudo apt-get -y upgrade",
        "sudo apt-get -y install apt-transport-https ca-certificates curl gnupg lsb-release",
        # Setup repo
        "sudo mkdir -p /etc/apt/keyrings",
        "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg",
        "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
        # Update repo
        "sudo apt-get -y update",
        # Install latest docker
        "sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin mc htop tmux",
        # Cleanup
        "sudo apt-get -y autoremove",
        "sudo apt-get -y clean"
    ]
  }
}
```

Переменные выносим в отдельный файл `yandex.pkrvars.hcl`:
```hcl
mv_service_account_key_file = "key.json"
mv_folder_id                = "WYDIWYG"
mv_source_image_family      = "ubuntu-2204-lts"
mv_image_family             = "ubuntu-docker"
mv_username                 = "ubuntu"
```

Проверим шаблон на ошибки:
```console
> packer validate -var-file=yandex.pkrvars.hcl ubuntu-docker.pkr.hcl
The configuration is valid.
```

Всё прекрасно, собираем:
```console
> packer build -var-file=yandex.pkrvars.hcl ubuntu-docker.pkr.hcl
yandex.image: output will be in this color.

==> yandex.image: Creating temporary RSA SSH key for instance...
==> yandex.image: Using as source image: fd8egv6phshj1f64q94n (name: "ubuntu-22-04-lts-v20221024", family: "ubuntu-2204-lts")
==> yandex.image: Creating network...
==> yandex.image: Creating subnet in zone "ru-central1-a"...
==> yandex.image: Creating disk...
==> yandex.image: Creating instance...
==> yandex.image: Waiting for instance with id fhmic1hvch2stnurr4ib to become active...
    yandex.image: Detected instance IP: 178.154.207.47
==> yandex.image: Using SSH communicator to connect: 178.154.207.47
==> yandex.image: Waiting for SSH to become available...
==> yandex.image: Connected to SSH!
==> yandex.image: Pausing 30s before the next provisioner...
==> yandex.image: Provisioning with shell script: /tmp/packer-shell1309385743
    yandex.image: Hit:1 http://ru.archive.ubuntu.com/ubuntu jammy InRelease
...
...
...
    yandex.image: Removing libftdi1-2:amd64 (1.5-5build3) ...
    yandex.image: Processing triggers for libc-bin (2.35-0ubuntu3.1) ...
==> yandex.image: Stopping instance...
==> yandex.image: Deleting instance...
    yandex.image: Instance has been deleted!
==> yandex.image: Creating image: ubuntu-docker-20221028185210
==> yandex.image: Waiting for image to complete...
==> yandex.image: Success image create...
==> yandex.image: Destroying subnet...
    yandex.image: Subnet has been deleted!
==> yandex.image: Destroying network...
    yandex.image: Network has been deleted!
==> yandex.image: Destroying boot disk...
    yandex.image: Disk has been deleted!
Build 'yandex.image' finished after 9 minutes 26 seconds.

==> Wait completed after 9 minutes 26 seconds

==> Builds finished. The artifacts of successful builds are:
--> yandex.image: A disk image was created: ubuntu-docker-20221028185210 (id: fd8h8umi4qqh0ovrgchl) with family name ubuntu-docker
```

С образом виртуальной машины закончили, поднимаем саму машину. Описываем конфигурацию:
```hcl
# provider.tf

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}
```

```hcl
# variables.tf

variable "service_account_key_file" {
  description = "Path to service account key file"
}

variable "cloud_id" {
  description = "Cloud"
}

variable "folder_id" {
  description = "Folder"
}

variable "zone" {
  description = "Zone"
  default     = "ru-central1-a"
}

variable "image_id" {
  description = "Image id for VM"
}

variable "subnet_id" {
  description = "ID for subnet"
}

variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}

variable "server_name" {
  description = "VM name"
}

variable "disk_size" {
  description = "VM disk size"
}
```

```hcl
# terraform.tfvars

service_account_key_file    = "key.json"
cloud_id                    = "00000000000000000000"
folder_id                   = "00000000000000000000"
zone                        = "00-00000000-0"
image_id                    = "fd8mkch2tdig66qg0edu"
subnet_id                   = "00000000000000000000"
public_key_path             = "~/.ssh/ubuntu.pub"
server_name                 = "Nemo"
disk_size                   = 50
```

```hcl
#

resource "yandex_compute_instance" "server" {
  name = var.server_name
  zone = var.zone

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = var.disk_size
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}
```

Проверяем:
```console
> terraform validate
╷
│ Error: Missing required provider
│
│ This configuration requires provider registry.terraform.io/yandex-cloud/yandex, but that provider isn't available. You may be able to install it automatically by
│ running:
│   terraform init
```

А, точно:
```console
> terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of yandex-cloud/yandex...
- Installing yandex-cloud/yandex v0.81.0...
- Installed yandex-cloud/yandex v0.81.0 (self-signed, key ID E40F590B50BB8E40)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/cli/plugins/signing.html

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

> terraform validate
Success! The configuration is valid.
```

Применяем конфигурацию:
```console
> terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.server will be created
  + resource "yandex_compute_instance" "server" {
      + created_at                = (known after apply)
...
...
...
Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

yandex_compute_instance.server: Creating...
yandex_compute_instance.server: Still creating... [10s elapsed]
yandex_compute_instance.server: Still creating... [20s elapsed]
yandex_compute_instance.server: Still creating... [30s elapsed]
yandex_compute_instance.server: Still creating... [40s elapsed]
yandex_compute_instance.server: Still creating... [50s elapsed]
yandex_compute_instance.server: Creation complete after 1m0s [id=fhmtcvphatodu6nrmj7t]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

**Результат №04-1:**
 - Подготовлен образ виртуальной машины с предустановленным `docker`
 - Из этого образа создана виртуальная машина в облаке

---

**Задание №04-2:**

Написать плейбук или небольшую роль по поднятию `Gitlab` в контейнере.


**Решение №04-2:**

В предыдущих занятиях мы уже настраивали инвентори, просто заберём конфиг и проверим его работу:
```console
> ansible-inventory --list
{
    "_meta": {
        "hostvars": {
            "fhmtqhi1g294dgsialot.auto.internal": {
                "ansible_host": "84.252.128.119"
            }
        }
    },
    "all": {
        "children": [
            "ungrouped"
        ]
    },
    "ungrouped": {
        "hosts": [
            "fhmtqhi1g294dgsialot.auto.internal"
        ]
    }
}
```

Готовим плейбук для установки `Gitlab`. Используем модуль для работы с контейнерами [docker_container_module](https://docs.ansible.com/ansible/latest/collections/community/docker/docker_container_module.html). Читаем описание, выдаём результат:
```yaml
- name: Run Gitlab in Docker
  hosts: all
  become: yes
  tasks:

    - name: Create dirs for volumes
      file:
        name: "{{ item }}"
        state: directory
        owner: root
        group: root
      with_items:
        - "/srv/gitlab/config"
        - "/srv/gitlab/logs"
        - "/srv/gitlab/data"

    - name: Install PIP
      apt:
        name: python3-pip
        state: present

    - name: Install Docker SDK for Python
      pip:
        name: docker
        state: present

    - name: Run Gitlab in Docker
      community.docker.docker_container:
        name: gitlab
        hostname: gitlab
        image: gitlab/gitlab-ce:15.4.0-ce.0
        state: started
        restart_policy: unless-stopped
        container_default_behavior: "no_defaults"
        env:
          GITLAB_OMNIBUS_CONFIG: "external_url \"http://{{ ansible_host }}\""
        ports:
          - "80:80"
          - "443:443"
          - "2222:22"
        volumes:
          - "/srv/gitlab/config:/etc/gitlab"
          - "/srv/gitlab/logs:/var/log/gitlab"
          - "/srv/gitlab/data:/var/opt/gitlab"
```

Применяем:
```console
ansible-playbook gitlab_in_docker.yml

PLAY [Run Gitlab in Docker] *****************************************************

TASK [Gathering Facts] **********************************************************
ok: [fhmtqhi1g294dgsialot.auto.internal]

TASK [Create dirs for volumes] **************************************************
changed: [fhmtqhi1g294dgsialot.auto.internal] => (item=/srv/gitlab/config)
changed: [fhmtqhi1g294dgsialot.auto.internal] => (item=/srv/gitlab/logs)
changed: [fhmtqhi1g294dgsialot.auto.internal] => (item=/srv/gitlab/data)

TASK [Install PIP] **************************************************************
changed: [fhmtqhi1g294dgsialot.auto.internal]

TASK [Install Docker SDK for Python] ********************************************
changed: [fhmtqhi1g294dgsialot.auto.internal]

TASK [Run Gitlab in Docker] *****************************************************
changed: [fhmtqhi1g294dgsialot.auto.internal]

PLAY RECAP **********************************************************************
fhmtqhi1g294dgsialot.auto.internal : ok=5    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

Даём серверу пять минут на разворачивание конфигурации внутри контейнера, проверяем:
```console
> lynx -dump http://84.252.128.119
   #[1]Search GitLab

   GitLab Logo

GitLab

   Username or email ____________________
   Password ____________________
   [ ] Remember me
   [2]Forgot your password?
   (BUTTON) Sign in

   By signing in you accept the [3]Terms of Use and acknowledge the
   Privacy Policy and Cookie Policy.

   Don't have an account yet? [4]Register now
     __________________________________________________________________

   [5]Explore [6]Help [7]About GitLab [8]Community forum

References

   1. http://84.252.128.119/search/opensearch.xml
   2. http://84.252.128.119/users/password/new
   3. http://84.252.128.119/-/users/terms
   4. http://84.252.128.119/users/sign_up
   5. http://84.252.128.119/explore
   6. http://84.252.128.119/help
   7. https://about.gitlab.com/
   8. https://forum.gitlab.com/
```

Видим ответ от `Gitlab`.

**Результат №04-2:**
 - `Gitlab` развёрнут автоматически, при помощи `ansible`.


**Задание №04-2:**
Настраиваем `Gitlab`.

**Решение №04-2:**

Открываем браузер, идём на `http://84.252.128.119`. После первой установки для `root` генерируется случайный пароль, лежит в каталоге с конфигурацией. Идём на сервер, смотрим пароль:
```console
ubuntu@fhmtqhi1g294dgsialot:~$ sudo cat /srv/gitlab/config/initial_root_password
# WARNING: This value is valid only in the following conditions
#          1. If provided manually (either via `GITLAB_ROOT_PASSWORD` environment variable or via `gitlab_rails['initial_root_password']` setting in `gitlab.rb`, it was provided before database was seeded for the first time (usually, the first reconfigure run).
#          2. Password hasn't been changed manually, either via UI or via command line.
#
#          If the password shown here doesn't work, you must reset the admin password following https://docs.gitlab.com/ee/security/reset_user_password.html#reset-your-root-password.

Password: 9/oj46i2FqN2rlXutHq/nUewaNoCqz3BBu5qp7bMIXo=

# NOTE: This file will be automatically deleted in the first reconfigure run after 24 hours.
```

После ввода пароля попадаем в `Gitlab`. Пока сидел в консоли, заметил, что процессы отъели почти 80% памяти.
В [официальной документации](https://docs.gitlab.com/omnibus/settings/memory_constrained_envs.html) есть советы по снижению аппетитов.
После быстрой оптимизации `Gitlab` занимает уже 30% памяти.

Через веб-интерфейс создаём группу `homework`, в ней проект `example`.
Клонируем репозиторий на локальную машину:
```console
> git clone http://84.252.128.119/homework/example.git
Cloning into 'example'...
Username for 'http://84.252.128.119': root
Password for 'http://root@84.252.128.119':
warning: You appear to have cloned an empty repository.
```

В корне репозитория создадим описание пайплайна `.gitlab-ci.yml`:
```yaml
stages:
  - build
  - test
  - deploy

build_job:
  stage: build
  script:
    - echo 'Building'

test_unit_job:
  stage: test
  script:
    - echo 'Testing 1'

test_integration_job:
  stage: test
  script:
    - echo 'Testing 2'

deploy_job:
  stage: deploy
  script:
    - echo 'Deploy'
```

Пушим изменения в удалённый репозиторий:
```console
> git add .gitlab-ci.yml

> git commit -m "Add pipeline definition"
[main a116fa6] Add pipeline definition
 1 file changed, 24 insertions(+)
 create mode 100644 .gitlab-ci.yml

> git push
Username for 'http://84.252.128.119': root
Password for 'http://root@84.252.128.119':
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 2 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 408 bytes | 408.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
To http://84.252.128.119/homework/example.git
   08fcbf7..a116fa6  main -> main
```

Идём в `CI/CD -> Pipelines`, видим, что наш пайплайн застрял в состоянии `pending`. Это произошло из-за отсуствия раннеров, которые могут выполнять работу.
Раннер запустим на том же сервере, где установлен `Gitlab`. В консоли выполняем:
```console
> sudo mkdir -p /srv/gitlab-runnner/config

> sudo docker run -d --name gitlab-runner --restart always -v /srv/gitlab-runnner/config:/etc/gitlab-runnner -v /var/run/docker.sock:/var/run/docker.sock gitlab/gitlab-runner:alpine-v15.5.0

Unable to find image 'gitlab/gitlab-runner:alpine-v15.5.0' locally
alpine-v15.5.0: Pulling from gitlab/gitlab-runner
9621f1afde84: Pull complete
4facbddabc98: Pull complete
12db4ccead3b: Pull complete
Digest: sha256:31ca964ad8f227c7dee37f5eda5df216b82ce0ba5cba291df26a6179f02ef234
Status: Downloaded newer image for gitlab/gitlab-runner:alpine-v15.5.0
27a5b705a3d50caa49309d8e70acab494c09f238b7755b2478d3ceede6f037ee
```

Теперь этот раннер нужно зарегистрировать, то есть привязать к нашему `Gitlab`. В настройках CI/CD находим токен, с его помощью регистрируем раннер:
```console
> sudo docker exec -it gitlab-runner register --url http://84.252.128.119/ --non-interactive --locked=false --name=DockerRunner --executor docker --docker-image alpine:latest --registration-token GR13489414ApxCsr63cLavyuDh384 --tag-list="linux,xenial,ubuntu,docker" --run-untagged

Runtime platform arch=amd64 os=linux pid=37 revision=0d4137b8 version=15.5.0
Running in system-mode.
Registering runner... succeeded runner=GR13489414ApxCsr6
Runner registered successfully.
Feel free to start it, but if it's running already the config should be automatically reloaded!
Configuration (with the authentication token) was saved in "/etc/gitlab-runner/config.toml"
```
В настройках CI/CD находим новый раннер. Пайплайн вышел из застрявшего состояния, отработал без ошибок.

Добавим приложение `reddit` в наш проект:
```console
> git clone https://github.com/express42/reddit.git
Cloning into 'reddit'...
remote: Enumerating objects: 376, done.
remote: Counting objects: 100% (5/5), done.
remote: Compressing objects: 100% (5/5), done.
remote: Total 376 (delta 0), reused 0 (delta 0), pack-reused 371
Receiving objects: 100% (376/376), 67.42 KiB | 945.00 KiB/s, done.
Resolving deltas: 100% (201/201), done.

> rm -rf ./reddit/.git
> git add reddit/

> git commit -m "Add reddit app"
[main d084e8b] Add reddit app
 17 files changed, 656 insertions(+)
 create mode 100644 reddit/.gitignore
 create mode 100644 reddit/Capfile
 create mode 100644 reddit/Gemfile
 create mode 100644 reddit/Gemfile.lock
 create mode 100644 reddit/README.md
 create mode 100644 reddit/app.rb
 create mode 100644 reddit/config.ru
 create mode 100644 reddit/config/deploy.rb
 create mode 100644 reddit/config/deploy/production.rb
 create mode 100644 reddit/config/deploy/staging.rb
 create mode 100644 reddit/helpers.rb
 create mode 100644 reddit/views/create.haml
 create mode 100644 reddit/views/index.haml
 create mode 100644 reddit/views/layout.haml
 create mode 100644 reddit/views/login.haml
 create mode 100644 reddit/views/show.haml
 create mode 100644 reddit/views/signup.haml

> git push
Username for 'http://84.252.128.119': root
Password for 'http://root@84.252.128.119':
Enumerating objects: 23, done.
Counting objects: 100% (23/23), done.
Delta compression using up to 2 threads
Compressing objects: 100% (20/20), done.
Writing objects: 100% (22/22), 7.99 KiB | 4.00 MiB/s, done.
Total 22 (delta 2), reused 0 (delta 0), pack-reused 0
To http://84.252.128.119/homework/example.git
   a116fa6..d084e8b  main -> main
```

Добавим запуск тетов в наш пайплайн:
```patch
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index cf9e693..bd8cbaa 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,8 +1,17 @@
+image: ruby:2.4.2
+
 stages:
   - build
   - test
   - deploy

+variables:
+  DATABASE_URL: 'mongo'
+
+before_script:
+  - cd reddit
+  - bundle install
+
 build_job:
   stage: build
   script:
@@ -10,8 +19,10 @@ build_job:

 test_unit_job:
   stage: test
+  services:
+    - mongo:3.2
   script:
-    - echo 'Testing 1'
+    - ruby simpletest.rb

 test_integration_job:
   stage: test
```

Создадим сам тест `reddit/simpletest.rb`:
```ruby
require_relative './app'
require 'test/unit'
require 'rack/test'

set :environment, :test

class MyAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_get_request
    get '/'
    assert last_response.ok?
  end
end
```

В `reddit/Gemfile` добавим библиотеку для тестирования:
```patch
diff --git a/reddit/Gemfile b/reddit/Gemfile
index 3ce71c0..4735172 100644
--- a/reddit/Gemfile
+++ b/reddit/Gemfile
@@ -7,6 +7,7 @@ gem 'bcrypt'
 gem 'puma'
 gem 'mongo'
 gem 'json'
+gem 'rack-test'

 group :development do
     gem 'capistrano',         require: false
```

Пушим изменения, видим, что тесты отработали:
```console
Running with gitlab-runner 15.5.0 (0d4137b8)
  on DockerRunner so4_tQcx
Preparing the "docker" executor 00:08
Using Docker executor with image ruby:2.4.2 ...
Starting service mongo:3.2 ...
Pulling docker image mongo:3.2 ...
Using docker image sha256:fb885d89ea5c35ac02acf79a398b793555cbb3216900f03f4b5f7dc31e595e31 for mongo:3.2 with digest mongo@sha256:0463a91d8eff189747348c154507afc7aba045baa40e8d58d8a4c798e71001f3 ...
Waiting for services to be up and running (timeout 30 seconds)...
Pulling docker image ruby:2.4.2 ...
Using docker image sha256:2a867526d4724cf92c845c70b67e53d61e0a76e324a6051262c3731ddcc2f568 for ruby:2.4.2 with digest ruby@sha256:7271d0cd55da37b6f28924c9452871d77e828c4d38ef3438cfc179388209e51f ...
Preparing environment 00:01
Running on runner-so4tqcx-project-3-concurrent-0 via dd3122804efe...
Getting source from Git repository 00:01
Fetching changes with git depth set to 20...
Reinitialized existing Git repository in /builds/homework/example/.git/
Checking out 65ce6b80 as main...
Skipping Git submodules setup
Executing "step_script" stage of the job script 00:18
Using docker image sha256:2a867526d4724cf92c845c70b67e53d61e0a76e324a6051262c3731ddcc2f568 for ruby:2.4.2 with digest ruby@sha256:7271d0cd55da37b6f28924c9452871d77e828c4d38ef3438cfc179388209e51f ...
$ cd reddit
$ bundle install
Warning: the running version of Bundler (1.16.0) is older than the version that created the lockfile (1.16.1). We suggest you upgrade to the latest version of Bundler by running `gem install bundler`.
Fetching gem metadata from https://rubygems.org/.......
Resolving dependencies...
Fetching rake 12.0.0
Installing rake 12.0.0
Fetching net-ssh 4.1.0
Installing net-ssh 4.1.0
Fetching net-scp 1.2.1
Installing net-scp 1.2.1
Fetching sshkit 1.14.0
Installing sshkit 1.14.0
Fetching airbrussh 1.3.0
Installing airbrussh 1.3.0
Fetching bcrypt 3.1.11
Installing bcrypt 3.1.11 with native extensions
Fetching bson 4.2.2
Installing bson 4.2.2 with native extensions
Fetching bson_ext 1.5.1
Installing bson_ext 1.5.1 with native extensions
Using bundler 1.16.0
Fetching i18n 0.8.6
Installing i18n 0.8.6
Fetching capistrano 3.9.0
Installing capistrano 3.9.0
Fetching capistrano-bundler 1.2.0
Installing capistrano-bundler 1.2.0
Fetching capistrano-rvm 0.1.2
Installing capistrano-rvm 0.1.2
Fetching puma 3.10.0
Installing puma 3.10.0 with native extensions
Fetching capistrano3-puma 3.1.1
Installing capistrano3-puma 3.1.1
Fetching temple 0.8.0
Installing temple 0.8.0
Fetching tilt 2.0.8
Installing tilt 2.0.8
Fetching haml 5.0.2
Installing haml 5.0.2
Fetching json 2.1.0
Installing json 2.1.0 with native extensions
Fetching mongo 2.4.3
Installing mongo 2.4.3
Fetching mustermann 1.0.2
Installing mustermann 1.0.2
Fetching rack 2.0.5
Installing rack 2.0.5
Fetching rack-protection 2.0.2
Installing rack-protection 2.0.2
Fetching rack-test 2.0.2
Installing rack-test 2.0.2
Fetching sinatra 2.0.2
Installing sinatra 2.0.2
Bundle complete! 12 Gemfile dependencies, 25 gems now installed.
Bundled gems are installed into `/usr/local/bundle`
Post-install message from capistrano3-puma:
    All plugins need to be explicitly installed with install_plugin.
    Please see README.md
  $ ruby simpletest.rb
/builds/homework/example/reddit/helpers.rb:4: warning: redefining `object_id' may cause serious problems
D, [2022-10-30T13:51:51.841902 #329] DEBUG -- : MONGODB | Topology type 'unknown' initializing.
D, [2022-10-30T13:51:51.842065 #329] DEBUG -- : MONGODB | Server mongo:27017 initializing.
D, [2022-10-30T13:51:51.845826 #329] DEBUG -- : MONGODB | Topology type 'unknown' changed to type 'single'.
D, [2022-10-30T13:51:51.845922 #329] DEBUG -- : MONGODB | Server description for mongo:27017 changed from 'unknown' to 'standalone'.
D, [2022-10-30T13:51:51.845981 #329] DEBUG -- : MONGODB | There was a change in the members of the 'single' topology.
Loaded suite simpletest
Started
D, [2022-10-30T13:51:51.957565 #329] DEBUG -- : MONGODB | mongo:27017 | user_posts.find | STARTED | {"find"=>"posts", "filter"=>{}, "sort"=>{"timestamp"=>-1}}
D, [2022-10-30T13:51:51.959650 #329] DEBUG -- : MONGODB | mongo:27017 | user_posts.find | SUCCEEDED | 0.0019516730000000001s
.
Finished in 0.058503711 seconds.
------
1 tests, 1 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications
100% passed
------
17.09 tests/s, 17.09 assertions/s
Job succeeded
```

Добавим в пайплайн dev окружение:
```patch
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a9ff7cf..83e0432 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -3,7 +3,7 @@ image: ruby:2.4.2
 stages:
   - build
   - test
-  - deploy
+  - review

 variables:
   DATABASE_URL: 'mongo'
@@ -29,7 +29,11 @@ test_integration_job:
   script:
     - echo 'Testing 2'

-deploy_job:
-  stage: deploy
+deploy_dev_job:
+  stage: review
   script:
     - echo 'Deploy'
+  environment:
+    name: dev
+    url: http://dev.example.com
```

Пушим изменения, видим, что у нас в `Deployments -> Environments` появилось окружение `dev`.

Добавим ещё два окружения в пайплайн:
```patch
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 83e0432..d565580 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -4,6 +4,8 @@ stages:
   - build
   - test
   - review
+  - stage
+  - production

 variables:
   DATABASE_URL: 'mongo'
@@ -37,3 +39,20 @@ deploy_dev_job:
     name: dev
     url: http://dev.example.com

+staging:
+  stage: stage
+  when: manual
+  script:
+    - echo 'Deploy'
+  environment:
+    name: beta
+    url: http://beta.example.com
+
+production:
+  stage: production
+  when: manual
+  script:
+    - echo 'Deploy'
+  environment:
+    name: production
+    url: http://example.com
```

После завершения работы пайплайна мы видим новые окружения.
Дбавим условие, при котором на `stage` и `production` пойдут только те ветки, которые отмечены тегом:
```patch
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index fd92f6e..882d818 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -42,6 +42,8 @@ deploy_dev_job:
 staging:
   stage: stage
   when: manual
+  only:
+    - tags
   script:
     - echo 'Deploy'
   environment:
@@ -51,6 +53,8 @@ staging:
 production:
   stage: production
   when: manual
+  only:
+    - tags
   script:
     - echo 'Deploy'
   environment:
```

Добавим тег к коммиту:
```console
> git commit -m "Remove unused files"
[main e15c2dc] Remove unused files
 1 file changed, 1 deletion(-)
 delete mode 100644 reddit/.gitignore

> git tag 2.4.10

> git push --tags
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 2 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 280 bytes | 280.00 KiB/s, done.
Total 3 (delta 2), reused 0 (delta 0), pack-reused 0
To http://84.252.128.119/homework/example.git
 * [new tag]         2.4.10 -> 2.4.10
```

Видим, что при пуше без тега паплайн состоит из трёх стадий, а при установке тега у нас появляется пять стадий.

В [документации](https://docs.gitlab.com/ee/ci/yaml/#deprecated-keywords) пишут: "Defining image, services, cache, before_script, and after_script globally is deprecated. Support could be removed from a future release.". Поправим свой пайплайн:
```patch
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3800749..df7f8ad 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,4 +1,8 @@
-image: ruby:2.4.2
+default:
+  image: ruby:2.4.2
+  before_script:
+    - cd reddit
+    - bundle install

 stages:
   - build
@@ -10,10 +14,6 @@ stages:
 variables:
   DATABASE_URL: 'mongo'

-before_script:
-  - cd reddit
-  - bundle install
-
 build_job:
   stage: build
   script:
```

Есть возможность созлавать динамические окружения. Сделаем это для всех веток, исключая главную ветку:
```patch
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index df7f8ad..96c17ef 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -39,6 +39,17 @@ deploy_dev_job:
     name: dev
     url: http://dev.example.com

+branch_review:
+  stage: review
+  script: echo "Deploy to $CI_ENVIRONMENT_SLUG"
+  environment:
+    name: branch/$CI_COMMIT_REF_NAME
+    url: http://$CI_ENVIRONMENT_SLUG.example.com
+  only:
+    - branches
+  except:
+    - main
+
 staging:
   stage: stage
   when: manual
```

Создаём несколько веток, пушим изменения, видим, что окружения создаются динамически.

**Результат №04-3:**
 - Отработаны приёмы настройки пайплайна в `Gitlab`
 - Научились создавать окружения, в том числе и динамические

---

**Задание №04-4:** Запуск reddit в контейнере (по желанию).
В этап пайплайна `build` добавьте запуск контейнера с приложением `reddit`. Сделайте так, чтобы контейнер с `reddit` деплоился на окружение, динамически создаваемое для каждой ветки в `Gitlab`.

**Решение №04-4:**
Какая-то невнятная постановка задачи. Какое ТЗ, такой результат)
В своё время мы загружали на `dockerhub` образ приложения, добавим его в этап `build`:
```patch
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 90138c8..c7ed2e6 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -18,6 +18,10 @@ build_job:
   stage: build
   script:
     - echo 'Building'
+  environment:
+    name: branch/$CI_COMMIT_REF_NAME
+    url: http://$CI_ENVIRONMENT_SLUG.example.com
+  image: r2d2k/otus-reddit:1.0
+  before_script:
+    - echo 'Prepare to run reddit'

 test_unit_job:
   stage: test
```

**Результат №04-4:**
Во время запуска шага `build` был выкачан образ и запущен контейнер с `reddit`.
Параллельно создалось окружение под эту ветку.

---

**Задание №04-5:**
Автоматизация развёртывания GitLab Runner (по желанию)

**Решение №04-5:**
Создадим под эту задачу отдельный плейбук. По умолчанию раннер будет устанавливаться на тот же хост, на котором работает `Gitlab`, то есть используем хост из динамического инвентори. Заполняем переменные окружения и запускаем плейбук. Если не указать никаких тегов, то контейнер будет запущен, но не зарегистрирован.
Регистрация произойдёт только при запуске плейбука с тегом `register`:
```yaml
- name: Got runner
  hosts: all
  become: yes
  vars:
    url: "http://84.252.128.119/"
    name: "DockerRunner"
    docker_image: "alpine:latest"
    token: "GR13489414ApxCsr63cLavyuDh384"
    tag_list: "linux,xenial,ubuntu,docker"
  tasks:

    - name: Create dirs for volumes
      file:
        name: "/srv/gitlab-runnner/config"
        state: directory
        owner: root
        group: root

    - name: Install PIP
      apt:
        name: python3-pip
        state: present

    - name: Install Docker SDK for Python
      pip:
        name: docker
        state: present

    - name: Run gitlab-runner
      community.docker.docker_container:
        name: gitlab-runner
        hostname: gitlab-runner
        image: gitlab/gitlab-runner:alpine-v15.5.0
        state: started
        restart_policy: unless-stopped
        container_default_behavior: "no_defaults"
        volumes:
          - "/srv/gitlab-runnner/config:/etc/gitlab-runnner"
          - "/var/run/docker.sock:/var/run/docker.sock"

    - name: Register runner
      community.docker.docker_container_exec:
        container: gitlab-runner
        command: gitlab-runner register --url {{ url }} --non-interactive --locked=false --name={{ name }} --executor docker --docker-image {{ docker_image }} --registration-token {{ token }} --tag-list={{ tag_list }} --run-untagged
      register: result
      tags: [ never, register ]

    - name: Print result
      debug:
        var: result.stderr_lines
      tags: [ never, register ]
```

**Результат №04-5:**
 - Автоматизирован процесс разворачивания и регистрации раннера
 - Переменные намеренно оставлены в плейбуке, для упрощения восприятия

---

**Задание №04-6:**
Настройка оповещений в Slack (пожеланию).
Настройте интеграцию вашего пайплайна с тестовым Slack-чатом, который вы использовали ранее. Для этого перейдите в `Settings -> Integrations -> Slack notifications`. Нужно включить эту интеграцию, выбрать события и заполнить поля с URL вашего Slack webhook. Добавьте ссылку на канал в слаке, в котором можно проверить работу оповещений, в файл README.md.

**Решение №04-6:**
В слаке идём в `Browse Apps -> Custom Integrations -> Incoming WebHooks -> Edit configuration`, добавляем входящий вебхук.
В `Gitlab` идём в `Settings -> Integrations -> Slack notifications`, вносим имя своего канала, адрес полученного на предыдущем шаге вебхука.

**Результат №04-6:**
 - Работу оповещений можно увидеть по [этой](https://app.slack.com/client/T6HR0TUP3/C03LBLPEGDA) ссылке.

 ---

## 05 - Введение в мониторинг. Системы мониторинга.

**Задание №05-1:**
 - Prometheus: запуск, конфигурация, знакомство с Web UI
 - Мониторинг состояния микросервисов
 - Сбор метрик хоста с использованием экспортера

**Решение №05-1:**

Создаём новую ветку `git checkout -b monitoring-1`.
Готовим окружение, нам нужен сервер с установленным `docker`. Возьмём описание сервера из предыдущего задания, поднимем его при помощи `terraform`.
После запуска сервера заходим на него по `ssh`, запускаем `prometheus`:
```console
> sudo docker run --rm -p 9090:9090 -d --name prometheus prom/prometheus
Unable to find image 'prom/prometheus:latest' locally
latest: Pulling from prom/prometheus
50783e0dfb64: Pull complete
daafb1bca260: Pull complete
72d3569fdc6f: Pull complete
13afa930da33: Pull complete
6ef28183cda8: Pull complete
4ad7245dbb40: Pull complete
26e6063b72b5: Pull complete
d859dd8f8ba9: Pull complete
583221d3597c: Pull complete
b4e477a4eb49: Pull complete
0b0ad5fc938d: Pull complete
53ddffa5a7d1: Pull complete
Digest: sha256:4748e26f9369ee7270a7cd3fb9385c1adb441c05792ce2bce2f6dd622fd91d38
Status: Downloaded newer image for prom/prometheus:latest
b7a22bf74cb765380384fcc1689dd96f47ab36583d408be64480bfef68e0b73f
```

Сервер слушает на порту `9090`, подключаемся, видим веб-интерфейс `prometheus`.
По умолчанию уже собираются метрики самой системы мониторинга. Можем посмотреть информацию о версии продукта:
```console
prometheus_build_info{branch="HEAD", goversion="go1.19.2", instance="localhost:9090", job="prometheus", revision="dcd6af9e0d56165c6f5c64ebbc1fae798d24933a", version="2.39.1"}
```

Создадим простой `prometheus/Dockerfile`:
```Dockerfile
FROM prom/prometheus:v2.1.0
ADD prometheus.yml /etc/prometheus/
```

Сам файл конфигурации `prometheus.yml` будет выглядеть так:
```yaml
global:
  scrape_interval: '5s'

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets:
        - 'localhost:9090'

  - job_name: 'ui'
    static_configs:
      - targets:
        - 'ui:9292'

  - job_name: 'comment'
    static_configs:
      - targets:
        - 'comment:9292'
```

Собираем образ:
```console
> docker build -t r2d2k/prometheus .
Sending build context to Docker daemon  3.072kB
Step 1/2 : FROM prom/prometheus:v2.1.0
v2.1.0: Pulling from prom/prometheus
Image docker.io/prom/prometheus:v2.1.0 uses outdated schema1 manifest format. Please upgrade to a schema2 image for better future compatibility. More information at https://docs.docker.com/registry/spec/deprecated-schema-v1/
aab39f0bc16d: Pull complete
a3ed95caeb02: Pull complete
2cd9e239cea6: Pull complete
48afad9e6cdd: Pull complete
8fb7aa0e1c16: Pull complete
3b9d4fd63760: Pull complete
57a87cf4a659: Pull complete
9a31588e38ae: Pull complete
7a0ac0080f04: Pull complete
659e24e6d37f: Pull complete
Digest: sha256:7b987901dbc44d17a88e7bda42dbbbb743c161e3152662959acd9f35aeefb9a3
Status: Downloaded newer image for prom/prometheus:v2.1.0
 ---> c8ecf7c719c1
Step 2/2 : ADD prometheus.yml /etc/prometheus/
 ---> fca39e0c1f75
Successfully built fca39e0c1f75
Successfully tagged r2d2k/prometheus:latest
```

Собираем образы всех приложений:
```console
/src/ui $ bash docker_build.sh
/src/post-py $ bash docker_build.sh
/src/comment $ bash docker_build.sh
```

После сборки получаем такой результат:
```console
> docker images
REPOSITORY      TAG            IMAGE ID       CREATED              SIZE
r2d2k/comment   latest         eb80e04347b7   11 seconds ago       769MB
r2d2k/post      latest         44874e613120   About a minute ago   121MB
r2d2k/ui        latest         ca343ac78a70   3 minutes ago        464MB
ubuntu          16.04          b6f507652425   14 months ago        135MB
ruby            2.2            6c8e6f9667b2   4 years ago          715MB
python          3.6.0-alpine   cb178ebbf0f2   5 years ago          88.6MB
```

Обновляем `docker-compose.yml`, добавив в него сервис `prometheus`:
```yaml
services:
  post_db:
    image: mongo:3.2
    volumes:
      - post_db:/data/db
    networks:
      - back_net

  ui:
    image: ${USERNAME}/ui:latest
    ports:
      - ${UI_PORT}:9292/tcp
    networks:
      - front_net

  post:
    image: ${USERNAME}/post:latest
    networks:
      - back_net
      - front_net

  comment:
    image: ${USERNAME}/comment:latest
    networks:
      - back_net
      - front_net

  prometheus:
    image: ${USERNAME}/prometheus:latest
    ports:
      - '9090:9090'
    volumes:
      - prometheus_data:/prometheus
    command: # Передаем доп параметры в командной строке
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--storage.tsdb.path=/prometheus'
      - '--storage.tsdb.retention=1d' # Задаем время хранения метрик в 1 день
    networks:
      - front_net
      - back_net

volumes:
  post_db:
  prometheus_data:

networks:
  front_net:
    driver: bridge
    ipam:
      config:
        - subnet: 10.0.1.0/24

  back_net:
    driver: bridge
    ipam:
      config:
        - subnet: 10.0.2.0/24
```

Поднимаем связку:
```console
> docker compose up -d
[+] Running 9/9
 ⠿ Network r2d2k_back_net          Created                                  0.2s
 ⠿ Network r2d2k_front_net         Created                                  0.1s
 ⠿ Volume "r2d2k_prometheus_data"  Crea...                                  0.0s
 ⠿ Volume "r2d2k_post_db"          Created                                  0.0s
 ⠿ Container r2d2k-comment-1       Started                                  2.0s
 ⠿ Container r2d2k-prometheus-1    Starte...                                1.8s
 ⠿ Container r2d2k-post_db-1       Started                                  1.6s
 ⠿ Container r2d2k-ui-1            Started                                  1.0s
 ⠿ Container r2d2k-post-1          Started                                  1.4s
```

Проверим приложение:
```console
> lynx -dump http://127.0.0.1:9292
   (BUTTON) [1]Microservices Reddit in d8a6f992662c container

Menu

     * [2]All posts
     * [3]New post

References

   1. http://127.0.0.1:9292/
   2. http://127.0.0.1:9292/
   3. http://127.0.0.1:9292/new
```

Проверяем доступность метрик в интерфейсе `prometheus`.
Для сбора информации о других сущностях можно использовать экспортёры `prometheus`, которых написано великое множество.
Добавим в наш `docker-compose.yml` `node-exporter`, который позволит собирать данные о хосте:
```patch
+  node-exporter:
+    image: prom/node-exporter:v0.15.2
+    user: root
+    volumes:
+      - /proc:/host/proc:ro
+      - /sys:/host/sys:ro
+      - /:/rootfs:ro
+    command:
+      - '--path.procfs=/host/proc'
+      - '--path.sysfs=/host/sys'
+      - '--collector.filesystem.ignored-mount-points="^/(sys|proc|dev|host|etc)($$|/)"'
+
```

В конфиг `prometheus` добавляем новую секцию:
```patch
+
+  - job_name: 'node'
+    static_configs:
+      - targets:
+        - 'node-exporter:9100'
```
Собираем образ с `prometheus`, перезапускаем наши сервисы, проверяем, что в `prometheus` появились новые данные.

Все собранные образы пушим в `registry`:
```console
> docker login
Login Succeeded

> docker push $USER_NAME/ui
> docker push $USER_NAME/comment
> docker push $USER_NAME/post
> docker push $USER_NAME/prometheus
```

Образы доступны по [ссылке](https://hub.docker.com/u/r2d2k).

**Результат №05-1:**
 - Собраны образы с экспортом метрик
 - Собран образ `prometheus` с преднастроенным конфигом
 - Подготовлен конфигурационный файл для `docker-compose`, позволяющий запустить все сервисы и мониторинг к ним

---

**Задание №05-2:**
 - Добавьте в Prometheus мониторинг MongoDB с использованием необходимого экспортера
 - Версию образа экспортера нужно фиксировать на последнюю стабильную версию
 - Если будете добавлять для него Dockerfile, он должен быть в директории monitoring, а не в корне репозитория

**Решение №05-2:**

Попробуем использовать [mongodb_exporter](https://github.com/percona/mongodb_exporter).
Есть вариант в виде образа `docker`, проверим его. После чтения документации по ссылке выше внесём изменения в наш `docker-compose.yml`:
```patch
+  mongo-exporter:
+    image: percona/mongodb_exporter:0.35
+    command:
+      - '--mongodb.uri=mongodb://post_db:27017'
+      - '--collect-all'
+      - '--log.level=debug'
+    ports:
+      - '9216:9216'
+    networks:
+      - back_net
+
```

В строке с образом фиксируем версию экспортёра. В параметрах команды указываем адрес сервера `mongodb`, список собираемых параметров.
В файл конфигурации `prometheus` также добавим опрос новых параметров:
```patch
+
+  - job_name: 'mongodb'
+    static_configs:
+      - targets:
+        - 'mongo-exporter:9216'
```

Собираем образ и поднимаем весь комплект при помощи `docker compose up -d`.
Проверим, отдаёт ли экспортёр метрики:
```console
> lynx -dump http://127.0.0.1:9216/metrics | grep mongodb | wc
   2300    6961  167231
```

Видим 2300 параметров с упоминанием `mongodb`. В интерфейсе `prometheus` появился `mongo-exporter` в статусе `up`.

**Результат №05-2:**
Для сбора метрик `mongodb` был использован отдельный контейнер, вмешательства в образ `mongodb` не потребовалось.

---

**Задание №05-3:**
 - Добавьте в Prometheus мониторинг сервисов `comment`, `post`, `ui` с помощью `blackbox` экспортера
 - Версию образа экспортера нужно фиксировать на последнюю стабильную версию
 - Если будете добавлять для него Dockerfile, он должен быть в директории monitoring, а не в корне репозитория

**Решение №05-3:**

Идём на [страницу](https://github.com/prometheus/blackbox_exporter/releases) разработчика и качаем последний релиз продукта.
Создаём папку `blackbox-exporter`, распаковываем в неё содержимое архива. Из файла конфигурации `blackbox.yml` вырезаем всё лишнее:
```yaml
modules:
  http_2xx:
    prober: http
    timeout: 5s
    http:
      valid_status_codes: []
      method: GET
```

Подготовим `Dockerfile` для сборки контейнера:
```Dockerfile
FROM scratch
COPY blackbox_exporter  /bin/blackbox_exporter
COPY blackbox.yml       /etc/blackbox_exporter/config.yml

EXPOSE      9115
ENTRYPOINT  [ "/bin/blackbox_exporter" ]
CMD         [ "--config.file=/etc/blackbox_exporter/config.yml" ]
```

Собираем образ:
```console
> docker build -t r2d2k/blackbox-exporter .
Sending build context to Docker daemon  20.75MB
Step 1/6 : FROM scratch
 --->
Step 2/6 : COPY blackbox_exporter  /bin/blackbox_exporter
 ---> e30c5d8b7c84
Step 3/6 : COPY blackbox.yml       /etc/blackbox_exporter/config.yml
 ---> 5480d381f219
Step 4/6 : EXPOSE      9115
 ---> Running in 050e4b77aeb6
Removing intermediate container 050e4b77aeb6
 ---> 0f2622c25a07
Step 5/6 : ENTRYPOINT  [ "/bin/blackbox_exporter" ]
 ---> Running in c6026a8e647e
Removing intermediate container c6026a8e647e
 ---> 79327d6d92df
Step 6/6 : CMD         [ "--config.file=/etc/blackbox_exporter/config.yml" ]
 ---> Running in d45bf82883b3
Removing intermediate container d45bf82883b3
 ---> 8d2fdebb3ecf
Successfully built 8d2fdebb3ecf
Successfully tagged r2d2k/blackbox-exporter:latest

> docker tag r2d2k/blackbox-exporter:latest r2d2k/blackbox-exporter:1.0
```

У нас получился образ размером в 20 МБ:
```console
> docker images
REPOSITORY                 TAG            IMAGE ID       CREATED                 SIZE
r2d2k/blackbox-exporter    1.0            8d2fdebb3ecf   over 9000 seconds ago   20.7MB
r2d2k/blackbox-exporter    latest         8d2fdebb3ecf   over 9000 seconds ago   20.7MB
```

Добавляем ещё один контейнер в наш `docker-compose.yml`:
```patch
+  blackbox-exporter:
+    image: r2d2k/blackbox-exporter:1.0
+    ports:
+      - '9115:9115'
+    networks:
+      - front_net
+
```

В файл конфигурации `prometheus` добавим опрос контейнеров через `blackbox-exporter`:
```patch
+  - job_name: 'blackbox-exporter'
+    metrics_path: /probe
+    params:
+      module: [http_2xx]
+    static_configs:
+      - targets:
+        - http://comment:9292/healthcheck
+        - http://post:5000/healthcheck
+        - http://ui:9292/healthcheck
+    relabel_configs:
+      - source_labels: [__address__]
+        target_label: __param_target
+      - source_labels: [__param_target]
+        target_label: instance
+      - target_label: __address__
+        replacement: blackbox-exporter:9115
```

По исходникам видно, что у каждого из сервисов есть endpoint для проверки здоровья.
Пересобираем образ, запускаем весь стек и видим, что новые цели мониторинга добавлены и опрашиваются.
По запросу `probe_success` в веб-интерфейсе `prometheus` видим следующий результат:
```console
probe_success{instance="http://comment:9292/healthcheck",job="blackbox-exporter"}   1
probe_success{instance="http://post:5000/healthcheck",job="blackbox-exporter"}      1
probe_success{instance="http://ui:9292/healthcheck",job="blackbox-exporter"}        1
```

**Результат №05-3:**
Собрали отдельный образ с `blackbox-exporter`, запустили в отдельном контейнере и мониторим состояние трёх сервисов.

---

**Задание №05-4:**

Написать `Makefile`, который умеет:
 - Билдить любой или все образы, которые сейчас используются
 - Умеет пушить их в докер хаб

**Решение №05-4:**
Идём, читаем [документацию](http://www.linuxlib.ru/prog/make_379_manual.html).
Она довольно старая, но для нашего случая это не имеет значения.
Структура каталога `src` у нас следующая:
```console
.
├── comment
│   ├── build_info.txt
│   ├── comment_app.rb
│   ├── config.ru
│   ├── docker_build.sh
│   ├── Dockerfile
│   ├── Dockerfile.1
│   ├── Dockerfile.2
│   ├── Gemfile
│   ├── Gemfile.lock
│   ├── helpers.rb
│   ├── Makefile
│   └── VERSION
├── post-py
│   ├── build_info.txt
│   ├── docker_build.sh
│   ├── Dockerfile
│   ├── helpers.py
│   ├── Makefile
│   ├── post_app.py
│   ├── requirements.txt
│   └── VERSION
├── ui
│   ├── views
│   ├── build_info.txt
│   ├── config.ru
│   ├── docker_build.sh
│   ├── Dockerfile
│   ├── Dockerfile.1
│   ├── Dockerfile.2
│   ├── Gemfile
│   ├── Gemfile.lock
│   ├── helpers.rb
│   ├── Makefile
│   ├── middleware.rb
│   ├── ui_app.rb
│   └── VERSION
├── docker-compose.override.yml
├── docker-compose.yml
├── Makefile
└── README.md
```

В каждом дочернем каталоге созадим `Makefile` следующего содержания (с учётом имени сервиса):
```Makefile
.PHONY: build push

build:
        docker build -t r2d2k/comment .

push:
        docker push r2d2k/comment
```

В корне родительского каталога создаём общий `Makefile`:
```Makefile
.PHONY: build push

build:
        $(MAKE) -C comment
        $(MAKE) -C post-py
        $(MAKE) -C ui

push:
        $(MAKE) push -C comment
        $(MAKE) push -C post-py
        $(MAKE) push -C ui
```

Файлы без особых излишеств, просто *делают* свою работу)
Для сборки отдельного образа выполняем `make` в соответствующем каталоге.
Для пуша в докер хаб говорим `make push`.
Эти же команды в родительском каталоге будут действовать на все три сервиса.

**Результат №05-4:**
 - Автоматизировали процесс сборки докер образов при помощи `make`

 ---

## 06 - Логирование и распределенная трассировка

**Задание №06-1:**
 - Подготовка окружения
 - Логирование Docker-контейнеров
 - Сбор неструктурированных логов
 - Визуализация логов
 - Сбор структурированных логов
 - Распределенный трейсинг

**Решение №06-1:**
Работаем в новой ветке `logging-1`.

Забираем обновлённые исходники наших сервисов:
```console
> git clone https://github.com/express42/reddit.git
Cloning into 'reddit'...
remote: Enumerating objects: 376, done.
remote: Counting objects: 100% (5/5), done.
remote: Compressing objects: 100% (5/5), done.
remote: Total 376 (delta 0), reused 0 (delta 0), pack-reused 371
Receiving objects: 100% (376/376), 67.42 KiB | 821.00 KiB/s, done.
Resolving deltas: 100% (201/201), done.

> cd reddit/

> git branch -a
* monolith
  remotes/origin/HEAD -> origin/monolith
  remotes/origin/bugged
  remotes/origin/dependabot/bundler/json-2.3.0
  remotes/origin/dependabot/bundler/puma-3.12.6
  remotes/origin/dependabot/bundler/rack-2.2.3
  remotes/origin/dependabot/bundler/rake-13.0.1
  remotes/origin/dependabot/bundler/sinatra-2.2.0
  remotes/origin/logging
  remotes/origin/microservices
  remotes/origin/microservices-docker
  remotes/origin/microservices_deprecated
  remotes/origin/microservices_for_mc
  remotes/origin/monolith
  remotes/origin/revert-6-microservices

> git checkout logging
Branch 'logging' set up to track remote branch 'logging' from 'origin'.
Switched to a new branch 'logging'

> tree -L 2 --dirsfirst
.
├── comment
│   ├── comment_app.rb
│   ├── config.ru
│   ├── docker_build.sh
│   ├── Gemfile
│   ├── Gemfile.lock
│   ├── helpers.rb
│   └── VERSION
├── post-py
│   ├── docker_build.sh
│   ├── helpers.py
│   ├── post_app.py
│   ├── requirements.txt
│   └── VERSION
├── ui
│   ├── views
│   ├── config.ru
│   ├── docker_build.sh
│   ├── Gemfile
│   ├── Gemfile.lock
│   ├── helpers.rb
│   ├── middleware.rb
│   ├── ui_app.rb
│   └── VERSION
└── README.md
```

Копируем эти файлы в наш каталог `src`.
Собираем образы и загружаем их на докер хаб.

```console
> export USER_NAME=r2d2k
> cd ./src/ui && bash docker_build.sh && docker push $USER_NAME/ui
...

> cd ../post-py && bash docker_build.sh && docker push $USER_NAME/post
...

> cd ../comment && bash docker_build.sh && docker push $USER_NAME/comment
...

> docker images
REPOSITORY      TAG            IMAGE ID       CREATED          SIZE
r2d2k/post      logging        3637ea2f7e34   37 seconds ago   210MB
r2d2k/comment   logging        9db45c86146f   2 minutes ago    187MB
r2d2k/ui        logging        ec99272cec4c   4 minutes ago    188MB
alpine          3.4            b7c5ffe56db7   3 years ago      4.81MB
python          3.6.0-alpine   cb178ebbf0f2   5 years ago      88.6MB
```

Образы подготовлены, теперь займёмся системой логирования. Будем использовать классическую связку ELK (Elasticsearch, Kibana, Logstash), только вместо Logstash возьмём Fluentd, он полегче. Получится EFK.

Для запуска системы создадим отдельный `docker/docker-compose-logging.yml`:
```yaml
version: '3'
services:
  fluentd:
    image: ${USERNAME}/fluentd
    ports:
      - "24224:24224"
      - "24224:24224/udp"

  elasticsearch:
    image: elasticsearch:7.4.0
    environment:
      - ELASTIC_CLUSTER=false
      - CLUSTER_NODE_MASTER=true
      - CLUSTER_MASTER_NODE_NAME=es01
      - discovery.type=single-node
    expose:
      - 9200
    ports:
      - "9200:9200"

  kibana:
    image: kibana:7.4.0
    ports:
      - "5601:5601"
```

Для запуска Fluentd подготовим образ с нужной нам конфигурацией.

`Dockerfile` создаём в каталоге `logging/fluentd`:
```Dockerfile
FROM fluent/fluentd:v0.12
RUN gem install --no-rdoc --no-ri --version 2.1.0 faraday-net_http
RUN gem install --no-rdoc --no-ri --version 1.10.2 faraday
RUN gem install --no-rdoc --no-ri --version 1.9.5 fluent-plugin-elasticsearch
RUN gem install --no-rdoc --no-ri --version 1.0.0 fluent-plugin-grok-parser
ADD fluent.conf /fluentd/etc
```

Рядом создаём файл конфигурации:
```html
<source>
  @type forward
  port 24224
  bind 0.0.0.0
</source>

<match *.**>
  @type copy
  <store>
    @type elasticsearch
    host elasticsearch
    port 9200
    logstash_format true
    logstash_prefix fluentd
    logstash_dateformat %Y%m%d
    include_tag_key true
    type_name access_log
    tag_key @log_name
    flush_interval 1s
  </store>
  <store>
    @type stdout
  </store>
</match>
```

Собираем образ:
```console
> docker build -t r2d2k/fluentd .
Sending build context to Docker daemon  3.072kB
Step 1/6 : FROM fluent/fluentd:v0.12
 ---> 5ad80e121366
Step 2/6 : RUN gem install --no-rdoc --no-ri --version 2.1.0 faraday-net_http
 ---> Running in e5f75bee3acc
Successfully installed faraday-net_http-2.1.0
1 gem installed
Removing intermediate container e5f75bee3acc
 ---> ad7785093b14
Step 3/6 : RUN gem install --no-rdoc --no-ri --version 1.10.2 faraday
 ---> Running in f9491d9f32b5
Successfully installed faraday-em_http-1.0.0
Successfully installed faraday-em_synchrony-1.0.0
Successfully installed faraday-excon-1.1.0
Successfully installed faraday-httpclient-1.0.1
Successfully installed multipart-post-2.2.3
Successfully installed faraday-multipart-1.0.4
Successfully installed faraday-net_http-1.0.1
Successfully installed faraday-net_http_persistent-1.2.0
Successfully installed faraday-patron-1.0.0
Successfully installed faraday-rack-1.0.0
Successfully installed faraday-retry-1.0.3
Successfully installed ruby2_keywords-0.0.5
Successfully installed faraday-1.10.2
13 gems installed
Removing intermediate container f9491d9f32b5
 ---> a8adad624361
Step 4/6 : RUN gem install --no-rdoc --no-ri --version 1.9.5 fluent-plugin-elasticsearch
 ---> Running in f2c42909dcbb
Successfully installed multi_json-1.15.0
Successfully installed elastic-transport-8.1.0
Successfully installed elasticsearch-api-8.5.0
Successfully installed elasticsearch-8.5.0
Successfully installed excon-0.94.0
Successfully installed fluent-plugin-elasticsearch-1.9.5
6 gems installed
Removing intermediate container f2c42909dcbb
 ---> 1e8267e11380
Step 5/6 : RUN gem install --no-rdoc --no-ri --version 1.0.0 fluent-plugin-grok-parser
 ---> Running in 60c68c694e6a
Successfully installed fluent-plugin-grok-parser-1.0.0
1 gem installed
Removing intermediate container 60c68c694e6a
 ---> d9f3026219f8
Step 6/6 : ADD fluent.conf /fluentd/etc
 ---> cd1dddbc6ca7
Successfully built cd1dddbc6ca7
Successfully tagged r2d2k/fluentd:latest
```

Меняем наш `docker-compose` для запуска сервисов с логированием:
```patch
diff --git a/docker/docker-compose.yml b/docker/docker-compose.yml
index d03c9f9..003e501 100644
--- a/docker/docker-compose.yml
+++ b/docker/docker-compose.yml
@@ -10,20 +10,20 @@ services:
       - back_net

   ui:
-    image: ${USERNAME}/ui:latest
+    image: ${USERNAME}/ui:logging
     ports:
       - ${UI_PORT}:9292/tcp
     networks:
       - front_net

   post:
-    image: ${USERNAME}/post:latest
+    image: ${USERNAME}/post:logging
     networks:
       - back_net
       - front_net

   comment:
-    image: ${USERNAME}/comment:latest
+    image: ${USERNAME}/comment:logging
     networks:
       - back_net
       - front_net
-  prometheus:
-    image: ${USERNAME}/prometheus:latest
-    ports:
-      - '9090:9090'
-    volumes:
-      - prometheus_data:/prometheus
-    command: # Передаем доп параметры в командной строке
-      - '--config.file=/etc/prometheus/prometheus.yml'
-      - '--storage.tsdb.path=/prometheus'
-      - '--storage.tsdb.retention=1d' # Задаем время хранения метрик в 1 день
-    networks:
-      - front_net
-      - back_net
-
-  node-exporter:
-    image: prom/node-exporter:v0.15.2
-    user: root
-    volumes:
-      - /proc:/host/proc:ro
-      - /sys:/host/sys:ro
-      - /:/rootfs:ro
-    command:
-      - '--path.procfs=/host/proc'
-      - '--path.sysfs=/host/sys'
-      - '--collector.filesystem.ignored-mount-points="^/(sys|proc|dev|host|etc)($$|/)"'
-    networks:
-      - front_net
-      - back_net
-
-  mongo-exporter:
-    image: percona/mongodb_exporter:0.35
-    command:
-      - '--mongodb.uri=mongodb://post_db:27017'
-      - '--collect-all'
-      - '--log.level=debug'
-    ports:
-      - '9216:9216'
-    networks:
-      - back_net
-
-  blackbox-exporter:
-    image: r2d2k/blackbox-exporter:1.0
-    ports:
-      - '9115:9115'
-    networks:
-      - front_net
-
 volumes:
   post_db:
-  prometheus_data:

 networks:
   front_net:
```

Стек запущен:
```console
> docker compose ps
NAME                COMMAND                  SERVICE             STATUS              PORTS
r2d2k-comment-1     "puma"                   comment             running
r2d2k-post-1        "python3 post_app.py"    post                running
r2d2k-post_db-1     "docker-entrypoint.s…"   post_db             running             27017/tcp
r2d2k-ui-1          "puma"                   ui                  running             0.0.0.0:9292->9292/tcp, :::9292->9292/tcp
```

Смотрим, что с логами `docker logs -f r2d2k-post-1`:
```json
{"event": "find_all_posts", "level": "info", "message": "Successfully retrieved all posts from the database", "params": {}, "request_id": "d8f9c2d9-88e8-4674-b40f-a875877266b3", "service": "post", "timestamp": "2022-11-10 18:32:45"}
{"addr": "10.0.1.3", "event": "request", "level": "info", "method": "GET", "path": "/posts?", "request_id": "d8f9c2d9-88e8-4674-b40f-a875877266b3", "response_status": 200, "service": "post", "timestamp": "2022-11-10 18:32:45"}
{"event": "find_all_posts", "level": "info", "message": "Successfully retrieved all posts from the database", "params": {}, "request_id": "0d704b11-5434-448f-bd83-9296bf965c68", "service": "post", "timestamp": "2022-11-10 18:32:47"}
{"addr": "10.0.1.3", "event": "request", "level": "info", "method": "GET", "path": "/posts?", "request_id": "0d704b11-5434-448f-bd83-9296bf965c68", "response_status": 200, "service": "post", "timestamp": "2022-11-10 18:32:47"}
```

Логи выглядят довольно структурированно. Настроим драйвер логирования для сервиса `post`:
```patch
diff --git a/docker/docker-compose.yml b/docker/docker-compose.yml
index 7db7f7d..bb38d2e 100644
--- a/docker/docker-compose.yml
+++ b/docker/docker-compose.yml
@@ -21,6 +21,11 @@ services:
     networks:
       - back_net
       - front_net
+    logging:
+      driver: "fluentd"
+      options:
+        fluentd-address: localhost:24224
+        tag: service.post

   comment:
     image: ${USERNAME}/comment:logging
```

Сначала запустим стек для приёма логов:
```console
> docker compose -f docker-compose-logging.yml up -d

> lynx -dump http://127.0.0.1:9200
{
  "name" : "4c627b97aef0",
  "cluster_name" : "docker-cluster",
  "cluster_uuid" : "jU1XzzAaRSitHuIUOysHnA",
  "version" : {
    "number" : "7.4.0",
    "build_flavor" : "default",
    "build_type" : "docker",
    "build_hash" : "22e1767283e61a198cb4db791ea66e3f11ab9910",
    "build_date" : "2019-09-27T08:36:48.569419Z",
    "build_snapshot" : false,
    "lucene_version" : "8.2.0",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}

> lynx -dump http://127.0.0.1:5601
   Loading Kibana

Please upgrade your browser

   This Kibana installation has strict security requirements enabled that
   your current browser does not meet.
```

Видим, что `elasticsearch` и `kibana` поднялись и отвечают на запросы.
Перезапустим стек нашего приложения `docker compose down`, затем `docker compose up -d`.
Создадим несколько постов и проверим, что видно в `kibana`.

Ничего не видно, создать индексы не можем, нет данных. Идём в логи `fluentd`, видим, что он не может найти транспорт `elasticsearch`.Говорят, что должен быть `gem elasticsearch`.

Для нормальной работы версии пакетов должны быть примерно одного времени выпуска. За ориентир возьмём `fluerntd-plugin-elasticsearch`.

OMG, версия 1.9.5 была выпущена 11 мая 2017 года. Ищем версию `gem elasticsearch` того же времени, это версия 6.2.0 выглядит подходящей.

Обновляем `Dockerfile` `fluentd`, собираем образ и запускаем стек. После запуска идём в `kibana`, создаём индекс, данные идут!

Записи мы получаем, но они выглядят, как строки, но в формате JSON:
```json
{"addr": "10.0.1.3", "event": "request", "level": "info", "method": "GET", "path": "/healthcheck?", "request_id": null, "response_status": 200, "service": "post", "timestamp": "2022-11-10 19:31:41"}
```

Можем разбить эту строку на поля, для этого используем фильры `fluentd`. Изменим конфиг:
```patch
index fedd386..9d2cb56 100644
--- a/logging/fluentd/fluent.conf
+++ b/logging/fluentd/fluent.conf
@@ -4,6 +4,12 @@
   bind 0.0.0.0
 </source>

+<filter service.post>
+  @type parser
+  format json
+  key_name log
+</filter>
+
 <match *.**>
   @type copy
   <store>
@@ -22,3 +28,4 @@
     @type stdout
   </store>
 </match>
```

Cоберём образ, перезапустим его и что мы видим? Видим, что строка разобрана на поля. Можем фильтровать, искать, что нам нужно.

Теперь разбираемся с неструктурированными логами. Сервис `ui` как раз занимается оправкой таких логов. Добавим к контейнеру драйвер для логирования:
```patch
index bb38d2e..fd85fe4 100644
--- a/docker/docker-compose.yml
+++ b/docker/docker-compose.yml
@@ -15,6 +15,11 @@ services:
       - ${UI_PORT}:9292/tcp
     networks:
       - front_net
+    logging:
+      driver: "fluentd"
+      options:
+        fluentd-address: localhost:24224
+        tag: service.ui

   post:
     image: ${USERNAME}/post:logging
```

Перезапускаем контейнер, видим логи сервиса `ui` следующего формата:
```console
I, [2022-11-10T19:52:07.401598 #1]  INFO -- : service=ui | event=request | path=/post/636d4abf9185ef0015c1116a/vote/1 | request_id=6378a322-909c-4c4e-907d-4fca282088af | remote_addr=192.168.10.97 | method= POST | response_status=303
```

Разобрать такие строки можно при помощи регулярных выражений.
Добавим фильтр в конфиг `fluentd`:
```patch
index 3ea4e43..93cead1 100644
--- a/logging/fluentd/fluent.conf
+++ b/logging/fluentd/fluent.conf
@@ -10,6 +10,12 @@
   key_name log
 </filter>

+<filter service.ui>
+  @type parser
+  format /\[(?<time>[^\]]*)\]  (?<level>\S+) (?<user>\S+)[\W]*service=(?<service>\S+)[\W]*event=(?<event>\S+)[\W]*(?:path=(?<path>\S+)[\W]*)?request_id=(?<request_id>\S+)[\W]*(?:remote_addr=(?<remote_addr>\S+)[\W]*)?(?:method= (?<method>\S+)[\W]*)?(?:response_status=(?<response_status>\S+)[\W]*)?(?:message='(?<message>[^\']*)[\W]*)?/
+  key_name log
+</filter>
+
 <match *.**>
   @type copy
   <store>
```

После пересборки и перезапуска контейнера `fluentd` видим, что строки разобраны по полям и доступны для поиска.
Чтобы не усложнять себе жизнь регулядными выражениями, можно использовать `grok` шаблоны.
Используем такой вместо фильтра на регулярных выражениях:
```patch
index 93cead1..0ef1c57 100644
--- a/logging/fluentd/fluent.conf
+++ b/logging/fluentd/fluent.conf
@@ -12,7 +12,8 @@

 <filter service.ui>
   @type parser
-  format /\[(?<time>[^\]]*)\]  (?<level>\S+) (?<user>\S+)[\W]*service=(?<service>\S+)[\W]*event=(?<event>\S+)[\W]*(?:path=(?<path>\S+)[\W]*)?request_id=(?<request_id>\S+)[\W]*(?:remote_addr=(?<remote_addr>\S+)[\W]*)?(?:method= (?<method>\S+)[\W]*)?(?:response_status=(?<response_status>\S+)[\W]*)?(?:message='(?<message>[^\']*)[\W]*)?/
+  format grok
+  grok_pattern %{RUBY_LOGGER}
   key_name log
 </filter>
```

После использования такого фильтра некоторые сообщения остаются в исходном виде.
```console
service=ui | event=show_all_posts | request_id=5a1d3778-88eb-4bce-827b-0998b559abe8 | message='Successfully showed the home page with posts' | params: "{}"
```
Для их разбора можно применить несколько фильтров последовательно. Применим ещё один фильтр.

```patch
index 0ef1c57..ed56fb4 100644
--- a/logging/fluentd/fluent.conf
+++ b/logging/fluentd/fluent.conf
@@ -17,6 +17,14 @@
   key_name log
 </filter>

+<filter service.ui>
+  @type parser
+  format grok
+  grok_pattern service=%{WORD:service} \| event=%{WORD:event} \| request_id=%{GREEDYDATA:request_id} \| message='%{GREEDYDATA:message}'
+  key_name message
+  reserve_data true
+</filter>
+
 <match *.**>
   @type copy
   <store>
```

**Результат №06-1:**
 - Подготовили окружение для сбора логов на базе EFK
 - Настроили передачу логов контейнера в базу
 - Настроили разбор структурированных логов при помощи стандартных фильтров
 - Настроили `grok` для обработки неструктурированных логов
 - Визуализировали логи с помощью `kibana`

---

**Задание №06-2:**
 - Разобрать осталные неструктурированные логи

**Решение №06-2:**

Часть записей остаётся неразобранной, напиример такая строка:
```console
service=ui | event=request | path=/ | request_id=47af35ff-46be-4dbd-83f8-6c544f3a0234 | remote_addr=192.168.10.97 | method= GET | response_status=200
```

Напишем для неё фильтр:
```patch
index 0ef1c57..7897957 100644
--- a/logging/fluentd/fluent.conf
+++ b/logging/fluentd/fluent.conf
@@ -17,6 +17,22 @@
   key_name log
 </filter>

+<filter service.ui>
+  @type parser
+  format grok
+  grok_pattern service=%{WORD:service} \| event=%{WORD:event} \| request_id=%{GREEDYDATA:request_id} \| message='%{GREEDYDATA:message}'
+  key_name message
+  reserve_data true
+</filter>
+
+<filter service.ui>
+  @type parser
+  format grok
+  grok_pattern service=%{WORD:service} \| event=%{WORD:event} \| path=%{URIPATH:path} \| request_id=%{UUID:request_id} \| remote_addr=%{IP:remote_addr} \| method= %{WORD:method} \| response_status=%{NUMBER:response_status}
+  key_name message
+</filter>
+
+
```

Для отладки шаблонов можно пользоваться [одним](https://grokdebug.herokuapp.com) из онлайн дебаггеров `grok`.

**Результат №06-2:**
 - После двух последовательных фильтров все сообщения сервиса `ui` начинают разбираться на составные части.

---

**Задание №06-3:**
 - Распределенный трейсинг

**Решение №06-3:**

Будем использовать `zipkin`.
Для этого добавим новый сервис в стек логирования:
```patch
index 5bd05c7..a003de5 100644
--- a/docker/docker-compose-logging.yml
+++ b/docker/docker-compose-logging.yml
@@ -22,3 +22,8 @@ services:
     image: kibana:7.4.0
     ports:
       - "5601:5601"
+
+  zipkin:
+    image: openzipkin/zipkin:2.21.0
+    ports:
+      - "9411:9411"
```

Для его включения каждому сервису добавим переменную окружения:
```patch
index fd85fe4..c930eb9 100644
--- a/docker/docker-compose.yml
+++ b/docker/docker-compose.yml
@@ -20,6 +20,8 @@ services:
       options:
         fluentd-address: localhost:24224
         tag: service.ui
+    environment:
+      - ZIPKIN_ENABLED=${ZIPKIN_ENABLED}

   post:
     image: ${USERNAME}/post:logging
@@ -31,12 +33,16 @@ services:
       options:
         fluentd-address: localhost:24224
         tag: service.post
+    environment:
+      - ZIPKIN_ENABLED=${ZIPKIN_ENABLED}

   comment:
     image: ${USERNAME}/comment:logging
     networks:
       - back_net
       - front_net
+    environment:
+      - ZIPKIN_ENABLED=${ZIPKIN_ENABLED}

 volumes:
   post_db:
```

Перезапускаем стек и открываем веб-интерфейс `zipkin`, порт 9411.
Ходим по веб-интерфейсу нашего приложения, но в `zipkin` ничего не появляется.
Правильно, мы не подключили `zipkin` к сетям нашего стека. Исправляем:
```patch
index a003de5..644012e 100644
--- a/docker/docker-compose-logging.yml
+++ b/docker/docker-compose-logging.yml
@@ -27,3 +27,19 @@ services:
     image: openzipkin/zipkin:2.21.0
     ports:
       - "9411:9411"
+    networks:
+      - front_net
+      - back_net
+
+networks:
+  front_net:
+    driver: bridge
+    ipam:
+      config:
+        - subnet: 10.0.1.0/24
+
+  back_net:
+    driver: bridge
+    ipam:
+      config:
+        - subnet: 10.0.2.0/24
```

Перезапускаем стек логирования, теперь данные сервисов собираются нормально.

**Результат №06-3:**
 - Мы настроили сбор данных о внутренних процессах сервисов при помощи `zipkin`

---

**Задание №06-4:**
 - Траблшутинг UI-экспириенса

 С нашим приложением происходит что-то странное.
 Пользователи жалуются, что при нажатии на пост они вынуждены долго ждать, пока у них загрузится страница с постом.
 Жалоб на загрузку других страниц не поступало. Нужно выяснить, в чем проблема, используя Zipkin.
 Код приложения с багом отличается от используемого ранее в этом ДЗ и доступен [в репозитории](https://github.com/Artemmkin/bugged-code) со сломанным кодом приложения.
 Т.е. необходимо сбилдить багнутую версию приложения и запустить Zipkin для неё.

**Решение №06-4:**
 - Качаем код по [ссылке](https://github.com/Artemmkin/bugged-code)
 - Размещаем в корне нашего репозитория, каталог `bugged-code`
 - Удаляем подкаталог `.git` в каталоге `bugged-code`
 - Правим `Gemfile`, меняем `https` на `http`. Контейнеры старые, все сертификаты давно протухли
 - Собираем образы при помощи `docker_build.sh`
 - Навешиваем на каждый образ тег `bug`
 - Делаем копию `docker-compose.yml` в `docker-compose-bug.yml`, меняя теги `logging` на `bug`
 - Останавливаем старый стек, поднимаем новый

Открываем главную страницу приложения, видим, что нам прямым текстом говорят:
```console
Can't show blog posts, some problems with the post service. Refresh?
```

Открываем `kibana`, в глаза бросается такая строка:
```console
Failed to read from Post service. Reason: Failed to open TCP connection to 127.0.0.1:4567 (Connection refused - connect(2) for "127.0.0.1" port 4567)
```

Проверяем, видим, что в `docker-compose-bug.yml` забыли указать переменные окружения для контейнеров и они не могут найти друг друга.
Исправим это:
```patch
--- docker/docker-compose.yml   2022-11-12 05:42:00.630286092 +0000
+++ docker/docker-compose-bug.yml       2022-11-12 12:06:08.709982815 +0000
@@ -10,7 +10,7 @@
       - back_net

   ui:
-    image: ${USERNAME}/ui:logging
+    image: ${USERNAME}/ui:bug
     ports:
       - ${UI_PORT}:9292/tcp
     networks:
@@ -21,10 +21,15 @@
         fluentd-address: localhost:24224
         tag: service.ui
     environment:
-      - ZIPKIN_ENABLED=${ZIPKIN_ENABLED}
+      - ZIPKIN_ENABLED=${ZIPKIN_ENABLED:-false}
+      - POST_SERVICE_HOST=${POST_SERVICE_HOST:-localhost}
+      - POST_SERVICE_PORT=${POST_SERVICE_PORT:-5000}
+      - COMMENT_SERVICE_HOST=${COMMENT_SERVICE_HOST:-localhost}
+      - COMMENT_SERVICE_PORT=${COMMENT_SERVICE_PORT:-9292}
+

   post:
-    image: ${USERNAME}/post:logging
+    image: ${USERNAME}/post:bug
     networks:
       - back_net
       - front_net
@@ -35,14 +40,20 @@
         tag: service.post
     environment:
       - ZIPKIN_ENABLED=${ZIPKIN_ENABLED}
+      - POST_DATABASE_HOST=${POST_DATABASE_HOST:-localhost}
+      - POST_DATABASE=${POST_DATABASE:-posts}
+

   comment:
-    image: ${USERNAME}/comment:logging
+    image: ${USERNAME}/comment:bug
     networks:
       - back_net
       - front_net
     environment:
       - ZIPKIN_ENABLED=${ZIPKIN_ENABLED}
+      - COMMENT_DATABASE_HOST=${COMMENT_DATABASE_HOST:-localhost}
+      - COMMENT_DATABASE=${COMMENT_DATABASE:-comments}
+

 volumes:
   post_db:
```

Перезапускаем стек с багами, теперь всё работает. При попытке открыть пост получаем задержку около 3 секунд.

В `zipkin` видим, что функция `db_find_single_post` сервиса `post` отрабатывает за 3 секунды.
Идём в исходники, ищем эту процедуру.
Видим странную задержку, комментируем:
```patch
index 1441173..da062f0 100644
--- a/bugged-code/post-py/post_app.py
+++ b/bugged-code/post-py/post_app.py
@@ -164,7 +164,7 @@ def find_post(id):
         stop_time = time.time()  # + 0.3
         resp_time = stop_time - start_time
         app.post_read_db_seconds.observe(resp_time)
-        time.sleep(3)
+#        time.sleep(3)
         log_event('info', 'post_find',
                   'Successfully found the post information',
                   {'post_id': id})
```

Пересобираем образ, перезапускаем стек, проверяем работу.
Процедура стала выполняться за 3 мс.

Прекрасно, ускорили сервис `post` в 1000 раз.

**Результат №06-4:**
 - Задержка при открытии поста вызвана `time.sleep(3)` в функции `db_find_single_post` сервиса `post`.

---

## 07 - Введение в kubernetes

**Задание №07-1:**
 - Разобрать на практике все компоненты Kubernetes, развернуть их вручную используя kubeadm
 - Ознакомиться с описанием основных примитивов нашего приложения и его дальнейшим запуском в Kubernetes

**Решение №07-1:**

Работу ведём в новой ветке `kubernetes-1`.

Опишем приложение в контексте `Kubernetes` с помощью манифестов в формате `yaml`.
Для каждого из четырёх сервисов создаём Deployment манифесты.

Содержимое `post-deployment.yml`:
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: post-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: post
  template:
    metadata:
      name: post
      labels:
        app: post
    spec:
      containers:
      - image: r2d2k/post
        name: post
```

Содержимое `ui-deployment.yml`:
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ui-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ui
  template:
    metadata:
      name: ui
      labels:
        app: ui
    spec:
      containers:
      - image: r2d2k/ui
        name: ui
```

Содержимое `comment-deployment.yml`:
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: comment-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: comment
  template:
    metadata:
      name: comment
      labels:
        app: comment
    spec:
      containers:
      - image: r2d2k/comment
        name: comment
```

Содержимое `mongo-deployment.yml`:
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mongo-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mongo
  template:
    metadata:
      name: mongo
      labels:
        app: mongo
    spec:
      containers:
      - image: mongo:3.2
        name: mongo
```

Развернуть k8s предложено при помощи `kubeadm` на двух нодах следующей конфигурации:
 - 4 GB RAM
 - 4 vCPU
 - 40 GB SSD

Виртуальные машины создадим в облаке Яндекс при помощи `terraform`. У нас уже подготовлен образ с `docker`, его и возьмём за основу.
Процедура неоднократно проводилась в предыдущих заданиях, поэтому не буду приводить подробности.

На данный момент у нас есть две виртуальные машины с установленным `docker`. Разворачивать кластер будем при помощи `ansible`.
Заготовку с динамическим инвентори возьмём из предыдущих заданий и убедимся, что всё функционирует как положено:
```console
> ansible all -m ping
fhmugpmt4brksfmqcfnf.auto.internal | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
fhmct74c8394a74ghbu1.auto.internal | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```

Читаем официальное [руководство](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/) по установке `kubeadm`, пишем плейбук.
```yaml
- name: k8s by kubeadm
  hosts: all
  become: true
  tasks:

  - name: Add k8s apt-key
    apt_key:
      url: https://packages.cloud.google.com/apt/doc/apt-key.gpg
      state: present

  - name: Add k8s repository
    apt_repository:
      repo: deb https://apt.kubernetes.io/ kubernetes-xenial main
      state: present

  - name: Install k8s utils
    apt:
      name: [kubelet, kubeadm, kubectl]
      state: present
      update_cache: true

  - name: Install cri-dockerd
    apt:
      deb: https://github.com/Mirantis/cri-dockerd/releases/download/v0.2.6/cri-dockerd_0.2.6.3-0.ubuntu-jammy_amd64.deb
      state: present


- name: Main node tasks
  hosts: fhmct74c8394a74ghbu1.auto.internal
  become: true
  tasks:

  - name: Init master node
    shell: kubeadm init --pod-network-cidr=10.244.0.0/16 --cri-socket unix://var/run/cri-dockerd.sock >> kubeadm_init.txt
    args:
      chdir: $HOME
      creates: kubeadm_init.txt

  - name: Create kubectl config dir
    file:
      path: /home/ubuntu/.kube
      state: directory
      owner: ubuntu
      group: ubuntu
      mode: 0755

  - name: Copy config for kubectl
    copy:
      src: /etc/kubernetes/admin.conf
      dest: /home/ubuntu/.kube/config
      remote_src: true
      owner: ubuntu
      group: ubuntu
      mode: 0600

  - name: Get join command
    shell: kubeadm token create --print-join-command
    register: join_command_out

  - name: Set join command
    set_fact:
      join_command: "{{ join_command_out.stdout_lines[0] }}"


- name: Worker node tasks
  hosts: fhmugpmt4brksfmqcfnf.auto.internal
  become: true
  tasks:

  - name: Join cluster
    shell: "{{ hostvars['fhmct74c8394a74ghbu1.auto.internal'].join_command }} --cri-socket unix://var/run/cri-dockerd.sock >> node_joined.txt"
    args:
      chdir: $HOME
      creates: hode_joined.txt
```

После запуска плейбука проверим состояние кластера на основной ноде:
```console
$ kubectl get nodes
NAME                   STATUS     ROLES           AGE   VERSION
fhmct74c8394a74ghbu1   NotReady   control-plane   10m   v1.25.4
fhmugpmt4brksfmqcfnf   NotReady   <none>          10s   v1.25.4
```

Проверяем состояние ноды при помощи `kubectl describe node ...`, видим такую ошибку:
```console
container runtime network not ready: NetworkReady=false reason:NetworkPluginNotReady message:docker: network plugin is not ready: cni config uninitialized
```

Как и описано в документации, устанавливаем `calico`:
```console
> kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
poddisruptionbudget.policy/calico-kube-controllers created
serviceaccount/calico-kube-controllers created
serviceaccount/calico-node created
configmap/calico-config created
customresourcedefinition.apiextensions.k8s.io/bgpconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/bgppeers.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/blockaffinities.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/caliconodestatuses.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/clusterinformations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/felixconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/globalnetworkpolicies.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/globalnetworksets.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/hostendpoints.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamblocks.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamconfigs.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamhandles.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ippools.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipreservations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/kubecontrollersconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/networkpolicies.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/networksets.crd.projectcalico.org created
clusterrole.rbac.authorization.k8s.io/calico-kube-controllers created
clusterrole.rbac.authorization.k8s.io/calico-node created
clusterrolebinding.rbac.authorization.k8s.io/calico-kube-controllers created
clusterrolebinding.rbac.authorization.k8s.io/calico-node created
daemonset.apps/calico-node created
deployment.apps/calico-kube-controllers created
```

Смотрим:
```console
> kubectl get nodes
NAME                   STATUS   ROLES           AGE   VERSION
fhmct74c8394a74ghbu1   Ready    control-plane   13m   v1.25.4
fhmugpmt4brksfmqcfnf   Ready    <none>          13s   v1.25.4
```

Применяем созданные ранее манифесты при помощи `kubectl apply -f <manifest_name>.yml`.

Проверяем результат:
```console
> kubectl get pods
NAME                                 READY   STATUS    RESTARTS   AGE
comment-deployment-7db9f6d87-47mqc   1/1     Running   0          38s
mongo-deployment-797dcbffd4-dpr7k    1/1     Running   0          2m9s
post-deployment-766cd985c7-r6whl     1/1     Running   0          42s
ui-deployment-75c5849b5c-tsn4h       1/1     Running   0          34s
```

Просто замечательно.

**Результат №07-1:**
 - При помощи `terraform` созданы виртуальные машины для нод кластера
 - При помощи `ansible` подготовлено окружение для кластера
 - Кластер инициализирован при помощи `kubeadm`
 - Ранее созданные манифесты применены к кластеру
 - Поды запущены

---

## 08 - Kubernetes. Запуск кластера и приложения. Модель безопасности

**Задание №08-1:**
 - Развернуть локальное окружение для работы с Kubernetes
 - Развернуть Kubernetes в Yandex Cloud
 - Запустить reddit в Kubernetes

**Решение №08-1:**

Работу ведём в новой ветке `kubernetes-2`.

Готовим окружение:
 - `kubectl` - главная утилита для работы с Kubernets API (все, что делает kubectl, можно сделать с помощью HTTP-запросов к API k8s)
 - `minikube` - утилита для разворачивания локальной инсталяции Kubernetes
 - ~/.kube - каталог, который содержит служебную информацию для kubectl (конфиги, кеши, схемы API)

`kubectl` будем ставить на Ubuntu "22.04.1 LTS (Jammy Jellyfish)".
Ставим по [официальной](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/) инструкции.

Проверяем результат:
```console
> kubectl version
Client Version: version.Info{Major:"1", Minor:"25", GitVersion:"v1.25.4", GitCommit:"872a965c6c6526caa949f0c6ac028ef7aff3fb78", GitTreeState:"clean", BuildDate:"2022-11-09T13:36:36Z", GoVersion:"go1.19.3", Compiler:"gc", Platform:"linux/amd64"}
Kustomize Version: v4.5.7
```

`minikube` устанавливаем подглядывая в [документацию](https://minikube.sigs.k8s.io/docs/start/).

Проверяем:
```console
> minikube version
minikube version: v1.28.0
commit: 986b1ebd987211ed16f8cc10aed7d2c42fc8392f
```

Поднимаем кластер:
```console
> minikube start
* minikube v1.28.0 on Ubuntu 22.04 (kvm/amd64)
* Using the docker driver based on existing profile
* Starting control plane node minikube in cluster minikube
* Pulling base image ...
* docker "minikube" container is missing, will recreate.
* Creating docker container (CPUs=2, Memory=2200MB) ...
* Preparing Kubernetes v1.25.3 on Docker 20.10.20 ...
  - Generating certificates and keys ...
  - Booting up control plane ...
  - Configuring RBAC rules ...
* Verifying Kubernetes components...
  - Using image gcr.io/k8s-minikube/storage-provisioner:v5
* Enabled addons: default-storageclass, storage-provisioner
* Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
```

В процессе поднятия кластера автоматически настраивается `kubectl`, проверим:
```console
> kubectl get nodes
NAME       STATUS   ROLES           AGE   VERSION
minikube   Ready    control-plane   10m   v1.25.3
```

Обновляем наши манифесты.

Содержимое `ui-deployment.yml`:
```yaml
apiVersion: apps/v1
kind: Deployment        # Deploy metadata
metadata:
  name: ui
  labels:
    app: reddit
    component: ui
spec:                   # Deploy specification
  replicas: 3
  selector:
    matchLabels:
      app: reddit
      component: ui
  template:             # Pod description
    metadata:
      name: ui-pod
      labels:
        app: reddit
        component: ui
    spec:
      containers:
      - image: r2d2k/ui
        name: ui
```

Проверяем:
```console
> kubectl apply -f ui-deployment.yml
deployment.apps/ui created

> kubectl get deployment
NAME   READY   UP-TO-DATE   AVAILABLE   AGE
ui     3/3     3            3           80s

> kubectl get pods
NAME                  READY   STATUS    RESTARTS   AGE
ui-65475c5d46-ggrds   1/1     Running   0          31s
ui-65475c5d46-m4mdp   1/1     Running   0          31s
ui-65475c5d46-vrzvf   1/1     Running   0          31s
```

Можно пробросить порт пода на локальную машину:
```console
> kubectl get pods --selector component=ui
NAME                  READY   STATUS    RESTARTS   AGE
ui-65475c5d46-ggrds   1/1     Running   0          3m44s
ui-65475c5d46-m4mdp   1/1     Running   0          3m44s
ui-65475c5d46-vrzvf   1/1     Running   0          3m44s

> kubectl port-forward ui-65475c5d46-ggrds 8080:9292
Forwarding from 127.0.0.1:8080 -> 9292
Forwarding from [::1]:8080 -> 9292
Handling connection for 8080
```

Проверим в соседней консоли:
```console
> lynx -dump http://127.0.0.1:8080
   (BUTTON) [1]Microservices Reddit in ui-65475c5d46-ggrds container

   Can't show blog posts, some problems with the post service. [2]Refresh?

Menu

     * [3]All posts
     * [4]New post

References

   1. http://127.0.0.1:8080/
   2. http://127.0.0.1:8080/
   3. http://127.0.0.1:8080/
   4. http://127.0.0.1:8080/new
```

Настроим остальные сервисы.

Содержимое `component-deployment.yml`:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: comment
  labels:
    app: reddit
    component: comment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: reddit
      component: comment
  template:
    metadata:
      name: comment
      labels:
        app: reddit
        component: comment
    spec:
      containers:
      - image: r2d2k/comment
        name: comment
```

Проверяем:
```console
> kubectl apply -f comment-deployment.yml
deployment.apps/comment created

> kubectl get deployment
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
comment   3/3     3            3           10s
ui        3/3     3            3           10m

> kubectl get pods
NAME                     READY   STATUS    RESTARTS   AGE
comment-f8fb4fdb-bb94z   1/1     Running   0          2m
comment-f8fb4fdb-krpwp   1/1     Running   0          2m
comment-f8fb4fdb-qcssw   1/1     Running   0          2m
ui-65475c5d46-ggrds      1/1     Running   0          10m
ui-65475c5d46-m4mdp      1/1     Running   0          10m
ui-65475c5d46-vrzvf      1/1     Running   0          10m

> kubectl port-forward comment-f8fb4fdb-bb94z 8080:9292
Forwarding from 127.0.0.1:8080 -> 9292
Forwarding from [::1]:8080 -> 9292
Handling connection for 8080
Handling connection for 8080
```

В соседней консоли проверим сервис:
```console
> lynx -dump http://127.0.0.1:8080/healthcheck
   {"status":0,"dependent_services":{"commentdb":0},"version":"0.0.3"}
```

Содержимое `post-deployment.yml`:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: post
  labels:
    app: reddit
    component: post
spec:
  replicas: 3
  selector:
    matchLabels:
      app: reddit
      component: post
  template:
    metadata:
      name: post
      labels:
        app: reddit
        component: post
    spec:
      containers:
      - image: r2d2k/post
        name: post
```

Проверяем:
```console
> kubectl apply -f post-deployment.yml
deployment.apps/post created

> kubectl get deployment
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
comment   3/3     3            3           10m
post      3/3     3            3           20s
ui        3/3     3            3           20m

> kubectl get pods
NAME                     READY   STATUS    RESTARTS   AGE
comment-f8fb4fdb-bb94z   1/1     Running   0          10m
comment-f8fb4fdb-krpwp   1/1     Running   0          10m
comment-f8fb4fdb-qcssw   1/1     Running   0          10m
post-86dd946b76-45nmr    1/1     Running   0          20s
post-86dd946b76-fjnrt    1/1     Running   0          20s
post-86dd946b76-tpc7h    1/1     Running   0          20s
ui-65475c5d46-ggrds      1/1     Running   0          20m
ui-65475c5d46-m4mdp      1/1     Running   0          20m
ui-65475c5d46-vrzvf      1/1     Running   0          20m

> kubectl port-forward post-86dd946b76-45nmr 8080:5000
Forwarding from 127.0.0.1:8080 -> 5000
Forwarding from [::1]:8080 -> 5000
```

В соседней консоли:
```console
> lynx -dump http://127.0.0.1:8080/healthcheck
   {"status": 0, "dependent_services": {"postdb": 0}, "version": "0.0.2"}
```

У базы данных появляется том для хранения данных.

Содержимое `mongo-deployment.yml`:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mongo
  labels:
    app: reddit
    component: mongo
spec:
  replicas: 1
  selector:
    matchLabels:
      app: reddit
      component: mongo
  template:
    metadata:
      name: mongo
      labels:
        app: reddit
        component: mongo
    spec:
      containers:
      - image: mongo:3.2
        name: mongo
        volumeMounts:                       # Mountpoint in container
        - name: mongo-persistent-storage
          mountPath: /data/db
      volumes:
      - name: mongo-persistent-storage
        emptyDir: {}
```

Смотрим результат:
```console
> kubectl get pods
NAME                     READY   STATUS    RESTARTS   AGE
comment-f8fb4fdb-bb94z   1/1     Running   0          20m
comment-f8fb4fdb-krpwp   1/1     Running   0          20m
comment-f8fb4fdb-qcssw   1/1     Running   0          20m
mongo-78fdcb9c65-7dntp   1/1     Running   0          20s
post-86dd946b76-45nmr    1/1     Running   0          10m
post-86dd946b76-fjnrt    1/1     Running   0          10m
post-86dd946b76-tpc7h    1/1     Running   0          10m
ui-65475c5d46-ggrds      1/1     Running   0          30m
ui-65475c5d46-m4mdp      1/1     Running   0          30m
ui-65475c5d46-vrzvf      1/1     Running   0          30m

> kubectl get deployment
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
comment   3/3     3            3           20m
mongo     1/1     1            1           20s
post      3/3     3            3           10m
ui        3/3     3            3           30m
```

В текущем состоянии приложение не будет работать, так его компоненты ещё не знают, как найти друг друга.

Для связи компонентов между собой и с внешним миром используется объект Service - абстракция, которая определяет набор POD-ов (Endpoints) и способ доступа к ним.

Создаём манифест сервиса для `comment`:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: comment
  labels:
    app: reddit
    component: comment
spec:
  ports:
  - port: 9292
    protocol: TCP
    targetPort: 9292
  selector:
    app: reddit
    component: comment
```

Проверяем:
```console
> kubectl apply -f comment-service.yml
service/comment created

> kubectl get services
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
comment      ClusterIP   10.111.231.173   <none>        9292/TCP   10s
kubernetes   ClusterIP   10.96.0.1        <none>        443/TCP    90m

> kubectl describe service comment
Name:              comment
Namespace:         default
Labels:            app=reddit
                   component=comment
Annotations:       <none>
Selector:          app=reddit,component=comment
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.111.231.173
IPs:               10.111.231.173
Port:              <unset>  9292/TCP
TargetPort:        9292/TCP
Endpoints:         172.17.0.6:9292,172.17.0.7:9292,172.17.0.8:9292
Session Affinity:  None
Events:            <none>

> kubectl exec post-86dd946b76-45nmr -- nslookup comment

Name:      comment
Address 1: 10.111.231.173 comment.default.svc.cluster.local
nslookup: can't resolve '(null)': Name does not resolve
```

Манифест для сервиса `post`:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: post
  labels:
    app: reddit
    component: post
spec:
  ports:
  - port: 5000
    protocol: TCP
    targetPort: 5000
  selector:
    app: reddit
    component: post
```

Проверяем:
```console
> kubectl apply -f post-service.yml
service/post created

> kubectl get services
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
comment      ClusterIP   10.111.231.173   <none>        9292/TCP   25m
kubernetes   ClusterIP   10.96.0.1        <none>        443/TCP    120m
post         ClusterIP   10.109.193.148   <none>        5000/TCP   10s

> kubectl describe service post
Name:              post
Namespace:         default
Labels:            app=reddit
                   component=post
Annotations:       <none>
Selector:          app=reddit,component=post
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.109.193.148
IPs:               10.109.193.148
Port:              <unset>  5000/TCP
TargetPort:        9292/TCP
Endpoints:         172.17.0.10:9292,172.17.0.11:9292,172.17.0.9:9292
Session Affinity:  None
Events:            <none>

> kubectl exec post-86dd946b76-45nmr -- nslookup post
nslookup: can't resolve '(null)': Name does not resolve

Name:      post
Address 1: 10.109.193.148 post.default.svc.cluster.local
```

Так, как с базой данных также нужно общаться по сети, то готовим `mongodb-service.yml`:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: mongodb
  labels:
    app: reddit
    component: mongo
spec:
  ports:
  - port: 27017
    protocol: TCP
    targetPort: 27017
  selector:
    app: reddit
    component: mongo
```

Проверяем:
```console
> kubectl apply -f mongodb-service.yml
service/mongodb created

> kubectl get services
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)     AGE
comment      ClusterIP   10.111.231.173   <none>        9292/TCP    50m
kubernetes   ClusterIP   10.96.0.1        <none>        443/TCP     130m
mongodb      ClusterIP   10.101.215.91    <none>        27017/TCP   20s
post         ClusterIP   10.109.193.148   <none>        5000/TCP    20m

> kubectl describe service mongodb
Name:              mongodb
Namespace:         default
Labels:            app=reddit
                   component=mongo
Annotations:       <none>
Selector:          app=reddit,component=mongo
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.101.215.91
IPs:               10.101.215.91
Port:              <unset>  27017/TCP
TargetPort:        27017/TCP
Endpoints:         172.17.0.12:27017
Session Affinity:  None
Events:            <none>

> kubectl exec post-86dd946b76-45nmr -- nslookup mongodb
nslookup: can't resolve '(null)': Name does not resolve

Name:      mongodb
Address 1: 10.101.215.91 mongodb.default.svc.cluster.local
```

Если пробросить порт сервиса `ui` наружу, попытаться подключиться к нему, то мы увидим ошибку.
Сервис `ui` ищет совсем другой адрес: `comment_db`, а не `mongodb`, как и сервис `comment` ищет `post_db`.
Эти адреса заданы в их `Dockerfile` в виде переменных окружения: `POST_DATABASE_HOST=post_db` и `COMMENT_DATABASE_HOST=comment_db`.

Пропишем в `deployment` этих сервисов переменные окружения, указывающие на сервис `mongodb`.
```patch
diff --git a/kubernetes/reddit/comment-deployment.yml b/kubernetes/reddit/comment-deployment.yml
index 4cecdab..380a34a 100644
--- a/kubernetes/reddit/comment-deployment.yml
+++ b/kubernetes/reddit/comment-deployment.yml
@@ -21,3 +21,6 @@ spec:
       containers:
       - image: r2d2k/comment
         name: comment
+        env:
+        - name: COMMENT_DATABASE_HOST
+          value: mongodb
diff --git a/kubernetes/reddit/post-deployment.yml b/kubernetes/reddit/post-deployment.yml
index 285ccb7..5a4499d 100644
--- a/kubernetes/reddit/post-deployment.yml
+++ b/kubernetes/reddit/post-deployment.yml
@@ -21,3 +21,6 @@ spec:
       containers:
       - image: r2d2k/post
         name: post
+        env:
+        - name: POST_DATABASE_HOST
+          value: mongodb
```

Применяем, проверяем:
```console
> kubectl apply -f kubernetes/reddit
deployment.apps/comment configured
service/comment unchanged
deployment.apps/mongo unchanged
service/mongodb unchanged
deployment.apps/post configured
service/post unchanged
deployment.apps/ui unchanged

> kubectl port-forward ui-65475c5d46-ggrds 8080:9292
Forwarding from 127.0.0.1:8080 -> 9292
Forwarding from [::1]:8080 -> 9292
Handling connection for 8080

> lynx -dump http://127.0.0.1:8080
   (BUTTON) [1]Microservices Reddit in ui-65475c5d46-ggrds container

   (BUTTON)

0

   (BUTTON)

[4]test

13-11-2022
12:10

   [5]Go to the link

Menu

     * [6]All posts
     * [7]New post

References

   1. http://127.0.0.1:8080/
   2. http://127.0.0.1:8080/post/6370ded06cf4fe000f485bf4
   3. http://test2.com/
   4. http://127.0.0.1:8080/post/6370de9ba04c21000f6482ab
   5. http://test.com/
   6. http://127.0.0.1:8080/
   7. http://127.0.0.1:8080/new
```

Видим сохранённые посты в базе, ошибок нет.

В методичке написано, что нужно сделать по отдельному сервису для `post` и `comment`. Причина мне пока непонятна, но раз просят, значит надо)
Создаём ещё два манифеста.

Содержимое `comment-mongodb-service.yml`:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: comment-db
  labels:
    app: reddit
    component: mongo
    comment-db: "true"
spec:
  ports:
  - port: 27017
    protocol: TCP
    targetPort: 27017
  selector:
    app: reddit
    component: mongo
    comment-db: "true"
```

Содержимое `post-mongodb-service.yml`:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: post-db
  labels:
    app: reddit
    component: mongo
    post-db: "true"
spec:
  ports:
  - port: 27017
    protocol: TCP
    targetPort: 27017
  selector:
    app: reddit
    component: mongo
    post-db: "true"
```

Ниже отражены изменения в существующих манифестах:
```patch
diff --git a/kubernetes/reddit/comment-deployment.yml b/kubernetes/reddit/comment-deployment.yml
index 380a34a..1c682bf 100644
--- a/kubernetes/reddit/comment-deployment.yml
+++ b/kubernetes/reddit/comment-deployment.yml
@@ -23,4 +23,4 @@ spec:
         name: comment
         env:
         - name: COMMENT_DATABASE_HOST
-          value: mongodb
+          value: comment-db
diff --git a/kubernetes/reddit/mongo-deployment.yml b/kubernetes/reddit/mongo-deployment.yml
index 50f3a11..f553bd7 100644
--- a/kubernetes/reddit/mongo-deployment.yml
+++ b/kubernetes/reddit/mongo-deployment.yml
@@ -5,6 +5,8 @@ metadata:
   labels:
     app: reddit
     component: mongo
+    comment-db: "true"
+    post-db: "true"
 spec:
   replicas: 1
   selector:
@@ -17,6 +19,8 @@ spec:
       labels:
         app: reddit
         component: mongo
+        comment-db: "true"
+        post-db: "true"
     spec:
       containers:
       - image: mongo:3.2
diff --git a/kubernetes/reddit/post-deployment.yml b/kubernetes/reddit/post-deployment.yml
index 5a4499d..75ffc08 100644
--- a/kubernetes/reddit/post-deployment.yml
+++ b/kubernetes/reddit/post-deployment.yml
@@ -23,4 +23,4 @@ spec:
         name: post
         env:
         - name: POST_DATABASE_HOST
-          value: mongodb
+          value: post-db
```

Применяем все манифесты в каталоге:
```console
> kubectl apply -f kubernetes/reddit/
deployment.apps/comment configured
service/comment-db created
service/comment unchanged
deployment.apps/mongo configured
service/mongodb unchanged
deployment.apps/post configured
service/post-db created
service/post unchanged
deployment.apps/ui unchanged

> kubectl get services
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)     AGE
comment      ClusterIP   10.111.231.173   <none>        9292/TCP    5h
comment-db   ClusterIP   10.108.201.61    <none>        27017/TCP   15s
kubernetes   ClusterIP   10.96.0.1        <none>        443/TCP     6h
mongodb      ClusterIP   10.101.215.91    <none>        27017/TCP   4h
post         ClusterIP   10.109.193.148   <none>        5000/TCP    4h
post-db      ClusterIP   10.99.236.22     <none>        27017/TCP   15s
```

Нам нужно как-то обеспечить доступ к `ui` снаружи, для этого нам понадобится Service для `ui`.
Создаём `ui-service.yml`:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: ui
  labels:
    app: reddit
    component: ui
spec:
  type: NodePort
  ports:
  - port: 9292
    protocol: TCP
    targetPort: 9292
  selector:
    app: reddit
    component: ui
```

Применяем:
```console
> kubectl apply -f kubernetes/reddit/
deployment.apps/comment unchanged
service/comment-db unchanged
service/comment unchanged
deployment.apps/mongo unchanged
service/mongodb unchanged
deployment.apps/post unchanged
service/post-db unchanged
service/post unchanged
deployment.apps/ui unchanged
service/ui created

> kubectl get services
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
comment      ClusterIP   10.111.231.173   <none>        9292/TCP         5h30m
comment-db   ClusterIP   10.108.201.61    <none>        27017/TCP        50m
kubernetes   ClusterIP   10.96.0.1        <none>        443/TCP          7h
mongodb      ClusterIP   10.96.201.234    <none>        27017/TCP        30m
post         ClusterIP   10.109.193.148   <none>        5000/TCP         5h
post-db      ClusterIP   10.99.236.22     <none>        27017/TCP        40m
ui           NodePort    10.111.205.235   <none>        9292:32145/TCP   10s
```

При работе с `minikube` можно получить доступ к `NodePort`, выглядит это так:
```console
> minikube service ui
|-----------|------|-------------|---------------------------|
| NAMESPACE | NAME | TARGET PORT |            URL            |
|-----------|------|-------------|---------------------------|
| default   | ui   |        9292 | http://192.168.49.2:32145 |
|-----------|------|-------------|---------------------------|
* Opening service default/ui in default browser...
```

После чего в браузере открывается наше приложение. Ходим по ссылкам, создаём заметки, всё работает.

Можно посмотреть список сервисов, которые доступны извне:
```console
> minikube service list
|-------------|------------|--------------|---------------------------|
|  NAMESPACE  |    NAME    | TARGET PORT  |            URL            |
|-------------|------------|--------------|---------------------------|
| default     | comment    | No node port |                           |
| default     | comment-db | No node port |                           |
| default     | kubernetes | No node port |                           |
| default     | mongodb    | No node port |                           |
| default     | post       | No node port |                           |
| default     | post-db    | No node port |                           |
| default     | ui         |         9292 | http://192.168.49.2:32145 |
| kube-system | kube-dns   | No node port |                           |
|-------------|------------|--------------|---------------------------|
```

В комплекте с `minikube` идёт достаточно большое количество дополнений:
```console
> minikube addons list
|-----------------------------|----------|--------------|--------------------------------|
|         ADDON NAME          | PROFILE  |    STATUS    |           MAINTAINER           |
|-----------------------------|----------|--------------|--------------------------------|
| ambassador                  | minikube | disabled     | 3rd party (Ambassador)         |
| auto-pause                  | minikube | disabled     | Google                         |
| cloud-spanner               | minikube | disabled     | Google                         |
| csi-hostpath-driver         | minikube | disabled     | Kubernetes                     |
| dashboard                   | minikube | disabled     | Kubernetes                     |
| default-storageclass        | minikube | enabled      | Kubernetes                     |
| efk                         | minikube | disabled     | 3rd party (Elastic)            |
| freshpod                    | minikube | disabled     | Google                         |
| gcp-auth                    | minikube | disabled     | Google                         |
| gvisor                      | minikube | disabled     | Google                         |
| headlamp                    | minikube | disabled     | 3rd party (kinvolk.io)         |
| helm-tiller                 | minikube | disabled     | 3rd party (Helm)               |
| inaccel                     | minikube | disabled     | 3rd party (InAccel             |
|                             |          |              | [info@inaccel.com])            |
| ingress                     | minikube | disabled     | Kubernetes                     |
| ingress-dns                 | minikube | disabled     | Google                         |
| istio                       | minikube | disabled     | 3rd party (Istio)              |
| istio-provisioner           | minikube | disabled     | 3rd party (Istio)              |
| kong                        | minikube | disabled     | 3rd party (Kong HQ)            |
| kubevirt                    | minikube | disabled     | 3rd party (KubeVirt)           |
| logviewer                   | minikube | disabled     | 3rd party (unknown)            |
| metallb                     | minikube | disabled     | 3rd party (MetalLB)            |
| metrics-server              | minikube | disabled     | Kubernetes                     |
| nvidia-driver-installer     | minikube | disabled     | Google                         |
| nvidia-gpu-device-plugin    | minikube | disabled     | 3rd party (Nvidia)             |
| olm                         | minikube | disabled     | 3rd party (Operator Framework) |
| pod-security-policy         | minikube | disabled     | 3rd party (unknown)            |
| portainer                   | minikube | disabled     | 3rd party (Portainer.io)       |
| registry                    | minikube | disabled     | Google                         |
| registry-aliases            | minikube | disabled     | 3rd party (unknown)            |
| registry-creds              | minikube | disabled     | 3rd party (UPMC Enterprises)   |
| storage-provisioner         | minikube | enabled      | Google                         |
| storage-provisioner-gluster | minikube | disabled     | 3rd party (Gluster)            |
| volumesnapshots             | minikube | disabled     | Kubernetes                     |
|-----------------------------|----------|--------------|--------------------------------|
```

При старте Kubernetes кластер имеет 3 namespace:
 - `default` - для объектов для которых не определен другой Namespace (в нём мы работали все это время)
 - `kube-system` - для объектов созданных Kubernetes и для управления им
 - `kube-public` - для объектов к которым нужен доступ из любой точки кластера

Для того, чтобы выбрать конкретное пространство имен, нужно указать флаг `-n` или `–namespace` при запуске `kubectl`.

Посмотрим, что у нас запущено для управления k8s:
```console
> kubectl get all -n kube-system
NAME                                   READY   STATUS    RESTARTS        AGE
pod/coredns-565d847f94-t8tjd           1/1     Running   0               7h
pod/etcd-minikube                      1/1     Running   0               7h
pod/kube-apiserver-minikube            1/1     Running   0               7h
pod/kube-controller-manager-minikube   1/1     Running   0               7h
pod/kube-proxy-95jk6                   1/1     Running   0               7h
pod/kube-scheduler-minikube            1/1     Running   0               7h
pod/storage-provisioner                1/1     Running   1 (7h57m ago)   7h

NAME               TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE
service/kube-dns   ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   7h

NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
daemonset.apps/kube-proxy   1         1         1       1            1           kubernetes.io/os=linux   7h

NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/coredns   1/1     1            1           7h

NAME                                 DESIRED   CURRENT   READY   AGE
replicaset.apps/coredns-565d847f94   1         1         1       7h
```

Включим `dashboard`:
```console
> minikube dashboard
* Enabling dashboard ...
  - Using image docker.io/kubernetesui/dashboard:v2.7.0
  - Using image docker.io/kubernetesui/metrics-scraper:v1.0.8
* Some dashboard features require the metrics-server addon. To enable all features please run:

        minikube addons enable metrics-server


* Verifying dashboard health ...
* Launching proxy ...
* Verifying proxy health ...
* Opening http://127.0.0.1:33067/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/ in your default browser...
```

После активации `dashboard` она откроется в браузере. Можно посмотреть состояние кластера со всх сторон:
 - Отслеживать состояние кластера и рабочих нагрузок в нём
 - Создавать новые объекты (загружать YAML-файлы)
 - Удалять и изменять объекты (кол-во реплик, YAML-файлы)
 - Отслеживать логи в POD-ах
 - При включении Heapster-аддона смотреть нагрузку на POD-ах

Воспользуемся `namespace` для отделения среды разработки нашего приложения от всего остального. Готовим манифест `dev-namespace.yml`:
```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: dev
```

Применяем:
```console
> kubectl apply -f dev-namespace.yml
namespace/dev created
```

Запускаем наше приложение в `dev`:
```console
> kubectl apply -n dev -f kubernetes/reddit/
deployment.apps/comment created
service/comment-db created
service/comment created
namespace/dev unchanged
deployment.apps/mongo created
service/mongodb created
deployment.apps/post created
service/post-db created
service/post created
deployment.apps/ui created
service/ui created

> kubectl get services -n dev
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
comment      ClusterIP   10.111.173.253   <none>        9292/TCP         99s
comment-db   ClusterIP   10.111.33.252    <none>        27017/TCP        99s
mongodb      ClusterIP   10.96.223.27     <none>        27017/TCP        99s
post         ClusterIP   10.105.189.255   <none>        5000/TCP         99s
post-db      ClusterIP   10.99.182.120    <none>        27017/TCP        99s
ui           NodePort    10.108.95.203    <none>        9292:30282/TCP   99s
```

Проверяем `minikube service ui -n dev`, всё работает.

**Результат №08-1:**
- При помощи `minikube` был развёрнут локальный k8s
- Подготовлены манифесты для запуска приложения `reddit` в k8s
- Приложение запущено в локальном кластере и оно работает

---

**Задание №08-2:**
 - Мы подготовили наше приложение в локальном окружении.
 - Самое время запустить его на реальном кластере Kubernetes.
 - В качестве основной платформы будем использовать Yandex Cloud "Managed Service for kubernetes"

**Решение №08-2:**
 - Идём в Yandex Cloud, перейдите в "Managed Service for kubernetes"
 - Жмём "Создать Cluster"
 - Имя кластера может быть произвольным
 - Если нет сервис аккаунта его можно создать
 - Релизный канал *** Rapid ***
 - Версия k8s 1.19
 - Зона доступности - на ваше усмотрение (сети - аналогично)
 - Жмём "Создать"" и ждём, пока поднимется кластер
 - После создания кластера, вам нужно создать группу узлов, входящих в кластер
 - Версия k8s 1.19
 - Количество узлов - 2
 - vCPU - 4
 - RAM - 8
 - Disk - SSD 64ГБ (минимальное значение)
 - В поле "Доступ" добавьте свой логин и публичный ssh-ключ

После поднятия кластера настраиваем к нему доступ:
```console
> yc managed-kubernetes cluster get-credentials test-cluster --external

> kubectl config get-contexts
CURRENT   NAME              CLUSTER                               AUTHINFO                              NAMESPACE
          minikube          minikube                              minikube                              default
*         yc-test-cluster   yc-managed-k8s-********************   yc-managed-k8s-********************
```

Запускаем наше приложение:
```console
> kubectl apply -f kubernetes/reddit/dev-namespace.yml
namespace/dev created

> kubectl apply -f kubernetes/reddit/ -n dev
deployment.apps/comment created
service/comment-db created
service/comment created
namespace/dev unchanged
deployment.apps/mongo created
service/mongodb created
deployment.apps/post created
service/post-db created
service/post created
deployment.apps/ui created
service/ui created

> kubectl get services -n dev
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
comment      ClusterIP   10.96.205.17    <none>        9292/TCP         108s
comment-db   ClusterIP   10.96.184.40    <none>        27017/TCP        109s
mongodb      ClusterIP   10.96.166.9     <none>        27017/TCP        108s
post         ClusterIP   10.96.132.178   <none>        5000/TCP         108s
post-db      ClusterIP   10.96.184.43    <none>        27017/TCP        108s
ui           NodePort    10.96.204.142   <none>        9292:31706/TCP   107s

> kubectl get pods -n dev
NAME                       READY   STATUS    RESTARTS   AGE
comment-7799d6d7cf-f4csf   1/1     Running   0          2m
comment-7799d6d7cf-r8p6f   1/1     Running   0          2m
comment-7799d6d7cf-z5f6q   1/1     Running   0          2m
mongo-6b9fcfd49f-h9vkf     1/1     Running   0          119s
post-678cc6585-74794       1/1     Running   0          119s
post-678cc6585-j2895       1/1     Running   0          119s
post-678cc6585-rmkr8       1/1     Running   0          119s
ui-565b9d6499-56q9w        1/1     Running   0          118s
ui-565b9d6499-d2fvb        1/1     Running   0          118s
ui-565b9d6499-gtlsf        1/1     Running   0          118s

> kubectl get nodes -o wide
NAME                        STATUS   ROLES    AGE   VERSION   INTERNAL-IP   EXTERNAL-IP      OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
cl16c21m1fm9vhbf0rap-isyc   Ready    <none>   18m   v1.22.6   10.129.0.23   51.250.23.100    Ubuntu 20.04.4 LTS   5.4.0-124-generic   containerd://1.6.7
cl16c21m1fm9vhbf0rap-urer   Ready    <none>   18m   v1.22.6   10.129.0.10   84.201.140.137   Ubuntu 20.04.4 LTS   5.4.0-124-generic   containerd://1.6.7
```

Из вывода выше берём внешние адреса нод и порт приложения, проверяем:
```console
> lynx -dump http://51.250.23.100:31706/
   (BUTTON) [1]Microservices Reddit in dev ui-565b9d6499-d2fvb container

Menu

     * [2]All posts
     * [3]New post

References

   1. http://51.250.23.100:31706/
   2. http://51.250.23.100:31706/
   3. http://51.250.23.100:31706/new
amur@vm-minikube ~/r2d2k_microservices (kubernetes-2)> lynx -dump http://84.201.140.137:31706/
   (BUTTON) [1]Microservices Reddit in dev ui-565b9d6499-d2fvb container

Menu

     * [2]All posts
     * [3]New post

References

   1. http://84.201.140.137:31706/
   2. http://84.201.140.137:31706/
   3. http://84.201.140.137:31706/new
```

Оба адреса в ответ возвращают наше приложение. Успех.

**Результат №08-2:**
 - В Yandex Cloud развёрнут кластер k8s
 - В этом кластере запущено приложение `reddit`

---

**Задание №08-3**
 - Разверните Kubernetes-кластер в Yandex cloud с помощью Terraform
 - Создайте YAML-манифесты для описания созданных сущностей для включения dashboard
 - Приложите конфигурацию к PR

**Решение №08-3**

Для создания кластера в облаке при помощи `terraform` придётся изучить документацию:
 - [yandex_kubernetes_cluster](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_cluster)
 - [yandex_kubernetes_node_group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_node_group)

Что у нас получается в итоге:
```hcl
resource "yandex_kubernetes_cluster" "yc_cluster" {

  name                    = var.cluster_name

  master {

    zonal {
      zone      = var.zone
      subnet_id = var.subnet_id
    }

    version               = var.k8s_version
    public_ip             = true
  }

  network_id              = var.network_id

  service_account_id      = var.service_account_id
  node_service_account_id = var.service_account_id

  release_channel         = "RAPID"
  network_policy_provider = "CALICO"
}

resource "yandex_kubernetes_node_group" "my_node_group" {

  cluster_id  = yandex_kubernetes_cluster.yc_cluster.id
  version     = var.k8s_version

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat                = true
      subnet_ids         = [var.subnet_id]
    }

    resources {
      memory = var.node_memory_size
      cores  = var.node_cpu_count
    }

    boot_disk {
      type = "network-ssd"
      size = var.node_disk_size
    }

    scheduling_policy {
      preemptible = false
    }

    container_runtime {
      type = "containerd"
    }
  }

  scale_policy {
    fixed_scale {
      size = 1
    }
  }
}
```

Применяем конфигурацию, добавляем полученный кластер в локальную конфигурацию:
```console
> yc managed-kubernetes cluster get-credentials test-cluster --external

Context 'yc-test-cluster' was added as default to kubeconfig '/home/.../.kube/config'.
Check connection to cluster using 'kubectl cluster-info --kubeconfig /home/.../.kube/config'.

Note, that authentication depends on 'yc' and its config profile 'default'.
To access clusters using the Kubernetes API, please use Kubernetes Service Account.

> kubectl config get-contexts
CURRENT   NAME              CLUSTER                               AUTHINFO                              NAMESPACE
          minikube          minikube                              minikube                              default
*         yc-test-cluster   yc-managed-k8s-********************   yc-managed-k8s-********************

> kubectl cluster-info
Kubernetes control plane is running at https://51.250.9.224
CoreDNS is running at https://51.250.9.224/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
```

Для установки `dashboard` воспользуемся стандартным манифестом со [страницы](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/) разработчика. Сохраним манифест в каталог `kubernetes/dashboard`.

Для того, чтобы полноценно управлять кластером, нужно создать пользователя с ролью `cluster-admin`. Подготовим манифест `user-admin.yaml` и сохраним его рядом с манифестом `dashboard`:
```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
 name: admin-user
 namespace: kubernetes-dashboard

apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
 name: admin-user
roleRef:
 apiGroup: rbac.authorization.k8s.io
 kind: ClusterRole
 name: cluster-admin
subjects:
- kind: ServiceAccount
 name: admin-user
 namespace: kubernetes-dashboard
```

Применим манифесты:
```console
> kubectl apply -f dashboard/
namespace/kubernetes-dashboard created
serviceaccount/kubernetes-dashboard created
service/kubernetes-dashboard created
secret/kubernetes-dashboard-certs created
secret/kubernetes-dashboard-csrf created
secret/kubernetes-dashboard-key-holder created
configmap/kubernetes-dashboard-settings created
role.rbac.authorization.k8s.io/kubernetes-dashboard created
clusterrole.rbac.authorization.k8s.io/kubernetes-dashboard created
rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
clusterrolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
deployment.apps/kubernetes-dashboard created
service/dashboard-metrics-scraper created
deployment.apps/dashboard-metrics-scraper created
serviceaccount/admin-user created
clusterrolebinding.rbac.authorization.k8s.io/admin-user created

> kubectl get pods --all-namespaces
NAMESPACE              NAME                                                  READY   STATUS    RESTARTS      AGE
kube-system            calico-node-b58hl                                     1/1     Running   0             24m
kube-system            calico-typha-58f9b7574f-xwj9t                         1/1     Running   0             33m
kube-system            calico-typha-79cddf6bd8-grs5x                         0/1     Pending   0             22m
kube-system            calico-typha-horizontal-autoscaler-8495b957fc-hrxnn   1/1     Running   0             33m
kube-system            calico-typha-vertical-autoscaler-6cc57f94f4-wh4j7     1/1     Running   3 (23m ago)   33m
kube-system            coredns-5f8dbbff8f-74wlt                              1/1     Running   0             33m
kube-system            ip-masq-agent-qnlcr                                   1/1     Running   0             24m
kube-system            kube-dns-autoscaler-598db8ff9c-gp8jj                  1/1     Running   0             33m
kube-system            kube-proxy-5q2xz                                      1/1     Running   0             24m
kube-system            metrics-server-7574f55985-hjl2g                       2/2     Running   0             23m
kube-system            npd-v0.8.0-kfflp                                      1/1     Running   0             24m
kube-system            yc-disk-csi-node-v2-p8hkl                             6/6     Running   0             24m
kubernetes-dashboard   dashboard-metrics-scraper-7c857855d9-54nhw            1/1     Running   0             2m
kubernetes-dashboard   kubernetes-dashboard-6b79449649-r2cxq                 1/1     Running   0             2m
```
Для доступа к `dashboard` запускаем `kubectl proxy`, на этой же машине переходим по адресу http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/. У нас запрашивают токен, который можно получить следующим образом:
```console
> kubectl get secret -n kubernetes-dashboard $(kubectl get serviceaccount admin-user -n kubernetes-dashboard -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode
```

Вводим токен для авторизации и попадаем в `dashboard`.

**Результат №08-3**
 - При помощи `terraform` поднят кластер k8s в Yandex Cloud
 - Подготовлены и проверенв а работе манифесты для запуска `dashboard` и создания пользователя с правами администратора

---

## 09 - Kubernetes. Networks, Storages

**Задание №09-1:**
 - Ingress Controller
 - Ingress
 - Secret
 - TLS
 - LoadBalancer Service
 - Network Policies
 - PersistentVolumes
 - PersistentVolumeClaims

**Решение №09-1:**

Работаем в новой ветке `kubernetes-3`.

При помощи `terraform` в Yandex Cloud поднимаем кластер, который готовили в предыдущем задании.
Пока кластер поднимается (занимает минут десять), разбермся с балансировщиком.

Тип LoadBalancer позволяет нам использовать внешний облачный балансировщик нагрузки как единую точку входа в наши сервисы, а не полагаться на IPTables и не открывать наружу весь кластер. Настроим соответствующим образом сервис `ui`, правим `ui-service.yml`:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: ui
  labels:
    app: reddit
    component: ui
spec:
  type: LoadBalancer
  ports:
  - port: 80
    protocol: TCP
    targetPort: 9292
  selector:
    app: reddit
    component: ui
```

Регистрируем кластер в локальном окружении:
```console
> yc managed-kubernetes cluster get-credentials test-cluster --external
...

> kubectl cluster-info
Kubernetes control plane is running at https://158.160.39.143
CoreDNS is running at https://158.160.39.143/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
```

Применяем манифесты и проверяем результат:
```console
> kubectl apply -f kubernetes/reddit/dev-namespace.yml
namespace/dev created

> kubectl apply -n dev -f kubernetes/redditdeployment.apps/comment created
service/comment-db created
service/comment created
namespace/dev unchanged
deployment.apps/mongo created
service/mongodb created
deployment.apps/post created
service/post-db created
service/post created
deployment.apps/ui created
service/ui created

> kubectl get pods -n dev
NAME                       READY   STATUS    RESTARTS   AGE
comment-7799d6d7cf-mg5lj   1/1     Running   0          60s
comment-7799d6d7cf-t5pzf   1/1     Running   0          60s
comment-7799d6d7cf-xn2bs   1/1     Running   0          60s
mongo-6b9fcfd49f-5rgwm     1/1     Running   0          60s
post-678cc6585-4ssr5       1/1     Running   0          60s
post-678cc6585-q6fpb       1/1     Running   0          60s
post-678cc6585-z8dwf       1/1     Running   0          60s
ui-565b9d6499-4n9ck        1/1     Running   0          60s
ui-565b9d6499-8cmg5        1/1     Running   0          60s
ui-565b9d6499-r2826        1/1     Running   0          60s

> kubectl get services -n dev
NAME         TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)        AGE
comment      ClusterIP      10.96.158.99    <none>           9292/TCP       100s
comment-db   ClusterIP      10.96.170.3     <none>           27017/TCP      100s
mongodb      ClusterIP      10.96.226.69    <none>           27017/TCP      100s
post         ClusterIP      10.96.176.224   <none>           5000/TCP       100s
post-db      ClusterIP      10.96.243.20    <none>           27017/TCP      100s
ui           LoadBalancer   10.96.146.125   158.160.37.149   80:31746/TCP   100s

> lynx -dump http://158.160.37.149/
   (BUTTON) [1]Microservices Reddit in dev ui-565b9d6499-8cmg5 container

Menu

     * [2]All posts
     * [3]New post

References

   1. http://158.160.37.149/
   2. http://158.160.37.149/
   3. http://158.160.37.149/new
```

Видим, что все поды поднялись, сервисы работают, а у сервиса `LoadBalancer` появился внешний адрес. По этому адресу и доступно наше приложение.

Балансировка с помощью Service типа `LoadBalancer` имеет ряд недостатков:
 - Нельзя управлять с помощью http URI (L7-балансировщика)
 - Используются только облачные балансировщики
 - Нет гибких правил работы с трафиком

Для более удобного управления входящим снаружи трафиком и решения недостатков LoadBalancer можно использовать другой объект Kubernetes - Ingress

Ingress - это набор правил внутри кластера Kuberntes, предназначенных для того, чтобы входящие подключения могли достичь сервисов. Сами по себе Ingress'ы это просто правила. Для их применения нужен Ingress Controller.

Ingress Controller - это скорее плагин (а значит и отдельный POD), который состоит из 2-х функциональных частей:
 - Приложение, которое отслеживает через k8s API новые объекты Ingress и обновляет конфигурацию балансировщика
 - Балансировщик (Nginx, haproxy, traefik, ...), который и занимается управлением сетевым трафиком

Основные задачи, решаемые с помощью Ingress'ов:
 - Организация единой точки входа в приложения снаружи
 - Обеспечение балансировки трафика
 - Терминация SSL
 - Виртуальный хостинг на основе имен

Установим `ingress controller`:
```console
> kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.5.1/deploy/static/provider/cloud/deploy.yaml

namespace/ingress-nginx created
serviceaccount/ingress-nginx created
serviceaccount/ingress-nginx-admission created
role.rbac.authorization.k8s.io/ingress-nginx created
role.rbac.authorization.k8s.io/ingress-nginx-admission created
clusterrole.rbac.authorization.k8s.io/ingress-nginx created
clusterrole.rbac.authorization.k8s.io/ingress-nginx-admission created
rolebinding.rbac.authorization.k8s.io/ingress-nginx created
rolebinding.rbac.authorization.k8s.io/ingress-nginx-admission created
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx created
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx-admission created
configmap/ingress-nginx-controller created
service/ingress-nginx-controller created
service/ingress-nginx-controller-admission created
deployment.apps/ingress-nginx-controller created
job.batch/ingress-nginx-admission-create created
job.batch/ingress-nginx-admission-patch created
ingressclass.networking.k8s.io/nginx created
validatingwebhookconfiguration.admissionregistration.k8s.io/ingress-nginx-admission created
```

Создадим манифест `ingress` для сервиса `ui`:
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ui
spec:
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: ui
            port:
              number: 9292
```

Применим:
```console
> kubectl apply -n dev -f ui-ingress.yml
ingress.networking.k8s.io/ui configured
```

Проверим статус:
```console
> kubectl get ingress ui -n dev
NAME   CLASS   HOSTS   ADDRESS        PORTS   AGE
ui     nginx   *       62.84.124.91   80      12m

> lynx -dump http://62.84.124.91/
   (BUTTON) [1]Microservices Reddit in dev ui-565b9d6499-8cmg5 container

Menu

     * [2]All posts
     * [3]New post

References

   1. http://62.84.124.91/
   2. http://62.84.124.91/
   3. http://62.84.124.91/new
```

Теперь давайте защитим наш сервис с помощью TLS.
Генерируем сертификат:
```console
> openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=62.84.124.91"
..+.....+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*......+...+..+...+......+....+.................+.+.....+....+...+.....+...+............+.+..+...+.+...+.....+............+.............+...........+......+...............+.+..+.+..+....+........+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*..+......+.........+.+..+............+.......+......+........+....+...+.....+............+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
...+.....+...+...+...+.........+.+..+.......+..+.+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.+....+...+..+.........+....+......+..+.........+...+...+...+....+...+...+......+.....+...+.+.....+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*..+....+........+......+..........+.....+......+..........+......+..............+...+.......+........+.+..+....+.........+..+............+......+.+.....+....+......+...+..+.........+....+........+...+............+....+.....+...+......+.......+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-----
```

Создаём секрет с данным сертификатом:
```console
> kubectl create secret tls ui-ingress --key tls.key --cert tls.crt -n dev
secret/ui-ingress created

> kubectl describe secret ui-ingress -n dev
Name:         ui-ingress
Namespace:    dev
Labels:       <none>
Annotations:  <none>

Type:  kubernetes.io/tls

Data
====
tls.crt:  1123 bytes
tls.key:  1704 bytes
```

Обновим манифест `ui-ingress.yml`:
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ui
  annotations:
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
spec:
  ingressClassName: nginx
  tls:
  - secretName: ui-ingress
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: ui
            port:
              number: 9292
```

Применяем, проверяем:
```console
> kubectl apply -n dev -f ui-ingress.yml
ingress.networking.k8s.io/ui configured

> kubectl get ingress ui -n dev
NAME   CLASS   HOSTS   ADDRESS        PORTS     AGE
ui     nginx   *       62.84.124.91   80, 443   26m

> kubectl describe ingress ui -n dev
Name:             ui
Labels:           <none>
Namespace:        dev
Address:          62.84.124.91
Ingress Class:    nginx
Default backend:  <default>
TLS:
  ui-ingress terminates
Rules:
  Host        Path  Backends
  ----        ----  --------
  *
              /   ui:9292 (10.112.128.23:9292,10.112.128.24:9292,10.112.128.25:9292)
Annotations:  nginx.ingress.kubernetes.io/force-ssl-redirect: true
Events:
  Type    Reason  Age                  From                      Message
  ----    ------  ----                 ----                      -------
  Normal  Sync    2m21s (x8 over 20m)  nginx-ingress-controller  Scheduled for sync

> lynx -dump http://62.84.124.91
                           308 Permanent Redirect
     __________________________________________________________________

                                    nginx
```

Наш сервис отвечает по `https`, а при обращении на `http` делает редирект.

**Результат №09-1:**
 - Создан `ingress controller`
 - Создан `ingress`
 - Настроено шифрование трафика при помощи сертификата (HTTPS)

 ---

**Задание №09-2:**
 - Опишите создаваемый объект Secret в виде Kubernetes-манифеста

**Решение №09-2:**

Предлагаю не мудрить. Готовый секрет у нас есть, поэтому добудем его содержимое:
```console
> kubectl edit secret ui-ingress -n dev

apiVersion: v1
data:
  tls.crt: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUREekNDQWZlZ0F3SUJBZ0lVU2dUaGxZeGFXejBSTVdBc1VPMnBTSHNhWXc4d0RRWUpLb1pJaHZjTkFRRUwKQlFBd0Z6RVZNQk1HQTFVRUF3d01Oakl1T0RRdU1USTBMamt4TUI0WERUSXlNVEV4TkRFM05UZ3pNVm9YRFRJegpNVEV4TkRFM05UZ3pNVm93RnpFVk1CTUdBMVVFQXd3TU5qSXVPRFF1TVRJMExqa3hNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUF6ZVBzMVYvT050MmNhK3k2OURFWnkzTENiZ3NKNmo2ZzJvelkKYkhyQlBWaGJmYnNEMGNtakZmdWVpY0J6eldOVkZZeGJPQWV3dXpwcDJmYnJPR3lvSzhUWUx4VXVQSVVucW1XZwp3eVpaMDlUN2pxak1STnFmQTBoekJDVGE3VW82ajBqUGZvMWQyZ1UwaXQ4MHl2UTVUbXhValdja2ZHSFlKRU9DCjBiRTdzSkRQZVVHcW9yU3c2RVRYWkUramlDTHIrRHU5d09rV01oekI0MlhvZU1NOHVrOVh3bnBTdUdGZHRheGMKNE1CVTN6djg2OGprdStYV1FKU2Z2NWMwdE5EMXlHZmFnaUJnMmNnTVloQW4waS9SZmVrVS9YSk5URlJkVThjZwpMMGJyWDgwOHdLNjA5c2R4c2tjTlVId253U1p2MWNqK3JkVlkvRGQ0eDBMeHRzS1YwUUlEQVFBQm8xTXdVVEFkCkJnTlZIUTRFRmdRVU5IYlhacExaejlSekVxY0lEaGthZnRpRUhYZ3dId1lEVlIwakJCZ3dGb0FVTkhiWFpwTFoKejlSekVxY0lEaGthZnRpRUhYZ3dEd1lEVlIwVEFRSC9CQVV3QXdFQi96QU5CZ2txaGtpRzl3MEJBUXNGQUFPQwpBUUVBWUw1UVRYRk5zU3htckJyNERmQ3lUUXBaNlA3eFdQN1NnVE9DenN5M3ZpalNjZ3pPUkt0cjJMSk5GYzdICnE3WDlGL1FVbzRpZ1VlVmlaaytDek80QURwa2FMWUlmWGM5K2NEQWE1ZjY0Q1dPYXV6Z2k2cCs5NUNRd2N0VzEKa1RsdzJaK3BPYkp1SEZEZ09MQ0lLbXA4cGIvVFlGU3VxMk9OdFBWMjk1V29Wd0dkSllBZHhBTkRGczdzOXBYego1S0dYRWNURlg3aFZOOUFSZFNzUEZiRW56M1YrRFRKQnVpWkNDNXJGZmc3MFdpVWErZkhvalh6WWlTbGg1OEh0CnVMcjlYNlM5bHJtcDF0YXdYcERXS1V1MStPU1pYMUJiOGpJM2Q5YmxIMXlTNlA3MlljKzV5QU9GOSs5VVBia2QKeng3dmNWMWF6eVVKdHREa0hLeklKT0g4elE9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
  tls.key: LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JSUV2UUlCQURBTkJna3Foa2lHOXcwQkFRRUZBQVNDQktjd2dnU2pBZ0VBQW9JQkFRRE40K3pWWDg0MjNaeHIKN0xyME1Sbkxjc0p1Q3ducVBxRGFqTmhzZXNFOVdGdDl1d1BSeWFNVis1Nkp3SFBOWTFVVmpGczRCN0M3T21uWgo5dXM0YktncnhOZ3ZGUzQ4aFNlcVphRERKbG5UMVB1T3FNeEUycDhEU0hNRUpOcnRTanFQU005K2pWM2FCVFNLCjN6VEs5RGxPYkZTTlp5UjhZZGdrUTRMUnNUdXdrTTk1UWFxaXRMRG9STmRrVDZPSUl1djRPNzNBNlJZeUhNSGoKWmVoNHd6eTZUMWZDZWxLNFlWMjFyRnpnd0ZUZk8venJ5T1M3NWRaQWxKKy9selMwMFBYSVo5cUNJR0RaeUF4aQpFQ2ZTTDlGOTZSVDljazFNVkYxVHh5QXZSdXRmelR6QXJyVDJ4M0d5UncxUWZDZkJKbS9WeVA2dDFWajhOM2pIClF2RzJ3cFhSQWdNQkFBRUNnZ0VBREpSeUZDZmd0dndWTmJ0VHA4U0xEbTY5Z3hlUFg2RHUvYlVnWGlFL0xTc1MKWm1uemlSZWV4Z2t0cEZla3FJTkhoaGNIb3BqZ0dBVktramNWOEdKWE5JNDRKVWtjNnM2NStaMXdvUkpEdEprNgpJZnNFSDFGSEhDc2tYbEZadzNXdGd1YTI0dDYzd2YyU2JjbGdqMHdCWnlzdEhKTVZkYmlBVndyandFR2RGcjJCCmF5MWFMS2lpemdHNCtMdERLcnhOSzdhb0NVYzFWN2kwRzhWdDBoUGJzWlpkM1hHVFNrVkZSQ1B0OE5mMDh3ckkKTGNBSE9CYzRKbTdEWlowQXJhaFBDRnVBOFhWVjk0SmNWVit1Wjk5OEc0SVRYS1l5MDNGYWV6K2tzeTFGTElnZApPU0g2WUFhVlpYUE5EalV2ZEdFaTF2Z0tOaU5kM1p0RTc2bmFwUi9FandLQmdRRDN2blVOUHRMRE5wemY0eGsvCk1vWkhYb0lMVnRrb21zOXZBS3JtZW8xQVd0cE1ydUE0T25NcXI0N0hlb2JEcmplU1JLdkZ2WHdCaEZoZzNobGYKQkJvTjRnak85Q2xITldjZGxnckxCMGtIbjJTTUJGaWlLdWFVU1ZRa2k5QWhVR1psTEg1Rlo0WmJHMkNoTnBhNAoyUXFGQ0hiaUdJUjlwTDF1TUZWM2xPZlgvd0tCZ1FEVXdHaHN3Q1FlYnJTZXhXU2JvcFpRT1JrUkFUc3pxNnJuCmlrK25xRjhvendBcEo5UEdFdm5ZWWFWd1VpYU43L3YrMnpFVkZ2S2c1eU9GZ2RnUHZHMXhiTE9MQmUxZVExZU4KSldpaFB5bEF0SUp5U0VHUUxLejVNenExSWtMRmhWc09XaWloRitKcE4rUlpzNEJVRFNobTJQb0tpeE5RK2hwVgpZWE1qUFA0U0x3S0JnRmFWK1NEMCtRS0RQdGE4NzJENERwZzQvcWhwNVNIYzRXekJSZm1oa1dhUm1rUTh4bDdBCmh1bS9TOTZLQXptMjFQTkpEdVBnY3N1dzdwYUVhVWVkRG1JVnd0Qlo0MmRnMGJZMGIzZEFCNVVqYnlmRWlSbTgKZHJRUzROYVpDdGZwMnErM21qWTFsVzZZSmZDU1BLRkVNZm9HMkUzekZiTTM5WURpWWF5V25XVVBBb0dCQUxpOApkakJ3U3l5dHZtTGJUamdpWHRrOEt6cnIwY2RWT2lxaG0vY2VLYnNhdTY0QTZrL2xMRk9xdm1nZ3ZWK2tVakdECmpVUWQwQUxOa2JlYy9zcnpPQ2swVlZiVGg4REJRdVhKNU9lWEc3QVd6ZXFFT1lJQ2VSUk9XcHpzS2dTdmZsaWgKQ3dTTzQ4ZXZnN1lzT3JOQlZhS3dwN1c5KzhEbDJ6WG1UMzc2dURkN0FvR0FJbGtBb2tqVUJwc2RRbGZJWFJFOAp0K1J1Q1lhTFBmTGltKzQ2V2haZkIzcjY4QVUvZlM0eFc3VHZZcUJ2QS9SOGdYVnpzTDRNeWt2ZWsyLzlyd3lRCjNEMSt2NEh4MVFWNWNNcURxb1QrNUZSYTgrbUZxQkNWcU5jcXNwemRnSTdlOUlwZVREWm90dk9ldHJZYmJkR20KclRBeldGZWc3ZXZxQVplYmtmdml2ZFE9Ci0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS0K
kind: Secret
metadata:
  creationTimestamp: "2022-11-14T17:59:54Z"
  name: ui-ingress
  namespace: dev
  resourceVersion: "17833"
  uid: 005cbbc1-2cce-4e95-b235-14b8b29153a7
type: kubernetes.io/tls
```

Сохраним это в файл `ui-ingress-secret.yml`.

**Результат №09-2:**
 - Для создания `ui-ingress-secret.yml` мы использовали команду редактирования секрета.

 ---

**Задание №09-3:**
 - - ограничить трафик, поступающий на mongodb отовсюду, кроме сервисов post и comment

**Решение №09-3:**

В прошлых проектах мы договорились о том, что хотелось бы разнести сервисы базы данных и сервис фронтенда по разным сетям, сделав их недоступными друг для друга.
В Kubernetes у нас так сделать не получится с помощью отдельных сетей, так как все POD-ы могут достучаться друг до друга по-умолчанию.
Мы будем использовать NetworkPolicy - инструмент для декларативного описания потоков трафика.

Описываем правило в манифесте `mongo-network-policy.yml`:
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-db-traffic
  labels:
    app: reddit
spec:
  podSelector:
    matchLabels:
      app: reddit
      component: mongo
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: reddit
          component: comment
```

Применяем, проверяем:
```console
> kubectl apply -n dev -f mongo-network-policy.yml
networkpolicy.networking.k8s.io/deny-db-traffic created

> kubectl get networkpolicy -n dev
NAME              POD-SELECTOR                 AGE
deny-db-traffic   app=reddit,component=mongo   21s

> kubectl describe networkpolicy -n dev
Name:         deny-db-traffic
Namespace:    dev
Created on:   2022-11-14 00:00:00 +0000 UTC
Labels:       app=reddit
Annotations:  <none>
Spec:
  PodSelector:     app=reddit,component=mongo
  Allowing ingress traffic:
    To Port: <any> (traffic allowed to all ports)
    From:
      PodSelector: app=reddit,component=comment
  Not affecting egress traffic
  Policy Types: Ingress
```

Чтобы `post` мог подключаться к базе, его нужно добавить в podSelector:
```patch
index 2417842..48ba4a5 100644
--- a/kubernetes/reddit/mongo-network-policy.yml
+++ b/kubernetes/reddit/mongo-network-policy.yml
@@ -17,3 +17,7 @@ spec:
         matchLabels:
           app: reddit
           component: comment
+    - podSelector:
+        matchLabels:
+          app: reddit
+          component: post
```

Применяем, проверяем:
```console
> kubectl apply -n dev -f mongo-network-policy.yml
networkpolicy.networking.k8s.io/deny-db-traffic configured

> kubectl get networkpolicy -n dev
NAME              POD-SELECTOR                 AGE
deny-db-traffic   app=reddit,component=mongo   19m

> kubectl describe networkpolicy -n dev
Name:         deny-db-traffic
Namespace:    dev
Created on:   2022-11-14 00:00:00 +0000 UTC
Labels:       app=reddit
Annotations:  <none>
Spec:
  PodSelector:     app=reddit,component=mongo
  Allowing ingress traffic:
    To Port: <any> (traffic allowed to all ports)
    From:
      PodSelector: app=reddit,component=comment
    From:
      PodSelector: app=reddit,component=post
  Not affecting egress traffic
  Policy Types: Ingress
```

**Результат №09-3:**
 - Для контейнера с БД ограничен трафик, доступ разрешён только с `post` и `comment`, но это не точно.

---

**Задание №09-4:**
 - Рассмотрим вопросы хранения данных

**Решение №09-4:**

 Основной Stateful сервис в нашем приложении - это базы данных MongoDB. В текущий момент она запускается в виде Deployment и хранит данные в стандартных Docker Volume-ах. Это имеет несколько проблем:
 - При удалении POD-а удаляется и Volume
 - Потерям Nod'ы с mongo грозит потерей данных
 - Запуск базы на другой ноде запускает новый экземпляр данных

Пробуем удалить `deployment` для `mongo` и создать его заново. После запуска пода база оказывается пустой.

Для постоянного хранения данных используется PersistentVolume.

Создадим диск в облаке:
```console
> yc compute disk create --name k8s --size 4 --description "disk for k8s"

done (10s)
id: fhm1tve2dl47lp9lukfj
folder_id: b1******************
created_at: "2022-11-14T00:00:00Z"
name: k8s
description: disk for k8s
type_id: network-hdd
zone_id: ru-central1-a
size: "4294967296"
block_size: "4096"
status: READY
disk_placement_policy: {}
```

Описываем `mongo-volume.yml`:
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: mongo-pv
spec:
  capacity:
    storage: 4Gi
  accessModes:
    - ReadWriteOnce
  csi:
    driver: disk-csi-driver.mks.ycloud.io
    fsType: ext4
    volumeHandle: fhm1tve2dl47lp9lukfj
```

Мы создали ресурс дискового хранилища, распространенный на весь кластер, в виде PersistentVolume.
Чтобы выделить приложению часть такого ресурса - нужно создать запрос на выдачу - PersistentVolumeClain.
Claim - это именно запрос, а не само хранилище. С помощью запроса можно выделить место как из конкретного
PersistentVolume (тогда параметры accessModes и StorageClass должны соответствовать, а места должно хватать),
так и просто создать отдельный PersistentVolume под конкретный запрос.

Описываем `mongo-claim.yml`:
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mongo-pvc
spec:
  storageClassName: ""
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 4Gi
  volumeName: mongo-ya-pd-storage
```

Обновляем `mongo-deployment.yml`:
```patch
--- a/kubernetes/reddit/mongo-deployment.yml
+++ b/kubernetes/reddit/mongo-deployment.yml
@@ -30,4 +30,5 @@ spec:
           mountPath: /data/db
       volumes:
       - name: mongo-persistent-storage
-        emptyDir: {}
+        persistentVolumeClaim:
+          claimName: mongo-pvc
```

Применяем, проверяем:
```console
> kubectl apply -f mongo-pv.yml
persistentvolume/mongo-pv created

> kubectl apply -f mongo-pvc.yml -n dev
persistentvolumeclaim/mongo-pvc created

> kubectl get pv
NAME       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
mongo-pv   4Gi        RWO            Retain           Available                                   50s

> kubectl describe pv mongo-pv
Name:            mongo-pv
Labels:          <none>
Annotations:     <none>
Finalizers:      [kubernetes.io/pv-protection]
StorageClass:
Status:          Available
Claim:
Reclaim Policy:  Retain
Access Modes:    RWO
VolumeMode:      Filesystem
Capacity:        4Gi
Node Affinity:   <none>
Message:
Source:
    Type:              CSI (a Container Storage Interface (CSI) volume source)
    Driver:            disk-csi-driver.mks.ycloud.io
    FSType:            ext4
    VolumeHandle:      fhm1tve2dl47lp9lukfj
    ReadOnly:          false
    VolumeAttributes:  <none>
Events:                <none>

> kubectl get pvc -n dev
NAME        STATUS    VOLUME                CAPACITY   ACCESS MODES   STORAGECLASS   AGE
mongo-pvc   Pending   mongo-ya-pd-storage   0                                        5m

> kubectl describe pvc mongo-pvc -n dev
Name:          mongo-pvc
Namespace:     dev
StorageClass:
Status:        Bound
Volume:        mongo-pv
Labels:        <none>
Annotations:   pv.kubernetes.io/bind-completed: yes
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      4Gi
Access Modes:  RWO
VolumeMode:    Filesystem
Used By:       mongo-7dbb8b6f7b-fqhkg
Events:        <none>
```

Создаём пост, удаляем под с базой данных, запускаем его заново.
Пост на месте.

Всё работает.

**Результат №09-4:**
 - При помощи PersistentVolume было создано постоянное хранилище даных для `mongo`

---

## 10 - CI/CD в Kubernetes

**Задание №10-1:**
 - Работа с Helm
 - Развертывание Gitlab в Kubernetes
 - Запуск CI/CD конвейера в Kubernetes

**Решение №10-1:**

Работу ведём в новой ветке `kubernetes-4`.

Helm - пакетный менеджер для Kubernetes.

С его помощью мы будем:
 - Стандартизировать поставку приложения в Kubernetes
 - Декларировать инфраструктуру
 - Деплоить новые версии приложения

Начнём с установки Helm. Так, как у нас Ubuntu, то делаем так:
```console
> sudo snap install helm --classic
helm 3.7.0 from Snapcrafters installed
```

Helm читает конфигурацию kubectl `~/.kube/config` и сам определяет текущий контекст (кластер, пользователь, неймспейс).

Chart - это пакет в Helm.
Создаём подкаталог Charts в каталоге kubernetes со следующей структурой:
```console
> mkdir -p kubernetes/Charts/{comment,post,reddit,ui}

> tree kubernetes/Charts/
kubernetes/Charts/
├── comment
├── post
├── reddit
└── ui
```

Создадим файл-описание чарта для компонента `ui`, сохраним его в `ui/Chart.yaml`:
```yaml
name: ui
version: 1.0.0
description: OTUS reddit application UI
maintainers:
  - name: me
    email: me@me.me
appVersion: 1.0
```

Перенесём в каталог `ui/templates` все манифесты, разработанные для `ui`, сделаем косметические изменения:
```console
> tree
.
├── comment
├── post
├── reddit
└── ui
    ├── Chart.yaml
    └── templates
        ├── deployment.yaml
        ├── ingress.yaml
        └── service.yaml
```

Для работы нужен кластер Kubernetes, поднимем его в Yandex Cloud, как делали в предыдущих заданиях и зарегистрируем кластер локально.
```console
> /home/amur/yandex-cloud/bin/yc managed-kubernetes cluster get-credentials test-cluster --external

> kubectl cluster-info
Kubernetes control plane is running at https://84.252.130.138
CoreDNS is running at https://84.252.130.138/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
```

Установим наш Chart:
```console
> helm ls
NAME    NAMESPACE       REVISION        UPDATED STATUS  CHART   APP VERSION

> helm install test-ui-1 ui/
NAME: test-ui-1
LAST DEPLOYED: Wed Nov 16 05:06:31 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None

> helm ls
NAME            NAMESPACE       REVISION        UPDATED                                STATUS   CHART           APP VERSION
test-ui-1       default         1               2022-11-16 05:06:31.776316382 +0000 UTCdeployed ui-1.0.0        1

> kubectl get deployments
NAME   READY   UP-TO-DATE   AVAILABLE   AGE
ui     3/3     3            3           30s

> kubectl get pods
NAME                  READY   STATUS    RESTARTS   AGE
ui-565b9d6499-9rj7n   1/1     Running   0          34s
ui-565b9d6499-bwf5h   1/1     Running   0          34s
ui-565b9d6499-j65sm   1/1     Running   0          34s

```

Теперь шаблонизируем Chart, чтобы можно было запускать несколько релизов одновременно.

```patch
diff --git a/kubernetes/Charts/ui/templates/deployment.yaml b/kubernetes/Charts/ui/templates/deployment.yaml
index 83d77ac..f3ee482 100644
--- a/kubernetes/Charts/ui/templates/deployment.yaml
+++ b/kubernetes/Charts/ui/templates/deployment.yaml
@@ -1,22 +1,25 @@
 apiVersion: apps/v1
 kind: Deployment       # Deploy metadata
 metadata:
-  name: ui
+  name: {{ .Release.Name }}-{{ .Chart.Name }}
   labels:
     app: reddit
     component: ui
+    release: {{ .Release.Name }}
 spec:                  # Deploy specification
   replicas: 3
   selector:
     matchLabels:
       app: reddit
       component: ui
+      release: {{ .Release.Name }}
   template:            # Pod description
     metadata:
       name: ui-pod
       labels:
         app: reddit
         component: ui
+        release: {{ .Release.Name }}
     spec:
       containers:
       - image: r2d2k/ui
diff --git a/kubernetes/Charts/ui/templates/ingress.yaml b/kubernetes/Charts/ui/templates/ingress.yaml
index e149a98..62bd972 100644
--- a/kubernetes/Charts/ui/templates/ingress.yaml
+++ b/kubernetes/Charts/ui/templates/ingress.yaml
@@ -1,7 +1,7 @@
 apiVersion: networking.k8s.io/v1
 kind: Ingress
 metadata:
-  name: ui
+  name: {{ .Release.Name }}-{{ .Chart.Name }}
   annotations:
     nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
 spec:
@@ -15,6 +15,6 @@ spec:
         pathType: Prefix
         backend:
           service:
-            name: ui
+            name: {{ .Release.Name }}-{{ .Chart.Name }}
             port:
               number: 9292
diff --git a/kubernetes/Charts/ui/templates/service.yaml b/kubernetes/Charts/ui/templates/service.yaml
index 8797099..971c457 100644
--- a/kubernetes/Charts/ui/templates/service.yaml
+++ b/kubernetes/Charts/ui/templates/service.yaml
@@ -1,10 +1,11 @@
 apiVersion: v1
 kind: Service
 metadata:
-  name: ui
+  name: {{ .Release.Name }}-{{ .Chart.Name }}
   labels:
     app: reddit
     component: ui
+    release: {{ .Release.Name }}
 spec:
   type: LoadBalancer
   ports:
@@ -14,3 +15,4 @@ spec:
   selector:
     app: reddit
     component: ui
+    release: {{ .Release.Name }}
```

Определим значения переменных в `ui/values.yaml`:
```yaml
service:
  internalPort: 9292
  externalPort: 9292
image:
  repository: r2d2k/ui
  tag: latest
```

Установим пару релизов:
```console
> helm install test-ui-2 ui/
NAME: test-ui-2
LAST DEPLOYED: Thu Nov 17 03:55:08 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None

> helm install test-ui-3 ui/
NAME: test-ui-3
LAST DEPLOYED: Thu Nov 17 03:55:18 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None

> kubectl get ingress
NAME           CLASS   HOSTS   ADDRESS   PORTS     AGE
test-ui-2-ui   nginx   *                 80, 443   18s
test-ui-3-ui   nginx   *                 80, 443   9s
ui             nginx   *                 80, 443   22h
```

Видим, что внешний адрес не появляется.

Спросим у облака, что у нас с балансировщиками:
```console
> yc lb nlb list
+----------------------+----------------------------------------------+-------------+----------+----------------+------------------------+--------+
|          ID          |                     NAME                     |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS | STATUS |
+----------------------+----------------------------------------------+-------------+----------+----------------+------------------------+--------+
| enp6t701tk97ge4k75oc | k8s-91ce5bff8ca6697cb9567ac809a71aaf48e9f093 | ru-central1 | EXTERNAL |              1 | enpdssprnrnadoslcdhb   | ACTIVE |
| enpn65s3tpitk5k2me8c | k8s-6b39764270d3383e462b282effdec09230a84fb6 | ru-central1 | EXTERNAL |              1 | enpdssprnrnadoslcdhb   | ACTIVE |
+----------------------+----------------------------------------------+-------------+----------+----------------+------------------------+--------+

> yc lb nlb get enp6t701tk97ge4k75oc
id: enp6t701tk97ge4k75oc
folder_id: b1gesodgpd94d12usupp
created_at: "2022-11-17T04:20:47Z"
name: k8s-91ce5bff8ca6697cb9567ac809a71aaf48e9f093
description: cluster cat2v91bt9lco01gdk4k, service default/test-ui-2-ui
labels:
  cluster-name: cat2v91bt9lco01gdk4k
  service-name: test-ui-2-ui
  service-namespace: default
  service-uid: 4de34cbe-0588-4065-ae1f-370fa8e3d81f
region_id: ru-central1
status: ACTIVE
type: EXTERNAL
listeners:
  - name: default
    address: 84.201.132.37
    port: "80"
    protocol: TCP
    target_port: "30769"
    ip_version: IPV4
attached_target_groups:
  - target_group_id: enpdssprnrnadoslcdhb
    health_checks:
      - name: default
        interval: 10s
        timeout: 5s
        unhealthy_threshold: "2"
        healthy_threshold: "2"
        http_options:
          port: "10256"
          path: /healthz

> /home/amur/yandex-cloud/bin/yc lb nlb get enpn65s3tpitk5k2me8c
id: enpn65s3tpitk5k2me8c
folder_id: b1gesodgpd94d12usupp
created_at: "2022-11-17T04:14:37Z"
name: k8s-6b39764270d3383e462b282effdec09230a84fb6
description: cluster cat2v91bt9lco01gdk4k, service default/test-ui-1-ui
labels:
  cluster-name: cat2v91bt9lco01gdk4k
  service-name: test-ui-1-ui
  service-namespace: default
  service-uid: 5a2fcd6a-1120-461d-af4b-c740a434fa05
region_id: ru-central1
status: ACTIVE
type: EXTERNAL
listeners:
  - name: default
    address: 84.201.175.243
    port: "80"
    protocol: TCP
    target_port: "32084"
    ip_version: IPV4
attached_target_groups:
  - target_group_id: enpdssprnrnadoslcdhb
    health_checks:
      - name: default
        interval: 10s
        timeout: 5s
        unhealthy_threshold: "2"
        healthy_threshold: "2"
        http_options:
          port: "10256"
          path: /healthz
```

Видим, что создано два балансировщика, третьего нет  не будет по простой причине:
```
Error syncing load balancer: failed to ensure load balancer: failed to ensure cloud loadbalancer: failed to start cloud lb creation: request-id = e44410dd-c2df-41b3-b701-cdf668701dfa rpc error: code = ResourceExhausted desc = Quota limit ylb.networkLoadBalancers.count exceeded
```

Что самое интересное - по адресам, указанным в свойствах балансировщика, наше приложение отвечает:
```console
> lynx -dump http://84.201.132.37
   (BUTTON) [1]Microservices Reddit in default
   test-ui-2-ui-6c87d9b8c4-vpd2j container

   Can't show blog posts, some problems with the post service. [2]Refresh?

Menu

     * [3]All posts
     * [4]New post

References

   1. http://84.201.132.37/
   2. http://84.201.132.37/
   3. http://84.201.132.37/
   4. http://84.201.132.37/new

> lynx -dump http://84.201.175.243
   (BUTTON) [1]Microservices Reddit in default
   test-ui-1-ui-f974d5575-6kkqp container

   Can't show blog posts, some problems with the post service. [2]Refresh?

Menu

     * [3]All posts
     * [4]New post

References

   1. http://84.201.175.243/
   2. http://84.201.175.243/
   3. http://84.201.175.243/
   4. http://84.201.175.243/new
```

Пройдём по шаблонам и заменим значения портов на переменные. После обновим релиз:
```console
> helm upgrade test-ui-1 ui/
Release "test-ui-1" has been upgraded. Happy Helming!
NAME: test-ui-1
LAST DEPLOYED: Thu Nov 17 04:39:44 2022
NAMESPACE: default
STATUS: deployed
REVISION: 2
TEST SUITE: None

> helm upgrade test-ui-2 ui/
Release "test-ui-2" has been upgraded. Happy Helming!
NAME: test-ui-2
LAST DEPLOYED: Thu Nov 17 04:39:50 2022
NAMESPACE: default
STATUS: deployed
REVISION: 2
TEST SUITE: None

> kubectl get ingress --all-namespaces
NAMESPACE   NAME           CLASS   HOSTS   ADDRESS   PORTS     AGE
default     test-ui-1-ui   nginx   *                 80, 443   25m
default     test-ui-2-ui   nginx   *                 80, 443   19m

> helm ls
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
test-ui-1       default         2               2022-11-17 04:39:44.236811529 +0000 UTC deployed        ui-1.0.0        1
test-ui-2       default         2               2022-11-17 04:39:50.938181636 +0000 UTC deployed        ui-1.0.0        1

> lynx -dump http://84.201.132.37:9292
   (BUTTON) [1]Microservices Reddit in default
   test-ui-2-ui-5b96678f8d-9r47v container

   Can't show blog posts, some problems with the post service. [2]Refresh?

Menu

     * [3]All posts
     * [4]New post

References

   1. http://84.201.132.37:9292/
   2. http://84.201.132.37:9292/
   3. http://84.201.132.37:9292/
   4. http://84.201.132.37:9292/new

> lynx -dump http://84.201.175.243:9292
   (BUTTON) [1]Microservices Reddit in default
   test-ui-1-ui-585676fb7-rgfvl container

   Can't show blog posts, some problems with the post service. [2]Refresh?

Menu

     * [3]All posts
     * [4]New post

References

   1. http://84.201.175.243:9292/
   2. http://84.201.175.243:9292/
   3. http://84.201.175.243:9292/
   4. http://84.201.175.243:9292/new

```

Приложение отвечает на портах, указанных в переменных.

Структура чарта приобрела следующий вид:
```console
> tree
.
├── comment
├── post
└── ui
    ├── Chart.yaml
    ├── templates
    │   ├── deployment.yaml
    │   ├── ingress.yaml
    │   └── service.yaml
    └── values.yaml
```

Подготовим чарты для остальных приложений, структура будет такая:
```
> tree
.
├── comment
│   ├── Chart.yaml
│   ├── templates
│   │   ├── deployment.yaml
│   │   └── service.yaml
│   └── values.yaml
├── post
│   ├── Chart.yaml
│   ├── templates
│   │   ├── deployment.yaml
│   │   └── service.yaml
│   └── values.yaml
└── ui
    ├── Chart.yaml
    ├── templates
    │   ├── deployment.yaml
    │   ├── ingress.yaml
    │   └── service.yaml
    └── values.yaml
```

В каждую папку с шаблонами добавим `_helpers.tpl`:
```go
{{- define "comment.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name }}
{{- end -}}
```

Все ссылки на имена заменим функцией `{{ template "comment.fullname" . }}`.

Для запуска приложения целиком создадим общий чарт в каталоге `reddit`:
Содержимое `requirements.yaml`:
```yaml
dependencies:
  - name: ui
    version: "1.0.0"
    repository: "file://../ui"

  - name: post
    version: "1.0.0"
    repository: "file://../post"

  - name: comment
    version: "1.0.0"
    repository: "file://../comment"
```
Сожержимое `Chart.yaml`:
```yaml
name: reddit
version: 0.1.0
description: OTUS reddit application
maintainers:
  - name: me
    email: me@me.me
appVersion: 1.0
```

Загружаем зависимости:
```console
> helm dep update
Saving 3 charts
Deleting outdated charts

> tree
.
├── Chart.yaml
├── charts
│   ├── comment-1.0.0.tgz
│   ├── post-1.0.0.tgz
│   └── ui-1.0.0.tgz
├── requirements.lock
├── requirements.yaml
└── values.yaml
```

Для полной картины нам не хватает базы данных, поищем готовый чарт:
```console
> helm repo list
Error: no repositories to show

> helm repo add google https://kubernetes-charts.storage.googleapis.com
Error: repo "https://kubernetes-charts.storage.googleapis.com" is no longer available; try "https://charts.helm.sh/stable" instead

> helm repo add google https://charts.helm.sh/stable
"google" has been added to your repositories

> helm repo add bitnami https://charts.bitnami.com/bitnami
"bitnami" has been added to your repositories

> helm search repo mongo
NAME                                    CHART VERSION   APP VERSION     DESCRIPTION
bitnami/mongodb                         13.4.4          6.0.3           MongoDB(R) is a relational open source NoSQL da...
bitnami/mongodb-sharded                 6.1.13          6.0.3           MongoDB(R) is an open source NoSQL database tha...
google/mongodb                          7.8.10          4.2.4           DEPRECATED NoSQL document-oriented database tha...
google/mongodb-replicaset               3.17.2          3.6             DEPRECATED - NoSQL document-oriented database t...
google/prometheus-mongodb-exporter      2.8.1           v0.10.0         DEPRECATED A Prometheus exporter for MongoDB me...
google/unifi                            0.10.2          5.12.35         DEPRECATED - Ubiquiti Network's Unifi Controller
```

Попробуем установить БД так, как указано в методичке:
```patch
index 0d2aa1f..2477c52 100644
--- a/kubernetes/Charts/reddit/requirements.yaml
+++ b/kubernetes/Charts/reddit/requirements.yaml
@@ -10,3 +10,7 @@ dependencies:
   - name: comment
     version: "1.0.0"
     repository: "file://../comment"
+
+  - name: mongodb
+    version: 0.4.18
+    repository: https://charts.helm.sh/stable
```
```console
> helm dep update
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "bitnami" chart repository
...Successfully got an update from the "google" chart repository
Update Complete. ⎈Happy Helming!⎈
Saving 4 charts
Downloading mongodb from repo https://charts.helm.sh/stable
Deleting outdated charts
```

У нас проблема:
```console
> helm install reddit-test reddit
Error: INSTALLATION FAILED: unable to build kubernetes objects from release manifest: unable to recognize "": no matches for kind "Deployment" in version "extensions/v1beta1"
```

Извлечём Chart БД из архива и оформим его отдельным каталогом. Поправим всё, что не нравится `helm3`.

*Плохая идея, слишком много проблем, поэтому напишем свой чарт для БД*.

Запускаем:
```console
> helm install reddit-test reddit
NAME: reddit-test
LAST DEPLOYED: Thu Nov 17 17:54:55 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None

> kubectl get pods
NAME                                   READY   STATUS         RESTARTS   AGE
reddit-test-comment-7986ffbdd4-lmpp5   1/1     Running        0          48s
reddit-test-mongodb-856884f4d4-znzpb   0/1     ErrImagePull   0          48s
reddit-test-post-5fbbcb9499-fscwv      1/1     Running        0          48s
reddit-test-ui-7b8ccdd5b7-7l4mr        1/1     Running        0          48s
reddit-test-ui-7b8ccdd5b7-8f4jg        1/1     Running        0          48s
reddit-test-ui-7b8ccdd5b7-lrkng        1/1     Running        0          48s

> kubectl describe pod reddit-test-mongodb-856884f4d4-znzpb
Name:             reddit-test-mongodb-856884f4d4-znzpb
Namespace:        default
Priority:         0
Service Account:  default
Node:             cl1mdightd6q302tsooo-utaq/10.128.0.30
Start Time:       Thu, 17 Nov 2022 17:54:57 +0000
Labels:           app=reddit
                  component=mongodb
                  pod-template-hash=856884f4d4
                  release=reddit-test
Annotations:      cni.projectcalico.org/containerID: 16dc3515fe1866fe02091a83f0a4156008975b9fb8ff6ace49260cdbf72eb31f
                  cni.projectcalico.org/podIP: 10.112.129.16/32
                  cni.projectcalico.org/podIPs: 10.112.129.16/32
Status:           Pending
IP:               10.112.129.16
IPs:
  IP:           10.112.129.16
Controlled By:  ReplicaSet/reddit-test-mongodb-856884f4d4
Containers:
  mongodb:
    Container ID:
    Image:          mongodb:3.2
    Image ID:
    Port:           27017/TCP
    Host Port:      0/TCP
    State:          Waiting
      Reason:       ImagePullBackOff
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-ssdks (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             False
  ContainersReady   False
  PodScheduled      True
Volumes:
  kube-api-access-ssdks:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason     Age                  From               Message
  ----     ------     ----                 ----               -------
  Normal   Scheduled  2m48s                default-scheduler  Successfully assigned default/reddit-test-mongodb-856884f4d4-znzpb to cl1mdightd6q302tsooo-utaq
  Normal   Pulling    80s (x4 over 2m48s)  kubelet            Pulling image "mongodb:3.2"
  Warning  Failed     79s (x4 over 2m37s)  kubelet            Failed to pull image "mongodb:3.2": rpc error: code = Unknown desc = failed to pull and unpack image "docker.io/library/mongodb:3.2": failed to resolve reference "docker.io/library/mongodb:3.2": pull access denied, repository does not exist or may require authorization: server message: insufficient_scope: authorization failed
  Warning  Failed     79s (x4 over 2m37s)  kubelet            Error: ErrImagePull
  Warning  Failed     53s (x6 over 2m37s)  kubelet            Error: ImagePullBackOff
  Normal   BackOff    39s (x7 over 2m37s)  kubelet            Back-off pulling image "mongodb:3.2"
```

Ошибка в имени образа, исправляем, повторяем:
```console
> helm dep update
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "google" chart repository
...Successfully got an update from the "bitnami" chart repository
Update Complete. ⎈Happy Helming!⎈
Saving 4 charts
Deleting outdated charts

> helm upgrade reddit-test reddit
Release "reddit-test" has been upgraded. Happy Helming!
NAME: reddit-test
LAST DEPLOYED: Thu Nov 17 18:00:50 2022
NAMESPACE: default
STATUS: deployed
REVISION: 2
TEST SUITE: None

> kubectl get pods
NAME                                   READY   STATUS    RESTARTS   AGE
reddit-test-comment-7986ffbdd4-lmpp5   1/1     Running   0          6m12s
reddit-test-mongodb-5d789f678-pvlzx    1/1     Running   0          17s
reddit-test-post-5fbbcb9499-fscwv      1/1     Running   0          6m12s
reddit-test-ui-7b8ccdd5b7-7l4mr        1/1     Running   0          6m12s
reddit-test-ui-7b8ccdd5b7-8f4jg        1/1     Running   0          6m12s
reddit-test-ui-7b8ccdd5b7-lrkng        1/1     Running   0          6m12s
```

По старой схеме (через Yandex Cloud) выясняем адрес балансировщика, проверяем:
```console
> lynx -dump http://51.250.10.12:9292
   (BUTTON) [1]Microservices Reddit in default
   reddit-test-ui-7b8ccdd5b7-8f4jg container

   Can't show blog posts, some problems with the post service. [2]Refresh?

Menu

     * [3]All posts
     * [4]New post

References

   1. http://51.250.10.12:9292/
   2. http://51.250.10.12:9292/
   3. http://51.250.10.12:9292/
   4. http://51.250.10.12:9292/new
```

Мы не указали переменыне окружения для поиска хостов, исправим:
```patch
index 4e29a92..8d443ac 100644
--- a/kubernetes/Charts/ui/templates/deployment.yaml
+++ b/kubernetes/Charts/ui/templates/deployment.yaml
@@ -25,9 +25,18 @@ spec:                        # Deploy specification
       - image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
         name: ui
         ports:
-          - containerPort: {{ .Values.service.internalPort }}
+        - containerPort: {{ .Values.service.internalPort }}
+          name: ui
         env:
+        - name: POST_SERVICE_HOST
+          value: {{  .Values.postHost | default (printf "%s-post" .Release.Name) }}
+        - name: POST_SERVICE_PORT
+          value: {{  .Values.postPort | default "5000" | quote }}
+        - name: COMMENT_SERVICE_HOST
+          value: {{  .Values.commentHost | default (printf "%s-comment" .Release.Name) }}
+        - name: COMMENT_SERVICE_PORT
+          value: {{  .Values.commentPort | default "9292" | quote }}
         - name: ENV
           valueFrom:
             fieldRef:
-              fieldPath: metadata.namespace
+              fieldPath: metadata.namespace
```

Обновим чарты и релиз:
```console
> helm dep update ./reddit
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "bitnami" chart repository
...Successfully got an update from the "google" chart repository
Update Complete. ⎈Happy Helming!⎈
Saving 4 charts
Deleting outdated charts

> helm upgrade reddit-test reddit
Release "reddit-test" has been upgraded. Happy Helming!
NAME: reddit-test
LAST DEPLOYED: Thu Nov 17 18:49:18 2022
NAMESPACE: default
STATUS: deployed
REVISION: 2
TEST SUITE: None

> lynx -dump http://51.250.75.182:9292
   (BUTTON) [1]Microservices Reddit in default
   reddit-test-ui-5f778f9b95-48pvf container

   (BUTTON)

7

   (BUTTON)

[2]1

17-11-2022
18:50

   [3]Go to the link

Menu

     * [4]All posts
     * [5]New post

References

   1. http://51.250.75.182:9292/
   2. http://51.250.75.182:9292/post/637682859fd337000f32f9e8
   3. http://test.com/
   4. http://51.250.75.182:9292/
   5. http://51.250.75.182:9292/new
```
Посты сохраняются, приложение работает.

Понятно, почему у нас не было внешнего адреса. Кое что забыли поставить:
```console
> kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.5.1/deploy/static/provider/cloud/deploy.yaml

ud/deploy.yaml
namespace/ingress-nginx created
serviceaccount/ingress-nginx created
serviceaccount/ingress-nginx-admission created
role.rbac.authorization.k8s.io/ingress-nginx created
role.rbac.authorization.k8s.io/ingress-nginx-admission created
clusterrole.rbac.authorization.k8s.io/ingress-nginx created
clusterrole.rbac.authorization.k8s.io/ingress-nginx-admission created
rolebinding.rbac.authorization.k8s.io/ingress-nginx created
rolebinding.rbac.authorization.k8s.io/ingress-nginx-admission created
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx created
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx-admission created
configmap/ingress-nginx-controller created
service/ingress-nginx-controller created
service/ingress-nginx-controller-admission created
deployment.apps/ingress-nginx-controller created
job.batch/ingress-nginx-admission-create created
job.batch/ingress-nginx-admission-patch created
ingressclass.networking.k8s.io/nginx created
validatingwebhookconfiguration.admissionregistration.k8s.io/ingress-nginx-admission created

> kubectl get ingress reddit-test-ui
NAME             CLASS   HOSTS   ADDRESS          PORTS   AGE
reddit-test-ui   nginx   *       84.201.159.206   80      23m

> lynx -dump http://84.201.159.206
   (BUTTON) [1]Microservices Reddit in default
   reddit-test-ui-5f778f9b95-48pvf container

   (BUTTON)

7

   (BUTTON)

[2]1

17-11-2022
18:50

   [3]Go to the link

Menu

     * [4]All posts
     * [5]New post

References

   1. http://84.201.159.206/
   2. http://84.201.159.206/post/637682859fd337000f32f9e8
   3. http://test.com/
   4. http://84.201.159.206/
   5. http://84.201.159.206/new

```

Так то лучше)


**Результат №10-1:**
 - Подготовлены чарты для приложения `reddit`
 - Приложение запущено в кластере облака при помощи Helm

---

**Задание №10-2:**
 - GitLab + Kubernetes

**Решение №10-2:**

Первая задача - подготовить кластер для установки Gitlab, думаю пары нод с 4 CPU и 8 RAM хватит.
Поднимаем кластер при помощи `terraform`, как делали в предыдущих занятиях.
```console
> terraform apply
...
...
Plan: 3 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

yandex_kubernetes_cluster.yc_cluster: Creating...
yandex_kubernetes_cluster.yc_cluster: Still creating... [10s elapsed]
...
...
yandex_kubernetes_node_group.my_node_group[0]: Still creating... [2m20s elapsed]
yandex_kubernetes_node_group.my_node_group[1]: Creation complete after 2m26s [id=cathm2m36lmp45h2b7et]
yandex_kubernetes_node_group.my_node_group[0]: Still creating... [2m30s elapsed]
yandex_kubernetes_node_group.my_node_group[0]: Creation complete after 2m38s [id=cat3o1mdmt24aumc3ubt]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
```

Регистрируем кластер локально:
```console
> yc managed-kubernetes cluster get-credentials test-cluster --external --force

Context 'yc-test-cluster' was added as default to kubeconfig '/home/amur/.kube/config'.
Check connection to cluster using 'kubectl cluster-info --kubeconfig /home/amur/.kube/config'.

Note, that authentication depends on 'yc' and its config profile 'default'.
To access clusters using the Kubernetes API, please use Kubernetes Service Account.

> kubectl cluster-info
Kubernetes control plane is running at https://51.250.94.80
CoreDNS is running at https://51.250.94.80/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

Gitlab будем ставить с помощью Helm Chart’а.

Добавим репозиторий Gitlab и скачаем чарт:
```console
> helm repo remove bitnami
"bitnami" has been removed from your repositories

> helm repo add gitlab https://charts.gitlab.io/
"gitlab" has been added to your repositories

> helm repo update
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "gitlab" chart repository
...Successfully got an update from the "bitnami" chart repository
...Successfully got an update from the "google" chart repository
Update Complete. ⎈Happy Helming!⎈

> helm pull gitlab/gitlab --untar
```

Вносим минимальные измененения в настройки чарта:
```patch
diff --git a/kubernetes/Charts/gitlab/values.yaml b/kubernetes/Charts/gitlab/values.yaml
index 448897b..73178af 100644
--- a/kubernetes/Charts/gitlab/values.yaml
+++ b/kubernetes/Charts/gitlab/values.yaml
@@ -36,7 +36,7 @@ global:
     labels: {}

   ## https://docs.gitlab.com/charts/installation/deployment#deploy-the-community-edition
-  edition: ee
+  edition: ce

   ## https://docs.gitlab.com/charts/charts/globals#gitlab-version
   # gitlabVersion:
@@ -664,7 +664,7 @@ global:
       certName: "tls.crt"

   ## Timezone for containers.
-  time_zone: UTC
+  time_zone: Europe/Moscow

   ## Global Service Annotations and Labels
   service:
@@ -805,10 +805,10 @@ upgradeCheck:
   priorityClassName: ""

 ## Settings to for the Let's Encrypt ACME Issuer
-# certmanager-issuer:
+certmanager-issuer:
 #   # The email address to register certificates requested from Let's Encrypt.
 #   # Required if using Let's Encrypt.
-#   email: email@example.com
+  email: ****@******.com

 ## Installation & configuration of jetstack/cert-manager
 ## See requirements.yaml for current version
@@ -884,7 +884,7 @@ nginx-ingress:
 ## Installation & configuration of stable/prometheus
 ## See requirements.yaml for current version
 prometheus:
-  install: true
+  install: false
   rbac:
     create: true
   alertmanager:
```

Ставим по [официальной](https://docs.gitlab.com/charts/installation/deployment.html) документации:
```console
> helm install gitlab ./gitlab

NAME: gitlab
LAST DEPLOYED: Wed Nov 23 05:10:13 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
=== NOTICE
The minimum required version of PostgreSQL is now 12. See https://gitlab.com/gitlab-org/charts/gitlab/-/blob/master/doc/installation/upgrade.md for more details.

=== NOTICE
You've installed GitLab Runner without the ability to use 'docker in docker'.
The GitLab Runner chart (gitlab/gitlab-runner) is deployed without the `privileged` flag by default for security purposes. This can be changed by setting `gitlab-runner.runners.privileged` to `true`. Before doing so, please read the GitLab Runner chart's documentation on why we
chose not to enable this by default. See https://docs.gitlab.com/runner/install/kubernetes.html#running-docker-in-docker-containers-with-gitlab-runners
Help us improve the installation experience, let us know how we did with a 1 minute survey:https://gitlab.fra1.qualtrics.com/jfe/form/SV_6kVqZANThUQ1bZb?installation=helm&release=15-6

=== NOTICE
The in-chart NGINX Ingress Controller has the following requirements:
    - Kubernetes version must be 1.19 or newer.
    - Ingress objects must be in group/version `networking.k8s.io/v1`.
```

Ждём несколько минут, проверяем:
```console
> kubectl get ingress
NAME                        CLASS          HOSTS                  ADDRESS          PORTS     AGE
gitlab-kas                  gitlab-nginx   kas.example.com        158.160.37.223   80, 443   2m15s
gitlab-minio                gitlab-nginx   minio.example.com      158.160.37.223   80, 443   2m15s
gitlab-registry             gitlab-nginx   registry.example.com   158.160.37.223   80, 443   2m15s
gitlab-webservice-default   gitlab-nginx   gitlab.example.com     158.160.37.223   80, 443   2m15s
```

Вносим изменения в чарт:
```patch
diff --git a/kubernetes/Charts/gitlab/values.yaml b/kubernetes/Charts/gitlab/values.yaml
index 73178af..5c425d2 100644
--- a/kubernetes/Charts/gitlab/values.yaml
+++ b/kubernetes/Charts/gitlab/values.yaml
@@ -48,10 +48,10 @@ global:
     allowClusterRoles: true
   ## https://docs.gitlab.com/charts/charts/globals#configure-host-settings
   hosts:
-    domain: example.com
+    domain: 158.160.37.223.sslip.io
     hostSuffix:
     https: true
-    externalIP:
+    externalIP: 158.160.37.223
     ssh: ~
     gitlab: {}
     minio: {}
```

Применяем изменения:
```console
> helm upgrade gitlab ./gitlab
Release "gitlab" has been upgraded. Happy Helming!
NAME: gitlab
LAST DEPLOYED: Wed Nov 23 05:17:45 2022
NAMESPACE: default
STATUS: deployed
REVISION: 2
NOTES:
=== NOTICE
The minimum required version of PostgreSQL is now 12. See https://gitlab.com/gitlab-org/charts/gitlab/-/blob/master/doc/installation/upgrade.md for more details.

=== NOTICE
You've installed GitLab Runner without the ability to use 'docker in docker'.
The GitLab Runner chart (gitlab/gitlab-runner) is deployed without the `privileged` flag by default for security purposes. This can be changed by setting `gitlab-runner.runners.privileged` to `true`. Before doing so, please read the GitLab Runner chart's documentation on why we
chose not to enable this by default. See https://docs.gitlab.com/runner/install/kubernetes.html#running-docker-in-docker-containers-with-gitlab-runners

=== NOTICE
The in-chart NGINX Ingress Controller has the following requirements:
    - Kubernetes version must be 1.19 or newer.
    - Ingress objects must be in group/version `networking.k8s.io/v1`.

> kubectl get ingress
NAME                        CLASS          HOSTS                              ADDRESS          PORTS     AGE
gitlab-kas                  gitlab-nginx   kas.158.160.37.223.sslip.io        158.160.37.223   80, 443   7m53s
gitlab-minio                gitlab-nginx   minio.158.160.37.223.sslip.io      158.160.37.223   80, 443   7m53s
gitlab-registry             gitlab-nginx   registry.158.160.37.223.sslip.io   158.160.37.223   80, 443   7m53s
gitlab-webservice-default   gitlab-nginx   gitlab.158.160.37.223.sslip.io     158.160.37.223   80, 443   7m53s
```

Получаем первоначальный пароль:
```console
> kubectl get secret gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' | base64 --decode ; echo
sGXV3JkYPtGmNrMB3jsvsx6pMzUMDnJM1Ruqdr9lB8vBGX9QDajrZ9GDHUHQrgV6
```

Заходим по адресу `https://gitlab.158.160.37.223.sslip.io`, логин `root`, пароль мы добыли выше.

Создаём публичную группу, в качестве имени выбираем логин пользователя, который выполянет работы.

В свойствах группы находим `CI/CD`, добавляем две переменные - CI_REGISTRY_USER - логин в DockerHub и CI_REGISTRY_PASSWORD - пароль от DockerHub.

В группе создаём четыре публичных проекта: `reddit-deploy`, `comment`, `post`, `ui`.

Локально создаём каталоги под каждый проект, в `comment`, `post`, `ui` переносим исходный код сервисов, пушим всё в Gitlab.

В `reddit-deploy` добавляем все чарты, которые мы создавали ранее и аналогично пушим всё в Gitlab.

В репозиторий `ui` добавим конфигурацию CI/CD, файл `.gitlab-ci.yml`:
```yaml
image: alpine:latest

stages:
  - build
  - test
  - release
  - cleanup

build:
  stage: build
  image: docker:git
  services:
    - docker:18.09.7-dind
  script:
    - setup_docker
    - build
  variables:
    DOCKER_DRIVER: overlay2
  only:
    - branches

test:
  stage: test
  script:
    - exit 0
  only:
    - branches

release:
  stage: release
  image: docker
  services:
    - docker:18.09.7-dind
  script:
    - setup_docker
    - release
  variables:
    DOCKER_TLS_CERTDIR: ""
  only:
    - main

.auto_devops: &auto_devops |
  [[ "$TRACE" ]] && set -x
  export CI_REGISTRY="index.docker.io"
  export CI_APPLICATION_REPOSITORY=$CI_REGISTRY/$CI_PROJECT_PATH
  export CI_APPLICATION_TAG=$CI_COMMIT_REF_SLUG
  export CI_CONTAINER_NAME=ci_job_build_${CI_JOB_ID}
  export TILLER_NAMESPACE="kube-system"

  function setup_docker() {
    if ! docker info &>/dev/null; then
      if [ -z "$DOCKER_HOST" -a "$KUBERNETES_PORT" ]; then
        export DOCKER_HOST='tcp://localhost:2375'
      fi
    fi
  }

  function release() {

    echo "Updating docker images ..."

    if [[ -n "$CI_REGISTRY_USER" ]]; then
      echo "Logging to GitLab Container Registry with CI credentials..."
      docker login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
      echo ""
    fi

    docker pull "$CI_APPLICATION_REPOSITORY:$CI_APPLICATION_TAG"
    docker tag "$CI_APPLICATION_REPOSITORY:$CI_APPLICATION_TAG" "$CI_APPLICATION_REPOSITORY:$(cat VERSION)"
    docker push "$CI_APPLICATION_REPOSITORY:$(cat VERSION)"
    echo ""
  }

  function build() {

    echo "Building Dockerfile-based application..."
    echo `git show --format="%h" HEAD | head -1` > build_info.txt
    echo `git rev-parse --abbrev-ref HEAD` >> build_info.txt
    docker build -t "$CI_APPLICATION_REPOSITORY:$CI_APPLICATION_TAG" .

    if [[ -n "$CI_REGISTRY_USER" ]]; then
      echo "Logging to GitLab Container Registry with CI credentials..."
      docker login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
      echo ""
    fi

    echo "Pushing to GitLab Container Registry..."
    docker push "$CI_APPLICATION_REPOSITORY:$CI_APPLICATION_TAG"
    echo ""
  }

before_script:
  - *auto_devops
```

Аналогичные файлы добавляем в `comment` и `post`.

При запуске пайплайна получили проблемы с докером, лечим:
```console
> helm upgrade gitlab ./gitlab --set gitlab-runner.runners.privileged=true
Release "gitlab" has been upgraded. Happy Helming!
NAME: gitlab
LAST DEPLOYED: Wed Nov 23 18:20:51 2022
NAMESPACE: default
STATUS: deployed
REVISION: 4
NOTES:
=== NOTICE
The minimum required version of PostgreSQL is now 12. See https://gitlab.com/gitlab-org/charts/gitlab/-/blob/master/doc/installation/upgrade.md for more details.

=== NOTICE
The in-chart NGINX Ingress Controller has the following requirements:
    - Kubernetes version must be 1.19 or newer.
    - Ingress objects must be in group/version `networking.k8s.io/v1`.
```

Вносим изменения в `ui`:
```patch
diff --git a/ui/templates/ingress.yaml b/ui/templates/ingress.yaml
index 8e5ff84..e1a2af0 100644
--- a/ui/templates/ingress.yaml
+++ b/ui/templates/ingress.yaml
@@ -2,10 +2,13 @@ apiVersion: networking.k8s.io/v1
 kind: Ingress
 metadata:
   name: {{ template "ui.fullname" . }}
+  annotations:
+    kubernetes.io/ingress.class: {{ .Values.ingress.class }}
 spec:
   ingressClassName: {{ .Values.ingress.class }}
   rules:
-  - http:
+  - host: {{ .Values.ingress.host | default .Release.Name }}
+    http:
       paths:
       - path: /
         pathType: Prefix
```

Настройки CI/CD тоже меняем (с учётом настоящего времени):
```yaml
image: alpine:latest

stages:
  - build
  - test
  - review
  - release

build:
  stage: build
  image: docker:git
  services:
    - docker:18.09.7-dind
  script:
    - setup_docker
    - build
  variables:
    DOCKER_DRIVER: overlay2
  only:
    - branches

test:
  stage: test
  script:
    - exit 0
  only:
    - branches

release:
  stage: release
  image: docker
  services:
    - docker:18.09.7-dind
  script:
    - setup_docker
    - release
  only:
    - main

review:
  stage: review
  script:
    - install_dependencies
    - kubectl config get-contexts
    - kubectl config use-context r2d2k/reddit-deploy:reddit-agent
    - kubectl get pods
    - ensure_namespace
    - deploy
  variables:
    KUBE_NAMESPACE: review
    host: $CI_PROJECT_PATH_SLUG-$CI_COMMIT_REF_SLUG
  environment:
    name: review/$CI_PROJECT_PATH/$CI_COMMIT_REF_NAME
    url: http://$CI_PROJECT_PATH_SLUG-$CI_COMMIT_REF_SLUG
  only:
    refs:
      - branches
  except:
    - main

.auto_devops: &auto_devops |
  [[ "$TRACE" ]] && set -x
  export CI_REGISTRY="index.docker.io"
  export CI_APPLICATION_REPOSITORY=$CI_REGISTRY/$CI_PROJECT_PATH
  export CI_APPLICATION_TAG=$CI_COMMIT_REF_SLUG
  export CI_CONTAINER_NAME=ci_job_build_${CI_JOB_ID}
  export TILLER_NAMESPACE="kube-system"

  function deploy() {
    track="${1-stable}"
    name="$CI_ENVIRONMENT_SLUG"

    if [[ "$track" != "stable" ]]; then
      name="$name-$track"
    fi

    echo "Clone deploy repository..."
    git clone $CI_SERVER_URL/$CI_PROJECT_NAMESPACE/reddit-deploy.git

    echo "Download helm dependencies..."
    helm dep update reddit-deploy/reddit

    echo "Deploy helm release $name to $KUBE_NAMESPACE"
    helm upgrade --install \
      --wait \
      --set ui.ingress.host="$host" \
      --set $CI_PROJECT_NAME.image.tag=$CI_APPLICATION_TAG \
      --namespace="$KUBE_NAMESPACE" \
      --version="$CI_PIPELINE_ID-$CI_JOB_ID" \
      "$name" \
      reddit-deploy/reddit/
  }

  function install_dependencies() {

    apk add -U openssl curl tar gzip bash ca-certificates git
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r0/glibc-2.35-r0.apk
    apk add --force-overwrite glibc-2.35-r0.apk
    apk fix --force-overwrite alpine-baselayout-data
    rm glibc-2.35-r0.apk

    curl https://storage.googleapis.com/pub/gsutil.tar.gz | tar -xz -C $HOME
    export PATH=${PATH}:$HOME/gsutil

    curl https://get.helm.sh/helm-v3.10.2-linux-amd64.tar.gz | tar zx

    mv linux-amd64/helm /usr/bin/
    helm version --client

    curl  -o /usr/bin/sync-repo.sh https://raw.githubusercontent.com/kubernetes/helm/master/scripts/sync-repo.sh
    chmod a+x /usr/bin/sync-repo.sh

    curl -L -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
    chmod +x /usr/bin/kubectl
    kubectl version --client
  }

  function setup_docker() {
    if ! docker info &>/dev/null; then
      if [ -z "$DOCKER_HOST" -a "$KUBERNETES_PORT" ]; then
        export DOCKER_HOST='tcp://localhost:2375'
      fi
    fi
  }

  function ensure_namespace() {
    kubectl describe namespace "$KUBE_NAMESPACE" || kubectl create namespace "$KUBE_NAMESPACE"
  }

  function release() {

    echo "Updating docker images ..."

    if [[ -n "$CI_REGISTRY_USER" ]]; then
      echo "Logging to GitLab Container Registry with CI credentials..."
      docker login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
      echo ""
    fi

    docker pull "$CI_APPLICATION_REPOSITORY:$CI_APPLICATION_TAG"
    docker tag "$CI_APPLICATION_REPOSITORY:$CI_APPLICATION_TAG" "$CI_APPLICATION_REPOSITORY:$(cat VERSION)"
    docker push "$CI_APPLICATION_REPOSITORY:$(cat VERSION)"
    echo ""
  }

  function build() {

    echo "Building Dockerfile-based application..."
    echo `git show --format="%h" HEAD | head -1` > build_info.txt
    echo `git rev-parse --abbrev-ref HEAD` >> build_info.txt
    docker build -t "$CI_APPLICATION_REPOSITORY:$CI_APPLICATION_TAG" .

    if [[ -n "$CI_REGISTRY_USER" ]]; then
      echo "Logging to GitLab Container Registry with CI credentials..."
      docker login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
      echo ""
    fi

    echo "Pushing to GitLab Container Registry..."
    docker push "$CI_APPLICATION_REPOSITORY:$CI_APPLICATION_TAG"
    echo ""
  }

before_script:
  - *auto_devops
```

Пайплайн ломается на функции `ensure_namespace` шага `review`, судя по всему раннеру не хватает прав.

Чтобы работать с Kubernetes, нужно настроить Gitlab. Процедура описана [тут](https://docs.gitlab.com/ee/user/clusters/agent/ci_cd_workflow.html).
Установка самого агента описана в [этом разделе](https://docs.gitlab.com/ee/user/clusters/agent/install/index.html).

Конфигурация агента должна лежать в основной ветке репозитория, полный путь: `.gitlab/agents/<agent-name>/config.yaml`.
Авторизуем агента для проектов нашей группы.
```yaml
ci_access:
  groups:
    - id: r2d2k
```

Пушим изменения в Gitlab.

Идём в проект, в котором создан файл конфигурации, Infastucture/Kubernetes cluster, Connect a cluster, выбираем имя агента и жмём Register.
Gitlab генерирует команды для установки и подключения агента:
```console
> helm repo add gitlab https://charts.gitlab.io
> helm repo update
> helm upgrade --install reddit-agent gitlab/gitlab-agent \
    --namespace gitlab-agent \
    --create-namespace \
    --set image.tag=v15.6.0 \
    --set config.token=szv2u9_uHzy85zpdoTtdP9u15QKf93m2jui18DMDJbfDBfzL2w \
    --set config.kasAddress=wss://kas.158.160.37.223.sslip.io

Release "reddit-agent" does not exist. Installing it now.
NAME: reddit-agent
LAST DEPLOYED: Thu Nov 24 16:56:54 2022
NAMESPACE: gitlab-agent
STATUS: deployed
REVISION: 1
TEST SUITE: None
```

Через некоторое время агент выйдет на связь.

После нескольких часов правок багов приходим к такому рабочему конфигу:
```yaml
image: alpine:latest

stages:
  - build
  - test
  - review
  - release
  - cleanup

build:
  stage: build
  image: docker:git
  services:
    - docker:18.09.7-dind
  script:
    - setup_docker
    - build
  variables:
    DOCKER_DRIVER: overlay2
  only:
    - branches

test:
  stage: test
  script:
    - exit 0
  only:
    - branches

release:
  stage: release
  image: docker
  services:
    - docker:18.09.7-dind
  script:
    - setup_docker
    - release
  only:
    - main

review:
  stage: review
  script:
    - install_dependencies
    - kubectl config get-contexts
    - kubectl config use-context r2d2k/reddit-deploy:reddit-agent
    - kubectl get pods
    - ensure_namespace
    - deploy
  variables:
    KUBE_NAMESPACE: review
    host: $CI_PROJECT_PATH_SLUG-$CI_COMMIT_REF_SLUG
  environment:
    name: review/$CI_PROJECT_PATH/$CI_COMMIT_REF_NAME
    url: http://$CI_PROJECT_PATH_SLUG-$CI_COMMIT_REF_SLUG
    on_stop: stop_review
  only:
    refs:
      - branches
  except:
    - main

stop_review:
  stage: cleanup
  variables:
    GIT_STRATEGY: none
    KUBE_NAMESPACE: review
  script:
    - install_dependencies
    - kubectl config get-contexts
    - kubectl config use-context r2d2k/reddit-deploy:reddit-agent
    - kubectl get pods
    - delete
  environment:
    name: review/$CI_PROJECT_PATH/$CI_COMMIT_REF_NAME
    action: stop
  when: manual
  allow_failure: true
  only:
    refs:
      - branches
  except:
    - main

.auto_devops: &auto_devops |
  [[ "$TRACE" ]] && set -x
  export CI_REGISTRY="index.docker.io"
  export CI_APPLICATION_REPOSITORY=$CI_REGISTRY/$CI_PROJECT_PATH
  export CI_APPLICATION_TAG=$CI_COMMIT_REF_SLUG
  export CI_CONTAINER_NAME=ci_job_build_${CI_JOB_ID}
  export TILLER_NAMESPACE="kube-system"

  function delete() {
    track="${1-stable}"
    name="$CI_ENVIRONMENT_SLUG"
    helm delete "$name" --namespace="$KUBE_NAMESPACE" || true
  }

  function deploy() {
    track="${1-stable}"
    name="$CI_ENVIRONMENT_SLUG"

    if [[ "$track" != "stable" ]]; then
      name="$name-$track"
    fi

    echo "Clone deploy repository..."
    git clone $CI_SERVER_URL/$CI_PROJECT_NAMESPACE/reddit-deploy.git

    echo "Download helm dependencies..."
    helm dep update reddit-deploy/reddit

    echo "Deploy helm release $name to $KUBE_NAMESPACE"
    helm upgrade --install \
      --wait \
      --set ui.ingress.host="$host" \
      --set $CI_PROJECT_NAME.image.tag=$CI_APPLICATION_TAG \
      --namespace="$KUBE_NAMESPACE" \
      --version="$CI_PIPELINE_ID-$CI_JOB_ID" \
      "$name" \
      reddit-deploy/reddit/
  }

  function install_dependencies() {

    apk add -U openssl curl tar gzip bash ca-certificates git
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r0/glibc-2.35-r0.apk
    apk add --force-overwrite glibc-2.35-r0.apk
    apk fix --force-overwrite alpine-baselayout-data
    rm glibc-2.35-r0.apk

    curl https://storage.googleapis.com/pub/gsutil.tar.gz | tar -xz -C $HOME
    export PATH=${PATH}:$HOME/gsutil

    curl https://get.helm.sh/helm-v3.10.2-linux-amd64.tar.gz | tar zx

    mv linux-amd64/helm /usr/bin/
    helm version --client

    curl  -o /usr/bin/sync-repo.sh https://raw.githubusercontent.com/kubernetes/helm/master/scripts/sync-repo.sh
    chmod a+x /usr/bin/sync-repo.sh

    curl -L -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
    chmod +x /usr/bin/kubectl
    kubectl version --client
  }

  function setup_docker() {
    if ! docker info &>/dev/null; then
      if [ -z "$DOCKER_HOST" -a "$KUBERNETES_PORT" ]; then
        export DOCKER_HOST='tcp://localhost:2375'
      fi
    fi
  }

  function ensure_namespace() {
    kubectl describe namespace "$KUBE_NAMESPACE" || kubectl create namespace "$KUBE_NAMESPACE"
  }

  function release() {

    echo "Updating docker images ..."

    if [[ -n "$CI_REGISTRY_USER" ]]; then
      echo "Logging to GitLab Container Registry with CI credentials..."
      docker login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
      echo ""
    fi

    docker pull "$CI_APPLICATION_REPOSITORY:$CI_APPLICATION_TAG"
    docker tag "$CI_APPLICATION_REPOSITORY:$CI_APPLICATION_TAG" "$CI_APPLICATION_REPOSITORY:$(cat VERSION)"
    docker push "$CI_APPLICATION_REPOSITORY:$(cat VERSION)"
    echo ""
  }

  function build() {

    echo "Building Dockerfile-based application..."
    echo `git show --format="%h" HEAD | head -1` > build_info.txt
    echo `git rev-parse --abbrev-ref HEAD` >> build_info.txt
    docker build -t "$CI_APPLICATION_REPOSITORY:$CI_APPLICATION_TAG" .

    if [[ -n "$CI_REGISTRY_USER" ]]; then
      echo "Logging to GitLab Container Registry with CI credentials..."
      docker login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
      echo ""
    fi

    echo "Pushing to GitLab Container Registry..."
    docker push "$CI_APPLICATION_REPOSITORY:$CI_APPLICATION_TAG"
    echo ""
  }

before_script:
  - *auto_devops
```

Копируем этот конфиг в `post` и `comment`, проверяем работу. Для этого создаём ветку, что-то меняем в ней, пушим. Должны отработать пайплайны с review.
Исходное состояние:
```console
> helm ls --namespace review
NAME    NAMESPACE       REVISION        UPDATED STATUS  CHART   APP VERSION
```

После изменений в ветках `post`:
```console
> helm ls --namespace review
NAME                            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
review-r2d2k-post-vtboig        review          1               2022-11-24 19:37:05.806289118 +0000 UTC deployed        reddit-0.1.0    1
```

После ручной остановки пайплайна в ветках `post`:
```console
> helm ls --namespace review
NAME    NAMESPACE       REVISION        UPDATED STATUS  CHART   APP VERSION
```

Для создания `staging` и `production` среды используем следующий конфиг CI\CD для репозитория `reddit-deploy`:
```yaml
image: alpine:latest

stages:
  - test
  - staging
  - production

test:
  stage: test
  script:
    - exit 0
  only:
    - triggers
    - branches

staging:
  stage: staging
  script:
  - install_dependencies
  - kubectl config get-contexts
  - kubectl config use-context r2d2k/reddit-deploy:reddit-agent
  - kubectl get pods --namespace "$KUBE_NAMESPACE"
  - ensure_namespace
  - deploy
  variables:
    KUBE_NAMESPACE: staging
  environment:
    name: staging
    url: http://staging
  only:
    refs:
      - main

production:
  stage: production
  script:
    - install_dependencies
    - kubectl config get-contexts
    - kubectl config use-context r2d2k/reddit-deploy:reddit-agent
    - kubectl get pods --namespace "$KUBE_NAMESPACE"
    - ensure_namespace
    - deploy
  variables:
    KUBE_NAMESPACE: production
  environment:
    name: production
    url: http://production
  when: manual
  only:
    refs:
      - main

.auto_devops: &auto_devops |
  # Auto DevOps variables and functions
  [[ "$TRACE" ]] && set -x
  export CI_REGISTRY="index.docker.io"
  export CI_APPLICATION_REPOSITORY=$CI_REGISTRY/$CI_PROJECT_PATH
  export CI_APPLICATION_TAG=$CI_COMMIT_REF_SLUG
  export CI_CONTAINER_NAME=ci_job_build_${CI_JOB_ID}
  export TILLER_NAMESPACE="kube-system"

  function deploy() {
    echo $KUBE_NAMESPACE
    track="${1-stable}"
    name="$CI_ENVIRONMENT_SLUG"
    helm dep build reddit

    helm upgrade --install \
      --debug \
      --wait \
      --set ui.ingress.host="$host" \
      --set ui.image.tag="$(curl $CI_SERVER_URL/$CI_PROJECT_NAMESPACE/ui/-/raw/main/VERSION)" \
      --set post.image.tag="$(curl $CI_SERVER_URL/$CI_PROJECT_NAMESPACE/post/-/raw/main/VERSION)" \
      --set comment.image.tag="$(curl $CI_SERVER_URL/$CI_PROJECT_NAMESPACE/comment/-/raw/main/VERSION)" \
      --namespace="$KUBE_NAMESPACE" \
      --version="$CI_PIPELINE_ID-$CI_JOB_ID" \
      "$name" \
      reddit
  }

  function install_dependencies() {

    apk add -U openssl curl tar gzip bash ca-certificates git
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r0/glibc-2.35-r0.apk
    apk add --force-overwrite glibc-2.35-r0.apk
    apk fix --force-overwrite alpine-baselayout-data
    rm glibc-2.35-r0.apk

    curl https://storage.googleapis.com/pub/gsutil.tar.gz | tar -xz -C $HOME
    export PATH=${PATH}:$HOME/gsutil

    curl https://get.helm.sh/helm-v3.10.2-linux-amd64.tar.gz | tar zx

    mv linux-amd64/helm /usr/bin/
    helm version --client

    curl  -o /usr/bin/sync-repo.sh https://raw.githubusercontent.com/kubernetes/helm/master/scripts/sync-repo.sh
    chmod a+x /usr/bin/sync-repo.sh

    curl -L -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
    chmod +x /usr/bin/kubectl
    kubectl version --client
  }

  function ensure_namespace() {
    kubectl describe namespace "$KUBE_NAMESPACE" || kubectl create namespace "$KUBE_NAMESPACE"
  }

  function delete() {
    track="${1-stable}"
    name="$CI_ENVIRONMENT_SLUG"
    helm delete "$name" --namespace="$KUBE_NAMESPACE" || true
  }

before_script:
  - *auto_devops
```

Этот конфиг отличается от предыдущего тем, что:
 - Не собирает docker-образы
 - Деплоит на статичные окружения (staging и production)
 - Не удаляет окружения

После успешного завершения `staging` прописываем в `host` соответствие имени среды и IP, который можно увидеть у облачного балансировщика нагрузки.
Проверяем - приложение работает. Т.к. количество внешних балансировщиков ограничено, то для запуска `production` нужно удалить балансировщик `staging`.
Удаляем, запускаем этап `production` руками из интерфейса Gitlab, смотрим адрес балансировщика, прописываем в `hosts` - работает.

Можно избавиться от AutoDevOps, перенеся все процедуры в соотвествующте шаги. Для `ui` получим следущий вариант:
```yaml
image: alpine:latest

stages:
  - build
  - test
  - review
  - release
  - cleanup

build:
  stage: build
  only:
    - branches
  image: docker:git
  services:
    - docker:18.09.7-dind
  variables:
    DOCKER_DRIVER: overlay2
    CI_REGISTRY: 'index.docker.io'
    CI_APPLICATION_REPOSITORY: $CI_REGISTRY/$CI_PROJECT_PATH
    CI_APPLICATION_TAG: $CI_COMMIT_REF_SLUG
    CI_CONTAINER_NAME: ci_job_build_${CI_JOB_ID}
  before_script:
    - >
      if ! docker info &>/dev/null; then
        if [ -z "$DOCKER_HOST" -a "$KUBERNETES_PORT" ]; then
          export DOCKER_HOST='tcp://localhost:2375'
        fi
      fi
  script:
    # Building
    - echo "Building Dockerfile-based application..."
    - echo `git show --format="%h" HEAD | head -1` > build_info.txt
    - echo `git rev-parse --abbrev-ref HEAD` >> build_info.txt
    - docker build -t "$CI_APPLICATION_REPOSITORY:$CI_APPLICATION_TAG" .
    - >
      if [[ -n "$CI_REGISTRY_USER" ]]; then
        echo "Logging to GitLab Container Registry with CI credentials...for build"
        docker login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
      fi
    - echo "Pushing to GitLab Container Registry..."
    - docker push "$CI_APPLICATION_REPOSITORY:$CI_APPLICATION_TAG"

test:
  stage: test
  script:
    - exit 0
  only:
    - branches

release:
  stage: release
  image: docker
  services:
    - docker:18.09.7-dind
  variables:
    CI_REGISTRY: 'index.docker.io'
    CI_APPLICATION_REPOSITORY: $CI_REGISTRY/$CI_PROJECT_PATH
    CI_APPLICATION_TAG: $CI_COMMIT_REF_SLUG
    CI_CONTAINER_NAME: ci_job_build_${CI_JOB_ID}
  before_script:
    - >
      if ! docker info &>/dev/null; then
        if [ -z "$DOCKER_HOST" -a "$KUBERNETES_PORT" ]; then
          export DOCKER_HOST='tcp://localhost:2375'
        fi
      fi
  script:
    # Releasing
    - echo "Updating docker images ..."
    - >
      if [[ -n "$CI_REGISTRY_USER" ]]; then
        echo "Logging to GitLab Container Registry with CI credentials for release..."
        docker login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
      fi
    - docker pull "$CI_APPLICATION_REPOSITORY:$CI_APPLICATION_TAG"
    - docker tag "$CI_APPLICATION_REPOSITORY:$CI_APPLICATION_TAG" "$CI_APPLICATION_REPOSITORY:$(cat VERSION)"
    - docker push "$CI_APPLICATION_REPOSITORY:$(cat VERSION)"
    # latest is neede for feature flags
    - docker tag "$CI_APPLICATION_REPOSITORY:$CI_APPLICATION_TAG" "$CI_APPLICATION_REPOSITORY:latest"
    - docker push "$CI_APPLICATION_REPOSITORY:latest"
  only:
    - main

review:
  stage: review
  variables:
    KUBE_NAMESPACE: review
    host: $CI_PROJECT_PATH_SLUG-$CI_COMMIT_REF_SLUG
    CI_APPLICATION_TAG: $CI_COMMIT_REF_SLUG
    name: $CI_ENVIRONMENT_SLUG
  environment:
    name: review/$CI_PROJECT_PATH/$CI_COMMIT_REF_NAME
    url: http://$CI_PROJECT_PATH_SLUG-$CI_COMMIT_REF_SLUG
    on_stop: stop_review
  only:
    refs:
      - branches
    kubernetes: active
  except:
    - main
  before_script:
    # installing dependencies
    - apk add -U openssl curl tar gzip bash ca-certificates git
    - wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
    - wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r0/glibc-2.35-r0.apk
    - apk add --force-overwrite glibc-2.35-r0.apk
    - apk fix --force-overwrite alpine-baselayout-data
    - rm glibc-2.35-r0.apk
    - curl https://storage.googleapis.com/pub/gsutil.tar.gz | tar -xz -C $HOME
    - export PATH=${PATH}:$HOME/gsutil
    - curl https://get.helm.sh/helm-v3.10.2-linux-amd64.tar.gz | tar zx
    - mv linux-amd64/helm /usr/bin/
    - helm version --client
    - curl  -o /usr/bin/sync-repo.sh https://raw.githubusercontent.com/kubernetes/helm/master/scripts/sync-repo.sh
    - chmod a+x /usr/bin/sync-repo.sh
    - curl -L -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
    - chmod +x /usr/bin/kubectl
    - kubectl version --client
    # Set context
    - kubectl config get-contexts
    - kubectl config use-context r2d2k/reddit-deploy:reddit-agent
    - kubectl get pods
    # ensuring namespace
    - kubectl describe namespace "$KUBE_NAMESPACE" || kubectl create namespace "$KUBE_NAMESPACE"
  script:
    - export track="${1-stable}"
    - >
      if [[ "$track" != "stable" ]]; then
        name="$name-$track"
      fi
    - echo "Clone deploy repository..."
    - git clone $CI_SERVER_URL/$CI_PROJECT_NAMESPACE/reddit-deploy.git
    - echo "Download helm dependencies..."
    - helm dep update reddit-deploy/reddit
    - echo "Deploy helm release $name to $KUBE_NAMESPACE"
    - echo "Upgrading existing release..."
    - >
      helm upgrade \
        --install \
        --wait \
        --set ui.ingress.host="$host" \
        --set $CI_PROJECT_NAME.image.tag="$CI_APPLICATION_TAG" \
        --namespace="$KUBE_NAMESPACE" \
        --version="$CI_PIPELINE_ID-$CI_JOB_ID" \
        "$name" \
        reddit-deploy/reddit/

stop_review:
  stage: cleanup
  variables:
    KUBE_NAMESPACE: review
    GIT_STRATEGY: none
    name: $CI_ENVIRONMENT_SLUG
  environment:
    name: review/$CI_PROJECT_PATH/$CI_COMMIT_REF_NAME
    action: stop
  when: manual
  allow_failure: true
  only:
    refs:
      - branches
    kubernetes: active
  except:
    - main
  before_script:
    # installing dependencies
    - apk add -U openssl curl tar gzip bash ca-certificates git
    - wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
    - wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r0/glibc-2.35-r0.apk
    - apk add --force-overwrite glibc-2.35-r0.apk
    - apk fix --force-overwrite alpine-baselayout-data
    - rm glibc-2.35-r0.apk
    - curl https://storage.googleapis.com/pub/gsutil.tar.gz | tar -xz -C $HOME
    - export PATH=${PATH}:$HOME/gsutil
    - curl https://get.helm.sh/helm-v3.10.2-linux-amd64.tar.gz | tar zx
    - mv linux-amd64/helm /usr/bin/
    - helm version --client
    - curl  -o /usr/bin/sync-repo.sh https://raw.githubusercontent.com/kubernetes/helm/master/scripts/sync-repo.sh
    - chmod a+x /usr/bin/sync-repo.sh
    - curl -L -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
    - chmod +x /usr/bin/kubectl
    - kubectl version --client
    # Set context
    - kubectl config get-contexts
    - kubectl config use-context r2d2k/reddit-deploy:reddit-agent
    - kubectl get pods
  script:
    - helm delete "$name" --namespace="$KUBE_NAMESPACE" || true
```

Аналогично меняем конфиги для `post` и `comment`.

Так как мы изначально использовали helm3, то нужда в переделке отпадает.

Для `reddit-deploy` также избавимся от AutoDevOps:
```yaml
image: alpine:latest

stages:
  - test
  - staging
  - production

test:
  stage: test
  script:
    - exit 0
  only:
    - triggers
    - branches

staging:
  stage: staging
  variables:
    KUBE_NAMESPACE: staging
    CI_REGISTRY: "index.docker.io"
    CI_APPLICATION_REPOSITORY: $CI_REGISTRY/$CI_PROJECT_PATH
    CI_APPLICATION_TAG: $CI_COMMIT_REF_SLUG
    CI_CONTAINER_NAME: ci_job_build_${CI_JOB_ID}
  environment:
    name: staging
    url: http://staging
  only:
    refs:
      - main
  before_script:
    # installing dependencies
    - apk add -U openssl curl tar gzip bash ca-certificates git
    - wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
    - wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r0/glibc-2.35-r0.apk
    - apk add --force-overwrite glibc-2.35-r0.apk
    - apk fix --force-overwrite alpine-baselayout-data
    - rm glibc-2.35-r0.apk
    - curl https://storage.googleapis.com/pub/gsutil.tar.gz | tar -xz -C $HOME
    - export PATH=${PATH}:$HOME/gsutil
    - curl https://get.helm.sh/helm-v3.10.2-linux-amd64.tar.gz | tar zx
    - mv linux-amd64/helm /usr/bin/
    - helm version --client
    - curl  -o /usr/bin/sync-repo.sh https://raw.githubusercontent.com/kubernetes/helm/master/scripts/sync-repo.sh
    - chmod a+x /usr/bin/sync-repo.sh
    - curl -L -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
    - chmod +x /usr/bin/kubectl
    - kubectl version --client
    # Set context
    - kubectl config get-contexts
    - kubectl config use-context r2d2k/reddit-deploy:reddit-agent
    - kubectl get pods
    # ensuring namespace
    - kubectl describe namespace "$KUBE_NAMESPACE" || kubectl create namespace "$KUBE_NAMESPACE"
  script:
    - export track="${1-stable}"
    - export name="$CI_ENVIRONMENT_SLUG"
    - echo "Release name - $name"
    - helm dep build reddit
    - >
       helm upgrade --install \
        --debug \
        --wait \
        --set ui.ingress.host="$host" \
        --set ui.image.tag="$(curl $CI_SERVER_URL/$CI_PROJECT_NAMESPACE/ui/-/raw/main/VERSION)" \
        --set post.image.tag="$(curl $CI_SERVER_URL/$CI_PROJECT_NAMESPACE/post/-/raw/main/VERSION)" \
        --set comment.image.tag="$(curl $CI_SERVER_URL/$CI_PROJECT_NAMESPACE/comment/-/raw/main/VERSION)" \
        --namespace="$KUBE_NAMESPACE" \
        --version="$CI_PIPELINE_ID-$CI_JOB_ID" \
        "$name" \
        reddit

production:
  stage: production
  variables:
    KUBE_NAMESPACE: production
    CI_REGISTRY: "index.docker.io"
    CI_APPLICATION_REPOSITORY: $CI_REGISTRY/$CI_PROJECT_PATH
    CI_APPLICATION_TAG: $CI_COMMIT_REF_SLUG
    CI_CONTAINER_NAME: ci_job_build_${CI_JOB_ID}
  environment:
    name: production
    url: http://production
  when: manual
  only:
    refs:
      - main
  before_script:
    # installing dependencies
    - apk add -U openssl curl tar gzip bash ca-certificates git
    - wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
    - wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r0/glibc-2.35-r0.apk
    - apk add --force-overwrite glibc-2.35-r0.apk
    - apk fix --force-overwrite alpine-baselayout-data
    - rm glibc-2.35-r0.apk
    - curl https://storage.googleapis.com/pub/gsutil.tar.gz | tar -xz -C $HOME
    - export PATH=${PATH}:$HOME/gsutil
    - curl https://get.helm.sh/helm-v3.10.2-linux-amd64.tar.gz | tar zx
    - mv linux-amd64/helm /usr/bin/
    - helm version --client
    - curl  -o /usr/bin/sync-repo.sh https://raw.githubusercontent.com/kubernetes/helm/master/scripts/sync-repo.sh
    - chmod a+x /usr/bin/sync-repo.sh
    - curl -L -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
    - chmod +x /usr/bin/kubectl
    - kubectl version --client
    # Set context
    - kubectl config get-contexts
    - kubectl config use-context r2d2k/reddit-deploy:reddit-agent
    - kubectl get pods
    # ensuring namespace
    - kubectl describe namespace "$KUBE_NAMESPACE" || kubectl create namespace "$KUBE_NAMESPACE"
  script:
    - export track="${1-stable}"
    - export name="$CI_ENVIRONMENT_SLUG"
    - echo "Release name - $name"
    - helm dep build reddit
    - >
       helm upgrade --install \
        --debug \
        --wait \
        --set ui.ingress.host="$host" \
        --set ui.image.tag="$(curl $CI_SERVER_URL/$CI_PROJECT_NAMESPACE/ui/-/raw/main/VERSION)" \
        --set post.image.tag="$(curl $CI_SERVER_URL/$CI_PROJECT_NAMESPACE/post/-/raw/main/VERSION)" \
        --set comment.image.tag="$(curl $CI_SERVER_URL/$CI_PROJECT_NAMESPACE/comment/-/raw/main/VERSION)" \
        --namespace="$KUBE_NAMESPACE" \
        --version="$CI_PIPELINE_ID-$CI_JOB_ID" \
        "$name" \
        reddit
```

Для автоматического запуска деплоя после сборки образов можно использовать триггеры.
Добавим следующий блок в конфигурацию CI сервисов:
```yaml
deploy-app:
  stage: deploy-app
  trigger:
    project: r2d2k/reddit-deploy
    branch: main
  only:
    - main
```

**Результат №10-2:**

 - При помощи Terraform поднят кластер в Yandex Cloud
 - При помощи helm3 раззвёрнуто тестовое приложение
 - В кластере запущен Gitlab
 - Настроены процессы сборки и деплоя приложения в различные среды

 ---

 FIN
