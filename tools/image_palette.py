from collections import Counter
from PIL import Image
import glob
import os

for path in sorted(glob.glob(os.path.join(os.path.dirname(__file__), '..', '*.png'))):
    image = Image.open(path).convert('RGB')
    width, height = image.size
    if width > 800:
        continue
    palette = Counter(image.resize((100, 178)).getdata()).most_common(10)
    samples = {}
    for point in [(5, 5), (width // 2, 20), (width // 2, 100), (5, 150),
                  (width // 2, 200), (5, 300), (width // 2, 450),
                  (width // 2, 900), (width // 2, 975)]:
        samples[point] = image.getpixel(point)
    print('\n' + os.path.basename(path), image.size)
    print(palette)
    print(samples)
