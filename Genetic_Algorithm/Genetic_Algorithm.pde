import GeneticAlgorithm.*;

Population population;
int nParameters = 2;
int nIndiv = 10;

void setup(){
  population = new Population(nIndiv, nParameters);
  population.crossover_type = "multiple_random";
  
  println("Setup done");
}

void draw(){
  
  //Evaluate
  for (Individual indiv: population.individuals){
    float model = genes2model(indiv.chromosome);
    float error = (model - 3.141592) * (model - 3.141592);
    indiv.fitness = 1/error;
  }
  
  println("New crew");
  population.printReport();
  println();
  
  //Selection
  population.calculate_selection_probability();
  
  Individual children [] = new Individual [nIndiv];
  for (int i = 0; i < nIndiv; i++){
    children[i] = new Individual(nParameters);
  }
  for (int i = 0; i < nIndiv; i++){
    int p1 = population.get_parent();
    int p2 = population.get_parent();
    
    println(str(p1) + ":" + str(p2));
    
    //crossover
    children[i] = population.crossover(p1, p2, 1);
    
    //mutation
    children[i].addMutation(0.01);
    
  }
  
  // Renew population
  for (int i = 0; i < nIndiv; i++){
    population.individuals[i] = children[i];
  }
    
}

float genes2model(float[] chromosome){
  return chromosome[0]/chromosome[1];
}
