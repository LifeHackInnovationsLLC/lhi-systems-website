# AI Agent Configuration - LHI Systems Website

## Project Overview

This is the website repository for **lhisystems.com**, the professional services brand of Life Hack Innovations LLC.

## Domain & Hosting

- **Domain**: lhisystems.com
- **Hosting**: DigitalOcean droplet (134.199.198.58)
- **Nginx config**: `/etc/nginx/sites-available/lhisystems.com`
- **SSL**: Let's Encrypt at `/etc/letsencrypt/live/lhisystems.com/`

## Deployment

This repo syncs automatically via Mutagen as part of the lhi_scripts ecosystem:
- DO serves from symlink: `/var/www/lhisystems/` → Mutagen-synced path
- Changes made here appear live within seconds

## Development Guidelines

1. **Keep it simple** - This is primarily a marketing/portfolio site
2. **Static first** - Prefer static HTML unless interactivity is truly needed
3. **Test locally** - Use `./launch.sh start` to preview before committing
4. **Spline 3D** - The logo uses Spline embeds; ensure viewer.spline.design is not blocked

## Current State

- **Phase**: Placeholder with 3D Spline logo
- **Next steps**: Full site build (Astro or Next.js TBD based on interactivity needs)

## Key Files

- `index.html` - Main entry point (currently placeholder)
- `launch.sh` - Development server launcher
