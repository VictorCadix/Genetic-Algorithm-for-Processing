
import GeneticAlgorithm.*;

Population population;
int nIndiv = 1000;
int nCrossPoints = 100;
float mutation_rate = 0.0001;
int elitism = 0;

ArrayList <PVector> cities;
int nCities = 10;

void setup(){
  size(800,800);
  cities = new ArrayList <PVector>();
  for(int i = 0; i < nCities; i++){
    cities.add(new PVector(random(0,1),random(0,1)));
  }
}

void draw(){
  background(200);
  for(int i = 0; i < nCities; i++){
    float posX = cities.get(i).x * width;
    float posY = cities.get(i).y * height;
    circle(posX,posY,20);
  }
}
