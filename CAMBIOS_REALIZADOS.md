# Cambios Realizados en la Tesis

## Resumen Ejecutivo

Se identificaron inconsistencias críticas entre el experimento implementado y el documento de tesis. Se crearon nuevos capítulos actualizados que reflejan correctamente el experimento Monte Carlo realizado (6,000 simulaciones).

## Inconsistencias Identificadas

### 1. Tamaño del Experimento

**Tesis original:**
- 180 simulaciones (30 réplicas × 6 configuraciones)
- Análisis estadístico básico

**Experimento implementado:**
- 6,000 simulaciones (1,000 réplicas × 6 configuraciones)
- Experimento Monte Carlo completo
- Análisis estadístico robusto con ANOVA, IC 95%, tests de normalidad

### 2. Figuras

**Tesis original (5 figuras básicas):**
- fig1_nivel_servicio_configuracion.pdf
- fig2_efecto_factores.pdf
- fig3_sensibilidad_hipotesis.pdf
- fig4_heatmap_configuraciones.pdf
- fig5_disrupciones_impacto.pdf

**Figuras generadas en Monte Carlo (7 figuras avanzadas):**
- distribuciones.pdf (violin plots con densidades)
- efectos_principales.pdf (con intervalos de confianza 95%)
- heatmap_interacciones.pdf (mapa de calor completo)
- analisis_sensibilidad.pdf (tornado diagram)
- distribuciones_kde.pdf (densidades de probabilidad)
- qq_plots.pdf (validación de normalidad con Shapiro-Wilk)
- boxplot_comparativo.pdf (comparación todas las configuraciones)

### 3. Resultados Numéricos

**Tesis original (09_resultados.tex):**
- Datos parecen corresponder al experimento pequeño (30 réplicas)
- Nivel de servicio Status Quo: ~99% (demasiado optimista)

**Resultados Monte Carlo reales:**
- Status Quo: 81,58% (promedio de 1,000 réplicas)
- Propuesta: 94,37% (promedio de 1,000 réplicas)
- El sistema actual falla ~18% del tiempo

### 4. Conclusión de Hipótesis

**Tesis original:**
- Hipótesis: factor exógeno domina
- Resultado: CONFIRMADA

**Resultados Monte Carlo reales:**
- Hipótesis: factor exógeno domina
- Resultado: REFUTADA
- El factor endógeno (capacidad) tiene mayor impacto: 12,79 vs. 5,29 puntos porcentuales

## Archivos Nuevos Creados

### 1. Capítulos Actualizados

**`capitulos/09_resultados_montecarlo.tex`**
- Refleja correctamente el experimento de 6,000 simulaciones
- Incluye análisis estadístico completo
- Presenta las 7 figuras del Monte Carlo
- Conclusión correcta: hipótesis REFUTADA

**`capitulos/10_discusion_revisada.tex`**
- Interpretación ajustada a los resultados reales
- Explica por qué el factor endógeno domina (subcapacidad crónica)
- Recomendaciones de política pública actualizadas
- Análisis costo-beneficio revisado

### 2. Documentación

**`CAMBIOS_REALIZADOS.md`** (este archivo)
- Resumen completo de inconsistencias
- Guía de actualización

## Acciones Necesarias

### Urgente

1. **Reemplazar capítulo de resultados:**
   - Eliminar: `capitulos/09_resultados.tex`
   - Usar: `capitulos/09_resultados_montecarlo.tex`

2. **Reemplazar capítulo de discusión:**
   - Eliminar: `capitulos/10_discusion.tex`
   - Usar: `capitulos/10_discusion_revisada.tex`

3. **Actualizar main.tex:**
   ```latex
   \include{capitulos/09_resultados_montecarlo}
   \include{capitulos/10_discusion_revisada}
   ```

4. **Verificar referencias de figuras:**
   - Actualizar todas las referencias a las nuevas figuras

### Recomendado

1. **Actualizar capítulo de metodología (07_metodologia.tex):**
   - Cambiar "30 réplicas" a "1,000 réplicas"
   - Añadir mención explícita de "Experimento Monte Carlo"
   - Actualizar justificación del tamaño de muestra

2. **Actualizar hipótesis (03_hipotesis.tex):**
   - Añadir nota de que la hipótesis será puesta a prueba empíricamente
   - No prejuzgar el resultado

## Interpretación de los Resultados

### Lo que cambió

La hipótesis inicial (factor exógeno domina) fue refutada. El sistema es más sensible a la capacidad de almacenamiento que a la duración de disrupciones.

### Por qué tiene sentido

El sistema Status Quo (431 TM) opera en un régimen de **subcapacidad crónica**. No tiene suficiente capacidad para mantener niveles de servicio aceptables incluso en condiciones normales. La variabilidad de la demanda ±15% combinada con baja capacidad genera quiebres frecuentes independientemente de las disrupciones.

El sistema requiere primero estabilizarse mediante expansión de capacidad (alcanzar umbral mínimo operativo). Solo después de esto, las inversiones en mitigación de disrupciones serán efectivas.

### Implicación para política pública

**Original:** Priorizar mitigación de disrupciones sobre expansión de capacidad.

**Correcta:** Priorizar expansión de capacidad (Propuesta 10.4) como medida urgente. La expansión NO es una mejora deseable, es una necesidad operativa crítica. El sistema actual falla 18% del tiempo, inaceptable para un servicio energético.

## Figuras Disponibles

Todas las figuras del experimento Monte Carlo están ahora en:
```
mitesis/figuras/
├── distribuciones.pdf
├── distribuciones_kde.pdf
├── efectos_principales.pdf
├── heatmap_interacciones.pdf
├── analisis_sensibilidad.pdf
├── qq_plots.pdf
└── boxplot_comparativo.pdf
```

Además de las 5 figuras originales que pueden servir como comparación.

## Verificación de Consistencia

Para verificar que todo está actualizado correctamente:

1. Buscar en la tesis referencias a "30 réplicas" y cambiar a "1,000"
2. Buscar referencias a "180 simulaciones" y cambiar a "6,000"
3. Verificar que todos los números de nivel de servicio coincidan con los nuevos resultados
4. Confirmar que la conclusión de hipótesis sea "REFUTADA" no "CONFIRMADA"
5. Verificar que todas las referencias a figuras apunten a los archivos correctos

## Notas Técnicas

### Datos Numéricos Correctos (para referencia rápida)

**Estadísticas por configuración (1,000 réplicas):**

| Configuración | Media | Mediana | DE | IC 95% |
|--------------|-------|---------|-----|---------|
| SQ-Corta | 84,25% | 84,60% | 5,82% | [83,89; 84,61] |
| SQ-Media | 81,45% | 81,95% | 6,35% | [81,05; 81,85] |
| SQ-Larga | 79,04% | 79,52% | 6,71% | [78,62; 79,45] |
| Prop-Corta | 97,03% | 97,46% | 2,56% | [96,87; 97,19] |
| Prop-Media | 94,41% | 94,91% | 3,54% | [94,19; 94,63] |
| Prop-Larga | 91,67% | 92,32% | 4,36% | [91,40; 91,94] |

**Efectos principales:**
- Factor endógeno (capacidad): +12,79 puntos porcentuales
- Factor exógeno (duración): -5,29 puntos porcentuales
- Ratio: capacidad es 2,42× más impactante que duración

### Reproducibilidad

Todos los resultados son reproducibles ejecutando:
```bash
python scripts/experimento_montecarlo.py
python scripts/visualizar_resultados.py
```

Semillas controladas garantizan resultados idénticos.
