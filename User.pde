class User {

  int ID;
  String name;
  String mail;
  int money;

  User() {
  }

  User(String name, String mail) {
    setData(name, mail);
  }

  User(String name, String mail, int money) {
    setData(name, mail, money);
  }

  void setData(String name, String mail) {
    this.name = name;
    this.mail = mail;
  }

  void setData(String name, String mail, int money) {
    setData(name, mail);
    this.money = money;
  }

  void getData(SQLite database, int ID) {
    if (database.connect())
      database.query("SELECT * FROM User WHERE ID = " + ID);
    else {
      println("Database failed to connect");
      return;
    }
    this.ID = database.getInt("ID");
    name = database.getString("Name");
    mail = database.getString("Mail");
    money = database.getInt("Money");
  }

  void saveData(SQLite database, String name, int money) {
    this.name = name;
    this.money = money;
    if (database.connect())
      database.query("UPDATE User SET Name = '" + name + "', Money = " + money + " WHERE ID = " + ID);
    else {
      println("Database failed to connect");
      return;
    }
  }
}
