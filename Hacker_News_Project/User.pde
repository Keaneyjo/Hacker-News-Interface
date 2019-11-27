// User class by Thomas Keyes

class User {
  
  private String name;
  private int score;
  
  public User(String name, int score) {
    
    this.name = name;
    this.score = score;
    
  }
  
  public String getName() {
    
    
    return name;
    
  }
  
  public int getScore() {
    
    
    return score;
    
  }
  
  // Allows for the user's total score to be calculated
  public void addToScore(int inputScore) {
    
    
    score += inputScore;
    
  }  
  
  public String toString(){
    
    
    return name;
    
  }
  
}  
