# 🚀 Instrucciones para Subir a GitHub

Tu repositorio local ya está inicializado. Sigue estos pasos para subirlo a GitHub:

## Paso 1: Crear un Repositorio en GitHub

1. Ve a [GitHub.com](https://github.com) e inicia sesión
2. Haz clic en el **+** en la esquina superior derecha → **New repository**
3. Nombre del repositorio: `YourLaTeXSchedule`
4. Descripción (opcional): "Create university schedules using LaTeX and Docker"
5. **NO** inicialices con README, .gitignore, ni licencia (ya los tenemos)
6. Haz clic en **Create repository**

## Paso 2: Conectar tu Repositorio Local a GitHub

Ejecuta estos comandos en PowerShell:

```powershell
cd "c:\Users\smore\Desktop\YourLaTeXSchedule"

# Renombra la rama a 'main' (recomendado)
git branch -M main

# Agrega la URL remota
git remote add origin https://github.com/slmorenog-ud/YourLaTeXSchedule.git

# Sube el código a GitHub
git push -u origin main
```

## Paso 3: Verificación

✅ Ve a `https://github.com/slmorenog-ud/YourLaTeXSchedule`  
✅ Deberías ver tus archivos y el README.md formateado

## Paso 4: Agregar una Licencia (Opcional pero Recomendado)

```powershell
# Crea un archivo LICENSE
"MIT License - Copyright (c) 2026 Your Name" | Out-File -Encoding UTF8 LICENSE

git add LICENSE
git commit -m "Add MIT License"
git push
```

## 🔑 Problemas Comunes

### "Authentication failed"
- Usa **tokens de acceso personal** en lugar de contraseña
- Ve a GitHub → Settings → Developer settings → Personal access tokens

### "Repository not found"
- Verifica que creaste el repo en GitHub
- Confirma el nombre de usuario en la URL

### "fatal: not a git repository"
- Asegúrate de estar en la carpeta correcta: `c:\Users\smore\Desktop\YourLaTeXSchedule`

---

¡Listo! Tu proyecto está en GitHub. 🎉
