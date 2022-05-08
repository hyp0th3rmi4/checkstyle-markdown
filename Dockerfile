FROM  debian:9.5-slim

# installs the xslt library used to process
# the stylesheet generating the markdown.

RUN    apt-get update              \
    && apt-get upgrade -y          \
    && apt-get install libxslt1.1 -y

ADD checkstyle-markdown.xsl /checkstyle-markdown.xsl
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
