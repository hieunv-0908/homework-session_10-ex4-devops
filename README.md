\# Bài 4: Thiết lập Custom Network \& Named Volume bằng Docker CLI



\## 1. Cấu trúc thư mục

```text

homework/session\_10/ex4/

├── commands.sh

└── README.md



\------



CLI:



Admin@Admin MINGW64 /d/baitap\_devops/baitap/ss10/b4

$ docker run -d --name app-container --network app-net -e DB\_HOST=db-server -e DB\_PORT=5432 -e DB\_USER=myuser -e DB\_PASS=mypassword -e DB\_NAME=mydb alpine tail -f /dev/null

da38cbf03b0bd0e14c88b9e774100b3acd1e30ce568c2d080059db9c39423d48



Admin@Admin MINGW64 /d/baitap\_devops/baitap/ss10/b4

$ docker exec -it app-container ping -c 2 db-server



What's next:

&#x20;   Try Docker Debug for seamless, persistent debugging tools in any container or image → docker debug app-container

&#x20;   Learn more at https://docs.docker.com/go/debug-cli/

Error response from daemon: container da38cbf03b0bd0e14c88b9e774100b3acd1e30ce568c2d080059db9c39423d48 is not running



Admin@Admin MINGW64 /d/baitap\_devops/baitap/ss10/b4

$ docker ps -a

CONTAINER ID   IMAGE                 COMMAND                  CREATED          STATUS                        PORTS      NAMES

da38cbf03b0b   alpine                "tail -f nul"            20 seconds ago   Exited (1) 20 seconds ago                app-container

6931a19dd008   postgres:15-alpine    "docker-entrypoint.s…"   5 minutes ago    Up 5 minutes                  5432/tcp   db-server

7515efa74831   hw-backend:v1         "docker-entrypoint.s…"   15 minutes ago   Exited (137) 12 minutes ago              app-single-stage

bc348b7ba183   apache/kafka:latest   "/\_\_cacert\_entrypoin…"   2 weeks ago      Exited (255) 28 hours ago     9092/tcp   awesome\_villani

a20dd97fe1f9   apache/kafka:latest   "/\_\_cacert\_entrypoin…"   2 weeks ago      Exited (137) 2 weeks ago                 nice\_banach

8c8a51e59b9b   redis:7-alpine        "docker-entrypoint.s…"   5 weeks ago      Exited (0) 5 weeks ago                   langfuse-redis



Admin@Admin MINGW64 /d/baitap\_devops/baitap/ss10/b4

$ docker stop app-container

app-container



Admin@Admin MINGW64 /d/baitap\_devops/baitap/ss10/b4

$ docker rm app-container

app-container



Admin@Admin MINGW64 /d/baitap\_devops/baitap/ss10/b4

$ docker ps -a

CONTAINER ID   IMAGE                 COMMAND                  CREATED          STATUS                        PORTS      NAMES

6931a19dd008   postgres:15-alpine    "docker-entrypoint.s…"   6 minutes ago    Up 6 minutes                  5432/tcp   db-server

7515efa74831   hw-backend:v1         "docker-entrypoint.s…"   16 minutes ago   Exited (137) 13 minutes ago              app-single-stage

bc348b7ba183   apache/kafka:latest   "/\_\_cacert\_entrypoin…"   2 weeks ago      Exited (255) 28 hours ago     9092/tcp   awesome\_villani

a20dd97fe1f9   apache/kafka:latest   "/\_\_cacert\_entrypoin…"   2 weeks ago      Exited (137) 2 weeks ago                 nice\_banach

8c8a51e59b9b   redis:7-alpine        "docker-entrypoint.s…"   5 weeks ago      Exited (0) 5 weeks ago                   langfuse-redis



Admin@Admin MINGW64 /d/baitap\_devops/baitap/ss10/b4

$ docker run -d --name app-container --network app-net -e DB\_HOST=db-server -e DB\_PORT=5432 -e DB\_USER=myuser -e DB\_PASS=mypassword -e DB\_NAME=mydb alpine sleep infinity

7ad9b89ebddf66d87d413b20a268899cdd717ea24171bb3beff67d2c786bdf1d



Admin@Admin MINGW64 /d/baitap\_devops/baitap/ss10/b4

$ docker ps -a

CONTAINER ID   IMAGE                 COMMAND                  CREATED          STATUS                        PORTS      NAMES

7ad9b89ebddf   alpine                "sleep infinity"         4 seconds ago    Up 3 seconds                             app-container

6931a19dd008   postgres:15-alpine    "docker-entrypoint.s…"   7 minutes ago    Up 7 minutes                  5432/tcp   db-server

7515efa74831   hw-backend:v1         "docker-entrypoint.s…"   17 minutes ago   Exited (137) 14 minutes ago              app-single-stage

bc348b7ba183   apache/kafka:latest   "/\_\_cacert\_entrypoin…"   2 weeks ago      Exited (255) 28 hours ago     9092/tcp   awesome\_villani

a20dd97fe1f9   apache/kafka:latest   "/\_\_cacert\_entrypoin…"   2 weeks ago      Exited (137) 2 weeks ago                 nice\_banach

8c8a51e59b9b   redis:7-alpine        "docker-entrypoint.s…"   5 weeks ago      Exited (0) 5 weeks ago                   langfuse-redis



Admin@Admin MINGW64 /d/baitap\_devops/baitap/ss10/b4

$ docker exec -it app-container ping -c 2 db-server

PING db-server (172.20.0.2): 56 data bytes

64 bytes from 172.20.0.2: seq=0 ttl=64 time=0.612 ms

64 bytes from 172.20.0.2: seq=1 ttl=64 time=0.076 ms



\--- db-server ping statistics ---

2 packets transmitted, 2 packets received, 0% packet loss

round-trip min/avg/max = 0.076/0.344/0.612 ms



What's next:

&#x20;   Try Docker Debug for seamless, persistent debugging tools in any container or image → docker debug app-container

&#x20;   Learn more at https://docs.docker.com/go/debug-cli/



Admin@Admin MINGW64 /d/baitap\_devops/baitap/ss10/b4

$ docker ps -a

CONTAINER ID   IMAGE                 COMMAND                  CREATED          STATUS                        PORTS      NAMES

7ad9b89ebddf   alpine                "sleep infinity"         20 seconds ago   Up 19 seconds                            app-container

6931a19dd008   postgres:15-alpine    "docker-entrypoint.s…"   7 minutes ago    Up 7 minutes                  5432/tcp   db-server

7515efa74831   hw-backend:v1         "docker-entrypoint.s…"   17 minutes ago   Exited (137) 15 minutes ago              app-single-stage

bc348b7ba183   apache/kafka:latest   "/\_\_cacert\_entrypoin…"   2 weeks ago      Exited (255) 28 hours ago     9092/tcp   awesome\_villani

a20dd97fe1f9   apache/kafka:latest   "/\_\_cacert\_entrypoin…"   2 weeks ago      Exited (137) 2 weeks ago                 nice\_banach

8c8a51e59b9b   redis:7-alpine        "docker-entrypoint.s…"   5 weeks ago      Exited (0) 5 weeks ago                   langfuse-redis



Admin@Admin MINGW64 /d/baitap\_devops/baitap/ss10/b4

$ docker exec -i db-server psql -U myuser -d mydb -c "CREATE TABLE test\_data (id SERIAL PRIMARY KEY, val VARCHAR(50));"

ERROR:  relation "test\_data" already exists



Admin@Admin MINGW64 /d/baitap\_devops/baitap/ss10/b4

$ docker ps -a

CONTAINER ID   IMAGE                 COMMAND                  CREATED              STATUS                        PORTS      NAMES

7ad9b89ebddf   alpine                "sleep infinity"         About a minute ago   Up About a minute                        app-container

6931a19dd008   postgres:15-alpine    "docker-entrypoint.s…"   8 minutes ago        Up 8 minutes                  5432/tcp   db-server

7515efa74831   hw-backend:v1         "docker-entrypoint.s…"   19 minutes ago       Exited (137) 16 minutes ago              app-single-stage

bc348b7ba183   apache/kafka:latest   "/\_\_cacert\_entrypoin…"   2 weeks ago          Exited (255) 28 hours ago     9092/tcp   awesome\_villani

a20dd97fe1f9   apache/kafka:latest   "/\_\_cacert\_entrypoin…"   2 weeks ago          Exited (137) 2 weeks ago                 nice\_banach

8c8a51e59b9b   redis:7-alpine        "docker-entrypoint.s…"   5 weeks ago          Exited (0) 5 weeks ago                   langfuse-redis



Admin@Admin MINGW64 /d/baitap\_devops/baitap/ss10/b4

$ docker exec -i db-server psql -U myuser -d mydb -c "INSERT INTO test\_data (val) VALUES ('Du lieu van con - Test OK');"

INSERT 0 1



Admin@Admin MINGW64 /d/baitap\_devops/baitap/ss10/b4

$ docker rm -f db-server

db-server



Admin@Admin MINGW64 /d/baitap\_devops/baitap/ss10/b4

$ docker run -d --name db-server --network app-net -v db-data:/var/lib/postgresql/data -e POSTGRES\_USER=myuser -e POSTGRES\_PASSWORD=mypassword -e POSTGRES\_DB=mydb postgres:15-alpine

89629756e94e42f3a9c0da6fcd7303a8aaaf1186d36bcadbe2f6d764a4cc1919



Admin@Admin MINGW64 /d/baitap\_devops/baitap/ss10/b4

$ docker exec -i db-server psql -U myuser -d mydb -c "SELECT \* FROM test\_data;"

&#x20;id |            val

\----+---------------------------

&#x20; 1 | Persistence Test OK

&#x20;34 | Du lieu van con - Test OK

(2 rows)





