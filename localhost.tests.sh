#!/bin/sh

echo
echo INITIALIZE LOCAL TESTING
echo ------------------------
CONTAINER_TEMPLATE_IMAGE="container-template-img"
CONTAINER_TEMPLATE_CONTAINER="container-template-cnt"
TEST_SCRIPT="dockerhub.tests.sh"

echo
echo REMOVING CONTAINERS AND IMAGES
echo ------------------------------
docker stop $CONTAINER_TEMPLATE_CONTAINER
docker rm $CONTAINER_TEMPLATE_CONTAINER
if [ "$1" = "no-cache" ]; then 
    echo "Enforcing option $1"
    sudo docker rmi $CONTAINER_TEMPLATE_IMAGE
fi 

echo
echo REBUILD IMAGE FROM DOCKERFILE
echo -----------------------------
docker build --tag $CONTAINER_TEMPLATE_IMAGE .

echo
echo CREATE NEW CONTAINER
echo --------------------
#run options --> d:detach i:interactive t:tty
docker run -d -it --name $CONTAINER_TEMPLATE_CONTAINER $CONTAINER_TEMPLATE_IMAGE sh

echo
echo RUN CLOUD TESTS LOCALLLY
echo ------------------------
docker cp $TEST_SCRIPT $CONTAINER_TEMPLATE_CONTAINER:$TEST_SCRIPT
docker exec -it $CONTAINER_TEMPLATE_CONTAINER sh $TEST_SCRIPT

echo
echo STOPPING CONTAINER
docker stop $CONTAINER_TEMPLATE_CONTAINER
echo FINISHED