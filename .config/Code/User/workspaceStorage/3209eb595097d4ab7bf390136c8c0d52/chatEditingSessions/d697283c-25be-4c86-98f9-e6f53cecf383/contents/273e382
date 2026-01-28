# Matugen Waybar Integration

This guide explains how to use Material You colors with Waybar when using Matugen to generate dynamic themes based on wallpapers.

## Setup Instructions

1. **Install the updated configuration:**
   - The files have been fixed to use CSS custom properties (variables) instead of direct color references.

2. **Set up Matugen to generate Waybar colors:**
   - Matugen has been configured to generate colors in `~/.cache/wal/colors-waybar.css`.
   - The CSS file is imported in your Waybar style.

3. **How to use:**
   - When Matugen generates new colors for your wallpaper, it will update the `~/.cache/wal/colors-waybar.css` file.
   - Waybar will load these colors automatically.
   
## Configure Matugen

Add the following to your Matugen configuration to run the script after generating colors:

```yaml
hooks:
  post_generation:
    - ~/.config/matugen/scripts/update-waybar-colors.sh
```

## Manual Testing

You can manually trigger the color generation script with:

```bash
~/.config/matugen/scripts/update-waybar-colors.sh
```

And then restart Waybar:

```bash
killall -SIGUSR2 waybar
```

## Troubleshooting

- If colors aren't applying correctly, check that:
  1. The `colors-waybar.css` file is being generated in `~/.cache/wal/`
  2. The Matugen post-generation hook is running the script
  3. Waybar is restarting to load the new colors
  4. There are no syntax errors in your CSS files