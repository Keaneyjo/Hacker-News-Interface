// Code by Thomas Keyes

class Post {
   
   private int[] kids;
   private int descendants;
   private String url;
   private String title;
   private String text;
   private String author;
   private int score;
   private int time;
   private String type;
   private int id;
   
  // Constructor for stories 
  
  public Post (int[] kids, int descendants, String url, String title, String author, int score, int time, int id) {
    
    this.kids = kids;
    this.descendants = descendants;
    this.url = url;
    this.title = title;
    this.author = author;
    this.score = score;
    this.time = time;
    this.type = "story";
    this.id = id;
    
  }
  
  // Constructor for comments
  
  public Post (int kids[], int descendants, String text, String author, int time, int id) {
    
    this.kids = kids;
    this.descendants = descendants;
    this.url = "";
    this.text = text;
    this.author = author;
    this.score = 0;
    this.time = time;
    this.type = "comment";
    this.id = id;
    
    
  }

  
  public int[] getKids() {
    return kids;  
  }
  
  public int getDescendants() {
    
    return descendants;  
  }
  
  public String getTitle() {
    return title;
  }
  
  public String getText() {
    
    return text;
  }
  
  public String getURL(){
    
    return url;
    
  }
  
  public String getAuthor(){
    
    return author;
    
  }
  
  public int getScore() {
    
    return score;
    
  }
  
  public int getTime() {
    
    return time;  
  }
  
  public String getTimeString() {
    
    Date date = new Date((long)time * 1000);
    return date.toString();  
    
 }
  
  public String getType() {
    return type;  
  }
  
   public int getID() {
    
    return id;
    
  }
  
  public String toString(){
    
    return author;
    
  }
  
}
