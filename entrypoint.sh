#!/bin/bash


# OUTPUT_PATH and REPORT_PATH are environment variables
# defined by the action invoker. Since these are required
# we don't need to supply default values.

XSLT_PATH=/checkstyle-markdown.xsl
GITHUB_REPOSITORY_ROOT=/github/workspace


ROOT_PREFIX=${ROOT_PPREFIX:-'src/main/java/'}
ERROR_ICON=${ERROR_ICON:-'`ERROR`'}
WARNING_ICON=${WARNING_ICON:-'`WARNING`'}
INFO_ICON=${INFO_ICON:-'`INFO`'}

xsltproc --stringparam rootPrefix ${ROOT_PREFIX} errorIcon ${ERROR_ICON} warningIcon ${WARNING_ICON} infoIcon ${INFO_ICON} --output ${GITHUB_REPOSITORY_ROOT}/${OUTPUT_PATH} ${XSLT_PATH} ${GITHUB_REPOSITORY_ROOT}/${REPORT_PATH}