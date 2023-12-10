# dns-test

test scenario for alpine/musl dns issue

## Setup

The `docker-compose.yaml` contains following setup:

- a coredns with a `hello.local` zone which `long.hello.local` as A record returns many many IPs.
- alpine 3.14, alpine 3.18, bullseye and busybox-uclibc for running commands


To initialize:

```bash
make init
```

which runs up coredns, get its container IP, and set this IP into DNS server of the other containers.

## Testing

Repeat this for `alpine314`, `alpine318` and `bullseye`:

```bash
docker-compose run --rm bullseye nslookup long.hello.local
docker-compose run --rm bullseye dig long.hello.local
docker-compose run --rm bullseye curl -v long.hello.local
docker-compose run --rm bullseye ping long.hello.local
```

## Finding

- `y,y` where 1st y means `DNS over TCP is triggered`, 2nd y means `ip resolution returned something`
- Check coredns console log to see if DNS over TCP is triggered
- busy used `wget --timeout=1` instead of curl.

| Image      | nslookup | dig | curl | ping |
| ---------- | -------- | --- | ---- | ---- |
| alpine314  | n,y      | y,y | n,y  | n,y  |
| alpine318  | n,y      | y,y | y,n  | y,n  |
| bullseye   | n,y      | y,y | y,y  | y,y  |
| busybox    | n,n      | n/a | n,y  | n,y  |

1. `nslookup` and `dig` seems to have its own DNS resolution and do not rely on glibc/musl, while `curl`, `ping`, `wget` do.
2. alpine 3.18 does not really fix the issue (at least in this test environment)
3. uclibc is not better than musl, if not worse.
