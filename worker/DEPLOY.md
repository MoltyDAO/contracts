# Quick Deploy to Cloudflare Workers

## Step 1: Install Wrangler
```bash
npm install -g wrangler
```

## Step 2: Login to Cloudflare
```bash
wrangler login
```

## Step 3: Deploy
```bash
cd worker
wrangler deploy
```

## Step 4: Add Custom Domain (Important!)
After deploying, you MUST add the custom domain in Cloudflare dashboard:

1. Go to https://dash.cloudflare.com
2. Workers & Pages → moltydao-website
3. Settings → Triggers
4. Add Custom Domain: `moltydao.fun`
5. Add Custom Domain: `www.moltydao.fun`

## Alternative: Direct Dashboard Deploy

If wrangler doesn't work:

1. Go to https://dash.cloudflare.com
2. Workers & Pages → Create Application
3. Create Worker
4. Quick Edit
5. Delete default code
6. Copy ALL content from `worker/index.js`
7. Save and Deploy
8. Go to Settings → Triggers → Add Custom Domain
9. Add `moltydao.fun` and `www.moltydao.fun`

## DNS Configuration

Make sure DNS records point to the Worker:
- Type: CNAME
- Name: @ (or www)
- Target: moltydao-website.YOUR_SUBDOMAIN.workers.dev
- Proxy: Enabled (orange cloud)

Or if using Custom Domain trigger, Cloudflare handles this automatically.
