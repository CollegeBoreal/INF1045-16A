# Orchestration de services

## Preparation
contruire l'image
```
$ docker build -t monsite .
```


## Docker-Compose


## Sans orchestration
Lancer la DB
```
$ docker run --name some-redis -d redis
```
ensuite lancer l'application web avec un lien a la DB
```
$ docker run --name monsitelive -p 5000:5000 --link some-redis:redis -d monsite
```

