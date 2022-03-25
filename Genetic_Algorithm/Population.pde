
class Population{
  int nIndividues;
  float mutation_rate;
  
  Individual[] individuals;
  float[] probability;
  
  Population(int number_individues, int nParameters){
    nIndividues = number_individues;
    individuals = new Individual[nIndividues];
    for (int i = 0; i < nIndividues; i++){
      individuals[i] = new Individual(nParameters);
    }
    probability = new float[number_individues];
  }
  
  void calculate_selection_probability() {
    float sum = 0;
    for (Individual indiv: individuals) {
      sum += indiv.fitness;
    }
    int i = 0;
    for (Individual indiv: individuals) {
      probability[i] = indiv.fitness / sum * 100;
      i++;
    }
  }
  
  int get_parent() {
    float target = random(100);
    float accum_prob = 0;
    for (int i = 0; i < nIndividues; i++) {
      accum_prob += probability[i];
      if (accum_prob >= target) {
        return i;
      }
    }
    println("ERROR: get parent index");
    return -1; //Error
  }
  
  Individual crossover(int parent1, int parent2){
    int nParameters = individuals[parent1].chromosome_length;
    Individual child = new Individual(nParameters);
    
    //one-point crossover
    int crossover_point = int(random(nParameters));
    
    for (int i = 0; i < crossover_point; i++){
      child.chromosome[i] = individuals[parent1].chromosome[i];
    }
    
    for (int i = crossover_point; i < nParameters; i++){
      child.chromosome[i] = individuals[parent2].chromosome[i];
    }
    
    return child;
  }
  
  void printReport(){
    for (int i = 0; i < nIndividues; i++){
      individuals[i].printReport();
    }
  }
    
}

class Individual{
  int chromosome_length;
  float[] chromosome;
  float fitness;
  
  float chr_min, chr_max;
  
  Individual(int chro_length){
    chromosome_length = chro_length;
    chromosome = new float [chro_length];
    init(-1, 1);
  }
  
  void init(int min, int max){
    chr_min = min;
    chr_max = max;
    
    for(int i = 0; i < chromosome_length; i++){
      chromosome [i] = random(min, max);
    }
  }
  
  void addMutation(float mutation_rate){
    for(int i = 0; i < chromosome_length; i++){
      if (random(1) < mutation_rate){
        chromosome [i] = random(chr_min, chr_max);
      }
    }
  }
  
  void printReport(){
    for(int i = 0; i < chromosome_length; i++){
      print(str(chromosome [i]) + " ");
    }
    print("\t");
    println(fitness);
  }
}
