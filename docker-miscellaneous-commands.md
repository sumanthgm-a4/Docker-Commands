# Docker Miscellaneous Commands Cheat Sheet

## 1. Docker Images

| Command                        | Description                   | Useful Flags / Notes                                          |
| ------------------------------ | ----------------------------- | ------------------------------------------------------------- |
| `docker images`                | List all local images         | `-a` (all images), `--filter "dangling=true"` (only dangling) |
| `docker pull <image>`          | Pull an image from Docker Hub | `:tag` to pull specific version                               |
| `docker build -t <name:tag> .` | Build image from Dockerfile   | `--no-cache` ignore cache, `--build-arg <key=value>`          |
| `docker rmi <image>`           | Remove image                  | `-f` force, can use image ID                                  |
| `docker tag <source> <target>` | Tag image for repository      | `docker tag myimage:latest myrepo/myimage:v1`                 |
| `docker push <image>`          | Push image to registry        | Must be tagged with repo                                      |

## 2. Docker Containers

| Command                             | Description                          | Useful Flags / Notes                                                                                            |
| ----------------------------------- | ------------------------------------ | --------------------------------------------------------------------------------------------------------------- |
| `docker ps`                         | List running containers              | `-a` list all, `--format` for custom output                                                                     |
| `docker run <image>`                | Run a container                      | `-d` detached, `-it` interactive, `--name <name>`, `-p host:container` port mapping, `-v host:container` volume |
| `docker start <container>`          | Start stopped container              | -                                                                                                               |
| `docker stop <container>`           | Stop running container               | -                                                                                                               |
| `docker restart <container>`        | Restart container                    | -                                                                                                               |
| `docker rm <container>`             | Remove container                     | `-f` force                                                                                                      |
| `docker logs <container>`           | View logs                            | `-f` follow logs, `--tail 100` last 100 lines                                                                   |
| `docker exec -it <container> <cmd>` | Run command inside container         | Common: `bash` / `sh`                                                                                           |
| `docker attach <container>`         | Attach terminal to running container | Ctrl+C detaches differently (use `Ctrl+P Ctrl+Q`)                                                               |

## 3. Docker Networks

| Command                                       | Description                           | Useful Flags / Notes |                             |
| --------------------------------------------- | ------------------------------------- | -------------------- | --------------------------- |
| `docker network ls`                           | List networks                         | -                    |                             |
| `docker network create <name>`                | Create network                        | `--driver bridge`, `overlay`, `--subnet <CIDR>` |
| `docker network inspect <name>`               | Inspect network                       | -                    |                             |
| `docker network rm <name>`                    | Remove network                        | -                    |                             |
| `docker run --network <net>`                  | Connect container to network          | -                    |                             |
| `docker network connect <net> <container>`    | Connect existing container to network | -                    |                             |
| `docker network disconnect <net> <container>` | Disconnect container from network     | -                    |                             |

## 4. Docker Volumes

| Command                                     | Description    | Useful Flags / Notes                          |
| ------------------------------------------- | -------------- | --------------------------------------------- |
| `docker volume ls`                          | List volumes   | -                                             |
| `docker volume create <name>`               | Create volume  | -                                             |
| `docker volume inspect <name>`              | Inspect volume | -                                             |
| `docker volume rm <name>`                   | Remove volume  | `-f` force                                    |
| `docker run -v <volume>:/path/in/container` | Mount volume   | Named volumes persist after container removed |

## 5. Docker Compose

| Command                               | Description                      | Useful Flags / Notes                                  |
| ------------------------------------- | -------------------------------- | ----------------------------------------------------- |
| `docker-compose up`                   | Start services                   | `-d` detached, `--build` rebuild images               |
| `docker-compose down`                 | Stop & remove services           | `--volumes` remove volumes, `--rmi all` remove images |
| `docker-compose ps`                   | List compose containers          | -                                                     |
| `docker-compose logs`                 | View logs                        | `-f` follow, `--tail 100` last 100 lines              |
| `docker-compose exec <service> <cmd>` | Run command in service container | `-T` disable pseudo-TTY                               |

## 6. Docker Swarm

| Command                                             | Description            | Useful Flags / Notes                          |
| --------------------------------------------------- | ---------------------- | --------------------------------------------- |
| `docker swarm init`                                 | Initialize swarm       | `--advertise-addr <ip>`                       |
| `docker swarm join --token <token>`                 | Join existing swarm    | -                                             |
| `docker node ls`                                    | List swarm nodes       | -                                             |
| `docker service create`                             | Deploy service         | `--name`, `--replicas`, `-p` for port mapping |
| `docker service ls`                                 | List services          | -                                             |
| `docker service scale <service>=<replicas>`         | Scale service          | -                                             |
| `docker service ps <service>`                       | List tasks of service  | -                                             |
| `docker stack deploy -c docker-compose.yml <stack>` | Deploy stack           | `--with-registry-auth` for private images     |
| `docker stack ls`                                   | List stacks            | -                                             |
| `docker stack services <stack>`                     | List services in stack | -                                             |
| `docker stack rm <stack>`                           | Remove stack           | -                                             |

## 7. Miscellaneous

| Command                    | Description                               | Useful Flags / Notes                                |   |
| -------------------------- | ----------------------------------------- | --------------------------------------------------- | - |
| `docker info`              | Show system-wide info                     | -                                                   |   |
| `docker version`           | Show client & server version              | -                                                   |   |
| `docker system df`         | Disk usage by images, containers, volumes | -                                                   |   |
| `docker system prune`      | Remove unused data                        | `-a` all unused images, `--volumes` include volumes |   |
| `docker inspect <container / image>`                                   | Detailed info                                       | - |
| `docker cp <src> <dest>`   | Copy files between container & host       | -                                                   |   |
| `docker stats`             | Real-time container metrics               | -                                                   |   |
