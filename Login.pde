import de.bezier.data.sql.*;

ArrayList<ButtonField> buttonFields = new ArrayList<ButtonField>();
ArrayList<InputField> inputFields = new ArrayList<InputField>();
SQLite database;

void setup() {
  size(1000, 500);
  
  ButtonField b = new ButtonField(new PVector(100, 100), new PVector(170, 50), color(255), "I am button", 25, color(150));
  ButtonField g = new ButtonField(new PVector(300, 100), new PVector(170, 50), color(255), "Get data", 25, color(150));
  ButtonField a = new ButtonField(new PVector(500, 100), new PVector(170, 50), color(255), "Add account", 25, color(150));
  InputField i = new InputField(new PVector(200, 200), new PVector(270, 150), color(255), "Enter stuff here", 25, color(200));
  
  inputFields.add(i);
  buttonFields.add(b);
  buttonFields.add(g);
  buttonFields.add(a);
  
  database = new SQLite(this, "Users.sqlite");
}

void draw() {
  for (ButtonField b : buttonFields) {
    b.display();
  }

  for (InputField i : inputFields) {
    i.display();
  }
}

void mousePressed() {
  for (ButtonField b : buttonFields) {
    b.clicked();
  }
  for (InputField i : inputFields) {
    i.clicked();
  }
  for (ButtonField g : buttonFields) {
    g.clicked();
    getData();
  }
  for (ButtonField a : buttonFields){
    a.clicked();
    addAccount();
  }
}

void keyPressed() {
  for (InputField i : inputFields) {
    i.addInput(key);
  }

    if (keyCode == BACKSPACE )
    for (InputField i : inputFields) {
      i.removeInput();
    } 
  
}

void getData() {
  if (database.connect()) {
    database.query("SELECT ID, Name, Mail, Pass FROM User");

    while (database.next()) {
      println(
        "ID: " + database.getInt("ID") + 
        ", \t Name: " + database.getString("Name") + 
        ", \t Mail: " + database.getString("Mail") + 
        ", \t Password: " + database.getString("Pass")
        );
    }
  } else {
    println("Database failed to connect");
  }
}

void addAccount() {
  if (database.connect()) {
    database.query("INSERT INTO User (ID,Name,Mail,Pass) VALUES ( '3','Uaggauga','anotherMail@gmail.com', 'evenBetterPassword');");
  } else {
    println("Database failed to connect");
  }
}
