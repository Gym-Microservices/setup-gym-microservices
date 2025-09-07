#!/bin/bash

# Script para clonar todos los microservicios de la organización

# Configuración
ORG_URL="https://github.com/Gym-Microservices"
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
NC='\033[0m'

echo -e "${YELLOW}🚀 Iniciando clonación de microservicios...${NC}"
echo "======================================================"

# Función para clonar un repositorio
clone_repo() {
    local repo_name=$1
    local repo_url="${ORG_URL}/${repo_name}.git"
    
    if [ -d "$repo_name" ]; then
        echo -e "${YELLOW}⚠️  El directorio ${repo_name} ya existe, saltando...${NC}"
        return 0
    fi
    
    echo -e "${YELLOW}📥 Clonando ${repo_name}...${NC}"
    
    if git clone "$repo_url" "$repo_name"; then
        echo -e "${GREEN}✅ ${repo_name} clonado exitosamente${NC}"
        return 0
    else
        echo -e "${RED}❌ Error al clonar ${repo_name}${NC}"
        return 1
    fi
}

# Contadores
success_count=0
error_count=0

# Clonar todos los repositorios
for repo in "${REPOS[@]}"; do
    if clone_repo "$repo"; then
        ((success_count++))
    else
        ((error_count++))
    fi
    echo "------------------------------------------------------"
done

# Resumen final
echo -e "${YELLOW}📊 Resumen de clonación:${NC}"
echo -e "${GREEN}✅ Exitosos: ${success_count}${NC}"
echo -e "${RED}❌ Errores: ${error_count}${NC}"
echo "======================================================"

if [ $error_count -eq 0 ]; then
    echo -e "${GREEN}🎉 ¡Todos los repositorios fueron clonados exitosamente!${NC}"
else
    echo -e "${YELLOW}⚠️  Se completó con algunos errores. Verifica los repositorios fallidos.${NC}"
fi
