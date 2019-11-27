//Brian Farrell code
public class Widget
{ 
  float x, y, width, height, textSize;
  String label; int event;
  color widgetColor, labelColor;
  PFont widgetFont;
  color strk;
  boolean drawURL;
  
  Widget(float x,float y, float width, float height, String label,
  color widgetColor, color strk,int event, float textSize)
  {
    this.x=x; this.y=y; this.width = width; this.height= height;
    this.label=label;
    this.widgetColor=widgetColor;
    this.strk = strk;
    this.event = event;
    this.textSize = textSize;
    
   }
   
  void draw()
 { 
    fill(labelColor);
    textSize(textSize);
    stroke(255); 
    if(drawURL == true) //for displaying URL only when over it
    {
      text(label,x+80,y);
    }
    if(event != 3)
    {
      text(label,x,y);
    }
    color (30, 40, 40);
  }    
    int getEvent(int mX, int mY)
    {
      if (mX > x && mX < x + width  && mY > y-height && mY < y + height)
      {
      return event;
      }
      return EVENT_NULL;
    }
     
}
//Drop down Brian Farrell
public class dropDown
{ 
  float x, y, width, height, textSize;
  String label, label2, label3; int event;
  color widgetColor, labelColor;
  PFont widgetFont;
  color strk;
  boolean clicked;
  
  dropDown(float x,float y, float width, float height, String label,String label2, String label3,
  color widgetColor,int event, float textSize){
    this.x=x; this.y=y; this.width = width; this.height= height;
    this.label=label;
    this.label2 = label2;
    this.label3 = label3;
    this.widgetColor=widgetColor;
    this.event = event;
    this.textSize = textSize;
    
   }
  void draw()
 { 
    fill(255);
    textSize(textSize);
    stroke(0);
    if(!clicked)
    {
    rect(x,y,width,height);
    fill(0);
    text(label,x,y+height);
    }
    if(clicked)
    {
    rect(x,y,width,height); 
    rect(x,y+50,width,height);
    rect(x,y+100,width,height);
    fill(0);
    text(label,x,y+height);
    text(label2,x,y+50+height);
    text(label3,x,y+100+height);
    } 
    color (30, 40, 40);
  }
    
    int getEvent(int mX, int mY)
    {
      if (mX > x && mX < x + width  && mY > y-height && mY < y + height)
      {
      return event;
      }
      return EVENT_NULL;
    }
     
}
// Johns Code
public class Widget2
{
  // Height of widget = 10;
  // Widget of widget = 40;
  int widgetNumber;
  int secX;
  int sexY;
  int selY; 
  int x, y, width, height;
  String label; int event;
  color widgetColor, labelColor;
  PFont widgetFont;
  color strk;
  
  Widget2(int x,int y, int width, int height, String label,
  color widgetColor, PFont widgetFont, color strk)
  {
    this.x=x; this.y=y; this.width = width; this.height= height;
    this.label=label;
    this.widgetColor=widgetColor; this.widgetFont=widgetFont;
    this.strk = strk;
    labelColor= color(255);
   }

  
  void draw()
  {
    fill(labelColor);
    textSize(48);
    text(label, x, y);
    fill(70, 71, 89);
   
  }
  void borderHighlight(int mX, int mY)
  {
    int [] colors = new int[3];
    if(mX> x -5 && mX < x+width+ 5 && mY >y-50 && mY <y)
    {
      colors[0] = 0;
      colors[1] = 102;
      colors[2] = 153;
    }
    else
    {
      colors[0] = 255;
      colors[1] = 255;
      colors[2] = 255;
    }
    labelColor = color(colors[0], colors[1] , colors[2]);
    textSize(48);
    //fill(colors[0], colors[1] , colors[2]);
    return;
  }
  
}
