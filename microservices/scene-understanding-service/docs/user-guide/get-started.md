# Get Started

This page is the entry point for running the Scene Understanding Service.
Pick one of the two deployment paths and follow the linked guide.

## Before You Begin

- Confirm that your machine meets the
  [System Requirements](./get-started/system-requirements.md).
- Make sure you have a reachable **SceneScape** deployment (MQTT broker + REST
  API). The service is an event consumer — it needs SceneScape to produce
  meaningful output.
- Prepare your two config files (`scene-config.yaml` and `rules.yaml`). The
  service ships with samples under `configs/`; review the
  [Configuration Guide](./get-started/configuration.md) before editing them.

## Choose Deployment Path

<!--hide_directive::::{tab-set}
:::{tab-item}hide_directive--> **Run in Docker (Recommended)**
<!--hide_directive:sync: Docker hide_directive-->

The container image exposes the API on host port `8082` and reads its config
from `/app/configs`. The image bakes in the sample config, so it starts
out-of-the-box; mount your own `./configs` to override it.

See [Run with Docker Compose](./get-started/run-container.md) for the full step-by-step guide.

Quick start:

```bash
docker build -t intel/scene-understanding-service:latest .
docker run -p 8082:8082 \
  -v ./configs:/app/configs:ro \
  intel/scene-understanding-service:latest
curl --noproxy '*' http://127.0.0.1:8082/health
```

<!--hide_directive:::
:::{tab-item}hide_directive--> **Run on the Host**
<!--hide_directive:sync: Host hide_directive-->

Run the service directly with Python. This path is useful for development.

See [Run on the Host](./get-started/run-standalone.md) for the full step-by-step guide.

Quick start:

```bash
uv sync
uv run python main.py
```
<!--hide_directive:::
::::hide_directive-->

## Verify

Once the service is running:

```bash
curl --noproxy '*' http://127.0.0.1:8082/health
```

Expected response:

```json
{"status": "healthy"}
```

Service readiness (includes runtime stats):

```bash
curl --noproxy '*' http://127.0.0.1:8082/api/v1/lp/status
```

## Next Steps

- [API Reference](./api-reference.md) for endpoint details and examples
- [Configuration Guide](./get-started/configuration.md) to customize scenes, zones, and rules
- [Troubleshooting](./troubleshooting.md) for common startup issues

<!--hide_directive
:::{toctree}
:hidden:

./get-started/system-requirements.md
./get-started/configuration.md
./get-started/build-from-source.md
./get-started/run-container.md
./get-started/run-standalone.md

:::
hide_directive-->
