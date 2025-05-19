# --- Stage 1: Build ---
    FROM node:20-alpine AS builder

    WORKDIR /app
    
    COPY package.json package-lock.json* ./
    RUN npm ci
    
    COPY . .
    
    # If using a framework like Vite/Next.js/Vue, build for production
    RUN npm run build
    
    # --- Stage 2: Production ---
    FROM node:20-alpine
    
    WORKDIR /app
    
    COPY package.json package-lock.json* ./
    RUN npm ci --only=production
    
    # Copy built UI from builder
    COPY --from=builder /app/dist ./dist
    COPY --from=builder /app/index.js ./index.js
    
    # If you have other assets needed for runtime, copy them here:
    # COPY --from=builder /app/public ./public
    
    EXPOSE 3000
    
    # Entrypoint: run your SSR or custom server
    CMD ["node", "index.js"]
    