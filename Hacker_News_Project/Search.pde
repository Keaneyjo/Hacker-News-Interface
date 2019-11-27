// Search class and selectSearch function() by John Keaney
class Search
{

  Search() // default Search constructor
  {
  }

  boolean searchSelect(Widget2 searchWidget, int mX, int mY)    // function to check whether Search has been selected.
  {
      if (mX < searchWidget.x && mX > (searchWidget.x + searchWidgetWidth) && mY > searchWidget.y && mY < searchWidget.y + SEARCHWIDGET_HEIGHT)
      {
        return true;    // Returns true if magnifying glass selected, opening search/
      }  
      else
      {
        return false;   // Returns false if magnifying glass not selected, closing search.
      }
  }
}
