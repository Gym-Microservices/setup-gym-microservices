#!/bin/bash

# Script para actualizar todos los microservicios con git pull

# Lista de repositorios
REPOS=(
    ".github"
    "parent"
    "gateway"
    "eureka-server"
    "core-microservice"
    "class-microservice"
    "coach-microservice"
    "equipament-microservice"
    "member-microservice"
    "notification-microservice"
    "payment-microservice"
)

# Colores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${YELLOW}🔄 Iniciando actualización de microservicios...${NC}"
echo "======================================================"

# Función para actualizar un repositorio
update_repo() {
    local repo_name=$1
    
    if [ ! -d "$repo_name" ]; then
        echo -e "${RED}❌ El directorio ${repo_name} no existe${NC}"
        return 1
    fi
    
    if [ ! -d "$repo_name/.git" ]; then
        echo -e "${RED}❌ ${repo_name} no es un repositorio Git válido${NC}"
        return 1
    fi
    
    echo -e "${BLUE}📥 Actualizando ${repo_name}...${NC}"
    
    cd "$repo_name" || {
        echo -e "${RED}❌ No se pudo acceder al directorio ${repo_name}${NC}"
        return 1
    }
    
    # Verificar si hay cambios sin commitear
    if ! git diff-index --quiet HEAD --; then
        echo -e "${YELLOW}⚠️  ${repo_name} tiene cambios sin commitear${NC}"
        cd ..
        return 2
    fi
    
    # Obtener la rama actual
    current_branch=$(git branch --show-current)
    echo -e "${BLUE}   Rama actual: ${current_branch}${NC}"
    
    # Hacer git pull
    if git pull origin "$current_branch"; then
        echo -e "${GREEN}✅ ${repo_name} actualizado exitosamente${NC}"
        cd ..
        return 0
    else
        echo -e "${RED}❌ Error al actualizar ${repo_name}${NC}"
        cd ..
        return 1
    fi
}

# Contadores
success_count=0
error_count=0
warning_count=0

# Actualizar todos los repositorios
for repo in "${REPOS[@]}"; do
    result=$(update_repo "$repo")
    case $? in
        0)
            ((success_count++))
            ;;
        1)
            ((error_count++))
            ;;
        2)
            ((warning_count++))
            ;;
    esac
    echo "------------------------------------------------------"
done

# Resumen final
echo -e "${YELLOW}📊 Resumen de actualización:${NC}"
echo -e "${GREEN}✅ Exitosos: ${success_count}${NC}"
echo -e "${YELLOW}⚠️  Con cambios sin commitear: ${warning_count}${NC}"
echo -e "${RED}❌ Errores: ${error_count}${NC}"
echo "======================================================"

if [ $error_count -eq 0 ] && [ $warning_count -eq 0 ]; then
    echo -e "${GREEN}🎉 ¡Todos los repositorios fueron actualizados exitosamente!${NC}"
elif [ $error_count -eq 0 ]; then
    echo -e "${YELLOW}⚠️  Actualización completada. Algunos repositorios tienen cambios sin commitear.${NC}"
    echo -e "${YELLOW}💡 Commitea los cambios antes de actualizar esos repositorios.${NC}"
else
    echo -e "${RED}❌ Se completó con errores. Verifica los repositorios fallidos.${NC}"
fi
