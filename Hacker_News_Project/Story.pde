// Story class by Brian Farrell
//  4/4/2019  -  Better defined the text in ratios of screen size so that it works on several different resoltion - Finn Jaksland
class Story {
  float x, y, width, height;
  int score;
  String title, userName, url, date;
  color bannerColour, fontColour;  
  PImage upArrow;
  int[] kids;
  Widget userProfile, comment, URL, DATE;
  Widget[] widgetList = new Widget[4];
  Story(float x, float y, float width, float height, String title, color bannerColour, color fontColour, int score, String userName, int[] kids, String url, String date) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.score = score;
    this.title = title;
    this.kids = kids;
    this.url = url;
    this.bannerColour = color(240, 237, 187);
    this.fontColour = fontColour;
    this.userName = userName;
    this.date = date;
    // Adds all the widgets we need to make a story useable
    if (this.userName != null)
    {  
      userProfile = new Widget(x+50, y+75, 110 + textWidth(userName), 10, "By: "+ userName, 0, 255, EVENT_BUTTON1, SCREENX/96);
    }
    comment = new Widget(x+400, y+75, 90, 10, "comments", 0, 255, EVENT_BUTTON2, SCREENX/92);
    URL = new Widget(x, y+20, width, 10, url, 0, 255, EVENT_BUTTON3, SCREENX/92);
    DATE = new Widget(x+600, y+75, 20, 20, date, 0, 255, EVENT_BUTTON4, SCREENX/92);
  }


  void addWidgets()
  {  
    widgetList[0] = userProfile;
    widgetList[1] = comment;
    widgetList[2] = URL;
    widgetList[3] = DATE;
  }
  void mouseMoved() //Checks mouse movement for a specific story to highlight the widget that is being hovered.
  {
    int event = 0;
    for (int i = 0; i<widgetList.length; i++)
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
  void mousePressed() //Mouse pressed for a story
  {
    int event = 0;
    for (int i = 0; i<widgetList.length; i++)
    {
      Widget aWidget = widgetList[i];
      event = aWidget.getEvent(mouseX, mouseY);
      if (event == 1)
      {
        currentScreen = 3;
        currentUser = this.userName;
      }
      if (event == 2)
      {
        currentScreen = 4;
        commentStory = new Story(this.x, this.y, this.width, this.height, this.title, this.bannerColour, this.fontColour, this.score, this.userName, this.kids, this.url, this.date);
      }
      if (event == 3)
      {
        if (this.url.equals(""))
        {
          currentScreen = 4;
          commentStory = new Story(this.x, this.y, this.width, this.height, this.title, this.bannerColour, this.fontColour, this.score, this.userName, this.kids, this.url, this.date);
        } else
        {
          link(this.url);
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
    }
    return event;
  }
  public String getTitle()
  {
    return title;
  }

  public int[] getKids()
  {
    return kids;
  }

  void draw() 
  {
  //draws all of the stories widgets and its text.
    userProfile.draw();
    comment.draw();
    URL.draw();
    DATE.draw();
    fill(fontColour);
    textSize(20);
    text(title, x+width/16, y+height/2);
    fill(0);
    text(score, x - 25, y+1*height/2);
  }
  
}
