import os
import re

# Directories to scan
dirs_to_scan = ["lib/views", "lib/widgets"]

# Regex to match "anything inside quotes".tr
# - capture group (.*?): matches anything inside quotes, non-greedy
pattern = re.compile(r'"([^"]+)"\.tr')

keys = set()

for root_dir in dirs_to_scan:
    for subdir, _, files in os.walk(root_dir):
        for file in files:
            if file.endswith(".dart"):
                file_path = os.path.join(subdir, file)
                with open(file_path, "r", encoding="utf-8") as f:
                    content = f.read()

                matches = pattern.findall(content)
                keys.update(matches)

# Save unique keys to file
output_file = "translation_keys.txt"
with open(output_file, "w", encoding="utf-8") as f:
    for key in sorted(keys):
        f.write(key + "\n")

print(f"Extracted {len(keys)} keys into {output_file}")

