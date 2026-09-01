# Plakoro Digital Relay

WebSocket relay for two-phone tabletop sessions. It relays only validated move
results; card rules and localized presentation remain in the Godot client.

Run `npm install` and `npm start`. The health endpoint is `/` and WebSocket is
`/ws`. Set `online/server_url` in `project.godot` to the deployed `wss://` URL.
