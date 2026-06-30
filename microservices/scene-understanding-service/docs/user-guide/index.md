# Scene Understanding Service

<!--hide_directive
<div class="component_card_widget">
  <a class="icon_github" href="https://github.com/open-edge-platform/edge-ai-libraries/tree/main/microservices/scene-understanding-service">
     GitHub
  </a>
  <a class="icon_document" href="https://github.com/open-edge-platform/edge-ai-libraries/blob/main/microservices/scene-understanding-service/README.md">
     Readme
  </a>
</div>
hide_directive-->

Scene Understanding Service is a microservice for multi-scene behavioral
analysis and suspicious activity detection. It subscribes to
[SceneScape](https://github.com/open-edge-platform/scenescape) MQTT topics to
track people across configured scenes and zones, applies a declarative rule
engine to detect suspicious patterns (loitering, checkout bypass, concealment,
restricted-zone violations), and routes the resulting alerts to a downstream
alert service. It is designed to be dropped into any SceneScape-based
deployment by supplying two YAML config files — no code changes required.

## Use Cases

- Retail loss prevention: loitering, repeated high-value-zone visits,
  checkout bypass, and concealment detection.
- Restricted-area monitoring: alert when a person enters a zone they should
  not be in.
- Any SceneScape deployment that needs declarative, zone-based behavioral
  rules with optional pose/VLM escalation.

## Key Capabilities

- Multi-scene, multi-camera person tracking driven entirely by SceneScape MQTT.
- Declarative YAML rule engine — thresholds and rules change without code edits.
- Optional behavioral-analysis escalation (pose + VLM) over MQTT.
- Zone auto-discovery from the SceneScape REST API at startup.
- Per-person session state machine (zone visits, dwell time, flags).
- Optional SeaweedFS evidence-frame capture and alert routing.
- Self-contained image: ships with sample config and runs standalone.

## Configuration Surface

All runtime behavior is driven by two YAML files mounted at `/app/configs`
(override with `CONFIG_DIR`):

- `scene-config.yaml` — SceneScape connection (MQTT + REST), scenes, cameras,
  and zones.
- `rules.yaml` — declarative rule definitions, thresholds, session flags, and
  escalation services.

See the [Configuration Guide](./get-started/configuration.md) for the full field list.

## Next Steps

- [Get Started](./get-started.md) - a step-by-step guide to your first run.
- [Configuration](./get-started/configuration.md) - scenes, zones, rules, and services.
- [How It Works](./how-it-works.md) - the internal event and rule flow.

<!--hide_directive
:::{toctree}
:hidden:

./get-started.md
./how-it-works.md
./api-reference.md
./troubleshooting.md
Release Notes <./release-notes.md>

:::
hide_directive-->
