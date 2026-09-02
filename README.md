# Análisis de Ventas — Coffee Shop Sales (Maven Roasters)

## El problema de negocio

Maven Roasters es una cadena de cafeterías con 3 sucursales en Nueva York. Este análisis responde una pregunta central: **¿qué impulsa realmente el ingreso del negocio, y coincide con lo que más se vende?** Entender esto es clave para decisiones de inventario, promociones y espacio de menú.

## Los datos

- Fuente: [Maven Roasters Coffee Shop Sales](https://www.kaggle.com/datasets/agungpambudi/trends-product-coffee-shop-sales-revenue-dataset) (Kaggle)
- 149,116 transacciones individuales, enero-junio 2023
- 3 sucursales (Hell's Kitchen, Astoria, Lower Manhattan), 9 categorías de producto

## Lo que encontré

**1. Café y Té concentran dos tercios del ingreso.** De 9 categorías de producto, solo estas 2 generan el 66.7% del ingreso total ($466,358 de $698,812).

**2. El producto más vendido no es el que más gana.** "Gourmet brewed coffee" vende más unidades que "Barista Espresso" (25,973 vs 24,943), pero el espresso genera más ingreso ($91,406 vs $70,034) porque tiene precio unitario más alto. Volumen de ventas e ingreso son cosas distintas, y confundirlas lleva a decisiones equivocadas de qué producto priorizar.

**3. Las 3 sucursales tienen desempeño casi idéntico.** Menos de 3% de diferencia en ingreso entre la sucursal más alta y la más baja — el modelo de negocio funciona de forma consistente sin depender de una ubicación estrella.

**4. El ticket promedio es de $4.69**, y el negocio se sostiene por volumen alto de compras pequeñas, no por transacciones grandes ocasionales.

**5. El producto con mejor ticket promedio no es una bebida — es "Coffee beans" ($22.87 en promedio, 5x el ticket de "Coffee")**, aunque se vende en mucho menor volumen y por eso no domina el ingreso total.

## Cómo lo hice

Usé SQL (SQLite) para explorar la tabla `transactions`, combinando:

- **Agregaciones** (`SUM`, `AVG`) para medir ingreso, volumen y ticket promedio desde distintos ángulos
- **GROUP BY** para desglosar por categoría de producto, tipo de producto y sucursal
- **Verificación cruzada**: contrasté los resultados de consultas relacionadas entre sí (ej. la suma de tipos de café coincide exactamente con el total de la categoría "Coffee") para confirmar que no había errores

Consulta de ejemplo — ingreso vs. volumen por tipo de café (el hallazgo más revelador del proyecto):

```sql
SELECT product_type, 
       SUM(unit_price * transaction_qty) AS ingreso_total,
       SUM(transaction_qty) AS unidades_vendidas
FROM transactions
WHERE product_category = 'Coffee'
GROUP BY product_type
ORDER BY ingreso_total DESC;
```

## Recomendación de negocio

Si esto fuera una decisión real, priorizaría inventario y promociones en Café y Té (el 66.7% del ingreso), pero cuidaría no descuidar productos de ticket alto y bajo volumen como "Coffee beans" — ahí puede haber margen para crecer con relativamente poco esfuerzo de marketing, ya que el ticket ya es alto por transacción.

Esto conecta directamente con algo que estoy evaluando para mi propio proyecto de negocio de café: el hallazgo de que el ingreso no depende de una sola ubicación (Hallazgo 3) sugiere que un formato más simple — como un carrito para eventos o un carrito móvil — podría funcionar igual de bien que invertir en un local fijo desde el inicio, si el producto y el ticket promedio están bien pensados.

## Herramientas

SQL (SQLite, DB Browser for SQLite)

## Próximos pasos

Pendiente para una futura iteración: análisis de tendencias por fecha y hora (requiere funciones de fecha que aún no domino), y comparación de mix de producto entre sucursales.
