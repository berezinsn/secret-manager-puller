# Build the source code
FROM gradle:6.4.1-jdk11
COPY ./application /home/gradle
RUN ./gradlew build --stacktrace -x test 

# Run the copied artifact from the build step
FROM openjdk:11
# Downloading gcloud package
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz

# Installing the package
RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh

# Adding the package path to local
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin
WORKDIR /
COPY --from=0 /home/gradle/build/libs/secmanager-0.0.1-SNAPSHOT.jar .
CMD ["java", "-jar", "secmanager-0.0.1-SNAPSHOT.jar"]

