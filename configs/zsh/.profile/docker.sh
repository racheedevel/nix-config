alias dcu='docker compose up --build -d'
alias dcd='docker compose down'
alias dcl='docker compose logs -f'
alias dcr='docker compose restart'
alias dcp='docker compose ps'
alias dcs='docker compose stop -t 0'

# docker compose logs since start of the (1st provided) container
function dcls() {
  containerName=$1
  if [ -z "$containerName" ]; then
    docker compose logs -f
  else
    containerId=`docker compose ps -a --format=json | jq -r -s --arg containerName "$containerName"  '.[] | select(.Service == $containerName) | .ID'`
    containerStartedAt=`docker inspect --format '{{.State.StartedAt}}' "$containerId"`
    docker compose logs -f --since "$containerStartedAt" $@
  fi
}

function dce() {
    docker compose exec -it $1 /bin/bash
}

function dcd() {
    docker compose 
}

function dct() {
    local container=`rg 'services:' . --type=yaml -U --files-with-matches | fzf`
    echo "$container"
    docker compose -f "$container" up -d --build \
        && docker compose -f "$container" logs -f; \
        docker compose -f "$container" down
}

function dev_args() {
    local file=""
    # local args=""
    for i in {1..$#}; do
        if [[ "$@[$i]" =~ ".*compose.yml" ]]; then
            file="$@[$i]"
        # elif [[ "$@[$i]" =~ "--.*" || "$@[$i]" =~ "-.*" ]]; then
            # args="$args $@[$i]"
        fi
    done
    echo "Shutting down: $file"
    # echo "Options: $args"
    docker compose -f "$file" down
}
