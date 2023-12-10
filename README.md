# dns-test

test scenario for alpine/musl dns issue

## Setup

Initialize:

```bash
make init
```

## Testing

Repeat this for `alpine314`, `alpine318` and `bullseye`:

```bash
docker-compose run --rm bullseye nslookup long.hello.local
docker-compose run --rm bullseye dig long.hello.local
docker-compose run --rm bullseye curl -v long.hello.local
docker-compose run --rm bullseye ping long.hello.local
```

## Finding

`y,y` where 1st y means `DNS over TCP is triggered`, 2nd y means `ip resolution works`

| Image      | nslookup | dig | curl | ping |
| ---------- | -------- | --- | ---- | ---- |
| alpine314  | n,y      | y,y | n,y  | n,y  |
| alpine318  | n,y      | y,y | y,n  | y,n  |
| bullseye   | n,y      | y,y | y,y  | y,y  |
