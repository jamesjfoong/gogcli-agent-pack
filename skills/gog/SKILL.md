---
name: gog
description: "gog CLI: safe Google Workspace automation, JSON, auth, scoped reads/writes."
---

# gog

Use `gog` when built-in Google connectors miss a feature, when shell automation needs stable JSON, or when you need to inspect local Google auth state.

## Fast Path

```bash
gog --version
gog auth list --check --json --no-input
gog auth doctor --check --json --no-input
gog schema --json
```

Pick account explicitly for API work:

```bash
gog --account user@example.com drive ls --max 10 --json --wrap-untrusted
```

## Safety Rules

- Do not print access tokens, refresh tokens, OAuth client secrets, or keyring passwords.
- Use `--no-input` in automation.
- Use `--dry-run` first where supported.
- Destructive commands require explicit user approval and `--force`.
- Use `--gmail-no-send` unless user explicitly asks to send email.

## Auth

OAuth setup has interactive step. Agent can diagnose; user usually completes consent.

```bash
gog auth credentials list
gog auth add user@example.com --services all-user --force-consent
gog auth remove user@example.com
```

For Linux/WSL file keyring setups:

```bash
gog auth keyring file
export GOG_KEYRING_PASSWORD='<password>'
gog auth list --check --json --no-input
```

## Common Reads

```bash
gog --account user@example.com drive ls --max 20 --json --wrap-untrusted
gog --account user@example.com drive search 'query' --json --wrap-untrusted
gog --account user@example.com docs cat <documentId> --json --wrap-untrusted
gog --account user@example.com sheets get <spreadsheetId> Sheet1!A1:D20 --json --wrap-untrusted
```

## Sheets Smart-Chip Link Extraction

`gog sheets get` returns values only. It often does not expose rich chip URLs in cells.

Use raw Sheets API response instead:

```bash
gog sheets raw <spreadsheetId> --include-grid-data --json --account <email>
```

Read link fields in this order:

1. `chipRuns[].chip.richLinkProperties.uri` (Google smart chips)
2. `hyperlink` (cell-level link)
3. `textFormatRuns[].format.link.uri` (rich text spans)

Python extraction pattern:

```python
links = []
for run in cell.get('chipRuns') or []:
    uri = ((run.get('chip') or {}).get('richLinkProperties') or {}).get('uri')
    if uri:
        links.append(uri)
if cell.get('hyperlink'):
    links.append(cell['hyperlink'])
for run in cell.get('textFormatRuns') or []:
    uri = (((run.get('format') or {}).get('link') or {}).get('uri'))
    if uri:
        links.append(uri)
```

## Discovery

```bash
gog <service> --help
gog <service> <command> --help
gog schema <service> <command> --json
```

Reference: `{baseDir}/../AGENTS-GUIDE.md`
