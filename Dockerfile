FROM haskell:8.10.3

#RUN cabal update

COPY matrix /opt/matrix

WORKDIR /opt/matrix

RUN stack install

EXPOSE 8080

CMD ["matrix-exe"]