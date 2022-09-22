float hw;
String[] fights;
int fightIndex = 0;

void settings() {
  size(2 * displayWidth, displayHeight);
}

void setup() {
  textAlign(CENTER);
  frameRate(60);
  hw = width/2;
  
  leftLogo = loadImage("GladiatorsLogoPrint.png");
  rightLogo = loadImage("WarriorsLogoPrint.png");
  leftLogo.resize(int(hw/2 - 200), int(hw/2 - 200));
  rightLogo.resize(int(hw/2 - 200), int(hw/2 - 200));
  
  String[] lines = loadStrings("scores.txt");
  int[] data = int(split(lines [0], " "));
  
  leftScore = data [0];
  rightScore = data [1];
  
  fights = loadStrings("names.txt");
  
  changeFightIndex(0);
}

void draw() {
  if ( !paused )currentTime++;
  background(255);
  
  displayBottom();
  displayLeft();
  displayRight();
  
  
  displayAltLeft();
  displayAltRight();
  displayAltTime();
  
  if ( currentTime == roundLength ){
    paused = true;
    PrintWriter out = createWriter("scores.txt");
    out.println(str(leftScore) + " " + str(rightScore));
    out.flush();
    out.close();
  }
}

void changeFightIndex(int df) {
  fights = loadStrings("names.txt");
  fightIndex += df;
  fightIndex = max(0, fightIndex);
  fightIndex = min(fights.length-1, fightIndex);
  
  String[] names = split(fights [fightIndex], ",");
  
  leftName = names [0];
  rightName = names [1];
}

void displayAltLeft() {
  fill(rightCol);
  stroke(rightCol);
  
  rect(hw, 0, hw/2, height);
  
  image(rightLogo, hw + 100, 200);//, hw/2 - 200, hw/2 - 200);
  
  fill(255);
  stroke(255);
  
  textSize(0.6 * height);
  text(rightScore, 5 * hw/4, height/1.5);
  
  textSize(0.15 * height);
  text(rightName, 5 * hw/4, 0.1 * height);
}

void displayAltRight() {
  fill(leftCol);
  stroke(leftCol);
  
  rect(3 * hw/2, 0, hw/2, height);
  
  image(leftLogo, 3 * hw/2 + 100, 200);//, hw/2 - 200, hw/2 - 200);
  
  fill(255);
  stroke(255);
  
  textSize(0.6 * height);
  text(leftScore, 7 * hw/4, height/1.5);
  
  textSize(0.15 * height);
  text(leftName, 7 * hw/4, 0.1 * height);
}

void displayAltTime() {
  int timeLeft = roundLength - currentTime;
  
  fill(0);
  stroke(0);
  
  rect(5 * hw/4, 0.8 * height, hw/2, 0.2 * height);
  
  fill(255);
  stroke(255);
  
  textSize(0.2 * height);
  
  text(nf(timeLeft/(60 * fps), 2, 0) + ":" + nf((timeLeft%(60 * fps))/fps, 2, 0) + ":" + nf(100/fps * (timeLeft%fps), 2, 0), 3 * hw/2, 0.95 * height);
}

int bottomHeight = 200;
int currentTime = 0;
int roundLength = 0;
int fps = 60;
boolean paused = true;

void displayBottom() {
  fill(0);
  stroke(0);
  rect(0, height-bottomHeight, hw, bottomHeight);
  
  fill(50);
  stroke(50);
  
  rect(hw/6, height-(2.2 * bottomHeight/3), bottomHeight/3, bottomHeight/3);
  rect(hw/6 + 10 + bottomHeight/3, height-(2.2 * bottomHeight/3), bottomHeight/3, bottomHeight/3);
  rect(hw - 10 - hw/6, height - 8 * bottomHeight/9, hw/6, bottomHeight/3);
  rect(hw - 10 - hw/6, height - 4 * bottomHeight/9, hw/6, bottomHeight/3);
  rect(hw - 20 - hw/3, height - 8 * bottomHeight/9, hw/6, bottomHeight/3);
  rect(hw - 20 - hw/3, height - 4 * bottomHeight/9, hw/6, bottomHeight/3);
  
  fill(255);
  stroke(255);
  
  textSize(bottomHeight/1.5);
  text(nf(currentTime/(60 * fps), 2, 0) + ":" + nf((currentTime%(60 * fps))/fps, 2, 0) + ":" + nf(100/fps * (currentTime%fps), 2, 0), hw/2, height - bottomHeight/2.5);
  
  textSize(bottomHeight/3);
  text(nf(roundLength/(60 * fps), 2, 0) + ":" + nf((roundLength%(60 * fps))/fps, 2, 0) + ":" + nf(100/fps * (roundLength%fps), 2, 0), hw/10, height - bottomHeight/2);
  
  text("+", hw/6 + bottomHeight/6, height-(2.2 * bottomHeight/3) + 1.6 * bottomHeight/6);
  text("-", hw/6 + 3 * bottomHeight/6 + 10, height-(2.2 * bottomHeight/3) + 1.6 * bottomHeight/6);
  text("Reset Time", hw - 10 - hw/12, height - 1.8 * bottomHeight/3);
  text("Next Fight", hw - 10 - hw/12, height - 0.5 * bottomHeight/3);
  text("Start/Stop Time", hw - 20 - 3 * hw/12, height - 1.8 * bottomHeight/3);
  text("Previous Fight", hw - 20 - 3 * hw/12, height - 0.5 * bottomHeight/3);
}

color leftCol = color(128, 0, 32);
int leftScore = 0;
PImage leftLogo;
String leftName;

void displayLeft() {
  fill(leftCol);
  stroke(leftCol);
  
  rect(0, 0, hw/2, height-bottomHeight);
  
  fill(0);
  stroke(255);
  for ( int i = 7; i >= 4; i-- ){
    rect(i * hw/16, 0, hw/16, hw/16);
  }
  
  fill(255);
  stroke(255);
  
  textSize(0.6 * (height-bottomHeight));
  text(leftScore, hw/4, (height-bottomHeight)/1.5);
  
  textSize(0.6 * hw/16);
  text(-1, 15 * hw/32, hw/24);
  text("+2", 13 * hw/32, hw/24);
  text("+3", 11 * hw/32, hw/24);
  text("+4", 9 * hw/32, hw/24);
}

color rightCol = color(255, 128, 0);
int rightScore = 0;
PImage rightLogo;
String rightName;

void displayRight() {
  fill(rightCol);
  stroke(rightCol);
  
  rect(hw/2, 0, hw/2, height-bottomHeight);
  
  fill(0);
  stroke(255);
  for ( int i = 8; i <= 11; i++ ){
    rect(i * hw/16, 0, hw/16, hw/16);
  }
  
  fill(255);
  stroke(255);
  
  textSize(0.6 * (height-bottomHeight));
  text(rightScore, 3 * hw/4, (height-bottomHeight)/1.5);
  
  textSize(0.6 * hw/16);
  text(-1, 17 * hw/32, hw/24);
  text("+2", 19 * hw/32, hw/24);
  text("+3", 21 * hw/32, hw/24);
  text("+4", 23 * hw/32, hw/24);
}

void mouseReleased() {
  if ( mouseY < height-bottomHeight && mouseX < hw){
    if ( mouseY < hw/16 ){
      if ( mouseX > hw/4 && mouseX < 3 * hw/4 ){
        if ( mouseX < 5 * hw/16 )leftScore += 4;
        else if ( mouseX < 6 * hw/16 ) leftScore += 3;
        else if ( mouseX < 7 * hw/16 ) leftScore += 2;
        else if ( mouseX < 8 * hw/16 ) leftScore -= 1;
        else if ( mouseX < 9 * hw/16 ) rightScore -= 1;
        else if ( mouseX < 10 * hw/16 ) rightScore += 2;
        else if ( mouseX < 11 * hw/16 ) rightScore += 3;
        else if ( mouseX < 12 * hw/16 ) rightScore += 4;
      }
    } else {
      if ( mouseX < hw/2 )leftScore++;
      else rightScore++;
    }
  } else if ( mouseX < hw ){
    if ( mouseX < hw/2 ){
      if ( mouseY > height-(2.2 * bottomHeight/3) && mouseY < height-(2.2 * bottomHeight/3) + bottomHeight/3 ){
        if ( mouseX > hw/6 && mouseX < hw/6 + bottomHeight/3 )roundLength += 5 * fps;
        else if ( mouseX > hw/6 + 10 + bottomHeight/3 && mouseX < hw/6 + 2 * bottomHeight/3 + 10) roundLength -= 5 * fps;
        roundLength = max(0, roundLength);
      }
    } else if ( mouseX > hw - 10 - hw/6 && mouseX < hw - 10 ){
      if ( mouseY < height - bottomHeight/2 ){
        currentTime = 0;
        paused = true;
      } else {
        changeFightIndex(1);
      }
    } else if ( mouseX > hw - 20 - hw/3 && mouseX < hw - 20 - hw/6 ){
      if ( mouseY < height - bottomHeight/2 ){
        paused = !paused;
      } else {
        changeFightIndex(-1);
      }
    }
  }
}

void keyReleased() {
  if ( key == ' ' )paused = !paused;
}
