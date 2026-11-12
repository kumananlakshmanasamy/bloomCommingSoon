# bloom & body co. — launch page

Single-page "launching soon" site. It's plain static HTML served by nginx in Docker, with no build step.

```
bloom-launch/
├── public/              ← the website (edit index.html)
│   ├── index.html
│   └── assets/          ← logo, hero photo, All Round Gothic fonts
├── nginx.conf           ← gzip, caching, security headers, /healthz
├── Dockerfile           ← nginx:alpine image, port 80
└── docker-compose.yml   ← optional (local run / Compose build pack)
```

## Run locally

```bash
docker compose up --build
# open http://localhost:8080
```

To preview without Docker, run `cd public && python3 -m http.server 8080`.

## Deploy on Coolify

1. Push this folder to its own Git repo (GitHub, GitLab or Gitea).
   ```bash
   git init && git add . && git commit -m "bloom launch page"
   git remote add origin <your-repo-url> && git push -u origin main
   ```
2. In Coolify, go to **Projects → (your project) → + New → Application**.
   Pick **Public Repository** or your connected **GitHub App** and select the repo and branch.
3. Set **Build Pack** to **Dockerfile**. The base directory is `/` and the Dockerfile location is `/Dockerfile`.
4. Under **Network**, set **Ports Exposes** to `80`.
5. Under **Domains**, enter your domain, e.g. `https://bloomandbodyco.com,https://www.bloomandbodyco.com`.
   Coolify issues the Let's Encrypt SSL certificate automatically.
6. Point DNS at the Coolify server. Add an `A` record for `@` and `www` with your server's IP.
7. Click **Deploy**. The container's healthcheck hits `/healthz`.
8. Optional: turn on **Auto Deploy** with the Git webhook so each push redeploys.

If you'd rather use Compose, choose the **Docker Compose** build pack. It uses `docker-compose.yml` as-is.
