FROM rocker/verse:4.0.5

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    graphviz \
    less \
    libgsl-dev \
    liblapack-dev \
    libtk8.6 \
    pbzip2 \
    p7zip-full \
    tk8.6 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && install2.r --error \
    actuar \
    anytime \
    arules \
    arulesCBA \
    arulesNBMiner \
    arulesSequences \
    arulesViz \
    BiocManager \
    BTYD \
    BTYDplus \
    broom \
    CLVTools \
    conflicted \
    cowplot \
    descriptr \
    DataExplorer \
    DT \
    directlabels \
    evir \
    fitdistrplus \
    fs \
    furrr \
    FactoMineR \
    FactoInvestigate \
    Factoshiny \
    ggraph \
    kableExtra \
    lobstr \
    pryr \
    rfm \
    rmdformats \
    shinythemes \
    shinyBS \
    shinycssloaders \
    snakecase \
    survival \
    survminer \
    tidygraph \
    tidyquant \
    tidytext \
    timetk \
    visNetwork \
    xplorerr

RUN Rscript -e 'BiocManager::install("Rgraphviz")'

COPY build/conffiles.7z           /tmp
COPY build/docker_install_rpkgs.R /tmp

WORKDIR /tmp

RUN git clone https://github.com/lindenb/makefile2graph.git \
  && cd makefile2graph \
  && make \
  && make install

WORKDIR /home/rstudio

RUN Rscript /tmp/docker_install_rpkgs.R

RUN 7z x /tmp/conffiles.7z \
  && cp conffiles/.bash*     . \
  && cp conffiles/.gitconfig . \
  && cp conffiles/.Renviron  . \
  && cp conffiles/.Rprofile  . \
  && mkdir -p .config/rstudio \
  && cp conffiles/rstudio-prefs.json .config/rstudio/ \
  && chown -R rstudio:rstudio /home/rstudio \
  && rm -rfv conffiles/

