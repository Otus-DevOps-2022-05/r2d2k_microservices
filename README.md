# Домашние задания по микросервисам

Оглавление:
<!-- MarkdownTOC autolink=true -->

- [01 - Технология контейнеризации. Введение в Docker](#01---%D0%A2%D0%B5%D1%85%D0%BD%D0%BE%D0%BB%D0%BE%D0%B3%D0%B8%D1%8F-%D0%BA%D0%BE%D0%BD%D1%82%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D0%B8-%D0%92%D0%B2%D0%B5%D0%B4%D0%B5%D0%BD%D0%B8%D0%B5-%D0%B2-docker)

<!-- /MarkdownTOC -->

---

## 01 - Технология контейнеризации. Введение в Docker

**Задание №01-1:** Создать docker host. Создать свой образ. Изучить работу с Docker Hub

**Решение №01-1:**
Работаем в каталоге `docker-monolith`.
Устанавливаем Docker по (официальной)[https://docs.docker.com/engine/install/ubuntu/] документации.
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

Образ был скачан, запущен в контейнере, вывел сообщение и завершил работу. Вот он в выключенном состоянии:
```console
> docker ps -a
CONTAINER ID   IMAGE         COMMAND    CREATED         STATUS                     PORTS     NAMES
7209dc11e9c9   hello-world   "/hello"   6 seconds ago   Exited (0) 3 seconds ago             ecstatic_tu
```

Видим, что образ присутствут на локальной системе:
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

Из запущенного контейнера можно создать образ:
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

Пришло время собрать собственный образ. Подготовим четыре файла:
 - Dockerfile - текстовое описание нашего образа
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

Собирать образ будем на базе `Ubuntu 18.04`. Обновляем списки пакетов, устанавливаем всё необходимое для работы. Клонируем пепозиторий с приложением.
Копируем конфигурационные файлы приложения и скрипт для его запуска. Устанавливаем пакеты `ruby` и запускаем приложение.
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

Запустим наш образ и проверим статус:
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

Попробуем запустить контейнер с образом из hub.docker.com. Для начала зачистим систему от всех контейненров и образов:
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
