
import GeneticAlgorithm.*;

Population population;
int nIndiv = 100;
int nCrossPoints = 10;
float mutation_rate = 0.01;
int elitism = 0;

int generation = 0;

ArrayList <PVector> cities;
int nCities = 10;

void setup(){
  size(800,800);
  cities = new ArrayList <PVector>();
  for(int i = 0; i < nCities; i++){
    cities.add(new PVector(random(0,1),random(0,1)));
  }
  
  population = new Population(this, nIndiv, nCities);
  population.crossover_type = "multiple_random";
}

void draw(){
  
  generation++;
  print("Generation: ");
  print(generation);
  
  //Evaluate
  for (Individual indiv: population.individuals){
    int [] route = genes2route (indiv.chromosome);
    float distance = 0;
    for (int i = 1; i < route.length; i++) {
      PVector city1 = cities.get(route[i-1]);
      PVector city2 = cities.get(route[i]);
      float X1 = city1.x * width;
      float Y1 = city1.y * height;
      float X2 = city2.x * width;
      float Y2 = city2.y * height;
      distance += sqrt((X2-X1)*(X2-X1) + (Y2-Y1)*(Y2-Y1));
    }
    for (int i = 0; i < nCities; i++){
      for (int j = 0; j < route.length; j++){
        
      }
    }
    indiv.fitness = 1/(distance + 1e-6);
  }
  
  //Selection
  population.calculate_selection_probability();
  
  Individual child [] = new Individual [nIndiv];
  for (int i = 0; i < nIndiv; i++){
    int p1 = population.get_parent();
    int p2 = population.get_parent();
    
    //crossover and mutation
    child[i] = population.crossover(p1, p2, nCrossPoints);
    child[i].addMutation(mutation_rate);
  }
  
  //Draw cities and route
  background(200);
  for(int i = 0; i < nCities; i++){
    float posX = cities.get(i).x * width;
    float posY = cities.get(i).y * height;
    circle(posX,posY,20);
  }
  int best = population.getBetsIndiv();
  int [] route = genes2route (population.individuals[best].chromosome);
  drawRoute(route);
  println(" -> " + str(population.individuals[best].fitness));
  
  // Renew population
  for (int i = 0; i < nIndiv; i++){
    population.individuals[i] = child[i];    
  }
}

int[] genes2route(float[] chromosome){
  int [] route = new int [nCities];
  for (int i = 0; i < nCities; i++) {
    route[i] = round(map(chromosome[i], -1, 1, 0, nCities-1));
  }
  return route;
}

void drawRoute(int [] route){
  for (int i = 1; i < route.length; i++) {
    PVector city1 = cities.get(route[i-1]);
    PVector city2 = cities.get(route[i]);
    float X1 = city1.x * width;
    float Y1 = city1.y * height;
    float X2 = city2.x * width;
    float Y2 = city2.y * height;
    line(X1,Y1,X2,Y2);
  }
}
