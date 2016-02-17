#! /bin/bash
DOCKER_TAG=$1

# Dockerrun template
DOCKERRUN_TEMPLATE=./Dockerrun.aws.json.template

# Name of the new file
DOCKERRUN_FILE=$DOCKER_TAG-Dockerrun.aws.json

# AWS S3 bucket path
S3_PATH="s3://$DEPLOYMENT_BUCKET/$BUCKET_DIRECTORY/"

cp $DOCKERRUN_TEMPLATE ./$DOCKERRUN_FILE

# Replacing tags in the file and creating a file.
#sed -e 's/<TAG>/$DOCKER_TAG/' -e 's/<DEPLOYMENT_BUCKET>/$DEPLOYMENT_BUCKET/' -e 's/<IMAGE_NAME>/$IMAGE_NAME/' -e 's/<EXPOSED_PORTS>/$EXPOSED_PORTS/' -e 's/<AUTHENTICATION_KEY>/$AUTHENTICATION_KEY/' < $DOCKERRUN_TEMPLATE > $DOCKERRUN_FILE
#sed -e 's/<TAG>/$DOCKER_TAG/' -e 's/<DEPLOYMENT_BUCKET>/$DEPLOYMENT_BUCKET/' -e 's/<IMAGE_NAME>/$IMAGE_NAME/' -e 's/<EXPOSED_PORTS>/$EXPOSED_PORTS/' -e 's/<AUTHENTICATION_KEY>/$AUTHENTICATION_KEY/' < $DOCKERRUN_FILE
sed -i 's/\<TAG\>/$DOCKER_TAG/g' $DOCKERRUN_FILE
sed -i 's/\<DEPLOYMENT_BUCKET\>/$DEPLOYMENT_BUCKET/g' $DOCKERRUN_FILE
sed -i 's/\<IMAGE_NAME\>/$IMAGE_NAME/g' $DOCKERRUN_FILE
sed -i 's/\<EXPOSED_PORTS\>/$EXPOSED_PORTS/g' $DOCKERRUN_FILE
sed -i 's/\<AUTHENTICATION_KEY\>/$AUTHENTICATION_KEY/g' $DOCKERRUN_FILE

sed 's/\<TAG\>/$DOCKER_TAG/g' ./Dockerrun.aws.json.template > ./$DOCKERRUN_FILE

cat $DOCKERRUN_FILE

# Uploading json file to $S3_PATH
aws s3 cp $DOCKERRUN_FILE $S3_PATH
