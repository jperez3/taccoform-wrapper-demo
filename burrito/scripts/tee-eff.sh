#!/bin/bash

SUBCOMMAND=$1

# Terraform Backend S3 Bucket
export TF_STATE_BUCKET_NAME='taccoform-tf-backend'

# current working directory matches module name
export MODULE_NAME=$(basename $PWD)

# Retrieve absolute path for repo
export REPO_PATH=$(git rev-parse --show-toplevel)

# Parse out repository name from repository path
export REPO_NAME=$(basename ${REPO_PATH})

# grab service path name, eg. "burrito/workspaces/dev/base"
export SERVICE_PATH=${PWD#*$REPO_NAME/}

# remove everything after service path's first slash to retrieve service name
export SERVICE=${SERVICE_PATH%/workspaces*}

# Remove everything before workspace and split string to get environment name
export ENV=$(echo ${SERVICE_PATH#*/workspaces/} | cut -d "/" -f 1)

# Constructing module path for template files to be listed and rendered
export TEMPLATE_PATH="${REPO_PATH}/${SERVICE}/modules/${MODULE_NAME}"

echo "Module Name:  ${MODULE_NAME}"
echo "Repo Name:    ${REPO_NAME}"
echo "Repo Path:    ${REPO_PATH}"
echo "Service Path: ${SERVICE_PATH}"
echo "Service:      ${SERVICE}"
echo "Environment:  ${ENV}"
echo "Template Path: ${TEMPLATE_PATH}"


if [[ $SUBCOMMAND == *"init"* ]]; then
    echo "removing any existing terraform files in current working directory"
    rm -rf $PWD/*.tf

    export TEMPLATE_FILES=$(ls $TEMPLATE_PATH/workspace-templates/*.tf)

    for FILE_PATH in $TEMPLATE_FILES; do
        export FILE_NAME=$(basename ${FILE_PATH})
        echo "File NAME: ${FILE_NAME}"
        envsubst < ${FILE_PATH} | tee ./${FILE_NAME}
    done

elif [[ $SUBCOMMAND == *"plan"* || $SUBCOMMAND == *"apply"* ]]; then
    terraform $SUBCOMMAND
else
    echo "$SUBCOMMAND isn't an available terraform subcommand"
fi
