#!/usr/bin/env python3
import os
import re

# Directories to scan (adjust if you want more)
dirs_to_scan = ["lib/views"]


# Import lines
import_translation = "import 'package:get/get_utils/src/extensions/internacionalization.dart';"
import_get = "import 'package:get/get.dart';"


# Match AppLocalizations.of(context) (allow optional ! or ?) then the .property even if on next line
pattern_app = re.compile(
    r'AppLocalizations\s*\.\s*of\s*\(\s*context\s*\)\s*(?:!|\?)?\s*\.\s*([A-Za-z0-9_]+)',
    re.MULTILINE
)

# Cleanup pattern for accidental repeated .tr (e.g. .tr.tr or .tr  .tr)
pattern_tr_dup = re.compile(r'(\.tr)(\s*\.\s*tr)+')


def process_file(path):
    with open(path, 'r', encoding='utf-8') as f:
        original = f.read()

    content = original
    replaced_flag = [False]

    def app_repl(m):
        replaced_flag[0] = True
        key = m.group(1)
        return f'"{key}".tr'

    content = pattern_app.sub(app_repl, content)

    # Cleanup accidental .tr.tr (if any created)
    content = pattern_tr_dup.sub(r'\1', content)

    # If we replaced something, ensure import exists (only if neither import is present)
    if replaced_flag[0]:
        if import_translation not in content and import_get not in content:
            lines = content.splitlines()
            # Choose insertion index: after last import if exists, else after library/part if exists, else top
            last_import_idx = -1
            library_or_part_idx = -1
            for i, line in enumerate(lines):
                s = line.strip()
                if s.startswith("import "):
                    last_import_idx = i
                if library_or_part_idx == -1 and (s.startswith("library ") or s.startswith("part of ")):
                    library_or_part_idx = i

            if last_import_idx >= 0:
                insert_idx = last_import_idx + 1
            elif library_or_part_idx >= 0:
                insert_idx = library_or_part_idx + 1
            else:
                insert_idx = 0

            # Insert import line (preserve a blank line after imports for readability)
            lines.insert(insert_idx, import_translation)
            content = "\n".join(lines)

    # Write back if changed
    if content != original:
        with open(path, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Updated: {path} (replaced={replaced_flag[0]})")
        return True

    return False

def main():
    updated = 0
    for base in dirs_to_scan:
        for root, _, files in os.walk(base):
            for fn in files:
                if fn.endswith('.dart'):
                    path = os.path.join(root, fn)
                    try:
                        if process_file(path):
                            updated += 1
                    except Exception as e:
                        print(f"Error processing {path}: {e}")
    print(f"Done. Files updated: {updated}")

if __name__ == "__main__":
    main()

