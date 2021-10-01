import de.bezier.data.sql.*;

ArrayList<ButtonField> buttonFields = new ArrayList<ButtonField>();
Field test;

void setup() {
  size(1000, 500);
  test = new Field(new PVector(100, 100), new PVector(100, 50), color(255), "Hej", 25);
}

void draw() {
  test.display();
}

void mousePressed() {
  for(ButtonField b : buttonFields) {
    b.display();
  }
}

void keyPressed() {
  
}
