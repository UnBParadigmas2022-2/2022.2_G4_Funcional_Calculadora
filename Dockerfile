FROM haskell
WORKDIR /app
COPY . /app
RUN cabal build
ENTRYPOINT ["cabal", "run", "calculadora-exe"]