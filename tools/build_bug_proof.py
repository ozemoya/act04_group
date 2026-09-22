"""Assemble traceable Round 2 evidence from the real Android capture and source."""

from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parents[1]
source = (ROOT / "lib" / "main.dart").read_text(encoding="utf-8").splitlines()
screen = Image.open(ROOT / "evidence" / "CS-Coders-Round3-ChangedState.png").convert("RGB")
screen.thumbnail((580, 1210))

canvas = Image.new("RGB", (2200, 1390), "#11131c")
d = ImageDraw.Draw(canvas)
title = ImageFont.truetype(r"C:\Windows\Fonts\segoeuib.ttf", 46)
heading = ImageFont.truetype(r"C:\Windows\Fonts\segoeuib.ttf", 30)
body = ImageFont.truetype(r"C:\Windows\Fonts\segoeui.ttf", 24)
code = ImageFont.truetype(r"C:\Windows\Fonts\consola.ttf", 23)

d.text((42, 26), "CS Coders  |  Round 2 bug-fix proof", font=title, fill="#f6f2ff")
d.text((43, 88), "Myles Miller (002753776)  •  Zachari Taylor (002855653)", font=body, fill="#c8bce1")
d.text((42, 138), "Running Android app", font=heading, fill="#d7c2ff")
canvas.paste(screen, (42, 188))
d.rectangle((36, 182, 42 + screen.width + 6, 188 + screen.height + 6), outline="#8d6fc3", width=3)

x = 675
d.text((x, 138), "Corrected source: lib/main.dart", font=heading, fill="#d7c2ff")
groups = [
    ("BUG #1  •  local press state", [326, 327]),
    ("BUG #2  •  slider rebuild", [290, 291]),
    ("BUG #3  •  shadow geometry", [354, 359, 364, 371, 376]),
    ("BUG #4  •  release triggers action", [339, 340, 341, 342, 343, 344, 345]),
]
y = 195
for label, numbers in groups:
    h = 315 if len(numbers) > 6 else (245 if len(numbers) > 2 else 175)
    d.rounded_rectangle((x, y, 2152, y + h), radius=20, fill="#202332", outline="#514465", width=2)
    d.text((x + 24, y + 17), label, font=heading, fill="#e6d6ff")
    cy = y + 67
    for number in numbers:
        line = source[number - 1].strip().replace("🐛 ", "")
        d.text((x + 25, cy), f"{number:>3}  {line}", font=code, fill="#e4e4ef")
        cy += 32
    y += h + 21

d.text((675, 1327), "Evidence composite: actual Android capture + exact source lines; not a VS Code screenshot.", font=body, fill="#aaa4b6")
out = ROOT / "evidence" / "CS-Coders-Round2-BugProof.png"
canvas.save(out, optimize=True)
print(out)
