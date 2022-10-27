# Домашние задания по микросервисам

Оглавление:
<!-- MarkdownTOC autolink=true -->

- [01 - Технология контейнеризации. Введение в Docker](#01---%D0%A2%D0%B5%D1%85%D0%BD%D0%BE%D0%BB%D0%BE%D0%B3%D0%B8%D1%8F-%D0%BA%D0%BE%D0%BD%D1%82%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D0%B8-%D0%92%D0%B2%D0%B5%D0%B4%D0%B5%D0%BD%D0%B8%D0%B5-%D0%B2-docker)
- [02 - Docker-образы. Микросервисы](#02---docker-%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%D1%8B-%D0%9C%D0%B8%D0%BA%D1%80%D0%BE%D1%81%D0%B5%D1%80%D0%B2%D0%B8%D1%81%D1%8B)
- [03 - Docker: сети, docker-compose](#03---docker-%D1%81%D0%B5%D1%82%D0%B8-docker-compose)

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
