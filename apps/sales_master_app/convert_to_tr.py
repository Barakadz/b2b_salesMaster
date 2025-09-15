import os
import re

# Root directory
root_dir = "lib/views"

# Regex to match AppLocalizations.of(context)!.some_word
#pattern = re.compile(r'AppLocalizations\.of\(context\)!\.([a-zA-Z0-9_]+)')

pattern = re.compile(
    r'AppLocalizations\.of\s*\(\s*context\s*\)\s*!?\.([a-zA-Z0-9_]+)',
    re.MULTILINE
)
# Import line options
import_translation = "import 'package:get/get_utils/src/extensions/internacionalization.dart';"
import_get = "import 'package:get/get.dart';"

for subdir, _, files in os.walk(root_dir):
    for file in files:
        if file.endswith(".dart"):
            file_path = os.path.join(subdir, file)
            with open(file_path, "r", encoding="utf-8") as f:
                content = f.read()

            replaced = [False]  # use list to make it mutable inside replacer

            def replacer(m):
                replaced[0] = True
                return f'"{m.group(1)}".tr'

            new_content = pattern.sub(replacer, content)

            # Only if we replaced something, check the imports
            if replaced[0]:
                if import_translation not in new_content and import_get not in new_content:
                    # Insert the translation import at the top of the file
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
                        # If no imports found, just add at top
                        lines.insert(0, import_translation)
                    new_content = "\n".join(lines)

            # Save file if changes happened
            if new_content != content:
                with open(file_path, "w", encoding="utf-8") as f:
                    f.write(new_content)
                print(f"Updated: {file_path}")


