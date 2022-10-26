# Домашние задания по микросервисам

Оглавление:
<!-- MarkdownTOC autolink=true -->

- [01 - Технология контейнеризации. Введение в Docker](#01---%D0%A2%D0%B5%D1%85%D0%BD%D0%BE%D0%BB%D0%BE%D0%B3%D0%B8%D1%8F-%D0%BA%D0%BE%D0%BD%D1%82%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D0%B8-%D0%92%D0%B2%D0%B5%D0%B4%D0%B5%D0%BD%D0%B8%D0%B5-%D0%B2-docker)

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
