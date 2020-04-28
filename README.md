# LaTex шаблон Трудов Института системного программирования РАН

Сайт издания можно найти по [ссылке](https://ispranproceedings.elpub.ru/). Текст
статьи следует писать в файле `main.tex`.

## Зависимости

    $ sudo apt install texlive-full openjdk-11-jre make wget
    $ pdfannotextractor --install

## Сборка

    $ make

В результате будут сгенерированы два pdf файла: одностраничная (`main.pdf`) и
двухстраничная (`main_2.pdf`) версии статьи.

## Сборка в Docker

Альтернативно можно не устанавливать зависимости и собрать статью в специально
подготовленном Docker контейнере. Необходимо только установить Docker:

    $ sudo apt install docker.io

Собирать можно так:

    $ sudo docker run --volume ${PWD}:/paper --rm -it sweetvishnya/proceedings /bin/bash
    # cd paper
    # make
