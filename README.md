# Copilot-home

One hub, every machine. Keep your Copilot skills, agents, hooks, and instructions on a single always-on server — any work machine connects in one command and instantly shares the same up-to-date customizations over a live sshfs mount. Edit once on the hub, available everywhere.

## How it works

```
Hub server  (always-on, source of truth)
  └── ~/copilot-home/
        ├── skills/
        ├── agents/
        ├── instructions/
        └── hooks/
              │
              │  sshfs mount
              ▼
Work machine A       Work machine B       Work machine C  …
  └── ~/.copilot/      └── ~/.copilot/      └── ~/.copilot/
        ├── skills/          ├── skills/          ├── skills/
        ├── agents/          ├── agents/          ├── agents/
        ├── instructions/    ├── instructions/    ├── instructions/
        └── hooks/           └── hooks/           └── hooks/
```

All work machines read directly from the hub — no copies, no sync jobs. The moment you update something on the hub it's live on every connected machine.

The hub runs an SSH Certificate Authority. Each work machine gets a signed certificate once; after that the mount happens automatically at every login — no password, no manual remounting.

---

## Quickstart

**1. Initialize the hub** (once)

```bash
git clone https://github.com/rocknroll17/copilot-home.git
cd ~/copilot-home
HUB_HOST=<your_server.com> HUB_USER=<username> bash scripts/setup-hub.sh
```

This creates an SSH CA, registers it in `authorized_keys`, installs `~/bin/sign-copilot`, and bakes a ready-to-use `~/copilot-bootstrap.sh`.

**2. Connect a work machine** (one command per machine first time, then automatic)

```bash
scp <username>@<your_server.com>:~/copilot-bootstrap.sh /tmp/copilot-bootstrap.sh && bash /tmp/copilot-bootstrap.sh
```

The bootstrap script:
- Generates a local SSH key and gets it signed by the hub CA
- Installs `sshfs` if missing (apt / dnf / yum / brew — auto-detected)
- Writes `~/.copilot-automount` and registers it in `~/.bashrc`
- Mounts `skills/`, `agents/`, `hooks/`, `instructions/` under `~/.copilot/`

Re-run the same command to renew an expired certificate.

---

## Repository layout

```
agents/                 # Custom agent definitions (.agent.md)
hooks/                  # Copilot chat lifecycle hooks
instructions/           # Persistent instruction files (.instructions.md)
skills/                 # Copilot SKILL.md files
scripts/
  setup-hub.sh          # One-time hub setup: CA, sign-copilot, bootstrap bake
  sign-copilot          # CA signing helper (installed on hub by setup-hub.sh)
  copilot-bootstrap.sh  # Template distributed to work machines through scp
```

---

## Tips

If you have an active Copilot chat session open on a work machine when you push changes, run `/restart` in the chat to pick up the updated skills, instructions, and agents.

---

## License

[MIT](LICENSE)

