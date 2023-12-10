# dns-test

test scenario for alpine/musl dns issue

Initialize:

```bash
make init
```

Repeat this for `alpine314`, `alpine318` and `bullseye`:

```bash
docker-compose exec alpine314 bash
curl -v long.hello.local
```
