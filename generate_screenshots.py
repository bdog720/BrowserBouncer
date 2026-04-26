import sys
import subprocess

def install_pillow():
    subprocess.check_call([sys.executable, "-m", "pip", "install", "Pillow"])

try:
    from PIL import Image, ImageDraw, ImageFont, ImageFilter
except ImportError:
    print("Installing Pillow...")
    install_pillow()
    from PIL import Image, ImageDraw, ImageFont, ImageFilter

import os

def create_mac_screenshot(input_path, output_path, title_text):
    # App store dimension
    W, H = 2880, 1800
    
    # Create dark gradient background
    bg = Image.new('RGB', (W, H), '#1A1A1D')
    draw = ImageDraw.Draw(bg)
    for y in range(H):
        r = int(26 - (y/H)*10)
        g = int(26 - (y/H)*10)
        b = int(29 - (y/H)*10)
        draw.line([(0, y), (W, y)], fill=(r, g, b))
    
    # Load original screenshot
    try:
        shot = Image.open(input_path).convert("RGBA")
    except Exception as e:
        print(f"Error opening {input_path}")
        return

    # Scale up screenshot to look nice (e.g., width 1600 max)
    target_shot_w = 1800
    scale = target_shot_w / shot.width
    target_shot_h = int(shot.height * scale)
    shot = shot.resize((target_shot_w, target_shot_h), Image.Resampling.LANCZOS)
    
    # Add rounded corners
    rad = 20
    mask = Image.new('L', shot.size, 0)
    draw_mask = ImageDraw.Draw(mask)
    draw_mask.rounded_rectangle([0, 0, target_shot_w, target_shot_h], radius=rad, fill=255)
    shot.putalpha(mask)

    # Calculate positions
    shot_x = (W - target_shot_w) // 2
    shot_y = (H - target_shot_h) // 2 + 100 # Shift down slightly for text
    
    # Add shadow
    shadow_img = Image.new('RGBA', (W, H), (0, 0, 0, 0))
    shadow_draw = ImageDraw.Draw(shadow_img)
    shadow_offset = 20
    shadow_draw.rounded_rectangle(
        [shot_x - 10, shot_y - 10, shot_x + target_shot_w + 10, shot_y + target_shot_h + 30], 
        radius=rad, fill=(0, 0, 0, 150)
    )
    shadow_img = shadow_img.filter(ImageFilter.GaussianBlur(30))
    bg.paste(shadow_img, (0, 0), shadow_img)

    # Paste screenshot
    bg.paste(shot, (shot_x, shot_y), shot)

    # Add text
    try:
        # Try to use a system font
        font = ImageFont.truetype("/System/Library/Fonts/HelveticaNeue.ttc", 120, index=2) # Helvetica Neue Bold
    except Exception:
        font = ImageFont.load_default()
        
    text_bbox = draw.textbbox((0, 0), title_text, font=font)
    text_w = text_bbox[2] - text_bbox[0]
    text_x = (W - text_w) // 2
    text_y = 200

    draw.text((text_x, text_y), title_text, fill="white", font=font)

    bg.save(output_path, "PNG")
    print(f"Saved {output_path}")

if __name__ == '__main__':
    create_mac_screenshot("assets/interception_prompt.png", "assets/appstore_1.png", "Smart Browser Routing")
    create_mac_screenshot("assets/routing_rules.png", "assets/appstore_2.png", "Powerful Custom Rules")

