#!/bin/bash

cd ..

# variables
BUILD_OUPUT_FOLDER=dist
BUILD_ID=$(date +%s)
BUILD_FOLDER=$(pwd)/${BUILD_OUPUT_FOLDER}
S3_BUCKET_NAME=custom-build-react-website


# if we have first arugment defined then use it as the build id 
if [ $1 ]; then
 BUILD_ID=$1
fi


VITE_CUSTOM_BASE_PATH="/${BUILD_ID}" npm run build

aws s3 sync  $BUILD_FOLDER  s3://${S3_BUCKET_NAME}/${BUILD_ID}

echo -e "\n \n"

echo " your build id is ${BUILD_ID} use it it cookie name='build_id'"
