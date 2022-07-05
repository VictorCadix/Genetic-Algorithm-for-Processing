Population population;
int nParameters;
int nIndiv = 1000;
int nCrossPoints = 1000;
float mutation_rate = 0.0001;
int elitism = 0;

float min_error;

int generation = 0;

PImage target_image;

PrintWriter log_file;

void setup(){
  size(800,400);
  target_image = loadImage("Image.png");
  
  nParameters = target_image.height * target_image.width;
  println("nParameters: " + str(nParameters));
  
  population = new Population(nIndiv, nParameters);
  
  String name = "log_" + str(nIndiv) + "i_" + str(mutation_rate) + "m_" + str(nCrossPoints) + "cp_"  + str(elitism) + "E_#";
  log_file = createWriter("Data/" + name + ".txt");
  log_file.println("generation,best_fitness");
  println("Setup done");
}

void draw(){
  generation++;
  print("Generation: ");
  println(generation);
  
  //Evaluate
  for (Individual indiv: population.individuals){
    PImage img = genes2image(indiv.chromosome);
    float error = 0;
    img.loadPixels();
    target_image.loadPixels();
    
    for (int i = 0; i < img.pixels.length; i++) {
      int c1 = target_image.pixels[i];
      int c2 = img.pixels[i];
      c1 = (c1 >> 16) & 0xFF;
      c2 = (c2 >> 16) & 0xFF;
      error += (c1 - c2) * (c1 - c2);
    }
    error /= img.pixels.length;
    indiv.fitness = 1/error;
  }
  
  //println("New crew");
  //population.printReport();
  //println();
  
  //Selection
  population.calculate_selection_probability();
  
  Individual child [] = new Individual [nIndiv];
  for (int i = 0; i < nIndiv; i++){
    int p1 = population.get_parent();
    int p2 = population.get_parent();
    
    //println(str(p1) + ":" + str(p2));
    
    //crossover
    child[i] = population.crossover(p1, p2, nCrossPoints);
    
    //mutation
    child[i].addMutation(mutation_rate);
    
  }
  int best = population.getBetsIndiv();
  PImage model = genes2image(population.individuals[best].chromosome);
  println(population.individuals[best].fitness);
  image(target_image, 0, 0, 400, 400);
  image(model, 400, 0, 400, 400);
  
  log_file.print(generation);
  log_file.print(",");
  log_file.println(population.individuals[best].fitness);
  
  
  // Renew population
  for (int i = 0; i < nIndiv; i++){
    population.individuals[i] = child[i];    
  }
}

PImage genes2image(float[] chromosome){
  PImage img = createImage(50, 50, RGB);
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    int c = int(map(chromosome[i], -1, 1, 0, 255));
    img.pixels[i] = color(c, c, c);
  }
  img.updatePixels();
  return img;
}

void exit(){
  log_file.flush();
  log_file.close();
  println("Closing");
  super.exit();//let processing carry with it's regular exit routine
}
