import point2line.*;

class Cell {
  int maxConn = 15;
  int maxConnDistance = 50;
  int connections = 0;
  //color strain = #2E98FF; //azul bonito
  color strain = #FFFFFF; //blanco
  float weight = 0.5;
  PVector pos = new PVector();
  
  Cell(PVector initPos){
    pos.set(initPos);
  }
  
  boolean pair(Cell partner){
    if (connections < maxConn &&
        partner.connections < partner.maxConn &&
        partner.pos.dist(pos) <= maxConnDistance){
      connect(partner);
      return true;
    }else{
      return false;
    }
  }
  
  void connect(Cell partner){
    strokeWeight(weight);
    stroke(strain,50);
    line(pos.x,pos.y,partner.pos.x,partner.pos.y);
    connections++;
  }
}

class Websease {
  int d = 70;
  boolean add = false;
  PVector lastPos;
  ArrayList<Cell> cells = new ArrayList<Cell>();

  Websease(PVector initPos){
    cells.add(new Cell(initPos));
  }

  void spread(){
    add = false;
    lastPos = cells.get(cells.size()-1).pos;
    if(lastPos.x > width || lastPos.x < 0 || lastPos.y > height || lastPos.y < 0){
     lastPos = cells.get((int)random(cells.size())).pos;
    }
    Cell newCell = new Cell(posGenerator(lastPos));
    for(int i=1; i <= cells.size(); i++){
      if(newCell.pair(cells.get(i-1))) 
        add = true;
    }
    if(add) cells.add(newCell);
  }

  PVector posGenerator(PVector pt){
    PVector genPt = new PVector();
    genPt.set(pt);
    genPt.x += random(d)-random(d);
    genPt.y += random(d)-random(d);
    return genPt;
  }
  
}


///////////////////////////////////////

int wsQty = 1;
color bkgColor = #000000;
Websease R;
ArrayList<Websease> X = new ArrayList<Websease>();

void settings(){
  fullScreen(1);
}

void setup() {
  frameRate(200);
  background(bkgColor);
  fill(#010500); // semi-transparent white
  for(int i=1; i <= wsQty; i++){
    X.add(new Websease(new PVector(random(width),random(height))));
  }
}

void draw() {    //<>//
   for(int i=1; i <= X.size(); i++){
     X.get(i-1).spread();
   }
}