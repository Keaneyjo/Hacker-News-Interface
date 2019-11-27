import processing.sound.*;
import java.util.Date;

//Important Comments/Notes:
// 2/4/2019 - I've redefined the screen in terms of the constants listed in the constants class. If we are using a constant file, make sure all constants are defined in there. I've exported the constants here to there. - Finn Jaksland
// 2/4/2019 - I've changed the screen resolution to be the one we need for the presentation. - Finn Jaksland
// 11/4/2019 - Everything as I write this in this version uploaded around 10:04AM is functioning. Please revert to this version if polishing any further breaks the code - Finn Jaksland
float endCommentDisplayYpos = 0;
boolean finishedLoading = false;
boolean darkMode = false;
boolean nKey = false;
boolean ctrlKey = false;
float percentFinished = 0.0;
// hotKeyCooldown is used for making sure darkMode is not triggered every frame that the hotkey is pressed
int hotKeyCooldown = 0;

public int currentScreen = 0;
public String currentUser = "";
public Story commentStory;
SoundFile moonMusic;
SoundFile select;

public int jsonIndex = 0;
public PImage space;
public PImage logo;
JSONObject json = new JSONObject();
JSONObject tempJson;
JSONArray jsArray = new JSONArray();

ArrayList<User> users = new ArrayList<User>();
ArrayList<Post> postsByID = new ArrayList<Post>();
ArrayList<Post> sortedPosts = new ArrayList<Post>();
ArrayList<Post> searchPosts = new ArrayList<Post>();

int counter = 0;
String string;
Screen theHomeScreen, topUserScreen, storyScreen, currentProfile, commentSection, searchScreen, commentReply;
Comment currentComment;

Widget widget1, widget2, widget3, widget4;
ArrayList widgetList;
Widget2 searchWidget;
Search theSearchWidget;
public boolean slideSearch = false;
PImage searchBarFirstFrame;
PImage searchBarFirstFrameSecondHalf;

ArrayList jsons = new ArrayList<JSONObject>();
int howMany;
int totalWidgets = 1; // + 1
PFont stdFont;
int [] strk;
int firstColor, secondColor, thirdColor;

public PImage backgroundWallpaper;
public PImage profilePic1;
int rotateCounter = 0;

float n = 0;
float c = 4;

void settings() {

  //fullScreen();
  size(SCREENX, SCREENY);
}

void  setup() {

  background(255);
  frameRate(60);


  //initialize();
  thread("initialize"); // The function 'initialize' is run in a separate thread to the rest of the program.

  
}

void draw() {

  if (!finishedLoading) {
  
    // Loading bar by Thomas Keyes
    stroke(0);
    noFill();
    rect(SCREENX/2 - 150, SCREENY/2, LOADING_BAR_LENGTH, 10);
    fill(95, 155, 252);
    float w = map(percentFinished, 0, 1, 0, LOADING_BAR_LENGTH);
    rect(SCREENX/2 - 150, SCREENY/2, w, 10);
    textSize(20);
    //textAlign(CENTER);
    fill(0);
    text("Loading...", SCREENX / 2 - 30, SCREENY / 2 + 40);
    
    // Phyllotaxis pattern by Thomas Keyes
    // Pattern resets if n becomes graeter than 70
    
    float a = n * 137.5;
    float r = c * sqrt(n);
    float x = r * cos(a) + SCREENX / 2;
    float y = r * sin(a) + SCREENY / 3;
    fill(a%256, r%256, r%256);
    noStroke();
    ellipse(x, y, 4, 4);
    n += 1.5;

    if (n == 70) {
      background(255);
      n = 0;
    }  //Draws the current screen and continually calls the mouseMoved of that screen by Brian 
  } else if (currentScreen == 1)
  {
    theHomeScreen.draw();
    theHomeScreen.mouseMoved();
  } else if (currentScreen == 2)
  {
    topUserScreen.draw();
    topUserScreen.mouseMoved();
  } else if (currentScreen == 3)
  {
    currentProfile.draw();
    currentProfile.mouseMoved();
  } else if (currentScreen == 4)
  {
    commentSection.draw();
    commentSection.mouseMoved();
  } else if (currentScreen == 5)
  {
    searchScreen.draw();
    searchScreen.mouseMoved();
  } else if (currentScreen == 6)
  {
    commentReply.draw();
    commentReply.mouseMoved();
  }

  if (finishedLoading)
  {
    image(logo, 0, 0, 110*1.5, 110);
    if ((ctrlKey && nKey) && hotKeyCooldown == 0)
    {
      if (!darkMode) darkMode = true;
      else darkMode = false;
      hotKeyCooldown = 60;
    }
  }
  if (hotKeyCooldown !=0)
  {
    hotKeyCooldown--;
  }
  if (darkMode) {
    filter(INVERT);
    // fixes bug where inverting also inverts the profile pictures - Finn Jaksland
  }
}

// Nightmode Hotkey added in by Finn Jaksland, implementing on Thomas' darkMode code
void keyPressed()
{
  if (keyCode == CONTROL && ctrlKey == false) ctrlKey = true;
  if (char(keyCode) == 'N') nKey = true;
  if (keyCode == DOWN)  //Moves the screen Down when the Down arrow key is pressed, by Brian
  {
    if (currentScreen == 1)
    {

      float e = 1;
      for (int i = 0; i < theHomeScreen.storyList.size(); i++)
      {
        Story aStory = (Story) theHomeScreen.storyList.get(i);
        aStory.y -= (e * 50);
        if (aStory.userProfile != null)
        {
          aStory.userProfile.y-= (e * 50);
        }
        aStory.comment.y-= (e *50);
        aStory.DATE.y-= (e *50);
        aStory.URL.y -=(e *50);
      }
    }
    if (currentScreen == 3)
    {

      float e = 1;
      for (int i = 0; i < currentProfile.storyList.size(); i++)
      {
        Story aStory = (Story) currentProfile.storyList.get(i);
        aStory.y -= (e * 50);
        if (aStory.userProfile != null)
        {
          aStory.userProfile.y-= (e * 50);
        }
        aStory.comment.y-= (e *50);
        aStory.DATE.y-= (e *50);
        aStory.URL.y -=(e *50);
      }
    } else if (currentScreen == 4)  // Comments Section Screen
    {
      float e = 1;
      for (int i = 0; i < commentSection.storyList.size(); i++)
      {
        Comment aComment = (Comment) commentSection.storyList.get(i);
        aComment.y -= (e * 50);
        if (aComment.userProfile != null)
        {
          aComment.userProfile.y-= (e * 50);
        }
        aComment.replies.y-= (e *50);
      }
    } else if (currentScreen == 6)  // Comments Section Screen
    {
      float e = 1;
      for (int i = 0; i < commentReply.storyList.size(); i++)
      {
        Comment aComment = (Comment) commentReply.storyList.get(i);
        aComment.y -= (e * 50);
        if (aComment.userProfile != null)
        {
          aComment.userProfile.y-= (e * 50);
        }
        aComment.replies.y-= (e *50);
      }
    }
  }
  if (keyCode == UP) //Moves the screen UP when the Up arrow key is pressed, by Brian
  {
    if (currentScreen == 1)
    {

      float e = -1;
      for (int i = 0; i < theHomeScreen.storyList.size(); i++)
      {
        Story aStory = (Story) theHomeScreen.storyList.get(i);
        aStory.y -= (e * 50);
        if (aStory.userProfile != null)
        {
          aStory.userProfile.y-= (e * 50);
        }
        aStory.comment.y-= (e *50);
        aStory.DATE.y-= (e *50);
        aStory.URL.y -=(e *50);
      }
    } 
    if (currentScreen == 3)
    {

      float e = -1;
      for (int i = 0; i < currentProfile.storyList.size(); i++)
      {
        Story aStory = (Story) currentProfile.storyList.get(i);
        aStory.y -= (e * 50);
        if (aStory.userProfile != null)
        {
          aStory.userProfile.y-= (e * 50);
        }
        aStory.comment.y-= (e *50);
        aStory.DATE.y-= (e *50);
        aStory.URL.y -=(e *50);
      }
    } else if (currentScreen == 4)  // Comments Section Screen
    {
      float e = -1;
      for (int i = 0; i < commentSection.storyList.size(); i++)
      {
        Comment aComment = (Comment) commentSection.storyList.get(i);
        aComment.y -= (e * 50);
        if (aComment.userProfile != null)
        {
          aComment.userProfile.y-= (e * 50);
        }
        aComment.replies.y-= (e *50);
      }
    } else if (currentScreen == 6)  // Comments Section Screen
    {
      float e =-1;
      for (int i = 0; i < commentReply.storyList.size(); i++)
      {
        Comment aComment = (Comment) commentReply.storyList.get(i);
        aComment.y -= (e * 50);
        if (aComment.userProfile != null)
        {
          aComment.userProfile.y-= (e * 50);
        }
        aComment.replies.y-= (e *50);
      }
    }
  }
}

void keyReleased()
{
  if (keyCode == CONTROL) ctrlKey = false;
  if (char(keyCode) == 'N') nKey = false;
}

// MouseWheel() function written by  -John Keaney
// Fixed mouseWheel function to suit appropriate pages. - John Keaney

void mouseWheel(MouseEvent event) {

  if (currentScreen == 1)
  {
    float e = event.getCount();
    println(e);
    Story firstStory = (Story) theHomeScreen.storyList.get(0);
    Story endStory = (Story) theHomeScreen.storyList.get(theHomeScreen.storyList.size() - 1);
    println(firstStory.y); //176
    println(endStory.y); //280
    if (e == -1  && FIRST_STORY_DISPLAY_YPOS <= firstStory.y)
    {
      println("No movement");
    } else if (e == 1  && LAST_STORY_DISPLAY_YPOS <= endStory.y)
    {
      println("No movement");
    } else if (e == 1)
    {
      for (int i = 0; i < theHomeScreen.storyList.size(); i++)
      {
        Story aStory = (Story) theHomeScreen.storyList.get(i);
        aStory.y -= (e * 50);
        if (aStory.userProfile != null)
        {
          aStory.userProfile.y-= (e * 50);
        }
        aStory.comment.y-= (e *50);
        aStory.DATE.y-= (e *50);
        aStory.URL.y -=(e *50);
      }
    } else if (e == -1)
    {
      for (int i = 0; i < theHomeScreen.storyList.size(); i++)
      {
        Story aStory = (Story) theHomeScreen.storyList.get(i);
        aStory.y -= (e * 50);
        if (aStory.userProfile != null)
        {
          aStory.userProfile.y-= (e * 50);
        }
        aStory.comment.y-= (e *50);
        aStory.DATE.y-= (e *50);
        aStory.URL.y -=(e *50);
      }
    }
  } else if (currentScreen == 3)
  {
    float e = event.getCount();
    for (int i = 0; i < currentProfile.storyList.size(); i++)
    {
      Story aStory = (Story) currentProfile.storyList.get(i);
      aStory.y -= (e * 50);
      if (aStory.userProfile != null)
      {
        aStory.userProfile.y-= (e * 50);
      }
      aStory.comment.y-= (e *50);
      aStory.DATE.y-= (e *50);
      aStory.URL.y -=(e *50);
    }
  } 
  else if (currentScreen == 4)  // Comments Section Screen
  {
    //458

    float e = event.getCount();
    if (commentSection.storyList.size() != 0)
    {
      Comment firstComment = (Comment) commentSection.storyList.get(0);
      Comment endComment = (Comment) commentSection.storyList.get(commentSection.storyList.size()-1);
      println(firstComment.y);
      if (firstComment.y == FIRST_COMMENT_DISPLAY_YPOS)
      {
        endCommentDisplayYpos = endComment.y;
      }
      println(endCommentDisplayYpos); //2794
      if (e == -1  && FIRST_COMMENT_DISPLAY_YPOS <= firstComment.y)
      {
        println("No movement");
      }
      //else if (e == 1  && endCommentDisplayYpos > endComment.y)
      //{
      //  println("No movement");
      //} 
      else if (e == 1 || e == -1)
      {
        for (int i = 0; i < commentSection.storyList.size(); i++)
        {
          Comment aComment = (Comment) commentSection.storyList.get(i);
          aComment.y -= (e * 50);
          if (aComment.userProfile != null)
          {
            aComment.userProfile.y-= (e * 50);
          }
          aComment.replies.y-= (e *50);
        }
      }
    }
  } else if (currentScreen == 6)
  {
    float e = event.getCount();

    for (int i = 0; i < commentReply.storyList.size(); i++)
    {
      Comment aComment = (Comment) commentReply.storyList.get(i);
      aComment.y -= (e * 50);
      if (aComment.userProfile != null)
      {
        aComment.userProfile.y-= (e * 50);
        aComment.replies.y-= (e *50);
      }
    }
  }
}

// keyTyped Function by John Keaney
// Added keyTyped functionality (for search bar) on all pages appropriate - 04/09/2019
void keyTyped() {
  if (currentScreen == 1)
  {
    if (slideSearch == true)
    {
      theHomeScreen.keyPressed();
    } else
      searchInput = "";
  } else if (currentScreen == 2)
  {
    if (slideSearch == true)
    {
      topUserScreen.keyPressed();
    } else
      searchInput = "";
  } else if (currentScreen == 2)
  {
    if (slideSearch == true)
    {
      currentProfile.keyPressed();
    } else
      searchInput = "";
  } else if (currentScreen == 3)
  {
    if (slideSearch == true)
    {
      commentSection.keyPressed();
    } else
      searchInput = "";
  } else if (currentScreen == 4)
  {
    if (slideSearch == true)
    {
      searchScreen.keyPressed();
    } else
      searchInput = "";
  }
}




void mousePressed() //calls mousePressed for the current Screen only, by Brian
{
  if (currentScreen == 1)
  {
    theHomeScreen.mousePressed();
  } else if (currentScreen == 2)
  {
    topUserScreen.mousePressed();
  }
  if (currentScreen == 3)
  {
    currentProfile.mousePressed();
    currentProfile.addStory(userPosts(currentUser));
  }
  if (currentScreen == 4)
  {
    commentSection.mousePressed();
    commentSection.addStory(storyComments(commentStory)); //Creates an array of the comments that are relevent to whatever story has been clicked
    currentProfile.addStory(userPosts(currentUser));
  }
  if (currentScreen == 5)
  {
    searchScreen.mousePressed();
  }
  if (currentScreen == 6)
  {
    commentReply.mousePressed();
    commentReply.addStory(commentReplies(currentComment)); //Ties the replies to a comment
    commentReply.setTop(currentComment.getText());
    currentProfile.addStory(userPosts(currentUser));
  }

  if (currentScreen != 0) 
  {

    slideSearch = theSearchWidget.searchSelect(searchWidget, mouseX, mouseY);
  }
}

// Anything that needs to be loaded before the program is functional must be put here
void initialize () {

  finishedLoading = false;

  loadStrings(); 
  arrangeUsersByScore();
  arrangePostsByScore();
  theHomeScreen = new homeScreen(0, "", "", 0, 0);

  theHomeScreen.addStory(postsByID);
  topUserScreen = new topUserPage(0, "", "", 0, 0, topUsers(25));
  currentProfile = new profilePage(0, "", "", 0, 0);
  commentSection = new commentPage(0, "", "", 0, 0);
  commentReply = new commentReplies(0, "", "", 0, 0);

  currentProfile.addStory(null);
  topUserScreen.addStory(null);
  topUserScreen.createGraph();
  commentSection.addStory(null);
  commentReply.addStory(null);


  searchWidget = new Widget2(SEARCHWIDGET_XPOS, SEARCHWIDGET_YPOS, searchWidgetWidth, SEARCHWIDGET_HEIGHT, "", color(70, 71, 89), stdFont, color(0));      //
  theSearchWidget = new Search(); 
  space = loadImage("space.png");
  logo = loadImage("logo.png");
  backgroundWallpaper = loadImage("backgroundWallpaper.jpg");
  searchBarFirstFrame = loadImage("searchBarFirstFrame.png");
  searchBarFirstFrameSecondHalf = loadImage("searchBarFirstFrameSecondHalf.png");
  moonMusic = new SoundFile(this, "moonMusic.wav");
  select = new SoundFile(this, "select.wav");

  finishedLoading = true;
  currentScreen = 1;
}  
