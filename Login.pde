import de.bezier.data.sql.*;

ArrayList<ButtonField> buttonFields = new ArrayList<ButtonField>();
ArrayList<InputField> inputFields = new ArrayList<InputField>();

void setup() {
  size(1000, 500);
  ButtonField b = new ButtonField(new PVector(100, 100), new PVector(170, 50), color(255), "I am button", 25, color(150));
  InputField i = new InputField(new PVector(200, 200), new PVector(270, 150), color(255), "Enter stuff here", 25, color(200));
  inputFields.add(i);
  buttonFields.add(b);
}

void draw() {
  for(ButtonField b : buttonFields) {
    b.display();
  }
  
  for(InputField i : inputFields){
    i.display(); 
  }
}

void mousePressed() {
  for(ButtonField b : buttonFields) {
    b.clicked();
  }
  for(InputField i : inputFields) {
    i.clicked();
  }
}

void keyPressed() {
  for(InputField i : inputFields){
    i.addInput(key);
  } 
}
