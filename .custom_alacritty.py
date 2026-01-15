#!/usr/bin/env python3

import argparse
import logging
import subprocess
from pathlib import Path
import toml
import sys

logging.basicConfig(
    level=logging.INFO,
    format='[%(levelname)s] %(message)s'
)

HOME_DIR = Path.home()

ROUTER = {
    'alacritty_toml': HOME_DIR / '.config' / 'alacritty' / 'alacritty.toml',
}

def write_lines(file: Path, pattern: str, new_lines: list[str], offsets: list[int]):
    if not file.exists():
        logging.error(f'The file {file} does not exist.')
        return

    content = file.read_text(encoding='utf-8').splitlines(keepends=True)
    pattern_idx = None
    for idx, line in enumerate(content):
        if pattern in line:
            pattern_idx = idx
            break

    if pattern_idx is not None:
        for offset, new_line in zip(offsets, new_lines):
            pos = pattern_idx + offset
            if 0 <= pos < len(content):
                content[pos] = new_line
            else:
                content.append(new_line)
        logging.info(f'Pattern "{pattern}" updated in {file.name}.')
    else:
        logging.warning(f'Pattern "{pattern}" not found in "{file.name}". Appending at the end.')
        content.extend(new_lines)

    file.write_text(''.join(content), encoding='utf-8')


def change_opacity(value: str):
    try:
        op = float(value)
        if not (0.0 <= op <= 1.0):
            raise ValueError
    except ValueError:
        logging.error('Opacity value must be a number between 0 and 1.')
        return

    toml_path = ROUTER['alacritty_toml']
    if not toml_path.exists():
        logging.error('File not found: %s', toml_path)
        return

    try:
        config = toml.loads(toml_path.read_text(encoding='utf-8'))
    except Exception as e:
        logging.error('Error parsing %s: %s', toml_path, e)
        return

    if 'window' not in config:
        config['window'] = {}
    config['window']['opacity'] = op
    toml_path.write_text(toml.dumps(config), encoding='utf-8')
    logging.info('Opacity changed to %s in %s', op, toml_path.name)


def change_font_size(value: str):
    try:
        size = float(value)
        if size <= 6:
            raise ValueError
    except ValueError:
        logging.error('Font size must be a number greater than 6.')
        return

    toml_path = ROUTER['alacritty_toml']
    if not toml_path.exists():
        logging.error('File not found: %s', toml_path)
        return

    try:
        config = toml.loads(toml_path.read_text(encoding='utf-8'))
    except Exception as e:
        logging.error('Error parsing %s: %s', toml_path, e)
        return

    if 'font' not in config:
        config['font'] = {}
    config['font']['size'] = size
    toml_path.write_text(toml.dumps(config), encoding='utf-8')


def change_padding(value: str):
    try:
        padding = int(value)
        if padding < 0:
            raise ValueError
    except ValueError:
        logging.error('Padding must be an integer >= 0.')
        return

    toml_path = ROUTER['alacritty_toml']
    if not toml_path.exists():
        logging.error('File not found: %s', toml_path)
        return

    try:
        config = toml.loads(toml_path.read_text(encoding='utf-8'))
    except Exception as e:
        logging.error('Error parsing %s: %s', toml_path, e)
        return

    if 'window' not in config:
        config['window'] = {}
    if 'padding' not in config['window']:
        config['window']['padding'] = {}
    config['window']['padding']['x'] = padding
    config['window']['padding']['y'] = padding

    toml_path.write_text(toml.dumps(config), encoding='utf-8')
    logging.info('Padding changed to %s in %s', padding, toml_path.name)


def change_font(alias: str):
    fonts = {
        'mononoki': 'mononoki Nerd Font',
        'agave': 'Agave Nerd Font',
        'hurmit': 'Hurmit Nerd Font',
        'ubuntu': 'Ubuntu Nerd Font',
        'ubuntumono': 'Ubuntu Mono Nerd Font',
        'caskaydia': 'CaskaydiaCove Nerd Font',
        'terminess': 'TerminessTTF Nerd Font',
        'spacemono': 'SpaceMono NF',
        'jetbrains': 'JetBrains Mono ExtraBold Nerd Font',
        'inconsolata': 'Inconsolata Go',
        'profont': 'ProFont IIx Nerd Font'
    }

    if alias not in fonts:
        logging.error('Unknown font alias. Options: %s', ', '.join(fonts.keys()))
        return

    toml_path = ROUTER['alacritty_toml']
    if not toml_path.exists():
        logging.error('File not found: %s', toml_path)
        return

    try:
        config = toml.loads(toml_path.read_text(encoding='utf-8'))
    except Exception as e:
        logging.error('Error parsing %s: %s', toml_path, e)
        return

    if 'font' not in config:
        config['font'] = {}
    config['font']['family'] = [fonts[alias]]
    toml_path.write_text(toml.dumps(config), encoding='utf-8')
    logging.info('Font changed to "%s" in %s', fonts[alias], toml_path.name)


def main():
    parser = argparse.ArgumentParser(
        description='Script to customize terminal',
        formatter_class=argparse.RawTextHelpFormatter
    )

    parser.add_argument('-o', '--opacity', metavar='VALUE', help='Change Alacritty opacity (0.0–1.0)')
    parser.add_argument('-s', '--size', metavar='SIZE', help='Change Alacritty font size (>6)')
    parser.add_argument('-p', '--padding', metavar='PADDING', help='Change Alacritty padding (integer ≥0)')
    parser.add_argument('-f', '--font', metavar='ALIAS', help='Change Alacritty font family (alias)')

    args = parser.parse_args()

    if args.opacity:
        change_opacity(args.opacity)
    if args.size:
        change_font_size(args.size)
    if args.padding:
        change_padding(args.padding)
    if args.font:
        change_font(args.font)

    if len(sys.argv) == 1:
        parser.print_help()


if __name__ == '__main__':
    main()

