
//  Updates:
//  20/3/2019: File created initially by Finn Jaksland
//  21/3/2019: File updated. Displays and creates bar charts. Has color. - Finn Jaksland
//  27/3/2019: File updated to include methods that make life easier. - Finn Jaksland
//  28/3/2019: File updated to include new constructors for ints and floats - Finn Jaksland
//  28/3/2019: Fixed color mode issue - Finn Jaksland
//  4/4/2019:  Funny rainbow wheel goo wooooooooooooo. (Fixed isolation feature) - Finn Jaksland
//  4/4/2019 : Now implements all colours of the wheel effectively - Finn Jaksland
//  4/4/2019 : Added in 'walkies' easter egg. Hover over the wheel for 10 seconds - Finn Jaksland
//  4/4/2019: New methods and walkies fix. Walkies easter egg plays music - Finn Jaksland
//  5/5/2019: Slide function now fully functional. Might spruce up a bit later - Finn Jaksland
//  10/04/2019: Small quality of life changes - Finn Jaksland
//  11/4/2019: Small quality of life fixes - Finn Jaksland
//  11/4/2019: Fixed the isolate bug during the credits easter egg in the main code - Finn Jaksland
//  11/4/2019: New reset function! - Finn Jaksland
  
//  Future Features: None planned
// Known Issues: None

class PiChart
{
  ArrayList<Integer> colorList = new ArrayList();
  private int[] dataArray = null;
  private int diameter; 
  private float xpos;
  private float ypos;
  private int totalSum;
  private int remainderChecker = 360; 
  private boolean sliding = false;
  private float slideValue;
  private boolean spaceBackground = false;
  private float spaceX = 0;
   float defaultX;
   float defaultY;


  float spin; 
  int velocity; 
  int walkies;
  PiChart(int[] array, int diameter, int xpos, int ypos)
  {
    this.diameter = diameter;
    dataArray = array;
    this.ypos = ypos;
    this.xpos = xpos;
    defaultX = xpos;
    defaultY = ypos;
    for (int i =0; i < dataArray.length; i++)
    {
      totalSum+= dataArray[i];
      //System.out.println(dataArray[i]);
    }
    //System.out.println(totalSum);
    for (int i =0; i < dataArray.length; i++)
    {
      dataArray[i]= int (((float) dataArray[i] / (float) totalSum)*360);
      //System.out.println(dataArray[i]);
      remainderChecker -= dataArray[i];
    }
    for (int i = 0; i < dataArray.length; i++)
    {
      colorList.add(i * (360/dataArray.length));
    }
    if (remainderChecker != 0)
    {
      dataArray[0] +=remainderChecker;
    }
  }

// There is no set up required that is planned. PiGraph fully initiliases in the constructor
  void  setup()
  {

  }

  // Takes in int dimensions and float co-ordinates
  PiChart(int[] array, int diameter, float xpos, float ypos)
  {
    this.diameter = diameter;
    dataArray = array;
    this.ypos =   ypos;
    this.xpos =  xpos;
    defaultX = xpos;
    defaultY = ypos;
    for (int i =0; i < dataArray.length; i++)
    {
      totalSum+= dataArray[i];
      //System.out.println(dataArray[i]);
    }
    // System.out.println(totalSum);
    for (int i =0; i < dataArray.length; i++)
    {
      dataArray[i]= int (((float) dataArray[i] / (float) totalSum)*360);
      // System.out.println(dataArray[i]);
      remainderChecker -= dataArray[i];
    }
    for (int i = 0; i < dataArray.length; i++)
    {
      colorList.add(i * (360/dataArray.length));
    }
    if (remainderChecker != 0)
    {
      dataArray[0] +=remainderChecker;
    }
  }

  // Takes in float dimensions and float co-ordinates
  PiChart(int[] array, float diameter, float xpos, float ypos)
  {
    this.diameter = (int) diameter;
    dataArray = array;
    if (dataArray.length>18)
    {
      System.out.println("WARNING: A PiChart with more than 18 items will not generate a unique color for the last remaining ones");
    }
    this.ypos =   ypos;
    this.xpos =  xpos;
    defaultX = xpos;
    defaultY = ypos;
    for (int i =0; i < dataArray.length; i++)
    {
      totalSum+= dataArray[i];
      //System.out.println(dataArray[i]);
    }
    //System.out.println(totalSum);
    for (int i =0; i < dataArray.length; i++)
    {
      dataArray[i]= int (((float) dataArray[i] / (float) totalSum)*360);
      //System.out.println(dataArray[i]);
      remainderChecker -= dataArray[i];
    }
    for (int i = 0; i < dataArray.length; i++)
    {
      colorList.add(i * 20);
    }
    if (remainderChecker != 0)
    {
      dataArray[0] +=remainderChecker;
    }
  }

  void drawChart()
  {
    // spaceBackground is the state in which the background changes for the credits easter egg
    if (spaceBackground)
    {
      image(space, spaceX, 0);
      image(space, spaceX+1920, 0);
      
      if (spaceX<-1920)
      {
        spaceX=0;
      }
      spaceX-=1;
    }  
    double previousPiece = 0;
    for (int i = 0; i < dataArray.length; i++)
    {
      colorMode(HSB, 360, 100, 100);
      fill((int)colorList.get(i), 68, 100);
      arc(xpos+diameter/2, ypos+diameter/2, (float) diameter, (float) diameter, (float) previousPiece+spin, (float)previousPiece+radians(dataArray[i])+spin+slideValue);
      previousPiece+= radians(dataArray[i]);
      colorMode(RGB, 255);
    }
    spin+= 0.03 * velocity;
    // walkies is the name given to frames after the easter egg is triggered
    if (walkies >= 310)
    {
      if (!moonMusic.isPlaying())
      {
        moonMusic.play();
      } else
      {
        walkies++;
        velocity = 10;
      }
    }
    if (walkies >=500)
    {
      xpos+=8;
    }
    if (walkies == 1000)
    {
      xpos = 0;
    }
    if (walkies >= 1100)
    {
      xpos = SCREENX/2;
      spaceBackground = true;
    } else if (velocity != 0) {
      velocity-= 0.001;
    }
  }

// slide refers to the animation that plays when the top users page is first clicked on after booting the program
  void slide()
  {
    if (sliding == false)
    {
      sliding = true;
      slideValue=8;
      
    }
  }

// sliding is a continuation of slide function that changes values the entire animation
  void sliding()
  {
    if ((slideValue < 0)&&(sliding == true))
    {
      slideValue=0;
     // println("sliding circle "+slideValue);
    }
    if ((slideValue >= 0.1)&&(sliding == true))
    {
      slideValue-=0.1;
      velocity = 20;
      println("sliding circle " +slideValue);
    } else if ((slideValue < 0.1)&&(sliding == true))
    {
      sliding = false;
      slideValue =0;
    }
  }

// isSpace returns if the spaceBackground boolean is triggered which is only true if the easter egg is triggered by hovering over the chart for 10 seconds
  boolean isSpace()
  {
    return spaceBackground;
  }
// returns if the chart is in the middle of it's initlisation animation
  boolean isSliding()
  {
    return sliding;
  }

  int getX()
  {
    return (int)xpos;
  }
  int getY()
  {
    return (int)ypos;
  }

  void setX(int x)
  {
    xpos = x;
  }
  void setY(int y)
  {
    ypos = y;
  }
  //Returns the diameter
  int getDiameter()
  {
    return diameter;
  }
  //Returns the Radius
  int getRadius()
  {
    return diameter/2;
  }
  //Returns the length of the data 
  int getLength()
  {
    return dataArray.length;
  }
  //Returns the color of a specific item in the data array
  int getColor(int index)
  {
    return colorList.get(index);
  }
  //Returns the value of data at a given index
  int getValue(int index)
  {
    return dataArray[index];
  }
  // set velocity for the wheel spin to full. The velocity for the wheel will go back down to zero eventually. Walkies is the counter for the credits easter egg
  void resetVelocity()
  {
    if (!moonMusic.isPlaying())
    {
      velocity = 5;
      walkies++;
    }
  }

  //This function allows you to isolate a singular piece and only draw it.
  //Use with the hitboxes made for BarGraph
  //Isolation does not work in tandem with the credits easter egg. Removing the boolean that prevents this will cause the graph to glitch offscreen
  void isolate(int index)
  {
    if (!spaceBackground){
      fill(255);
      ellipse(xpos+diameter/2, ypos+diameter/2, diameter, diameter);
      double previousPiece = 0;
      for (int i = 0; i < dataArray.length; i++)
      {
        colorMode(HSB, 360, 100, 100);
        fill((int)colorList.get(i), 68, 100);
        if (i == index) {
          arc(xpos+diameter/2, ypos+diameter/2, (float) diameter, (float) diameter, (float) previousPiece+spin, (float)previousPiece+radians(dataArray[i])+spin);
        }
        previousPiece+= radians(dataArray[i]);
        colorMode(RGB, 255);
        spin+= 0.03 * velocity;
        if (walkies >=500)
        {
          xpos+=8;
        } else if (velocity != 0) {
          velocity-= 0.001;
        }
       }
    }
  }
  // Resets the chart after the easter egg has been triggered
  void resetChart()
 {
   velocity = 0;
   walkies =0;
   spaceBackground = false;
   moonMusic.stop();
   xpos = defaultX;
   ypos = defaultY;
 }
}
