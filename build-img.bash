#!/bin/bash

while getopts t:p: flag
do
    case "${flag}" in
        t) tagName=${OPTARG};;
    esac
done

if [ -z $tagName ] 
then 
  echo "Err: no tag provided. You need to provide a tag using option -t"
  exit 
fi

lastImageId=$(docker images --format "{{.ID}} {{.CreatedAt}}" | sort -rk 2 | awk 'NR==1{print $1}')

#1 build image with gradlew and jibDockerBuild
 echo "building docker image..."
./gradlew -Pprod bootWar jibDockerBuild -x test --console=plain

#2 tag image (get last created image id THEN excute tag command)
newImageId=$(docker images --format "{{.ID}} {{.CreatedAt}}" | sort -rk 2 | awk 'NR==1{print $1}')

#3 check if image was build successfully
if [ $lastImageId == $newImageId ] 
then
 echo "Err: failed to build docker image."
 exit
fi

#4 tag the image
echo "tagging image..."
docker tag ${newImageId} ${tagName}

#5) push image
echo "pushing image..."
docker push $tagName
echo "image created and pushed. id: ${newImageId} tag: ${tagName}"

