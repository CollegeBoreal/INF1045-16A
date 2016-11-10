# Orchestration de services

## Preparation
contruire l'image
```
$ docker build -t monsite .
```


## Avec orchestration (docker-Compose)

![alt tag](https://github.com/CollegeBoreal/INF1045-16A/blob/master/5.Orchestration/micro.png)


## Sans orchestration
Lancer la DB
```
$ docker run --name some-redis -d redis
```
ensuite lancer l'application web avec un lien a la DB
```
$ docker run --name monsitelive -p 5000:5000 --link some-redis:redis -d monsite
```

# Nettoyage

## Arreter et enlever un conteneur
```
$ docker rm -f monsitelive
```
