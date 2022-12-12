#!/bin/bash

cd ./charts

for dir in ./*/     # list directories in the form "/tmp/dirname/"
do
    dir=${dir%*/}      # remove the trailing "/"
    echo "${dir##*/}"    # print everything after the final "/"
    
    helm package $dir -d $dir

done

helm repo index . --merge index.yaml 