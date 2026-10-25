#!/usr/bin/env python3
"""Run declared verification commands without invoking a shell."""
import json
import os
import subprocess
import sys
from pathlib import Path


def main():
    root = Path(__file__).resolve().parent.parent
    config = root / '.vibe' / 'verify.json'
    try:
        spec = json.loads(config.read_text(encoding='utf-8'))
    except (OSError, ValueError) as exc:
        raise SystemExit(f'ERROR: missing or invalid verification config: {exc}')
    checks = spec.get('checks')
    if spec.get('ready') is not True or not isinstance(checks, list) or not checks:
        raise SystemExit('ERROR: quality checks are not configured; set ready=true only after adding real project tests')
    if not (root / '.git').exists():
        raise SystemExit('ERROR: expected a Git repository root')
    for check in checks:
        args = check.get('argv')
        name = check.get('name')
        if not isinstance(name, str) or not name.strip() or not isinstance(args, list) or not args or not all(isinstance(x, str) and x for x in args):
            raise SystemExit('ERROR: invalid check format; use argv string arrays')
        print(f'RUN: {name}: {args!r}', flush=True)
        try:
            proc = subprocess.run(args, cwd=root, check=False)
        except FileNotFoundError:
            raise SystemExit(f'ERROR: executable missing: {args[0]}')
        print(f'EXIT: {name}: {proc.returncode}', flush=True)
        if proc.returncode:
            raise SystemExit(proc.returncode)
    print('PASS: all declared checks passed', flush=True)


if __name__ == '__main__':
    main()
