FROM ubuntu:bionic

MAINTAINER Alexey Vishnyakov

ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir -p ~/.texlive2017/texmf-var

RUN apt-get update && \
    apt-get -y install texlive-full openjdk-11-jre make wget

RUN pdfannotextractor --install
