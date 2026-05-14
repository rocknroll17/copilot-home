#!/bin/bash
# cleanup-worker.sh
#
# Remove all copilot-home client-side setup from a work machine.
# Run this before re-running copilot-bootstrap.sh for a clean slate.

set -euo pipefail

echo "→ Cleaning up copilot-home client setup on $(hostname)..."

# --- 1. Unmount ~/.copilot/* ------------------------------------------------
for d in skills agents hooks instructions; do
    if mountpoint -q "$HOME/.copilot/$d" 2>/dev/null; then
        echo "  Unmounting ~/.copilot/$d..."
        fusermount -u "$HOME/.copilot/$d" 2>/dev/null || umount "$HOME/.copilot/$d" 2>/dev/null || true
    fi
done
rm -rf "$HOME/.copilot"

# --- 2. SSH key + certificate -----------------------------------------------
rm -f "$HOME/.ssh/id_copilot" \
      "$HOME/.ssh/id_copilot.pub" \
      "$HOME/.ssh/id_copilot-cert.pub"
echo "  SSH key/cert removed."

# --- 3. ~/.copilot-automount ------------------------------------------------
rm -f "$HOME/.copilot-automount"
echo "  ~/.copilot-automount removed."

# --- 4. ~/.bashrc hook ------------------------------------------------------
if grep -q ".copilot-automount" "$HOME/.bashrc" 2>/dev/null; then
    sed -i '/\.copilot-automount/d' "$HOME/.bashrc"
    echo "  ~/.bashrc entry removed."
fi

echo ""
echo "✅ Cleanup complete. Run copilot-bootstrap.sh to set up fresh."
