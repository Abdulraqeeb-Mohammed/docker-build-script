# docker-build-script

This is a shell script with Bash syntax, that assists with building a docker image for a spring-boot application using jibDockerBuild, and tag the image and push it to docker-hub

# How to use

Place the script file in your root project directory, then execute the following command:
`./build-img.bash -t <your image tag>`

This will :
1- Build docker image with `jibDockerBuild`
2- Tag the image with the specified tag name 
3- push the image to docker hub.


Incase anything goes wrong you will get the message : `Err: failed to build docker image.`