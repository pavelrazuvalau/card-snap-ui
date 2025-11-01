#!/bin/bash

# ============================================================================
# Build Number Generator Script
# ============================================================================
# Determines the next build number for feature branch builds
# Usage: get-build-number.sh <branch_name> <build_date>
# Example: get-build-number.sh feature/add-card-scanning 2025-11-01
# ============================================================================

set -e

BRANCH_NAME="$1"
BUILD_DATE="$2"

if [ -z "$BRANCH_NAME" ] || [ -z "$BUILD_DATE" ]; then
  echo "Error: Both branch_name and build_date are required" >&2
  echo "Usage: get-build-number.sh <branch_name> <build_date>" >&2
  exit 1
fi

# Convert date from YYYY-MM-DD to YYYYMMDD for searching
DATE_SEARCH=$(echo "$BUILD_DATE" | tr -d '-')

# Pattern to search for: feature-{branch_name}-{date}-{number}
# Replace slashes in branch name with dashes for URL-safe format
BRANCH_SAFE=$(echo "$BRANCH_NAME" | sed 's/\//-/g')
SEARCH_PATTERN="feature-${BRANCH_SAFE}-${BUILD_DATE}"

echo "Searching for previous builds with pattern: $SEARCH_PATTERN" >&2

# Search for previous releases/tags with this pattern
# Using gh CLI to search releases (if available) or tags
LAST_BUILD=""

# Try to find in GitHub Releases first (if gh CLI is available and authenticated)
if command -v gh &> /dev/null && gh auth status &> /dev/null; then
  # Search in releases
  LAST_BUILD=$(gh release list --limit 100 2>/dev/null | grep "$SEARCH_PATTERN" | head -1 || true)
  
  # If not found in releases, try tags
  if [ -z "$LAST_BUILD" ]; then
    LAST_BUILD=$(gh api repos/:owner/:repo/tags --jq ".[].name | select(startswith(\"$SEARCH_PATTERN\"))" 2>/dev/null | head -1 || true)
  fi
fi

# If still not found, try git tags locally
if [ -z "$LAST_BUILD" ]; then
  LAST_BUILD=$(git tag -l "${SEARCH_PATTERN}-*" | sort -V | tail -1 || true)
fi

if [ -z "$LAST_BUILD" ]; then
  # First build for this branch and date
  echo "1"
else
  # Extract number from the last build
  # Pattern: feature-{branch}-{date}-{number}
  LAST_NUMBER=$(echo "$LAST_BUILD" | sed -n "s/.*${SEARCH_PATTERN}-\([0-9]*\).*/\1/p")
  
  if [ -z "$LAST_NUMBER" ]; then
    # Couldn't extract number, start from 1
    echo "1"
  else
    # Increment and return
    NEXT_NUMBER=$((LAST_NUMBER + 1))
    echo "$NEXT_NUMBER"
  fi
fi

