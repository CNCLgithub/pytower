#!/bin/bash

. load_config.sh

usage="$(basename "$0") [targets...] -- setup an environmental component of the project according to [default|local].conf
supported targets:
    cont_[pull|build] : either pull the singularity container or build from scratch
    python : build the python environment
    julia : build julia environment
"

cont_pull_url="TODO"
SING="${ENV['path']}"

[ $# -eq 0 ] || [[ "${@}" =~ "help" ]] && echo "$usage"

# container setup
[[ "${@}" =~ "cont_build" ]] || [[ "${@}" =~ "cont_pull" ]] || echo "Not touching container"
[[ "${@}" =~ "cont_pull" ]] && echo "pulling container" && \
    wget "$cont_pull_url" -O "${ENV[cont]}"
[[ "${@}" =~ "cont_build" ]] && echo "building container" && \
    SINGULARITY_TMPDIR=/var/tmp sudo -E $SING build "${ENV[cont]}" "${ENV[build]}"


# python setup
[[ "${@}" =~ "python" ]] || echo "Not touching python"
[[ "${@}" =~ "python" ]] && echo "building python env" && \
    singularity exec ${ENV[cont]} bash -c "yes | conda create -p $PWD/${ENV[pyenv]} python=3.8" && \
    ./run.sh python -m pip install -r requirements.txt

# julia setup
[[ "${@}" =~ "julia" ]] || echo "Not touching julia"
[[ "${@}" =~ "julia" ]] && echo "building julia env" && \
    ./run.sh julia -e '"using Pkg; Pkg.instantiate();"'

# datasets
# none yet
[[ "${@}" =~ "datasets" ]] || [[ "${@}" =~ "datasets" ]] || echo "Not touching datasets"
# [[ "${@}" =~ "datasets" ]] && echo "pulling datasets" && \
#     echo "pulling datasets" && \
#     # fill in here

# checkpoints
# none yet
[[ "${@}" =~ "checkpoints" ]] || [[ "${@}" =~ "checkpoints" ]] || echo "Not touching checkpoints"
# [[ "${@}" =~ "checkpoints" ]] && echo "pulling checkpoints" && \
#     echo "pulling checkpoints" && \
#     # fill in here
