import de.bezier.data.sql.*;

ArrayList<ButtonField> buttonFields = new ArrayList<ButtonField>();
ArrayList<InputField> inputFields = new ArrayList<InputField>();
SQLite database;

void setup() {
  size(1000, 500);
  ButtonField b = new ButtonField(new PVector(100, 100), new PVector(170, 50), color(255), "I am button", 25, color(150));
  InputField i = new InputField(new PVector(200, 200), new PVector(270, 150), color(255), "Enter stuff here", 25, color(200));
  inputFields.add(i);
  buttonFields.add(b);
  database = new SQLite(this, "Users.sqlite");
}

void draw() {
  for (ButtonField b : buttonFields) {
    b.display();
  }
  
  for(InputField i : inputFields){
    i.display(); 
  }
}

void mousePressed() {
  for (ButtonField b : buttonFields) {
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
  if (key == 'b') {
    getData();
  }
  if (key =='v') {
    //addAccount();
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

/*void addAccount() {
  if (database.connect()) {
    database.query("INSERT INTO User ID Name Mail Pass ");

  } else {
    println("Database failed to connect");
}
*/
