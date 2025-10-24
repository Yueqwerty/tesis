# Datos Verificados del Experimento Monte Carlo

## Confirmación de Correctitud

Los datos han sido verificados directamente del archivo `resultados_montecarlo.csv` generado por el experimento.

## Estadísticas por Configuración (1,000 réplicas cada una)

| Configuración | Media | Mediana | DE | IC 95% Inferior | IC 95% Superior |
|--------------|-------|---------|-----|-----------------|-----------------|
| Status Quo - Corta | 84.32% | - | 3.49% | 84.10% | 84.54% |
| Status Quo - Media | 81.14% | - | 3.76% | 80.90% | 81.37% |
| Status Quo - Larga | 78.13% | - | 4.48% | 77.85% | 78.41% |
| Propuesta - Corta | 98.82% | - | 1.15% | 98.75% | 98.89% |
| Propuesta - Media | 97.22% | - | 2.30% | 97.08% | 97.37% |
| Propuesta - Larga | 94.70% | - | 3.97% | 94.45% | 94.94% |

## Efectos Principales

### Factor ENDÓGENO (Capacidad de Almacenamiento)

- **Status Quo (431 TM):** 81.20% (promedio de 3,000 simulaciones)
- **Propuesta (681 TM):** 96.91% (promedio de 3,000 simulaciones)
- **Efecto:** +15.72 puntos porcentuales

**Interpretación:** Aumentar la capacidad en 250 TM (58% de incremento) mejora el nivel de servicio en 15.72 puntos porcentuales.

### Factor EXÓGENO (Duración de Disrupciones)

- **Corta (7 días):** 91.57% (promedio de 2,000 simulaciones)
- **Media (14 días):** 89.18% (promedio de 2,000 simulaciones)
- **Larga (21 días):** 86.42% (promedio de 2,000 simulaciones)
- **Efecto (Corta vs. Larga):** +5.15 puntos porcentuales

**Interpretación:** Aumentar la duración máxima de disrupciones de 7 a 21 días (200% de incremento) degrada el nivel de servicio en 5.15 puntos porcentuales.

## Ratio de Sensibilidad

```
Ratio = Efecto Endógeno / Efecto Exógeno
Ratio = 15.72 / 5.15 = 3.05
```

**Conclusión:** El sistema es **3.05 veces más sensible** al factor endógeno (capacidad) que al factor exógeno (duración de disrupciones).

## Prueba de Hipótesis

**Hipótesis postulada:**
> La resiliencia del sistema exhibe una sensibilidad significativamente mayor a parámetros exógenos que a parámetros endógenos.

**Resultado:** **REFUTADA**

**Evidencia:**
1. El factor endógeno produce un cambio de 15.72 puntos porcentuales
2. El factor exógeno produce un cambio de 5.15 puntos porcentuales
3. El ratio de 3.05 indica que el factor endógeno domina

**Significancia estadística:**
- Los intervalos de confianza al 95% no se traslapan entre niveles
- Las diferencias son estadísticamente significativas (p < 0.001)

## Implicación Principal

El sistema Status Quo (431 TM) opera con un nivel de servicio de **81.20%**, lo que significa que **falla en satisfacer la demanda el 18.80% del tiempo**. Esto es extraordinariamente alto para un servicio energético crítico.

La expansión de capacidad a 681 TM mejora el nivel de servicio a **96.91%**, reduciendo el tiempo de falla a **3.09%**.

Este resultado indica que el sistema opera en un régimen de **subcapacidad crónica**, donde la insuficiencia de almacenamiento es el factor limitante dominante, más que la frecuencia o duración de las disrupciones externas.

## Validación

Estos números han sido verificados:
1. Contando las filas del CSV (6,000 simulaciones confirmadas)
2. Calculando las medias directamente del CSV
3. Verificando que coincidan con los intervalos de confianza pre-calculados
4. Comparando con las figuras generadas (que usan los mismos datos)

**Fecha de verificación:** 23 de octubre de 2025
**Archivo fuente:** `simres-glp-aysen/results/montecarlo/resultados_montecarlo.csv`
