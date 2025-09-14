#!/bin/bash

# Script para actualizar todos los microservicios con git pull

# Lista de repositorios
REPOS=(
    "../.github"
    "../parent"
    "../gateway"
    "../eureka-server"
    "../class-microservice"
    "../coach-microservice"
    "../equipament-microservice"
    "../member-microservice"
    "../notification-microservice"
    "../payment-microservice"
)

# Colores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${YELLOW}🔄 Iniciando actualización de microservicios...${NC}"
echo "======================================================"

# Guardar el directorio inicial
SCRIPT_DIR=$(pwd)

success=0
errors=0

for repo in "${REPOS[@]}"; do
    if [ -d "$repo" ]; then
        echo -e "${BLUE}📦 $repo${NC}"
        cd "$repo"
        
        if git pull; then
            echo -e "${GREEN}✅ $repo actualizado${NC}"
            ((success++))
        else
            echo -e "${RED}❌ Error en $repo${NC}"
            ((errors++))
        fi
        
        cd "$SCRIPT_DIR"
        echo "--------------------------------"
    else
        echo -e "${RED}❌ $repo no existe${NC}"
        ((errors++))
        echo "--------------------------------"
    fi
done

echo ""
echo "📊 Resumen:"
echo -e "${GREEN}✅ Exitosos: $success${NC}"
echo -e "${RED}❌ Errores: $errors${NC}"

if [ $errors -eq 0 ]; then
    echo -e "${GREEN}🎉 ¡Todos actualizados!${NC}"
else
    echo -e "${RED}⚠️  Hubo algunos errores${NC}"
fi
