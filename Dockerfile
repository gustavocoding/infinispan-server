FROM alpine:3.3

MAINTAINER gustavonalle

# Set the INFINISPAN_SERVER_HOME env variable
ENV INFINISPAN_SERVER_HOME /opt/jboss/infinispan-server

# Set the INFINISPAN_VERSION env variable
ENV INFINISPAN_VERSION 8.2.0.Final

ENV HOME /opt/jboss

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && apk add --update curl openjdk8 bash && rm /var/cache/apk/* 

# Download and unzip Infinispan server
RUN mkdir -p $HOME && cd $HOME && curl -o $HOME/infinispan.zip "https://repo1.maven.org/maven2/org/infinispan/server/infinispan-server-build/$INFINISPAN_VERSION/infinispan-server-build-$INFINISPAN_VERSION.zip" && unzip infinispan.zip && mv $HOME/infinispan-server-$INFINISPAN_VERSION $HOME/infinispan-server && rm infinispan.zip

COPY start.sh /opt/jboss/infinispan-server/bin/

# Expose Infinispan server  ports 
EXPOSE 57600 7600 8080 8181 9990 11211 11222 

CMD ["/opt/jboss/infinispan-server/bin/start.sh"]
