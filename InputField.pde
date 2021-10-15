class InputField extends ButtonField {
  // Konstroktør
  // if statment

  InputField(PVector pos, PVector size, color col, String text, int textSize, color colClicked) {
    super(pos, size, col, text, textSize, colClicked);
  }

  String input = "";

  void display() {
    println(input);
    color col;
    String text;
    
    if(input == "")
      text = this.text;
    else
      text = input;
      
    if(isClicked)
      col = colClicked;
    else
      col = this.col;
    super.display(col, text);
  }

  void addInput(char c) {
    
    if (isClicked) {
      if(c != BACKSPACE || c != SHIFT)
        input += c;
      if(c == BACKSPACE)
        removeInput();
    }
    input.replace("AltGr","");
   /*for(int i = 0;i<=input.length();i++){
      if(input.charAt(i) == '?'){
        input.replace(charAt(i),"");
      }
    }*/
  }

  void removeInput() {
    if (input.length() > 0) {
      input = input.substring(0, input.length() - 1);
    }
  }
}
