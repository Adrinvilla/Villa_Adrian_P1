
library (igraph) ## Cargar libreria

# PARTE I

# Red de amigues

Red <- read.csv (file = "Red de amigues.csv", sep = ",") ## Cargar archivo
Red ## Imprimir

row.names (Red) <- Red [ , 1]
Red <- Red [ , -1]

View (Red)

Red <- Red [-2, ] ## Quitar valores con NA
Red <- Red [, -2] ## Quitar valores con NA

View (Red) ## Ver que la matriz ya no tenga NA

# 1. Grafique la red

Red <- as.matrix (Red) ## Tomar como matrix
Red <- graph_from_adjacency_matrix (Red, mode = "directed") ## Hacer objeto igraph, Red dirigida

plot (Red) ## Graficar la red


# 2. Determine a las tres personas con mas amigues

Entrada <- degree (Red, mode = "in") ## Degree de los valores de entrada
sort (Entrada, decreasing = TRUE) [1:3] ## Ver a quienes mas personas seleccionaron como amigues


# 3. Determine a las tres personas que consideran que tiene mas amigues

Salida <- degree (Red, mode = "out") ## Degree de los valores de salida
sort (Salida, decreasing = TRUE) [1:3] ## Ver quienes seleccionaron a mas personas como amigues


# 4. Las tres personas mas importantes por tres medidas de centralidad

betweenness (Red) 
sort (betweenness (Red), decreasing = TRUE) [1:3] ## Los tres nodos mas importantes por ser los mas conectados

degree (Red)
sort (degree (Red), decreasing = TRUE) [1:3] ## Degree de los 3 nodos mas importantes (in and out)

eccentricity (Red)
sort (eccentricity (Red), decreasing = TRUE) [1:3] ## Nodos mas importantes por ser los mas excentricos


# 5. Clusteriza la red con al menos dos metodos y determine cuales son los clusters.

Optimal <- cluster_optimal (Red) ## Metodo de optima estructura
Optimal ## Ver los grupos (3)
table (membership (Optimal)) ## Ver en forma de tabla

Walk <- cluster_walktrap (Red) ## Metodo de "random walks" cortos
Walk ## Ver los grupos (3)
table (membership (Walk)) ## Ver en forma de tabla

# 6. Calcule el diametro

diameter (Red) ## Diametro de la red (3)


# 7. La matriz de distancias y dibuje un heatmap

dist (Red)
help ("dist")

