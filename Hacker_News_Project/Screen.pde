
//  28/3/2019: Top users page now more prettier. Has a Pi Chart and labeled names - Finn Jaksland
//  4/4/2019: Added in beta code for profile pics - Finn Jaksland
//  5/4/2019: Added in bargraph slide


// Screen class and all subclasses made by Brian, slideSearchMove() by John
// SearchScreen class code by John Keaney
// KeyPressed() function by John Keaney
public String searchInput = "";


public static int searchBarImageXpos = SCREENWIDTH - 89;
public static int searchBarImageXpos2 = searchBarImageXpos+26;
public static int searchBarImageYpos = SEARCHWIDGET_YPOS + 5;

public static int searchBarLineXpos = searchBarImageXpos2;
public static int searchBarLineYpos = SEARCHWIDGET_YPOS + 7;
public static int searchBarLineYpos_2 = searchBarLineYpos + 43;
public static int searchBarLineSize = 0;
//Main screen that all screen subclasses are based on
class Screen {
  color bgColor, buttonColor1, buttonColor2;
  Widget topButton, bottomButton, checkBox, checkBox2, radio, radio2, slider;
  String label1, label2;
  ArrayList widgetList;
  ArrayList storyList;
  Story story1;
  Comment comment1;
  BarGraph aBarGraph;
  PiChart aPiChart;
  String bigNames = " ";
  int cursorCounter = 0;
  int searchInputYPos = 147;
  Screen(color bgColor, String label1, String label2, color buttonColor1, color buttonColor2)
  {
    this.bgColor= bgColor;
    this.label1 = label1;
    this.label2 = label2;
    this.buttonColor1 = buttonColor1;
    this.buttonColor2 = buttonColor2;
  }
  void createGraph()
  {
  }
  void addStory(ArrayList<Post> posts) 
  {
  }
  void mousePressed()
  {
  }
  void draw() 
  {
  }
  void mouseMoved()
  {
  }
  void setTop(String topComment)
  {
  }

  // SlideSearchMove function by John Keaney
  // Draws search widget, determines if search widget has been selected and adjusts search widgets length
  void slideSearchMove()
  {
    if (slideSearch == false)      // If not selected search bar will remain descended
    {
      // Returns all positions to normal
      searchBarImageXpos = SCREENWIDTH - 89;        
      searchBarImageXpos2 = searchBarImageXpos+26;
      searchBarLineSize = 0;
      searchWidgetWidth = -100;
    } else if (slideSearch == true)  // Else will add to search bars length
    {
      if (searchWidgetWidth > SEARCH_BAR_MAX)  // Unless the searchBar has finished scrolling it continues to do so.
      {
        searchWidgetWidth = searchWidgetWidth - SEARCH_BAR_SPEED;    // Scroll the searchWidgets backgrounf rect() across the page.
        searchBarImageXpos = searchBarImageXpos - SEARCH_BAR_SPEED;  // Scrolls the searchIcon across the page.
        searchBarLineSize = searchBarLineSize - SEARCH_BAR_SPEED;    // Increase (as in makes decrease larger) the searchBarLine length.
      }
    }
    fill(BLACK_COLOR);    //Search bar colour
    searchWidget.draw();
    rect(SEARCHWIDGET_XPOS, SEARCHWIDGET_YPOS, searchWidgetWidth, SEARCHWIDGET_HEIGHT);
    rect(SEARCHWIDGET_XPOS, SEARCHWIDGET_YPOS, searchWidgetWidthMax, SEARCHWIDGET_HEIGHT);

    fill(255);
    stroke(BLACK_COLOR);
    rect(searchBarLineXpos, searchBarLineYpos, searchBarLineSize, 8);      // Magnifying Glass Lines
    rect(searchBarLineXpos, searchBarLineYpos_2, searchBarLineSize, 7);      // Magnifying Glass Line 2

    image(searchBarFirstFrame, searchBarImageXpos, searchBarImageYpos);      // Magnifying Glass Image 1
    image(searchBarFirstFrameSecondHalf, searchBarImageXpos2, searchBarImageYpos);  // Magnifying Glass Image 2

    if (slideSearch == true && searchWidgetWidth < SEARCH_BAR_MAX)    // Search bars length is increased till it reaches max length and from there user can type searchInput
    {
      textSize(24);
      text(searchInput, (SCREENX/15 + 65), searchInputYPos);    // displays searchInput
      cursorCounter+= .5;
      println(cursorCounter);
      if (cursorCounter % 10 == 0)
      {
        text("|", (SCREENX/15 + 65 + textWidth(searchInput)), searchInputYPos);     // displays cursor for searchInput
      }
    }
  }

  // KeyPressed() function by John Keaney
  // 4/9/2019 - Fixed backspace issue. Catched null inputs and raises an exception to correct this. Does the same for index out of bounds exception. - John Keaney
  // Search bar now works for all screens and is present on all screens. - John Keaney
  void keyPressed()
  {
    if (slideSearch == true)
    {
      if (key == ENTER)
      {
        ArrayList<Post> resultsPosts =  searchPosts(searchInput);
        for (int i = 0; i < resultsPosts.size(); i++)
        {
          if ("story".equals(resultsPosts.get(i).getType()))
          {
            println(resultsPosts.get(i).getTitle());
          }
          currentScreen = 5;
          searchScreen = new searchScreen(0, "", "", 0, 0, resultsPosts);
          searchScreen.addStory(resultsPosts);
        }
      } else if (key == BACKSPACE)
      {
        try
        {
          searchInput = searchInput.substring(0, searchInput.length()-1);
        }
        catch (Exception StringIndexOutOfBoundsException)
        {
          searchInput = "";
        }
      } else
        searchInput = searchInput + key;
    }
  }

  //mainScreenDraw by John Keaney
  void mainScreenDraw()
  {
    background(255);
    fill(0);
    textSize(24);
    textSize(SCREENX/40);
  }
}
//Home Screen, the main screen that is drawn at the start and is the base of the program. By Brian Farrell
class homeScreen extends Screen
{
  int counter = 0;
  float gap = 1;
  Widget TopUsers, HomePage, Trending, Next, Previous, top, newest, oldest;
  dropDown sort;
  Widget[] widgetList = new Widget[7];
  homeScreen(color bgColor, String label1, String label2, color buttonColor1, color buttonColor2)
  {
    super(bgColor, label1, label2, buttonColor1, buttonColor2);
    this.gap = 1;
  }  
  //takes in an ArrayList of posts and creates the widgets needed for the screen and the stories to display
  void addStory(ArrayList<Post> posts) 
  {
    //Creates and adds all of the screens widgets.
    TopUsers = new Widget(SCREENX/1.3, SCREENY/15, SCREENX/8.4, SCREENY/15, "Top Users", 0, 0, 2, SCREENX/40);
    HomePage = new Widget(SCREENX/2.4, SCREENY/15, SCREENX/7.4, SCREENY/15, "Home Page", 0, 0, 1, SCREENX/40);
    Next = new Widget(SCREENX/1.1, SCREENY/1.1, SCREENX/20, SCREENY/30, "Next", 0, 0, 4, SCREENX/80);
    Previous = new Widget(SCREENX/1.2, SCREENY/1.1, SCREENX/20, SCREENY/30, "Previous", 0, 0, 5, SCREENX/80);
    top = new Widget(SCREENX/1.3, SCREENY/5, 80, 30, "Top", 0, 0, 6, SCREENX/80);
    newest = new Widget(SCREENX/1.15, SCREENY/5, 80, 30, "New", 0, 0, 7, SCREENX/80);
    oldest = new Widget(SCREENX/1.05 + 10, SCREENY/5, 80, 30, "Oldest", 0, 0, 8, SCREENX/80);
    widgetList[0] = HomePage;
    widgetList[1] = TopUsers;
    widgetList[2] = Next;
    widgetList[3] = Previous;
    widgetList[4] = top;
    widgetList[5] = newest;
    widgetList[6] = oldest;
    storyList = new ArrayList();
    //Creates and adds the 8 stories to display
    for (int i = 0; i < posts.size(); i++)
    {
      if ("story".equals(posts.get(i).getType()))
      {
        if (counter > 7) {        
          gap = 1;
          counter = 0;
        }
        story1 = new Story(SCREENX/20, (SCREENY/9*gap) + 60, SCREENX/1.92, SCREENY/13.5, posts.get(i).getTitle(), 200, 0, posts.get(i).getScore(), posts.get(i).getAuthor(), posts.get(i).getKids(), posts.get(i).getURL(), posts.get(i).getTimeString());
        story1.addWidgets();
        storyList.add(story1);
        counter++;
        gap += .9;
      }
    }
  }
  void mouseMoved() 
  {
    int event;
    for (int i = 0; i<widgetList.length; i++) {
      Widget aWidget = (Widget)widgetList[i];
      event = aWidget.getEvent(mouseX, mouseY);

      if (event > 0) {
        aWidget.labelColor = color(0, 100, 200);
      } else
      {
        aWidget.labelColor = 0;
      }
    }
    for (int i =  startDisplay; i<endDisplay; i++)
    {
      Story aStory = (Story)storyList.get(i);
      aStory.mouseMoved();
    }
  }
  void draw() {
    mainScreenDraw();                // Draws main Screen background
    slideSearchMove();               // Draws search bar
    fill(STEEL_GREY_COLOR);          // left Side Rectangle
    rect(0, 0, SCREENX/15, SCREENY); // left Side Rectangle                    
    fill(STEEL_GREY_COLOR);          // left Side Rectangle
    rect(0, 0, SCREENX/15, SCREENY); // left Side Rectangle
    if (storyList != null)           //Draws the screens stories
    {
      for (int i = startDisplay; i < storyList.size() && i < endDisplay; i++) {
        Story aStory = (Story)storyList.get(i);
        aStory.draw();
      }
    }
    stroke(0);                       
    fill(LIGHT_BLUE_COLOR);             
    rect(0, 0, SCREENX, SCREENY/10); 
    fill(255);
    if (widgetList != null) //Draws the screens widgets
    {
      for (int i = 0; i<widgetList.length; i++)
      {
        Widget aWidget = (Widget)widgetList[i];
        aWidget.draw();
      }
    }
    slideSearchMove();
  }
  void mousePressed()
  {
    int event;

    for (int i = 0; i < widgetList.length; i++)
    {
      Widget aWidget = widgetList[i];
      event = aWidget.getEvent(mouseX, mouseY);
      switch(event) {
      case EVENT_BUTTON1:
        currentScreen = 1; //Homescreen
        break;
      case EVENT_BUTTON2:
        currentScreen = 2; //Top Users screen
        break;
      case EVENT_BUTTON4: //Next page button, load next 8 stories
        startDisplay += 8;
        endDisplay += 8;
        break;
      case EVENT_BUTTON5: //Previous page button, last 8 stories.
        if (startDisplay >= 8)
        {
          startDisplay -= 8;
          endDisplay -= 8;
        }
        break;
      case EVENT_BUTTON6: //Sort posts by Top Score
        for (int j = 0; j < 4; j++)
        {
          storyList.clear();
          arrangePostsByScore();
          theHomeScreen.addStory(postsByID);
          startDisplay = 0;
          endDisplay = 8;
          this.gap = 1;
        }
        break;
      case EVENT_BUTTON7: //Sort posts by newest
        for (int j = 0; j < 4; j++)
        {
          storyList.clear();
          arrangePostsByLatest();
          theHomeScreen.addStory(postsByID);
          startDisplay = 0;
          endDisplay = 8;
          this.gap = 1;
        }
        break;
      case EVENT_BUTTON8: //Sort posts by oldest
        for (int j = 0; j < 4; j++)
        {
          storyList.clear();
          arrangePostsByOldest();
          theHomeScreen.addStory(postsByID);
          startDisplay = 0;
          endDisplay = 8;
          this.gap = 1;
        }
        break;
      }
    }
    for (int i =  startDisplay; i<endDisplay; i++)
    {
      Story aStory = (Story)storyList.get(i);
      aStory.mousePressed();
    }
  }
}
//Top users page by, Screen designed by Brian, charts and layout all done by Finn.
class topUserPage extends Screen
{

  Widget TopUsers, HomePage, Trending;
  Widget[] widgetList = new Widget[3];
  int[] topUsers;
  boolean initialSlide = false;
  topUserPage(color bgColor, String label1, String label2, color buttonColor1, color buttonColor2, int[] array)
  {
    super(bgColor, label1, label2, buttonColor1, buttonColor2);
    this.topUsers = array;
  }
  void createGraph() //adds the graph we want to the screen
  {
    aBarGraph =  new BarGraph(topUsers, SCREENY/1.5, SCREENX, SCREENY/4, 0);

    aPiChart = new PiChart(topUsers, SCREENX/3, SCREENX/2, SCREENY/4);
  }
  void addStory(ArrayList<Post> posts) {

    //creates the widgets for the screen
    HomePage = new Widget(SCREENX/2.4, SCREENY/15, SCREENX/2.4, SCREENY/15, "Home Page", 255, 0, 1, SCREENX/40);
    TopUsers = new Widget(SCREENX/1.3, SCREENY/15, SCREENX/8.4, SCREENY/15, "Top Users", 0, 0, 2, SCREENX/40);
    Trending = new Widget(SCREENX/8.4, SCREENY/15, SCREENX/8.4, SCREENY/15, "Top Topics", 0, 0, 3, SCREENX/40);
    widgetList[0] = HomePage;
    widgetList[1] = TopUsers;
    widgetList[2] = Trending;
  }
  void mousePressed()
  {
    int event;

    for (int i = 0; i < widgetList.length; i++)
    {
      Widget aWidget = widgetList[i];
      event = aWidget.getEvent(mouseX, mouseY);
      switch(event) {
      case EVENT_BUTTON1:
        currentScreen = 1;
        aPiChart.resetChart();
        //println(event);
        break;
      case EVENT_BUTTON2:
        currentScreen = 2;
        aPiChart.resetChart();
        //println(event);
        break;
      }
    }
  }

  void draw() {
    if (initialSlide == false)
    {
      aBarGraph.slide();
      aPiChart.slide();
      initialSlide = true;
    }

    if ((mouseX>=aPiChart.getX() && mouseX <=(aPiChart.getX() + aPiChart.getDiameter())) && ((mouseY >= aPiChart.getY()) && mouseY<= aPiChart.getY() + aPiChart.getDiameter()))
    {
      aPiChart.resetVelocity();
    }
    background(255);
    stroke(0);
    aBarGraph.sliding();
    aPiChart.sliding();
    if (!aPiChart.isSpace())
    {
      aBarGraph.drawChartHorizontal();
    }
    if (!aPiChart.isSliding()&&!aPiChart.isSpace())
    {
      if (aBarGraph.mouseOverHorizontal() == -1)
      {
        aPiChart.drawChart();
      } else
      {

        aPiChart.isolate(aBarGraph.mouseOverHorizontal());
      }
    } else
    {
      aPiChart.drawChart();
    }
    fill(0);
    textSize(30);
    text(bigNames, 140, 400);
    fill(70, 130, 180);
    rect(0, 0, SCREENX, SCREENY/10); 
    if ((aBarGraph.isSliding() == false)&& (!aPiChart.isSpace()))
    {
      for (int i = 0; i <aBarGraph.getLength(); i++)
      {
        fill(200);
        text(users.get(i).getScore() + " - "+ users.get(i), aBarGraph.getBarHeight(i)+aBarGraph.getSpacing()/3, aBarGraph.getYVertical(i) + 3*aBarGraph.getSpacing()/4);
      }
    } else if (aPiChart.isSpace())
    {
      textSize(100);
      fill(200);
      text("  CREATED BY:\n  John Keaney\n  Brian Farrell\n  Thomas Keyes\n  Finn Jaksland", 0, SCREENY/3);
    }

    fill(255);
    stroke(0);
    fill(0);
    textSize(24);
    fill(0);
    if (widgetList != null)
    {
      for (int i = 0; i<widgetList.length; i++)
      {
        Widget aWidget = widgetList[i];
        aWidget.draw();
      }
    }
  }

  void mouseMoved() {
    int event;
    for (int i = 0; i<widgetList.length; i++) {
      Widget aWidget = (Widget)widgetList[i];
      event = aWidget.getEvent(mouseX, mouseY);

      if (event > 0) {
        aWidget.labelColor = color(0, 100, 200);
        println("over");
      } else
      {
        aWidget.labelColor = 0;
      }
    }
  }
}
//ProfilePage screen made by Brian
class profilePage extends Screen
{
  Widget TopUsers, HomePage, Trending;
  Widget[] widgetList = new Widget[2];
  PImage profilePic1, profilePic2, profilePic3, profilePic4, profilePic5, profilePic6, profilePic7, profilePic8, profilePic9, profilePic0, paulG, phyllis;

  int totalScore;
  boolean profileInverter = darkMode;

  profilePage(color bgColor, String label1, String label2, color buttonColor1, color buttonColor2)
  {
    super(bgColor, label1, label2, buttonColor1, buttonColor2);

    profilePic0  = loadImage("profilePic0.jpg");

    profilePic1  = loadImage("profilePic1.jpg");

    profilePic2  = loadImage("profilePic2.jpg");

    profilePic3  = loadImage("profilePic3.jpg");

    profilePic4  = loadImage("profilePic4.jpg");

    profilePic5  = loadImage("profilePic5.jpg");

    profilePic6  = loadImage("profilePic6.jpg");

    profilePic7  = loadImage("profilePic7.jpg");

    profilePic8  = loadImage("profilePic8.jpg");

    profilePic9  = loadImage("profilePic9.jpg");


    phyllis = loadImage("phyllis.jpg");

    paulG = loadImage("paulG.jpg");
  }


  void addStory(ArrayList<Post> posts) 
  {
    //creates the screens widgets
    totalScore = 0;
    HomePage = new Widget(SCREENX/2.4, SCREENY/15, SCREENX/7.4, SCREENY/15, "Home Page", 0, 0, 1, SCREENX/40);
    TopUsers = new Widget(SCREENX/1.3, SCREENY/15, SCREENX/8.4, SCREENY/15, "Top Users", 0, 0, 2, SCREENX/40);
    widgetList[0] = HomePage;
    widgetList[1] = TopUsers;
    //takes in an array of every post made by the user and creates a story for each one
    if (posts != null)
    {
      storyList = new ArrayList();
      int gap = 1;
      for (int i = 0; i < posts.size(); i++)
      {
        if ("story".equals(posts.get(i).getType()))
        {
          if (!"none".equals(posts.get(i).getTitle()))
          {
            story1 = new Story(SCREENX/4.8 - 30, (SCREENY/9*gap) + 60, SCREENX/1.92, SCREENY/13.5, posts.get(i).getTitle(), 200, 0, posts.get(i).getScore(), posts.get(i).getAuthor(), posts.get(i).getKids(), posts.get(i).getURL(), posts.get(i).getTimeString());
            story1.addWidgets();
            storyList.add(story1);
            gap += 1;
          }
        }
      }
      //adds the scores to get the users total score
      for (int i = 0; i < posts.size(); i++)
      {
        totalScore += posts.get(i).getScore();
      }
    }
  }



  void draw() {

    background(255);

    fill(255);
    stroke(0);
    fill(0);
    textSize(40);
    fill(255);
    fill(STEEL_GREY_COLOR);          // left Side Rectangle
    rect(0, 0, SCREENX/15, SCREENY); // left Side Rectangle

    int minus = 100;
    rect(SCREENWIDTH - 250 -minus, 180, 300, 300);
    fill(0);
    text(currentUser, SCREENWIDTH - 195 - minus, 215);
    if (profileInverter != darkMode) {
      paulG.filter(INVERT);
      phyllis.filter(INVERT);
      profilePic0.filter(INVERT);
      profilePic1.filter(INVERT);
      profilePic2.filter(INVERT);
      profilePic3.filter(INVERT);
      profilePic4.filter(INVERT);
      profilePic5.filter(INVERT);
      profilePic6.filter(INVERT);
      profilePic7.filter(INVERT);
      profilePic8.filter(INVERT);
      profilePic9.filter(INVERT);
      profileInverter = darkMode;
    }
    if ("pg".equals(currentUser)) {

      image(paulG, SCREENWIDTH - 200 - minus, 225);
    } else if ("phyllis".equals(currentUser))
    {
      image(phyllis, SCREENWIDTH - 200 - minus, 225);
    } else {

      switch(totalScore % 10) {

      case 0:
        image(profilePic0, SCREENWIDTH - 200 - minus, 225);

        break;
      case 1:
        image(profilePic1, SCREENWIDTH - 200 - minus, 225);

        break;
      case 2:
        image(profilePic2, SCREENWIDTH - 200 - minus, 225);

        break;
      case 3:
        image(profilePic3, SCREENWIDTH - 200 - minus, 225);

        break;
      case 4:
        image(profilePic4, SCREENWIDTH - 200 - minus, 225);

        break;
      case 5:
        image(profilePic5, SCREENWIDTH - 200 - minus, 225);

        break;
      case 6:
        image(profilePic6, SCREENWIDTH - 200 - minus, 225);

        break;
      case 7:
        image(profilePic7, SCREENWIDTH - 200 - minus, 225);

        break;
      case 8:
        image(profilePic8, SCREENWIDTH - 200 - minus, 225);

        break;
      case 9:
        image(profilePic9, SCREENWIDTH - 200 - minus, 225);

        break;
      }
    }

    textSize(30);
    text("Total Score: " + totalScore, SCREENWIDTH - 215 - minus, 470);
    //draws all of the users stories
    if (storyList != null)
    {
      for (int i = 0; i<storyList.size(); i++) {
        Story aStory = (Story)storyList.get(i);
        aStory.draw();
      }
    }
    fill(LIGHT_BLUE_COLOR);
    rect(0, 0, SCREENX, SCREENY/10); 
    fill(255);
    stroke(0);
    fill(0);
    textSize(24);
    textSize(40);
    fill(255);

    slideSearchMove();
    fill(STEEL_GREY_COLOR);          // left Side Rectangle
    rect(0, 0, SCREENX/15, SCREENY); // left Side Rectangle
    fill(70, 130, 180);
    rect(0, 0, SCREENX, SCREENY/10);
    //draws the screens widgets
    if (widgetList != null)
    {
      for (int i = 0; i<widgetList.length; i++)
      {
        Widget aWidget = (Widget)widgetList[i];
        if (aWidget !=null)
        {
          aWidget.draw();
        }
      }
    }
  }
  void mouseMoved() 
  {
    int event;
    for (int i = 0; i<widgetList.length; i++) {
      Widget aWidget = (Widget)widgetList[i];
      event = aWidget.getEvent(mouseX, mouseY);

      if (event > 0) {
        aWidget.labelColor = color(0, 100, 200);
      } else
      {
        aWidget.labelColor = 0;
      }
    }
    if (storyList != null)
    {
      for (int i =  0; i < storyList.size(); i++)
      {
        Story aStory = (Story)storyList.get(i);
        aStory.mouseMoved();
      }
    }
  }
  void mousePressed()
  {
    int event;

    for (int i = 0; i < widgetList.length; i++)
    {
      Widget aWidget = widgetList[i];
      event = aWidget.getEvent(mouseX, mouseY);
      switch(event) {
      case EVENT_BUTTON1:
        currentScreen = 1;
        break;
      case EVENT_BUTTON2:
        currentScreen = 2;
        break;
      case EVENT_BUTTON4:

        startDisplay += 16;
        endDisplay += 16;

        break;
      case EVENT_BUTTON5:
        if (startDisplay >=16)
        {
          startDisplay -= 16;
          endDisplay -=16 ;
        }
      }
    }
    if (storyList != null)
    {
      for (int i = 0; i< storyList.size(); i++)
      {
        Story aStory = (Story)storyList.get(i);
        aStory.mousePressed();
      }
    }
  }
}

//Comment Page Screen by Brian.
class commentPage extends Screen
{
  Widget TopUsers, HomePage, Trending;
  Widget[] widgetList = new Widget[3];
  commentPage(color bgColor, String label1, String label2, color buttonColor1, color buttonColor2)
  {
    super(bgColor, label1, label2, buttonColor1, buttonColor2);
  }  
  void addStory(ArrayList<Post> posts) 
  {
    HomePage = new Widget(SCREENX/2.4, SCREENY/15, SCREENX/7.4, SCREENY/15, "Home Page", 0, 0, 1, SCREENX/40);
    TopUsers = new Widget(SCREENX/1.3, SCREENY/15, SCREENX/8.4, SCREENY/15, "Top Users", 0, 0, 2, SCREENX/40);
    Trending = new Widget(SCREENX/8.4, SCREENY/15, SCREENX/8.4, SCREENY/15, "Top Topics", 0, 0, 3, SCREENX/40);
    widgetList[0] = HomePage;
    widgetList[1] = TopUsers;
    widgetList[2] = Trending;
    storyList = new ArrayList();
    int gap = 3;
    if (posts != null)
    {
      for (int i = 0; i < posts.size(); i++)
      {
        comment1 = new Comment(SCREENX/20, (SCREENY/9*gap)+ 60, SCREENX/1.92, SCREENY/13.5, posts.get(i).getText(), 200, 0, posts.get(i).getScore(), posts.get(i).getAuthor(), posts.get(i).getKids());
        comment1.addWidgets(); //add the comments widgets
        comment1.fixText(); //fix the comments text
        storyList.add(comment1);
        gap += 3;
      }
    }
  }

  void draw()
  {
    background(255);
    fill(STEEL_GREY_COLOR);          // left Side Rectangle
    rect(0, 0, SCREENX/15, SCREENY); // left Side Rectangle
    if (storyList != null)
    {
      for (int i = 0; i<storyList.size(); i++) {
        Comment aComment = (Comment)storyList.get(i);
        aComment.draw();
      }
    }
    fill(LIGHT_BLUE_COLOR);
    rect(0, 0, SCREENX, SCREENY/10); 
    if (widgetList != null)
    {
      for (int i = 0; i<widgetList.length; i++)
      {
        Widget aWidget = (Widget)widgetList[i];
        aWidget.draw();
      }
    }
    rect(SCREENX/15, SCREENY/10, (SCREENX - SCREENX/15), 100);
    fill(255);
    text(commentStory.title, 200, 170);
    fill(0);
  }
  void mouseMoved() 
  {
    int event;
    for (int i = 0; i<widgetList.length; i++) {
      Widget aWidget = (Widget)widgetList[i];
      event = aWidget.getEvent(mouseX, mouseY);

      if (event > 0) {
        aWidget.labelColor = color(0, 100, 200);
      } else
      {
        aWidget.labelColor = 0;
      }
    }
    if (storyList!=null)
    {
      for (int i =  0; i< storyList.size(); i++)
      {
        Comment aComment = (Comment)storyList.get(i);
        aComment.mouseMoved();
      }
    }


    fill(255);
    stroke(0);
    //rect(600,200,500,200);
  }
  void mousePressed()
  {
    int event;
    for (int i = 0; i < widgetList.length; i++)
    {
      Widget aWidget = widgetList[i];
      event = aWidget.getEvent(mouseX, mouseY);
      switch(event) {
      case EVENT_BUTTON1:
        currentScreen = 1;
        // println(event);
        break;
      case EVENT_BUTTON2:
        currentScreen = 2;

        //println(event);
        break;
      }
    }
    for (int i =  0; i<storyList.size(); i++)
    {
      if (storyList != null)
      {
        Comment aComment = (Comment)storyList.get(i);
        aComment.mousePressed();
      }
    }
  }
}



// SearchScreen class by John Keaney - 3/4/2019
class searchScreen extends Screen    // Screen class specifically for searches.
{
  Widget TopUsers, HomePage, Trending;  // Title card widgets
  Widget[] widgetList = new Widget[3];  // Array of title card widgets
  searchScreen(color bgColor, String label1, String label2, color buttonColor1, color buttonColor2, ArrayList<Post> resultsPosts)
  {
    super(bgColor, label1, label2, buttonColor1, buttonColor2);
  }  
  void addStory(ArrayList<Post> resultsPosts) 
  {
    HomePage = new Widget(SCREENX/2.4, SCREENY/15, SCREENX/2.4, SCREENY/15, "Home Page", 0, 0, 1, SCREENX/40);
    TopUsers = new Widget(SCREENX/1.3, SCREENY/15, SCREENX/1.3, SCREENY/15, "Top Users", 0, 0, 2, SCREENX/40);
    Trending = new Widget(SCREENX/8.4, SCREENY/15, SCREENX/8.4, SCREENY/15, "Top Topics", 0, 0, 3, SCREENX/40);
    widgetList[0] = HomePage;
    widgetList[1] = TopUsers;
    widgetList[2] = Trending;
    storyList = new ArrayList();
    float gap = 1;
    for (int i = 0; i < 8; i++)
    {
      if (resultsPosts.get(i).getType().equals("story"))
      {
        story1 = new Story(SCREENX/4.8, (SCREENY/9*gap)+ 60, SCREENX/1.92, SCREENY/13.5, resultsPosts.get(i).getTitle(), 200, 0, resultsPosts.get(i).getScore(), //Adds the elements of
          resultsPosts.get(i).getAuthor(), resultsPosts.get(i).getKids(), resultsPosts.get(i).getURL(), resultsPosts.get(i).getTimeString());                        // all the stories
        story1.addWidgets();                                                                                                                                           // Places these in an ArrayList
        storyList.add(story1);                                                                                                                                          
        gap += .9;                                                                                                                                                     // Increments spacing
      }
    }
  }

  void draw()
  {
    mainScreenDraw();                // function to draw majority of similar screen for all classes
    stroke(0);                       // left Side Rectangle
    fill(STEEL_GREY_COLOR);          // left Side Rectangle
    rect(0, 0, SCREENX/15, SCREENY); // left Side Rectangle

    fill(LIGHT_BLUE_COLOR);          // Title banner
    rect(0, 0, SCREENX, SCREENY/10); // Title banner

    if (storyList != null)           // Loops to display stories
    {
      for (int i = 0; i<storyList.size(); i++) {
        Story aComment = (Story)storyList.get(i);
        aComment.draw();
      }
    }
    if (widgetList != null)        // Loops to display title cards
    {
      for (int i = 0; i<widgetList.length; i++)
      {
        Widget aWidget = (Widget)widgetList[i];
        aWidget.draw();
      }
    }
    slideSearchMove();              // Draws search widget, determines if search widget has been selected and adjusts search widgets length
  }

  void mousePressed()
  {
    int event;

    for (int i = 0; i < widgetList.length; i++)
    {
      Widget aWidget = widgetList[i];
      event = aWidget.getEvent(mouseX, mouseY);
      switch(event) {
      case EVENT_BUTTON1:
        currentScreen = 1;
        //println(event);
        break;
      case EVENT_BUTTON2:
        currentScreen = 2;
        //println(event);
        break;
      case EVENT_BUTTON4:

        startDisplay += 16;
        endDisplay += 16;

        break;
      case EVENT_BUTTON5:
        if (startDisplay >=15)
        {
          startDisplay -= 16;
          endDisplay -=16 ;
        }
      }
    }
    for (int i =  startDisplay; i<storyList.size(); i++)
    {
      Story aStory = (Story)storyList.get(i);
      aStory.mousePressed();
    }
  }
}
//Comment replies screen by Brian.
class commentReplies extends Screen
{
  Widget TopUsers, HomePage, Trending;
  Widget[] widgetList = new Widget[3];
  String topComment;
  commentReplies(color bgColor, String label1, String label2, color buttonColor1, color buttonColor2)
  {
    super(bgColor, label1, label2, buttonColor1, buttonColor2);
  }  


  void addStory(ArrayList<Post> posts) 
  {
    HomePage = new Widget(SCREENX/2.4, SCREENY/15, SCREENX/7.4, SCREENY/15, "Home Page", 0, 0, 1, SCREENX/40);
    TopUsers = new Widget(SCREENX/1.3, SCREENY/15, SCREENX/8.4, SCREENY/15, "Top Users", 0, 0, 2, SCREENX/40);
    Trending = new Widget(SCREENX/8.4, SCREENY/15, SCREENX/8.4, SCREENY/15, "Top Topics", 0, 0, 3, SCREENX/40);
    widgetList[0] = HomePage;
    widgetList[1] = TopUsers;
    widgetList[2] = Trending;
    storyList = new ArrayList();
    int gap = 6;
    if (posts != null)
    {
      for (int i = 0; i < posts.size(); i++)
      {
        comment1 = new Comment(SCREENX/20, (SCREENY/9*gap)+ 60, SCREENX/1.92, SCREENY/13.5, posts.get(i).getText(), 200, 0, posts.get(i).getScore(), posts.get(i).getAuthor(), posts.get(i).getKids());
        comment1.addWidgets();
        comment1.fixText();
        storyList.add(comment1);
        gap += 3;
        println(comment1.text);
      }
    }
  }

  void setTop(String topComment)
  {
    this.topComment = topComment;
  }

  void draw()
  {
    background(255);                 // Draws white background
    fill(STEEL_GREY_COLOR);          // left Side Rectangle
    rect(0, 0, SCREENX/15, SCREENY); // left Side Rectangle
    textSize(30);

    if (storyList != null)
    {
      for (int i = 0; i<storyList.size(); i++) {
        Comment aComment = (Comment)storyList.get(i);
        aComment.draw();
        text(topComment, 200, 160);
      }
    }

    fill(LIGHT_BLUE_COLOR);
    rect(0, 0, SCREENX, SCREENY/10); 
    if (widgetList != null)
    {
      for (int i = 0; i<widgetList.length; i++)
      {
        Widget aWidget = (Widget)widgetList[i];
        aWidget.draw();
      }
    }
  }
  void mousePressed()
  {
    int event;
    for (int i = 0; i < widgetList.length; i++)
    {
      Widget aWidget = widgetList[i];
      event = aWidget.getEvent(mouseX, mouseY);
      switch(event) {
      case EVENT_BUTTON1:
        currentScreen = 1;
        // println(event);
        break;
      case EVENT_BUTTON2:
        currentScreen = 2;

        //println(event);
        break;
      }
    }
    for (int i =  0; i<storyList.size(); i++)
    {
      if (storyList != null)
      {
        Comment aComment = (Comment)storyList.get(i);
        aComment.mousePressed();
      }
    }
    fill(255);
    stroke(0);
  }
  void mouseMoved() 
  {
    int event;
    for (int i = 0; i<widgetList.length; i++) {
      Widget aWidget = (Widget)widgetList[i];
      event = aWidget.getEvent(mouseX, mouseY);

      if (event > 0) {
        aWidget.labelColor = color(0, 100, 200);
      } else
      {
        aWidget.labelColor = 0;
      }
    }
    if (storyList!=null)
    {
      for (int i =  0; i< storyList.size(); i++)
      {
        Comment aComment = (Comment)storyList.get(i);
        aComment.mouseMoved();
      }
    }
    fill(255);
    stroke(0);
    //rect(600,200,500,200);
  }
}
