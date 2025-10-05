# Loki in a container

This container is based on an [entry][ent] on the Internet Storm Center blog.

## Build

Build the image by running:

```bash
docker build --tag loki .
```

## Usage

```bash
docker run --rm -it -v $(PWD):/evidences loki -p /evidences --noprocscan
```

  [ent]: https://isc.sans.edu/diary/29788

