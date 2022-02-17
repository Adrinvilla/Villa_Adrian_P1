
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

## PARTE II

library (igraphdata)
data ("karate")

plot (karate)

# 1. Encuentre las tres personas mas conectadas.

Conectadas <- degree (karate) ## Ver todas las persoans mas conectadas de la red
sort (Conectadas, decreasing = TRUE) [1:3] ## Seleccionar las 3 mas conectadas


# 2. La grafica de la distribución de conectividades.

hist (Conectadas, xlab = "Conectividades", ylab = "Frecuencia", col = "lightblue", main = "Distribución de Conexiones")
## Muchas personas con pocas conexione y pocas personas con muchas

# 3. El diametro de la red.

diameter (karate) ## Diametro (13)


# 4. El coeficiente de clusterizacion cada una de las 3 personas mas conectadas.

transitivity (karate, type = "local", vids = c("John A", "Mr Hi", "Actor 33"))
## Coeficiente de clusterizacion: 0.1102941 0.1500000 0.1969697, respectivamente


# 5. Encuentre si los hay, a los nodos con coeficiente de clusterización de 1. Discute su significado.

head (sort (transitivity (karate, type = "local"), decreasing = TRUE))
## No supe colocar los nombres a los nodos
## Querria decir que los grupos formados en esta red estan muy conectados


# 6. El porcentaje de conexiones respecto al total.

gorder(karate) ## Ver el numero de nodos
sum (degree(karate)) ## Total de conexiones
gorder(karate)/sum (degree(karate))*100 ## Nodos / Conexiones * 100

## La red esta 21.79487% conectada
## No se si entendi bien la pregunta, pero creo que asi es como se hace


# 7. El promedio de conectividades.

mean (degree (karate)) ## Promedio de conectividades por nodo

# 8. Encuentre QUIENES son las 3 personas mas importantes con al menos 3 distintos metodos.

betweenness (karate) 
sort (betweenness (karate), decreasing = TRUE) [1:3] ## Los tres nodos mas importantes por ser los mas conectados
## Mr. Hi, John A y Actor 20


degree (karate)
sort (degree (karate), decreasing = TRUE) [1:3] ## Degree de los 3 nodos mas importantes (in and out)
## John A, Mr. Hi, Actor 33


eccentricity (karate)
sort (eccentricity (karate), decreasing = TRUE) [1:3] ## Nodos mas importantes por ser los mas excentricos
## Actor 5, Actor 16 y Actor 17


# 9. Encuentre la trayectoria entre las personas mas alejadas. 

get_diameter (karate) ## Actor 16 John A   Actor 20 Mr Hi    Actor 6  Actor 17

# 10. Clusteriza la red con al menos 4 metodos distintos y discute tu resultado sabiendo que ese grupo de personas se separo en dos clubes distintos con el tiempo.

Optimal <- cluster_optimal (karate) ## Metodo de optima estructura
Optimal ## Ver los grupos (4)
table (membership (Optimal)) ## Ver en forma de tabla

Walk <- cluster_walktrap (karate) ## Metodo de "random walks" cortos
Walk ## Ver los grupos (4)
table (membership (Walk)) ## Ver en forma de tabla

Leiden <- cluster_leiden (karate) ## Cluster usando algoritmo de Leiden.
Leiden ## Ver los grupos (17)
table (membership (Leiden)) ## Ver en forma de tabla

Louvain <- cluster_louvain (karate) ## Comunidad estructural multi-nivel..
Louvain ## Ver los grupos (4)
Louvain ## Ver en forma de tabla

## Quitando el metodo de Leiden, todos los clusters son de 4 grupos, tiene cierto sentido, si bien, el grupo inicial se dividio en 2
## No quiere decir que se cortaran todas las conexiones al 100%
## Puede significar que siguieron habiendo amigos o lo que sea entre ambos grupos.
