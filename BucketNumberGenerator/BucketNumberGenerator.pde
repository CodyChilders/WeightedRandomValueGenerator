final int randomNumbersPerFrame = 25;
final int numberOfBuckets = 300;
int[] counts = new int[numberOfBuckets];
int[] knownSums = new int[numberOfBuckets + 1]; //Fill this in ahead of time, only need to compute up to numberOfBuckets since that doesn't change at runtime.

void setup(){
  size(700, 300);
  frameRate(60);
  //noStroke();
  for(int i = 0; i < counts.length; i++){
    counts[i] = 0;
  }
  initSumReference();
}

void draw(){
  background(255);
  for(int i = 0; i < randomNumbersPerFrame; i++){
    float num = getRandom();
    //unrelated to the bucket method, this just finds which array slot to throw it into
    for(int j = 0; j < counts.length; j++){
      //println(num + " " + ((float)j / (float)counts.length));
      if(num <= ((float)j / (float)counts.length)){
        counts[j]++;
        break;
      }
    }
  }
  //printArray(counts);
  renderArray(counts);
}

void renderArray(int[] a){
  int max = getMaxElement(a);
  float barHeight = (float)height / ((float)counts.length - 1);
  fill(0);
  for(int i = 1; i < a.length; i++){
    float val = ((float)a[i] / (float)max) * width;
    rect(0, (i - 1) * barHeight, val, barHeight);
  }
}

int getMaxElement(int[] a){
  int max = 0;
  for(int i = 0; i < a.length; i++)
    if(a[i] > max)
      max = a[i];
  return max;
}

void printArray(int[] a){
  for(int i = 0; i < a.length; i++){
    print(a[i] + " ");
  }
  println("");
}

float getRandom(){
  float seed = random(0, 1) * countSum(numberOfBuckets);
  for(int i = 0; i < numberOfBuckets; i++){
    if(seed < knownSums[i]){
      return (float) i / numberOfBuckets;
    }
  }
  return seed;
}

int countSum(int max){
  //try{
  int sum = 0;
  for(int i = 1; i <= max; i++)
    sum += i; //This line makes the random numbers fit under y = x.  Replace 'i' with f(i) to make it fit under any other curve f(x).  The only requirement is that the function for inputs [0, 1] produce ranges [0, 1]
  return sum;
}

void initSumReference(){
  for(int i = 0; i < knownSums.length; i++){
    knownSums[i] = countSum(i);
  }
}

