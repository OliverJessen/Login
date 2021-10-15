import de.bezier.data.sql.*;

ArrayList<InputField> inputFields = new ArrayList<InputField>();

SQLite database;
int page = 0;

ButtonField createAccount;
ButtonField login;

void setup() {
  size(1000, 500);
  inputFields.add(new InputField(new PVector(200, 200), new PVector(270, 50), color(255), "Username", 25, color(200)));
  inputFields.add(new InputField(new PVector(200, 255), new PVector(270, 50), color(255), "Password", 25, color(200)));
  
  createAccount = new ButtonField(new PVector(200, 400), new PVector(200, 50), color(255), "Create Account", 25, color(150));
  login = new ButtonField(new PVector(500, 400), new PVector(170, 50), color(255), "Login", 25, color(150));

  database = new SQLite(this, "Users.sqlite");
}

void draw() {
  createAccount.display();
  login.display();
  
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
  for (ButtonField a : buttonFields) {
    a.clicked();
    addAccount();
  }
}

void keyPressed() {
  if (keyCode != SHIFT) {
    for (InputField i : inputFields) {
      i.addInput(key);
    }
    if (keyCode == BACKSPACE )
      for (InputField i : inputFields) {
        i.removeInput();
      }
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
