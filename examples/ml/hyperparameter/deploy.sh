#!/bin/sh

pachctl create-repo raw_data
pachctl create-repo parameters

pushd data
pachctl put-file raw_data master iris.csv -f noisy_iris.csv

pushd parameters
pachctl put-file parameters master -f c_parameters.txt --split line --target-file-datums 1
pachctl put-file parameters master -f gamma_parameters.txt --split line --target-file-datums 1
popd
popd

pachctl create-pipeline -f split.json
pachctl create-pipeline -f model.json
pachctl create-pipeline -f test.json
pachctl create-pipeline -f select.json
