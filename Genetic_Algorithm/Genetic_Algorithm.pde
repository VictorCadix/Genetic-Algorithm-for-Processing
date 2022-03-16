Population population;
int nParameters = 2;

void setup(){
  population = new Population(10, nParameters);
  
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
  
  
  //crossover
  
  //mutation
  
  
  
}

float genes2model(float[] chromosome){
  return chromosome[0]/chromosome[1];
}
