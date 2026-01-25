# LHI Systems Website

Website for **lhisystems.com** - the professional services brand of Life Hack Innovations LLC.

## Quick Start

```bash
npm start
# or
./launch.sh start
```

## Domain Information

| Item | Value |
|------|-------|
| Domain | lhisystems.com |
| Registrar | Namecheap |
| DNS | A Records → 134.199.198.58 |
| Hosting | DigitalOcean droplet |
| SSL | Let's Encrypt (auto-renews) |

## Deployment

This site is deployed via Mutagen sync from the LHI Scripts ecosystem:
- **Mac path**: `lhi_modules/lhi_git_projects/LifeHackInnovationsLLC/lhi-systems-website/`
- **DO path**: Symlinked from `/var/www/lhisystems/`

Changes sync automatically via Mutagen.

## Structure

```
lhi-systems-website/
├── index.html          # Main entry point
├── assets/             # Images, fonts (future)
├── css/                # Stylesheets (future)
├── js/                 # Scripts (future)
├── CLAUDE.md           # AI agent instructions
├── lhi_module.json     # Module metadata
├── package.json        # npm scripts
└── launch.sh           # Standardized launcher
```

## Related

- Parent ecosystem: [lhi_scripts](https://github.com/LifeHackInnovationsLLC/lhi_scripts)
- Legacy site: [lhi-website](https://github.com/LifeHackInnovationsLLC/lhi-website) (lifehackinnovations.com)
