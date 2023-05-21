import os

"""
Rename all files in this directory if they end in a _1.jpg to .jpg
"""

for filename in os.listdir("."):
    if filename.endswith("_1.jpg"):
        os.rename(filename, filename[:-6] + ".jpg")