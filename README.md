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
docker-compose exec alpine314 bash
nslookup long.hello.local
dig long.hello.local
curl -v long.hello.local
```

## Finding

`y,y` where 1st y means `DNS over TCP is triggered`, 2nd y means `works`

| Image      | nslookup | dig | curl |
| ---------- | -------- | --- | ---- |
| alpine314  | y,y      | y,y | y,y  |
| alpine318  | y,y      | y,y | y,n  |
| bullseye   | y,y      | y,y | y,y  |
