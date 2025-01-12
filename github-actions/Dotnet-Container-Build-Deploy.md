# Using GHA to Build an Application and Push it to GitHub Container Registry

## Scenario
I wanted to use GitHub Actions to automatically build my BronzeBot application's Docker image and push that image to a remote container registry. I chose GHCR because I saw it was free and I didn't have to worry too much about authenticating from my GHA. The BronzeBot application is a Dotnet core application which uses the Discord.NET library. 

## Steps

### Checkout the Code
- Code is checked out using the actions/checkout@main GHA

### Login to GHCR
- Docker provides an action (docker/login-action) which allows you to login to a 3rd party registry. It requires a registry, username, and password. 
- registry: ghcr.io
- username: ${{github.actor}} (this get the username of the user who started the action)
- password: ${{secrets.GITHUB_TOKEN}} (this uses the already available GITHUB_TOKEN secret as the password)

### Setup Python
- Use the actions/setup-python action to setup python. Will be needed to update the application version in the csproj file

### Setup Git Username and Email
- Run git config commands to set the git user and email. I used the following:
- user.name -> github-actions[bot]
- user.email -> github-actions[bot]@users.noreply.github.com

### Update Application Version
- For a Dotnet application, the Version number is store in the .csproj file's XML
- In order to update it, I wrote a python script which parses out the csproj XML and updates it according to the user provided options (file location, build type, etc)
- I used the `semver` package to enforce semantic versioning
- On push to the main branch, the `PATCH` number is bumped by one. For anything else (minor or major version bumps), a workflow dispatch should be used
- After the python script runs:
    - Set a variable VER to the value of the output of the script
    - Write the output to an env variable called NEW_VERSION
        - `echo "NEW_VERSION=$VER >> $GITHUB_ENV"`
        - The env var will be referenced when building the docker image
    - Commit and push the changes

### Build the Image
- To do this I just wrote a bash script but I think there is a docker action that will do it for you
- I built the image using the Dockerfile as normal, and added two tags: `latest` and the value of the `NEW_VERSION` env var
    - `docker build -f ./BronzeBot/Dockerfile . -t ghcr.io/celbert96/bronzebot:latest -t ghcr.io/celbert96/bronzebot:${{env.NEW_VERSION}}`
- I then pushed the image to ghcr.
    - `docker push ghcr.io/celbert96/bronzebot --all-tags`
    - NOTE: Initially I did not have the `--all-tags` argument and so in GHCR all you could see was the `latest` tag

## Pull the Image from GHCR
- In order to pull the image from GHCR, a Personal Access Token (classic) is needed. This access token needs to have the `repo` and `packages:write` scopes
- Once that PAT is created, you can log into GHCR using docker
    - `echo $GHCR_PAT | docker login ghcr.io -u {github-username} --password-stdin`
    - NOTE: If you get the error `Error: Cannot perform an interactive login from a non TTY device`, then the docker login command is not getting the password
- You can then pull the image (docker pull {github-username}/{image}/{tag})
    - `docker pull ghcr.io/celbert96/bronzebot:0.0.4`
    - `docker pull ghcr.io/celbert96/bronzebot:latest`

