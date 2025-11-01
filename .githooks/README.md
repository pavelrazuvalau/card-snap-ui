# Git Hooks for Card Snap UI

This directory contains git hooks that enforce repository standards.

## Available Hooks

### pre-commit
Validates before commit:
- ✅ **Branch naming**: Must match `feature/*`, `bugfix/*`, `release/*`, `hotfix/*`, `main`, or `develop`
- ✅ **Code formatting**: Checks Dart files are properly formatted
- ✅ **Commit message format**: Validates Conventional Commits format

### commit-msg
Validates commit message format (Conventional Commits):
- ✅ Format: `type(scope): description`
- ✅ Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`
- ✅ Examples:
  - `feat(auth): add token refresh on login`
  - `fix(devices): prevent crash when device id is null`
  - `docs(domain): explain device sync use case`

## Installation

### First Time Setup

After cloning the repository, install hooks:

```bash
bash scripts/install-git-hooks.sh
```

Or manually:

```bash
# Copy hooks to .git/hooks/
cp .git/hooks/pre-commit .git/hooks/pre-commit
cp .git/hooks/commit-msg .git/hooks/commit-msg

# Make executable
chmod +x .git/hooks/pre-commit
chmod +x .git/hooks/commit-msg
```

**Note:** Hooks in `.git/hooks/` are not tracked by git. Each developer needs to install them once after cloning.

## Manual Testing

### Test Branch Name Validation

```bash
# Should pass
git checkout -b feature/test-branch
git checkout -b bugfix/test-fix

# Should fail
git checkout -b invalid-branch-name
```

### Test Commit Message Validation

```bash
# Should pass
git commit -m "feat(auth): add login feature"
git commit -m "fix(ui): resolve button alignment"

# Should fail
git commit -m "Added new feature"
git commit -m "fix bug"
```

### Test Formatting Check

```bash
# Format code first
dart format .

# Then commit (should pass)
git add .
git commit -m "style: format code"
```

## Bypassing Hooks (Not Recommended)

If you absolutely need to bypass hooks (e.g., for emergency hotfixes):

```bash
# Skip pre-commit hook
git commit --no-verify -m "fix: emergency hotfix"

# Note: This should only be used in exceptional circumstances
# and should be followed by proper commit message correction
```

## Documentation

- **Conventional Commits**: See `ARCHITECTURE.md` §19
- **Branch Strategy**: See `ARCHITECTURE.md` §20 (GitFlow)
- **Code Style**: See `STYLEGUIDE.md`

---

*These hooks ensure code quality and consistency across all commits.*

