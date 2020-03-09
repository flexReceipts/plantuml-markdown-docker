FROM python:3.8-alpine

RUN mkdir -p /app
WORKDIR /app

ENV PLANTUML_VERSION 1.2020.2
ADD https://sourceforge.net/projects/plantuml/files/plantuml.${PLANTUML_VERSION}.jar/download /app/plantuml.jar

RUN apk add --no-cache \
    graphviz \
    openjdk8-jre \
    ttf-droid \
    ttf-droid-nonlatin \
    && echo -e '#!/usr/bin/env sh \njava -jar /app/plantuml.jar ${@}' >> /usr/local/bin/plantuml \
    && chmod +x /usr/local/bin/plantuml \
    && pip install plantuml-markdown \
    && pip install six \
    && echo done

CMD markdown_py -x plantuml_markdown
