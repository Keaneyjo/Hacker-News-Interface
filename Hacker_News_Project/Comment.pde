//Comment class by Brian, very similar to stories class but needs some different things 

class Comment {
  float x, y, width, height;
  String userName, text;
  color bannerColour, fontColour;  
  PImage upArrow;
  int[] kids;
  int score;
  ArrayList<Comment> replyList;
  Widget userProfile, replies;
  Widget[] widgetList = new Widget[2];
  Comment comment1;
  Comment(float x, float y, float width, float height, String text, color bannerColour, color fontColour, int score, String userName, int[]kids) {
    this.x = x;
    this.y = y;
    this.bannerColour = color(240, 237, 187);
    this.fontColour = fontColour;
    this.userName = userName;
    this.kids = kids;
    this.text = text;
    this.score = score;
    userProfile = new Widget(x+50, y+75, 30, 10, "Username: "+ userName, 0, 255, EVENT_BUTTON1, SCREENX/96);
    replies = new Widget(x+250, y+75, 30, 10, "Replies", 0, 255, EVENT_BUTTON2, SCREENX/96);
  }


  void addWidgets()
  {  
    widgetList[0] = userProfile;
    widgetList[1] = replies;
  }
  //This aligns the text in a comment so that it does not go off the screen, every 100 characters it inserts "\n" in order to create a new line
  void fixText() 
  {
    boolean loop = true;
    int breakpoint = 100;
    if (this.text != null)
    {
      while (loop)
      {
        if (this.text.length() > breakpoint)
        {
          this.text = this.text.substring(0, breakpoint) + "\n" + this.text.substring(breakpoint, this.text.length());
        }
        breakpoint+=100;
        if (this.text.length() < breakpoint)
        {
          loop = false;
        }
      }
    }
  }
  int getEvent(int x, int y)
  {
    int event = 0;
    for (int i = 0; i<widgetList.length; i++)
    {
      Widget aWidget = widgetList[i];
      event = aWidget.getEvent(x, y);
      if (event == 1)
      {
        currentScreen = 3;
        currentUser = userName;
      }
    }
    return event;
  }

  public int[] getKids()
  {
    return kids;
  }
  public String getText()
  {
    return text;
  }
  void mouseMoved()
  {
    int event = 0;
    for (int i = 0; i<widgetList.length; i++) //goes through the list of widgets and highlights whichever one has been pressed
    {
      Widget aWidget = widgetList[i];
      event = aWidget.getEvent(mouseX, mouseY);
      if (event > 0)
      {
        aWidget.labelColor = color(0, 100, 200);
      } else
      {
        aWidget.labelColor = 0;
        aWidget.drawURL = false;
      }
      if (event == 3)
      {
        aWidget.drawURL = true;
      }
    }
  }

  void mousePressed()
  {
    int event = 0;
    for (int i = 0; i<widgetList.length; i++)
    {
      Widget aWidget = widgetList[i];
      event = aWidget.getEvent(mouseX, mouseY);
      if (event == 1) //this event indicates we have clicked a username so we move to their profile
      {
        currentScreen = 3;
        currentUser = this.userName;
      }
      if (event == 2) // we have opened to replies of a comment so we get all the replies and move to the reply page
      {
        currentScreen = 6; 
        currentComment = new Comment (this.x, this.y, this.height, this.width, this.text, this.bannerColour, this.fontColour, this.score, this.userName, this.kids);
      }
    }
  }
  void draw() {
    userProfile.draw();
    replies.draw();
    fill(fontColour);
    textSize(SCREENX/80);    
    if (text != null)
    {
      text(text, x+400, y);
    }
  }
}
