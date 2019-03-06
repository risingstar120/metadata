#!/bin/bash
# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Convenience binary to build TFMD from source.

# Put wrapped c++ files in place

# Usage: build_pip_package.sh [--python_bin_path PYTHON_BIN_PATH]

if [[ -z "$1" ]]; then
  PYTHON_BIN_PATH=python
else
  if [[ "$1" == --python_bin_path ]]; then
    shift
    PYTHON_BIN_PATH=$1
  else
    printf "Unrecognized argument $1"
    exit 1
  fi
fi

set -u -x

cp -f tensorflow_metadata/proto/v0/schema_pb2.py \
  ${BUILD_WORKSPACE_DIRECTORY}/tensorflow_metadata/proto/v0

cp -f tensorflow_metadata/proto/v0/path_pb2.py \
  ${BUILD_WORKSPACE_DIRECTORY}/tensorflow_metadata/proto/v0

cp -f tensorflow_metadata/proto/v0/anomalies_pb2.py \
  ${BUILD_WORKSPACE_DIRECTORY}/tensorflow_metadata/proto/v0

cp -f tensorflow_metadata/proto/v0/statistics_pb2.py \
  ${BUILD_WORKSPACE_DIRECTORY}/tensorflow_metadata/proto/v0

# Create the wheel
cd ${BUILD_WORKSPACE_DIRECTORY}

${PYTHON_BIN_PATH} setup.py bdist_wheel

# Cleanup
cd -
