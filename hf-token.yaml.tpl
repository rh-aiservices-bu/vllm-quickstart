---
apiVersion: v1
kind: Secret
metadata:
  name: hf-token-secret
type: Opaque
stringData:
  HUGGING_FACE_HUB_TOKEN: $YOUR_HF_TOKEN
