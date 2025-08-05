#!/bin/sh -l
set -euo pipefail

mc alias set deploy $MINIO_ENDPOINT $MINIO_ACCESS_KEY $MINIO_SECRET_KEY --api S3v4

[[ -n "${1:+x}" ]] || ( echo "please supply a source as first parameter" && exit 1 )
[[ -n "${2:+x}" ]] || ( echo "please supply a target as second parameter" && exit 1 )

SOURCE=$1; shift
TARGET=$1; shift

mc mirror --overwrite $* $SOURCE "deploy/$TARGET" $*
