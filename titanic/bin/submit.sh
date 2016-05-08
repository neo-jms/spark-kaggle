#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OUTPUT="classified.csv"
TMP_FILE="${OUTPUT}2"

cd ${DIR}
rm -rf ${OUTPUT}
rm -rf ${TMP_FILE}

mvn clean package
spark-submit \
  --class io.github.benfradet.Titanic \
  --master local[2] \
  target/titanic-1.0-SNAPSHOT.jar \
  src/main/resources/train.csv src/main/resources/test.csv ${OUTPUT}

mv ${OUTPUT}/part-00000 ${TMP_FILE}
rm -rf ${OUTPUT}
mv ${TMP_FILE} ${OUTPUT}
