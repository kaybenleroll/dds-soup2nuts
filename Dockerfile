FROM rocker/verse:4.0.2

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    less \
    liblapack-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && install2.r --error \
    actuar \
    arules \
    arulesViz \
    broom \
    BTYD \
    conflicted \
    cowplot \
    DataExplorer \
    directlabels \
    evir \
    fitdistrplus \
    fs \
    furrr \
    rfm \
    rmdformats \
    snakecase \
    survival \
    survminer \
    tidygraph \
    tidyquant \
    tidytext \
    timetk

