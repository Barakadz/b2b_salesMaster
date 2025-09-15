import os
import re

root_dir = "lib/views"

# Regex to match Text("some_word", ...)
# group(1) = quote type, group(2) = string content, group(3) = other params
pattern = re.compile(
    r'(const\s+)?Text\(\s*([\'"])([^\'"$]+)\2(.*?)\)',
    re.DOTALL
)

import_translation = "import 'package:get/get_utils/src/extensions/internacionalization.dart';"
import_get = "import 'package:get/get.dart';"

def replacer(match, replaced_flag):
    const_prefix = match.group(1) or ""
    quote = match.group(2)
    text = match.group(3).strip()
    params = match.group(4)

    # Skip if contains interpolation (already filtered by regex, but extra guard)
    if "$" in text:
        return match.group(0)

    replaced_flag[0] = True
    return f'{const_prefix}Text({quote}{text}{quote}.tr{params})'


for subdir, _, files in os.walk(root_dir):
    for file in files:
        if file.endswith(".dart"):
            file_path = os.path.join(subdir, file)
            with open(file_path, "r", encoding="utf-8") as f:
                content = f.read()

            replaced = [False]
            new_content = pattern.sub(lambda m: replacer(m, replaced), content)

            if replaced[0]:
                # Add import if not already present
                if import_translation not in new_content and import_get not in new_content:
                    lines = new_content.splitlines()
                    inserted = False
                    for i, line in enumerate(lines):
                        if line.startswith("import "):
                            continue
                        # Insert before the first non-import line
                        lines.insert(i, import_translation)
                        inserted = True
                        break
                    if not inserted:
                        lines.insert(0, import_translation)
                    new_content = "\n".join(lines)

            # Save if changes
            if new_content != content:
                with open(file_path, "w", encoding="utf-8") as f:
                    f.write(new_content)
                print(f"Updated: {file_path}")

