
 //  Updates:
 //  20/3/2019: File created initially by Finn Jaksland
 //  21/3/2019: File updated by displays and creates bar charts. Has color. - Finn Jaksland
 //  21/3/2019: File updated to contain a horizontal draw function, requires the user to swap xpos/ypos currently - Finn Jaksland
 //  27/3/2019: File updated to inclue any local fixes I made - Finn Jaksland
 //  28/3/2019: File updated to have new constructors for int and double values - Finn Jaksland
 //  28/3/2019: File updated to fix the names of horizontal and vertical. Fixed color mode issue - Finn Jaksland
  //  28/3/2019: File updated to include a few more functions - Finn Jaksland
  //  4/4/2019:  File reimplemented unsaved features. - Finn Jaksland
  //  4/4/2019:  Fixed height bug - Finn Jaksland
  //  4/4/2019: Fixed bug for not fully extending to the inputted values - Finn Jaksland
  //  4/4/2019: Mouseover feature fully working - Finn Jaksland
  //  4/4/2019: Long-standing ranbow bug fixed - Finn Jaksland
  //  5/4/2019: Added in bargraph slide function - Finn Jaksland
  //  11/4/2019: Small quality of life fixes - Finn Jaksland
  //  11/4/2019: Fixed the isolate bug during the credits easter egg in the main code - Finn Jaksland

 //  Future Features: None planned
 //  Known Issues: None
 
 
class BarGraph
{
  // List of colors initialised
  ArrayList<Integer> colorList = new ArrayList();
  // dataArray = data to be passed through
  private int[] dataArray;
  private int width;  private int height ;private int xpos;private int ypos;private int maxValue;private int spacing;private int ratio; 
  private int lastSelected = -1;
  private boolean sliding = false;
  private int slidingRemainder;
  
  // CONSTRUCTOR - int values, width of entire chart, height and co-ords
  BarGraph(int[] array, int width, int height, int xpos, int ypos)
  {
    
    dataArray = array;
    if (dataArray.length>18)
    {
      //System.out.println("Wa");
    }
    this.height = height;
    this.width = width;
    this.ypos = ypos;
    slidingRemainder = ypos;
    this.xpos = xpos;
    //Spacing for each bar
    spacing = width / dataArray.length;
    //Finding max value and setting colors
    for(int i =0; i < dataArray.length; i++)
    {
      colorList.add(i * (360/dataArray.length));
      if (dataArray[i] > maxValue)
    {
      maxValue= dataArray[i];
    }
      
    }
    //Adjusting values so that the top value is equal to the inputted height
    for(int i = 0; i < dataArray.length; i++)
    {
      dataArray[i] = (int) (((float) dataArray[i] / (float) maxValue)* height);
      
    }
    maxValue = height;
  }
  
  // Float coordinates and int dimensions
  BarGraph(int[] array, int width, int height, float xpos, float ypos)
  {
    
    dataArray = array;
    if (dataArray.length>18)
    {
      //System.out.println("Wa");
    }
    this.height = height;
    this.width = width;
    this.ypos = (int) ypos;
    slidingRemainder = (int)ypos;
    this.xpos = (int) xpos;
    //Spacing for each bar
    spacing = width / dataArray.length;
    //Finding max value and setting colors
    for(int i =0; i < dataArray.length; i++)
    {
      colorList.add(i * (360/dataArray.length));
      if (dataArray[i] > maxValue)
    {
      maxValue= dataArray[i];
    }
      
    }
    //Adjusting values so that the top value is equal to the inputted height
    for(int i = 0; i < dataArray.length; i++)
    {
      dataArray[i] = (int) (((float) dataArray[i] / (float) maxValue)* height);
      
    }
    maxValue = this.height;
  }
    // Float coordinates and float dimensions
    BarGraph(int[] array, float width, float height, float xpos, float ypos)
  {
    
    dataArray = array;
    if (dataArray.length>18)
    {
      //System.out.println("Wa");
    }
    this.height = (int) height;
    this.width = (int) width;
    this.ypos = (int) ypos;
    slidingRemainder = (int)ypos;
    this.xpos = (int) xpos;
    //Spacing for each bar
    spacing = this.width / dataArray.length;
    //Finding max value and setting colors
    for(int i =0; i < dataArray.length; i++)
    {
      colorList.add(i * (360/dataArray.length));
      if (dataArray[i] > maxValue)
    {
      maxValue= dataArray[i];
    }
      ratio = maxValue / dataArray[i];
    }
    //Adjusting values so that the top value is equal to the inputted height
    for(int i = 0; i < dataArray.length; i++)
    {
      dataArray[i] = (int) (((float) dataArray[i] / (float) maxValue)* height);
      
    }
    maxValue = this.height;
  }
  
  //draws the entire chart, first item on the left
  void drawChartVertical()
  {
    for (int i = 0; i < dataArray.length; i++)
    {
      colorMode(HSB, 360, 100, 100);
      fill((int)colorList.get(i), 68,100);
      rect(xpos+(i*spacing), ypos + (maxValue + dataArray[i]), spacing, dataArray[i], 15, 15, 0, 0);
      colorMode(RGB,255);
    }
    
  }
  
  // Draws function horizontally, first item on the bottom
  void drawChartHorizontal()
  {
    for (int i = 0; i < dataArray.length; i++)
    {
      colorMode(HSB, 360, 100, 100);
      fill((int)colorList.get(i), 68,100);
      rect( ypos,xpos+(i*spacing),dataArray[i]*ratio, spacing, 0, 15, 15, 0);
      colorMode(RGB,255);
    }
   
  }
  
  // Returns the sliding value, please see the sliding() method for a description of what sliding is
  boolean isSliding()
  {
    return sliding;
  }
  void slide()
  {
    if (sliding == false)
    {
      slidingRemainder = ypos;
      sliding = true;
      ypos = ypos-(dataArray[0]*ratio);
    }
  }

//Sliding is the name given to when the graph page is first clicked on and the data in animated to appear in from the side. This should be used to avoid any glitches from trying the isolate feature before the graph is draw on screen
  void sliding()
  {
  if((ypos < slidingRemainder)&&(sliding == true))
  {
    ypos+=20;
    println("sliding");
  }
  if((ypos > slidingRemainder)&&(sliding == true))
  {
    ypos-=1;
    println("sliding");
  }
  else if((ypos == slidingRemainder)&&(sliding == true))
  {
    sliding = false;
  }  
  }
  
  
  int mouseOverHorizontal()
  {
    for(int i =0; i < dataArray.length; i++){
    if ((mouseX >= ypos) && (mouseX <= ypos + dataArray[i]*ratio) && (mouseY >= xpos+(i*spacing)) && (mouseY <= xpos+(i*spacing) + spacing))
    {
      if (lastSelected != i)
      {
        select.play();
        lastSelected = i;
      }
      return i;
    }
  }
    return -1;
  }
  
  // Not implemented so returns an error value
  int mouseOverVertical()
  {
    return -1;
  }
  //Returns the x postion
  int getX()
  {
    return xpos;
  }
  //Returns the y postion
  int getY()
  {
    return ypos;
  }
  //Sets the x postion
  void setX(int xpos)
  {
    this.xpos = xpos;
  }
  //Returns the y postion
  void setY(int ypos)
  {
    this.ypos = ypos;
  }
  //Returns the Max Value postion
  int getMaxValue()
  {
    return maxValue;
  }
  //Returns the Length
 int getLength()
  {
    return dataArray.length;
  }
  //Returns the height
  int getHeight()
  {
    return height;
  }
  //Returns the width
  int getWidth()
  {
    return width;
  }
  //Returns the color if given the index
  int getColor(int index)
  {
    return colorList.get(index);
  }
  //Returns the height value of a bar if given the index
  int getValue(int index)
  {
    return dataArray[index];
  }
  
  // Find where the y value of a piece of data is given it's being drawn vertically
  int getYVertical(int i)
  {
    return (xpos+(i*spacing));
  }
  // Get the spacing used to draw the chart
  int getSpacing()
  {
    return spacing;
  }
  // get the height that a piece of data takes up on the chart
  int getBarHeight(int i)
  {
    return dataArray[i]*ratio;
  }
}
