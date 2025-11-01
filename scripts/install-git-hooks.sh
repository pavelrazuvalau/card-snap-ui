#!/bin/bash

# ============================================================================
# Git Hooks Installation Script
# ============================================================================
# Installs pre-commit and commit-msg hooks for Card Snap UI
# Run this script after cloning the repository
# ============================================================================

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
HOOKS_DIR="$PROJECT_ROOT/.git/hooks"
GITHOOKS_DIR="$PROJECT_ROOT/.githooks"

echo -e "${GREEN}Installing git hooks...${NC}"

# Check if .git directory exists
if [ ! -d "$PROJECT_ROOT/.git" ]; then
  echo -e "${YELLOW}Error: Not a git repository${NC}"
  exit 1
fi

# Check if .githooks directory exists
if [ ! -d "$GITHOOKS_DIR" ]; then
  echo -e "${YELLOW}Error: .githooks directory not found${NC}"
  echo -e "${YELLOW}Make sure you're in the project root${NC}"
  exit 1
fi

# Create hooks directory if it doesn't exist
mkdir -p "$HOOKS_DIR"

# Copy hooks from .githooks to .git/hooks
if [ -f "$GITHOOKS_DIR/pre-commit" ]; then
  cp "$GITHOOKS_DIR/pre-commit" "$HOOKS_DIR/pre-commit"
  chmod +x "$HOOKS_DIR/pre-commit"
  echo -e "${GREEN}✓ Installed pre-commit hook${NC}"
else
  echo -e "${YELLOW}⚠ pre-commit hook not found in .githooks${NC}"
fi

if [ -f "$GITHOOKS_DIR/commit-msg" ]; then
  cp "$GITHOOKS_DIR/commit-msg" "$HOOKS_DIR/commit-msg"
  chmod +x "$HOOKS_DIR/commit-msg"
  echo -e "${GREEN}✓ Installed commit-msg hook${NC}"
else
  echo -e "${YELLOW}⚠ commit-msg hook not found in .githooks${NC}"
fi

echo -e "${GREEN}✓ Git hooks installed successfully${NC}"
echo -e "${YELLOW}Hooks will now validate:${NC}"
echo -e "  - Branch naming (feature/, bugfix/, release/, hotfix/)"
echo -e "  - Code formatting (dart format)"
echo -e "  - Commit message format (Conventional Commits)"

