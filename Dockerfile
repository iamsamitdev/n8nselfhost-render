FROM n8nio/n8n

ENV N8N_HOST=n8nselfhost-render.onrender.com
ENV N8N_PROTOCOL=https
ENV WEBHOOK_URL=https://n8nselfhost-render.onrender.com
ENV N8N_EDITOR_BASE_URL=https://n8nselfhost-render.onrender.com

# ใช้พอร์ต 5678 สำหรับ Render
EXPOSE 5678

CMD ["n8n", "start"]