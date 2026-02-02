# 📅 YourLaTeXSchedule

> **Crea horarios universitarios profesionales usando LaTeX y Docker** — Compila automáticamente documentos PDF hermosos en cuestión de segundos.

![LaTeX](https://img.shields.io/badge/LaTeX-006DA7?style=flat-square&logo=latex&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)

---

## ✨ Características

✅ **Compilación instantánea** - Sin instalar LaTeX localmente  
✅ **Docker containerizado** - Ambiente consistente y reproducible  
✅ **Fuentes personalizables** - Usa cualquier fuente TTF/OTF  
✅ **Múltiples horarios** - Gestiona varios horarios en un solo proyecto  
✅ **Configuración modular** - Separa estilos y contenido fácilmente  

---

## 📦 Estructura del Proyecto

```
YourLaTeXSchedule/
│
├── 📄 docker-compose.yml       # Configuración de Docker
├── 📄 extract_pdf.py           # Script para extraer texto de PDFs
├── 📄 test_ash.tex             # Archivo de prueba
├── 📄 README.md                # Este archivo
│
├── 📁 Schedules/
│   ├── UScheduleSophie.tex     # Horario de Sophie
│   └── UScheduleSergio.tex     # Horario de Sergio
│
├── 📁 Configurations/
│   ├── ConfigurationTLOTR.tex  # Configuración TLOTR
│   └── UConfigurationSE.tex    # Configuración SE
│
├── 📁 Fonts/
│   ├── readme.txt              # Instrucciones de fuentes
│   └── OFL.txt                 # Licencia de fuentes
│
└── 📁 build/                   # Archivos compilados (generados)
```

---

## 🚀 Guía de Inicio Rápido

### Requisitos Previos

- **Docker** y **Docker Compose** instalados
- Git (opcional, para clonar el repo)

### Pasos de Instalación

#### 1️⃣ **Clonar el Repositorio**

```bash
git clone https://github.com/tuusuario/YourLaTeXSchedule.git
cd YourLaTeXSchedule
```

#### 2️⃣ **Agregar Fuentes (Opcional)**

Descarga tus fuentes favoritas desde [Google Fonts](https://fonts.google.com) o [Font Awesome](https://fontawesome.com):

```bash
# Coloca los archivos .ttf o .otf en la carpeta Fonts/
cp ~/Descargas/*.ttf Fonts/
```

#### 3️⃣ **Compilar tu Primer Horario**

```bash
# Primera compilación (descargará ~4GB de TeXLive)
docker compose up
```

✨ ¡Tu PDF está listo en `build/UScheduleSophie.pdf`!

#### 4️⃣ **Compilaciones Futuras**

```bash
# Las siguientes compilaciones son mucho más rápidas
docker compose up
```

---

## 📝 Cómo Personalizar un Horario

### Crear un Nuevo Horario

1. **Duplica** uno de los archivos en `Schedules/`:
   ```bash
   cp Schedules/UScheduleSophie.tex Schedules/MySchedule.tex
   ```

2. **Edita** tu nuevo archivo LaTeX:
   ```latex
   \input{../Configurations/UConfigurationSE.tex}
   
   \begin{document}
   
   \begin{tikzpicture}
       % Tu diseño aquí
   \end{tikzpicture}
   
   \end{document}
   ```

3. **Actualiza** el `docker-compose.yml` con el nombre de tu archivo:
   ```yaml
   command: >
     ...
     lualatex -interaction=nonstopmode -halt-on-error MySchedule.tex && ...
   ```

### Cambiar la Fuente

Edita el archivo de configuración en `Configurations/`:

```latex
\setmainfont{TuFuente-Regular.ttf}[
    Path = ../Fonts/,
    BoldFont = TuFuente-Bold.ttf,
    Extension = .ttf
]
```

---

## 🛠️ Tecnologías Utilizadas

| Tecnología | Propósito |
|-----------|-----------|
| **LaTeX (LuaLaTeX)** | Sistema de composición tipográfica profesional |
| **Docker** | Contenedor reproducible para TeXLive |
| **TikZ** | Gráficos y diseño visual |
| **Python 3** | Procesamiento de PDFs |

---

## 📚 Recursos Útiles

- [Documentación de LaTeX](https://www.latex-project.org/)
- [TikZ & PGF Manual](https://ctan.org/pkg/pgf)
- [TeXLive Documentation](https://tug.org/texlive/)
- [Docker Getting Started](https://docs.docker.com/get-started/)

---

## 🤝 Contribuciones

¡Las contribuciones son bienvenidas! 

1. **Fork** el proyecto
2. **Crea una rama** para tu feature (`git checkout -b feature/AmazingFeature`)
3. **Commit** tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. **Push** a la rama (`git push origin feature/AmazingFeature`)
5. **Abre un Pull Request**

---

## 📄 Licencia

Este proyecto está bajo la licencia **MIT**. Ver [LICENSE](LICENSE) para más detalles.

Las fuentes incluidas pueden tener sus propias licencias. Consulta [Fonts/OFL.txt](Fonts/OFL.txt) para más información.

---

## 👤 Autor

**Sergio** 📅✨

---

## 💡 Tips & Trucos

- **Compilación rápida**: Docker cachea layers, así que compilaciones posteriores son velocísimas
- **Depuración**: Revisa `build/UScheduleSophie.log` para errores de LaTeX
- **Múltiples versiones**: Usa diferentes archivos en `Schedules/` para gestionar varios horarios
- **Extracción de texto**: Usa `extract_pdf.py` para obtener contenido de PDFs generados

---

## 📞 Soporte

¿Tienes problemas?

- 📖 Consulta la [Documentación de LaTeX](https://www.latex-project.org/help/)
- 🐛 Abre un [Issue](https://github.com/tuusuario/YourLaTeXSchedule/issues)
- 💬 Revisa issues existentes para soluciones

---

**Hecho con ❤️ y mucho LaTeX**

El archivo `horario.pdf` aparecerá en esta misma carpeta.

## 🎨 Personalizar tu Horario

Abre `horario.tex` y edita:
- Las materias
- Los horarios
- Los colores (en `configuracion.tex`)

## 🔧 Comandos Útiles

**Compilar y limpiar archivos temporales:**
```bash
docker compose up && rm -f *.aux *.log *.out
```

**Ver los logs si hay errores:**
```bash
docker compose up
```

## 💡 Ventajas de este Setup

✅ No instalas nada en tu sistema (excepto Docker)  
✅ Usa toda la potencia de tu procesador  
✅ Fuentes personalizadas sin complicaciones  
✅ PDF profesional en segundos  
✅ Portable y reproducible  

## 🆘 Solución de Problemas

**Error: "Font not found"**
- Verifica que los archivos `.ttf` estén en `fuentes/`
- Asegúrate de que el nombre en `configuracion.tex` sea exacto

**El PDF no se genera:**
- Revisa los errores en la terminal
- Verifica que Docker esté corriendo
- Asegúrate de estar en la carpeta correcta

**Quiero usar otra fuente:**
- Descarga los `.ttf`
- Ponlos en `fuentes/`
- Cambia el nombre en `configuracion.tex`

---

¡Listo! Ahora tienes tu propio sistema LaTeX profesional 🎓
