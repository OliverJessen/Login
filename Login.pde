import de.bezier.data.sql.*;

ArrayList<ButtonField> buttonFields = new ArrayList<ButtonField>();
SQLite database;
void setup() {
  size(1000, 500);
  ButtonField b = new ButtonField(new PVector(100, 100), new PVector(170, 50), color(255), "I am button", 25, color(150));
  buttonFields.add(b);
}

void draw() {
  for(ButtonField b : buttonFields) {
    b.display();
  }
}

void mousePressed() {
  for(ButtonField b : buttonFields) {
    b.clicked();
  }
}

void keyPressed() {
  if (key == 'b') {
    getData();
  }
}

void getData() {
  database = new SQLite(this, "Users.sqlite");

  if (database.connect()) {
    database.query("SELECT ID, Name, Mail, Pass FROM User");

    while (database.next()) {
      println("ID: " + database.getInt("ID") + ", \t Name: " + database.getString("Name") + ", \t Mail: " + database.getString("Mail") + ", \t Password: " + database.getString("Pass"));
    }
  } else {
    println("Database failed to connect");
  }
}
