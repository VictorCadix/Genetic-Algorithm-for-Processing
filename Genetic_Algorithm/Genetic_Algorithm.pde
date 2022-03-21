Population population;
int nParameters = 2;
int nIndiv = 10;

void setup(){
  population = new Population(nIndiv, nParameters);
  
  print("Setup done");
}

void draw(){
  
  //Evaluate
  for (Individual indiv: population.individuals){
    float model = genes2model(indiv.chromosome);
    float error = (model - 3.141592) * (model - 3.141592);
    indiv.fitness = 1/error;
  }
  
  //Selection
  population.calculate_selection_probability();
  int p1 = population.get_parent();
  int p2 = population.get_parent();
  
  //crossover
  Individual child = population.crossover(p1, p2);
  
  //mutation
  
  
  
}

float genes2model(float[] chromosome){
  return chromosome[0]/chromosome[1];
}
