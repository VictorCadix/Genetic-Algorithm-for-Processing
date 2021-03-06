# Genetic Algorithm for Processing

Work in progress

The object of this repo is to ease the use of the Genetic Algorithm (GA) in Processing scketches.

## Build and Install the library:

Compile the .java class files:
Go to the src/GeneticAlgorithm folder and run the following command (for windows):

    javac -cp "/path/to/core.jar" -d . *.java

Where ```"/path/to/core.jar"``` is the location of the core.jar file. For example ```"C:\Program Files\processing-4.0b6\core\library\core.jar"```.

After that a folder named "GeneticAlgorithm" with the compiled classes shuld have been created.

To create the compress .jar file of the folder run the command:

    jar -cf GeneticAlgorithm.jar GeneticAlgorithm

Place the .jar file in a folder named "library" inside another one named "GeneticAlgorithm".

    GeneticAlgorithm/library/GeneticAlgorithm.jar

For the last step move the folder to the libraries folder of processing located probably in your documents folder.

    "Path\to\User\Documents\Processing\libraries"

To import the library put ```import GeneticAlgorithm.*;``` on top of your sketch and *voilà, c'est fait*.

## How to use it:

### 1: Declare and initialize the Population

On the setup function, initialize the population by passing to the constructor the parameters needed:

```java
Population(int number_individues, int nParameters)
```
- nIndiv: The size of the population
- nParameter: Number of genes conteined in the genome.

```java
Population population;
int nParameters = 2;
int nIndiv = 100;

void setup(){
  population = new Population(nIndiv, nParameters);
}
```

Once this done, each individual of the **population will be initialized randomly, with genes going from -1 to 1**.
(I have in mind to give more options out of the box, but until then, feel free to change it manually on the class file).

### 2: Evaluate

Once the fitness of every individual is calculated, 
First compute the probability for each individual to be chosen.
This is automatically done with the function calculate_selection_probability();

```java
population.calculate_selection_probability();
```

### 3: Selection

```java
int p1 = population.get_parent();
int p2 = population.get_parent();
```

### 4: Crossover
The function expects 2 parameters wich are the indexes of the parents to be used.
```java
Individual crossover(int parent1, int parent2){
```

### 5: Mutation

```java
void Individual.addMutation(float mutation_rate)
```

### 6: Renew the population

```java
for (int i = 0; i < nIndiv; i++){
    population.individuals[i] = child[i];    
}
```

## Simple example
```java
//Evaluate
for (Individual indiv: population.individuals){
    float model = genes2model(indiv.chromosome);
    float error = (model - 3.141592);
    indiv.fitness = 1/error;
}
//Selection
population.calculate_selection_probability();

Individual child [] = new Individual [nIndiv];
for (int i = 0; i < nIndiv; i++){
    int p1 = population.get_parent();
    int p2 = population.get_parent();

    //crossover
    child[i] = population.crossover(p1, p2);

    //mutation
    child[i].addMutation(0.01);
}

// Renew population
for (int i = 0; i < nIndiv; i++){
    population.individuals[i] = child[i];    
}

```