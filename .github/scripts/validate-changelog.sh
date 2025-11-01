#!/bin/bash

# ============================================================================
# CHANGELOG Validator Script
# ============================================================================
# Validates CHANGELOG.md entries for releases and nightly builds
# Usage: validate-changelog.sh --type release|nightly
# ============================================================================

set -e

CHANGELOG_FILE="CHANGELOG.md"
PUBSPEC_FILE="pubspec.yaml"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Parse arguments
TYPE=""
while [[ $# -gt 0 ]]; do
  case $1 in
    --type)
      TYPE="$2"
      shift 2
      ;;
    *)
      echo -e "${RED}Error: Unknown option $1${NC}"
      exit 1
      ;;
  esac
done

if [ -z "$TYPE" ]; then
  echo -e "${RED}Error: --type argument is required (release|nightly)${NC}"
  exit 1
fi

if [ ! -f "$CHANGELOG_FILE" ]; then
  echo -e "${RED}Error: $CHANGELOG_FILE not found${NC}"
  exit 1
fi

echo -e "${GREEN}Validating CHANGELOG.md for type: $TYPE${NC}"

# Validate release type
if [ "$TYPE" = "release" ]; then
  # Extract version from pubspec.yaml
  if [ ! -f "$PUBSPEC_FILE" ]; then
    echo -e "${RED}Error: $PUBSPEC_FILE not found${NC}"
    exit 1
  fi

  VERSION=$(grep -E "^version:" "$PUBSPEC_FILE" | sed -E 's/version: ([0-9]+\.[0-9]+\.[0-9]+).*/\1/')
  
  if [ -z "$VERSION" ]; then
    echo -e "${RED}Error: Could not extract version from $PUBSPEC_FILE${NC}"
    exit 1
  fi

  echo -e "${YELLOW}Checking for version: $VERSION${NC}"

  # Check if version entry exists in CHANGELOG
  if ! grep -qE "^## \[${VERSION}\]" "$CHANGELOG_FILE"; then
    echo -e "${RED}Error: No entry found for version [$VERSION] in $CHANGELOG_FILE${NC}"
    echo -e "${YELLOW}Expected format: ## [$VERSION] - YYYY-MM-DD${NC}"
    exit 1
  fi

  # Extract section content
  VERSION_SECTION=$(awk "/^## \[${VERSION}\]/,/^## \[/" "$CHANGELOG_FILE" | grep -v "^## \[")
  
  # Check if section has any content (Added, Changed, Fixed, etc.)
  if ! echo "$VERSION_SECTION" | grep -qE "^(### Added|### Changed|### Fixed|### Infrastructure|### Documentation)"; then
    echo -e "${RED}Error: Version [$VERSION] entry is empty (no Added/Changed/Fixed sections)${NC}"
    exit 1
  fi

  echo -e "${GREEN}✓ CHANGELOG entry for version [$VERSION] is valid${NC}"

elif [ "$TYPE" = "nightly" ]; then
  # Get today's date in YYYYMMDD format
  TODAY=$(date +%Y%m%d)
  
  # Get version from pubspec.yaml
  if [ ! -f "$PUBSPEC_FILE" ]; then
    echo -e "${RED}Error: $PUBSPEC_FILE not found${NC}"
    exit 1
  fi

  VERSION=$(grep -E "^version:" "$PUBSPEC_FILE" | sed -E 's/version: ([0-9]+\.[0-9]+\.[0-9]+).*/\1/')
  
  if [ -z "$VERSION" ]; then
    echo -e "${RED}Error: Could not extract version from $PUBSPEC_FILE${NC}"
    exit 1
  fi

  NIGHTLY_VERSION="${VERSION}-nightly.${TODAY}"
  
  echo -e "${YELLOW}Checking for nightly version: $NIGHTLY_VERSION${NC}"

  # Check if nightly entry exists (can be in Unreleased section or separate)
  if ! grep -qE "^## \[${NIGHTLY_VERSION}\]" "$CHANGELOG_FILE"; then
    echo -e "${RED}Error: No entry found for nightly version [${NIGHTLY_VERSION}] in $CHANGELOG_FILE${NC}"
    echo -e "${YELLOW}Expected format: ## [${NIGHTLY_VERSION}] - YYYY-MM-DD${NC}"
    exit 1
  fi

  # Escape special regex characters in version for awk (dots need to be escaped)
  ESCAPED_NIGHTLY_VERSION=$(echo "$NIGHTLY_VERSION" | sed 's/\./\\./g')
  
  # Extract section content (from line after header to next section header, excluding both headers)
  NIGHTLY_SECTION=$(awk "/^## \[${ESCAPED_NIGHTLY_VERSION}\]/ {found=1; next} found && /^## \[/ {exit} found" "$CHANGELOG_FILE")
  
  # Check if section has any content
  if ! echo "$NIGHTLY_SECTION" | grep -qE "^(### Added|### Changed|### Fixed|### Infrastructure|### Documentation)"; then
    echo -e "${RED}Error: Nightly version [${NIGHTLY_VERSION}] entry is empty (no Added/Changed/Fixed sections)${NC}"
    exit 1
  fi

  echo -e "${GREEN}✓ CHANGELOG entry for nightly version [${NIGHTLY_VERSION}] is valid${NC}"

else
  echo -e "${RED}Error: Invalid type '$TYPE'. Must be 'release' or 'nightly'${NC}"
  exit 1
fi

echo -e "${GREEN}✓ CHANGELOG validation passed${NC}"
exit 0

