import de.bezier.data.sql.*; //<>//

SQLite database;

ArrayList<Field> fields = new ArrayList<Field>();
InputField username = new InputField(new PVector(200, 150), new PVector(580, 50), color(255), "Username", 25, color(200));
InputField password = new InputField(new PVector(200, 205), new PVector(580, 50), color(255), "Password", 25, color(200), true);
InputField mail = new InputField(new PVector(200, 260), new PVector(580, 50), color(255), "Email", 25, color(200));
ButtonField money = new ButtonField(new PVector(200, 315), new PVector(580, 50), color(255), "Balance", 25, color(150));
ButtonField create = new ButtonField(new PVector(200, 400), new PVector(220, 50), color(255), "Create Account", 25, color(150));
ButtonField login = new ButtonField(new PVector(450, 400), new PVector(150, 50), color(255), "Login", 25, color(150));
ButtonField save = new ButtonField(new PVector(630, 400), new PVector(150, 50), color(255), "Save Data", 25, color(150));

User currentUser = new User(username.input, mail.input);

void setup() {
  size(1000, 500);

  fields.add(username);
  fields.add(password);
  fields.add(mail);
  fields.add(money);
  fields.add(create);
  fields.add(login);
  fields.add(save);

  database = new SQLite(this, "Users.sqlite");
}

void draw() {
  background(30, 30, 40, 40);

  create.display();
  login.display();

  for (Field i : fields) {
    i.display();
  }
}

boolean updateUserData() {
  if (currentUser.ID == 0) {
    println("User is not logged in");
    return false;
  }

  return true;
}

void mousePressed() {
  for (Field f : fields)
    if (f instanceof ButtonField) { //Marcus: "instanceof" betyder at vi tjekker om "f" er et objekt af klassen "ButtonField"
      ButtonField b = (ButtonField)f;
      b.clicked();
    }

  if (create.isClicked) {
    if (username.input.length() != 0 && password.input.length() != 0 && mail.input.length() != 0 && isMailUnique())
      addAccount(username.input, password.input, mail.input);
    create.isClicked = false;
  }
  if (login.isClicked) {
    login();
    login.isClicked = false;
  }
  if (money.isClicked) {
    if (currentUser.ID != 0)
      money.text = String.valueOf(Integer.parseInt(money.text) + 1);
    money.isClicked = false;
  }
  if (save.isClicked) {
    if (currentUser.ID != 0)
      currentUser.saveData(database, username.input, Integer.parseInt(money.text));
    money.isClicked = false;
  }
}

void keyPressed() {
  for (Field f : fields)
    if (f instanceof InputField) {
      InputField i = (InputField)f;
      i.addInput(key, keyCode);
    }
}

void addAccount(String username, String password, String email) {
  if (database.connect())
    database.query("INSERT INTO User (Name,Mail,Pass) VALUES ('"+username+"','"+email+"', '"+password+"');");
  else {
    println("Database failed to connect");
    return;
  }
}

boolean isMailUnique() {
  if (database.connect())
    database.query("SELECT ID, Name, Mail, Pass FROM User");
  else {
    println("Database failed to connect");
    return false;
  }

  while (database.next())
    if (mail.input.equals(database.getString("Mail"))) {
      println("Email is already in use");
      return false;
    }

  return true;
}

boolean login() {
  if (database.connect())
    database.query("SELECT ID, Name, Mail, Pass FROM User");
  else {
    println("Database failed to connect");
    return false;
  }

  while (true) {
    if (database.next()) {
      if (mail.input.equals(database.getString("Mail")))
        break;
      else
        continue;
    }
    println("Email is incorrect");
    return false;
  }
  if (!password.input.equals(database.getString("Pass"))) {
    println("Password is incorrect");
    return false;
  }

  currentUser.getData(database, database.getInt("ID"));
  updateData();
  return true;
}

void updateData() {
  username.input = currentUser.name;
  mail.input = currentUser.mail;
  money.text = String.valueOf(currentUser.money);
}

void getAllData() {
  if (database.connect())
    database.query("SELECT ID, Name, Mail, Pass, Money FROM User");
  else {
    println("Database failed to connect");
    return;
  }

  while (database.next()) {
    println(
      "ID: " + database.getInt("ID") + 
      ", \t Name: " + database.getString("Name") + 
      ", \t Mail: " + database.getString("Mail") + 
      ", \t Password: " + database.getString("Pass") +
      ", \t Balance: " + database.getInt("Money")
      );
  }
}
