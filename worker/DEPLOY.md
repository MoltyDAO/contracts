# Cloudflare Worker Deployment

## Quick Deploy

### Using Wrangler CLI:

```bash
# Install wrangler
npm install -g wrangler

# Login to Cloudflare
wrangler login

# Deploy
wrangler deploy
```

### Using Cloudflare Dashboard:

1. Go to https://dash.cloudflare.com
2. Workers & Pages → Create Service
3. Quick edit
4. Paste contents of `index.js`
5. Save and deploy
6. Add custom domain: moltydao.fun

## Domain Setup

In Cloudflare dashboard:
1. Go to Workers → moltydao-website
2. Triggers → Add Custom Domain
3. Add `moltydao.fun` and `www.moltydao.fun`
4. Enable proxy (orange cloud)

## Updates

After making changes:
```bash
wrangler deploy
```

Or use GitHub integration for auto-deploy on push.
