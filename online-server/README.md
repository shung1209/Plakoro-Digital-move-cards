# Plakoro Digital Relay

WebSocket relay for two-phone tabletop sessions. It relays only validated move
results; card rules and localized presentation remain in the Godot client.

Run `npm install` and `npm start`. The health endpoint is `/` and WebSocket is
`/ws`. Set `online/server_url` in `project.godot` to the deployed `wss://` URL.

## Deployment

The repository-level `render.yaml` can create the service on Render. After the
service is live, verify its `/` health response and set the Godot project value:

```ini
[online]
server_url="wss://YOUR-SERVICE.onrender.com/ws"
```

The Web build must use `wss://` when it is served over HTTPS. A local desktop
test may use `ws://127.0.0.1:10000/ws`; another phone on the same LAN may use
the computer's LAN address, provided the firewall allows the selected port.

The relay is intentionally authoritative only for room membership, initiative,
readiness, ordering, and payload validation. Physical dice results remain
player-entered and card text is reconstructed locally in the receiver's chosen
language.
