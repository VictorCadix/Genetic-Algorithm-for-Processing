
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
  }
  
}

class Individual{
  float[] chromosome;
  float fitness;
  
  Individual(int chro_length){
    chromosome = new float [chro_length];
  }
}
