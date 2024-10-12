# Docker Commands

### Build Docker image
`docker build --tag {app-name} .`

### Create and Run Docker Container
`docker run -p 8080:8080 --name {name} -d {imageId}`

> -d means to run the container in detatched mode

### Stop a Running Container
`docker container stop {containerId}`

### Delete a Container
`docker container rm {containerId} `

### List Images
`docker images`

### List Running Containers
`docker ps`