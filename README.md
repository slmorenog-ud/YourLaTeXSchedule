# 📅 YourLaTeXSchedule

> **Crea horarios universitarios profesionales usando LaTeX y Docker** — Compila automáticamente documentos PDF hermosos en cuestión de segundos.

![LaTeX](https://img.shields.io/badge/LaTeX-006DA7?style=flat-square&logo=latex&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)

---

## ✨ Características

✅ **Compilación dinámica** - Compila cualquier horario sin editar archivos  
✅ **Modo batch** - Compila múltiples horarios simultáneamente  
✅ **Docker containerizado** - Ambiente consistente y reproducible  
✅ **Fuentes personalizables** - Usa cualquier fuente TTF/OTF  
✅ **Scripts helper** - Comandos rápidos con PowerShell/Bash  
✅ **Análisis de PDFs** - Compara y extrae información de schedules  

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

#### 3️⃣ **Compilar un Horario**

**Opción A: Script Helper (Recomendado) 🚀**

```powershell
# Windows PowerShell
.\compile.ps1 UScheduleSophie     # Compila un horario específico
.\compile.ps1 -All                # Compila todos los horarios
.\compile.ps1 -List               # Lista horarios disponibles
```

```bash
# Linux/macOS
./compile.sh UScheduleSophie      # Compila un horario específico
./compile.sh --all                # Compila todos los horarios
./compile.sh --list               # Lista horarios disponibles
```

**Opción B: Docker Compose Directo**

```bash
# Compilar horario por defecto (UScheduleSophie)
docker compose up

# Compilar un horario específico
SCHEDULE=UScheduleSergio docker compose up

# Compilar múltiples horarios
SCHEDULES="UScheduleSophie,UScheduleSergio" docker compose up
```

✨ ¡Tus PDFs están listos en `Schedules/`!

#### 4️⃣ **Analizar PDFs (Opcional)**

```bash
# Instalar dependencias Python
pip install -r requirements.txt

# Extraer texto de un PDF
python extract_pdf.py Schedules/UScheduleSophie.pdf

# Comparar múltiples horarios
python extract_pdf.py --compare Schedules/*.pdf

# Parsear información estructurada
python extract_pdf.py --parse Schedules/UScheduleSophie.pdf
```

---

## 🎯 Uso Avanzado

### Compilación Dinámica con Variables

El `docker-compose.yml` ahora soporta compilación dinámica mediante variables de entorno:

```bash
# Variable SCHEDULE: Compila un archivo específico
SCHEDULE=MiHorario docker compose up

# Variable SCHEDULES: Compila múltiples archivos (separados por coma)
SCHEDULES="Horario1,Horario2,Horario3" docker compose up
```

### Script Helper Completo

**Windows (PowerShell):**
```powershell
.\compile.ps1 -List                    # Ver horarios disponibles
.\compile.ps1 UScheduleSophie          # Compilar uno
.\compile.ps1 -All                     # Compilar todos
.\compile.ps1 -Clean                   # Limpiar archivos build
```

**Linux/macOS (Bash):**
```bash
./compile.sh --list                    # Ver horarios disponibles
./compile.sh UScheduleSophie           # Compilar uno
./compile.sh --all                     # Compilar todos
./compile.sh --clean                   # Limpiar archivos build
```

### Análisis Avanzado de PDFs

El script `extract_pdf.py` mejorado incluye:

```bash
# Modo básico: extraer texto
python extract_pdf.py archivo.pdf

# Procesar directorio completo
python extract_pdf.py --directory Schedules/

# Comparar múltiples schedules
python extract_pdf.py --compare Schedules/Sophie.pdf Schedules/Sergio.pdf

# Parsear información estructurada (cursos, grupos, días)
python extract_pdf.py --parse Schedules/UScheduleSophie.pdf

# Guardar resultados en archivo
python extract_pdf.py Schedules/*.pdf --output resultados.txt

# Modo verbose
python extract_pdf.py archivo.pdf --verbose
```

---

## 📝 Cómo Personalizar un Horario

### Crear un Nuevo Horario

1. **Duplica** uno de los archivos en `Schedules/`:
   ```bash
   cp Schedules/UScheduleSophie.tex Schedules/MySchedule.tex
   ```

2. **Edita** tu nuevo archivo LaTeX con tus datos

3. **Compila usando el script helper:**
   ```bash
   .\compile.ps1 MySchedule    # Windows
   ./compile.sh MySchedule     # Linux/macOS
   ```

   O con docker-compose:
   ```bash
   SCHEDULE=MySchedule docker compose up
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
