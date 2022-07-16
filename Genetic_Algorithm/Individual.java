package GeneticAlgorithm;

public class Individual{
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
                println("mutation gene: " + str(i));
            }
        }
    }
  
    void printReport(){
        for(int i = 0; i < chromosome_length; i++){
            print(str(chromosome [i]) + " ");
        }
        print("-> ");
        println(fitness);
    }
}