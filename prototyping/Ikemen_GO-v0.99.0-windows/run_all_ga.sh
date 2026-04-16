#!/usr/bin/env bash
# run_all_ga.sh
# Runs run_ga.py for every character that has one.
# Run from the Ikemen_GO-v0.99.0-windows directory:
#   bash run_all_ga.sh

CHARS_DIR="$(dirname "$0")/chars"
FAILED=()

for script in "$CHARS_DIR"/*/run_ga.py; do
    char_dir="$(dirname "$script")"
    char_name="$(basename "$char_dir")"

    echo "========================================="
    echo "Running GA for: $char_name"
    echo "========================================="

    # Run from inside the character directory so relative paths resolve correctly
    if (cd "$char_dir" && python run_ga.py); then
        echo "[OK] $char_name finished successfully."
    else
        echo "[FAILED] $char_name exited with an error."
        FAILED+=("$char_name")
    fi

    echo ""
done

echo "========================================="
echo "All characters processed."
if [ ${#FAILED[@]} -gt 0 ]; then
    echo "Failed characters:"
    for c in "${FAILED[@]}"; do
        echo "  - $c"
    done
    exit 1
else
    echo "All runs completed successfully."
fi
