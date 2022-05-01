Population population;
int nParameters;
int nIndiv = 100;

float min_error;

int generation = 0;

PImage target_image;

void setup(){
  size(800,400);
  target_image = loadImage("Image.png");
  
  nParameters = target_image.height * target_image.width;
  println("nParameters: " + str(nParameters));
  
  population = new Population(nIndiv, nParameters);
  
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
    child[i] = population.crossover(p1, p2);
    
    //mutation
    child[i].addMutation(0.01);
    
  }
  int best = population.getBetsIndiv();
  PImage model = genes2image(population.individuals[best].chromosome);
  println(population.individuals[best].fitness);
  image(target_image, 0, 0, 400, 400);
  image(model, 400, 0, 400, 400);
  
  
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
