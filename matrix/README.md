# Transpose matrix rest service written in Haskell

To run the http server with the service use the following commands

```bash
docker build -t vitorz/hs-matrix ./
docker run -p 8080:8080 hs-matrix
```

from another terminal do:
```bash
curl -v -d '[[93,2,3],[4,5,6],[7,8,9]]' http://localhost:8080/transpose
```