# Configuración de Neovim

## Requisitos

- Neovim >= 0.9.0
- Git
- ripgrep (para Telescope)

## Instalación

1. **Clonar el repositorio en la carpeta de configuración de Neovim:**

```bash
# Hacer backup de tu configuración actual si existe
mv ~/.config/nvim ~/.config/nvim.bak

# Clonar este repositorio
git clone https://github.com/Jose-Guglielmi/nvim-config.git ~/.config/nvim
```

2. **Iniciar Neovim:**

```bash
nvim
```

Lazy (el gestor de plugins) se descargará automáticamente los plugins.

3. **Instalar lenguajes LSP (opcional):**

Ejecuta `:Mason` dentro de Neovim para instalar lenguajes como rust-analyzer, pylsp, etc.

## Atajos de teclado

| Atajo | Acción |
|-------|--------|
| `<Space>w` | Guardar archivo |
| `<Space>q` | Cerrar archivo |
| `<Space>ff` | Buscar archivos (Telescope) |
| `<Space>f` | Ver buffers abiertos |
| `<Space>h` | Abrir archivo en split horizontal |
| `<Space>j` | Moverse a split izquierdo |
| `<Space>k` | Moverse a split derecho |
| `<C-1>` | Toggle terminal flotante 1 |
| `<C-2>` | Toggle terminal flotante 2 |
| `<C-3>` | Toggle terminal flotante 3 |
| `gd` | Ir a definición (LSP) |
| `gr` | Ver referencias (LSP) |
| `K` | Hover (LSP) |
| `<leader>c` | Comentar/Descomentar línea |
| `gcc` | Comentar línea |
| `gc` | Comentar selección |

## Notas

- La fuente configurada es `Inder:h14`. Si no la tienes, cámbiala en `init.lua` línea 50.
- Los plugins se instalan automáticamente con Lazy.nvim.