# DEMO-Echo-Flutter-CounterApp

## curl sample

``` bash
$ CID=11111111-1111-1111-1111-111111111111

curl -i -H "Authorization: Bearer $CID" http://localhost:8080/api/v1/ping
curl -i -H "Authorization: Bearer $CID" http://localhost:8080/api/v1/counter
curl -i -X POST -H "Authorization: Bearer $CID" http://localhost:8080/api/v1/counter/increment
curl -i -X POST -H "Authorization: Bearer $CID" http://localhost:8080/api/v1/counter/reset

---

$ CID2=22222222-2222-2222-2222-222222222222

curl -i -X POST -H "Authorization: Bearer $CID"  http://localhost:8080/api/v1/counter/increment
curl -i -X POST -H "Authorization: Bearer $CID2" http://localhost:8080/api/v1/counter/increment
curl -i -H "Authorization: Bearer $CID"  http://localhost:8080/api/v1/counter
curl -i -H "Authorization: Bearer $CID2" http://localhost:8080/api/v1/counter
```

## make Command sample
``` bash
# ローカル Echo (go run)
make web

# Docker Echo
make web API_BASE_URL=http://localhost:8080

# Cloud Run
make web-build API_BASE_URL=https://api.example.com
```