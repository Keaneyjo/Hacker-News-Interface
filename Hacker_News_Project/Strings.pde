// 6/4/2019 - Moved all functions related to parsing the JSON file and arranging the resulting objects to its own file - Thomas Keyes

// loadStrings() function by Thomas Keyes
// Reads the JSON file and sorts all the resulting strings into Post objects. 
public void loadStrings() {

  String lines[] = loadStrings("sgiut.json");
  println("There are " + lines.length + " lines.");

  for (int i = jsonIndex * STRINGS_TO_BE_LOADED; i < (jsonIndex + 1) * STRINGS_TO_BE_LOADED; i++) {
    json = parseJSONObject(lines[i]);
    jsArray.append(json);
  }
  
  int[] kids;
  int descendants;
  String text = "";
  String url;
  String title;
  String author;
  int score;
  int time;
  String type;
  int id;

  for (int i = 0; i < jsArray.size(); i++) {

    tempJson = jsArray.getJSONObject(i);

    try {
      descendants = tempJson.getInt("descendants");
    } 
    catch(Exception e) {
      descendants = 0;
    }  

    type = tempJson.getString("type");
    author = tempJson.getString("by");

    if (type != null) {

      if ("story".equals(type)) {
        try {
          score = tempJson.getInt("score");
        } 
        catch(Exception e) {
          score = 0;
        }
        url = tempJson.getString("url");
        title = tempJson.getString("title");
      } else {
        score = 0;
        url = "none";
        title = "none";
        try {
          text = tempJson.getString("text");
        } catch(Exception e) {
          //text = "";
        }  
        
      }
    } else {
      score = 0;
      url = "none";
      title = "none";
      //text = "";
    }

    try {
      time = tempJson.getInt("time");
    } 
    catch(Exception e) {
      time = 0;
    }  

    try {
      id = tempJson.getInt("id");
    } 
    catch(Exception e) {
      id = 0;
    } 
  
    kids = null;
    
    try {

      JSONArray jsonArray = tempJson.getJSONArray("kids");

      if (jsonArray != null) {

        kids = new int[jsonArray.size()];

        for (int j = 0; j < jsonArray.size(); j++) {
          kids[j] = jsonArray.getInt(j);
          println("works");
        }
      }
    } 
    catch(Exception e) {
      //kids = null;
    }  

    println(kids);

    if (type != null) {
      if ("story".equals(type)) {
        println(" Url: " + url + " Title: " + title + " Author: " + author + " Score: " + score + " Type: " + type);
        Post post = new Post(kids, descendants, url, title, author, score, time, id);
        postsByID.add(post);
      } else {
        println("Text: " + text + " Author: " + author + " Score: " + score + " Type: " + type);
        Post post = new Post(kids, descendants, text, author, time, id);
        postsByID.add(post);
      }


      //check for new users

      boolean newUser = true;

      for (int j = 0; j < users.size(); j++) {

        if ( author != null && author.equals(users.get(j).getName()) ) {
          users.get(j).addToScore(score);
          newUser = false;
        }
      }

      if (newUser) {
        User userToAdd = new User(author, score);
        users.add(userToAdd);
      }
    }
    
    percentFinished = (float)i / jsArray.size();
    
  }
  
  jsonIndex++;
}

// topUsers() function by Thomas Keyes

public int[] topUsers(int topX) {

  int[] topUsers = new int[topX];

  for (int i = 0; i < topX; i++) {  
    topUsers[i] = users.get(i).getScore();
  }

  return topUsers;
}  

// userPosts() function by Thomas Keyes

public ArrayList<Post> userPosts(String userName) {

  ArrayList<Post> userPosts = new ArrayList<Post>();

  String tempAuthor;

  for (int i = 0; i < postsByID.size(); i++) {

    tempAuthor = postsByID.get(i).getAuthor();

    if (userName.equals(tempAuthor)) {
      userPosts.add( postsByID.get(i));
    }
  }

  return userPosts;
}  

// searchPosts() function by Thomas Keyes

public ArrayList<Post> searchPosts(String query) {

  ArrayList<Post> resultPosts = new ArrayList<Post>();

  String postString;
  
  int resultCounter = 0;

  for (int i = 0; i < postsByID.size(); i++) {

    postString = "";
    postString += postsByID.get(i).getAuthor();
    postString += postsByID.get(i).getTitle();
    postString += postsByID.get(i).getText();

    if (postString.contains(query)) {
      resultPosts.add( postsByID.get(i));
      resultCounter++;
    }
  }
  
  println (resultCounter + " results.");
  return resultPosts;
}

// storyComments() function by Thomas Keyes

public ArrayList<Post> storyComments(Story story) {

  ArrayList<Post> resultPosts = new ArrayList<Post>();
  
  if (story.getKids() != null) {
    
    for (int i = 0; i < story.getKids().length; i++) {

      for (int j = 0; j < postsByID.size(); j++) {

        if (story.getKids()[i] == postsByID.get(j).getID()) {
          resultPosts.add(postsByID.get(j));
        }
      }
    }
  }
  println(story.getKids());
  println(resultPosts);
  return resultPosts;
}

// commentReplies() function by Thomas Keyes

public ArrayList<Post> commentReplies(Comment comment) {

  ArrayList<Post> resultPosts = new ArrayList<Post>();
  
  if (comment.getKids() != null) {
    
    println("not null");
    
    for (int i = 0; i < comment.getKids().length; i++) {

      for (int j = 0; j < postsByID.size(); j++) {

        if (comment.getKids()[i] == postsByID.get(j).getID()) {
          resultPosts.add(postsByID.get(j));
        }
      }
    }
  }
  println(comment.getKids());
  println(resultPosts);
  return resultPosts;
}


// arrangeUsersByScore() function by Thomas Keyes

public void arrangeUsersByScore() {

  User tempUser;

  for (int i = 0; i < users.size(); i++) {

    for (int j = i + 1; j < users.size(); j++) {

      if (users.get(i).getScore() < users.get(j).getScore()) {

        tempUser = users.get(i);

        users.set(i, users.get(j));
        users.set(j, tempUser);
      }
    }
  }
}

// arrangePostsByScore() function by Thomas Keyes

public void arrangePostsByScore() {

  Post tempPost;

  sortedPosts = postsByID;


  for (int i = 0; i < sortedPosts.size(); i++) {

    for (int j = i + 1; j < sortedPosts.size(); j++) {

      if (sortedPosts.get(i).getScore() < sortedPosts.get(j).getScore()) {

        tempPost = sortedPosts.get(i);

        sortedPosts.set(i, sortedPosts.get(j));
        sortedPosts.set(j, tempPost);
      }
    }
  }
}

// arrangePostsByLatest() function by Thomas Keyes

public void arrangePostsByLatest() {

  Post tempPost;

  sortedPosts = postsByID;


  for (int i = 0; i < sortedPosts.size(); i++) {

    for (int j = i + 1; j < sortedPosts.size(); j++) {

      if (sortedPosts.get(i).getTime() < sortedPosts.get(j).getTime()) {

        tempPost = sortedPosts.get(i);

        sortedPosts.set(i, sortedPosts.get(j));
        sortedPosts.set(j, tempPost);
        
      }
    }
  }
}

// arrangePostsByOldest() function by Thomas Keyes

public void arrangePostsByOldest() {

  Post tempPost;

  sortedPosts = postsByID;


  for (int i = 0; i < sortedPosts.size(); i++) {

    for (int j = i + 1; j < sortedPosts.size(); j++) {

      if (sortedPosts.get(i).getTime() > sortedPosts.get(j).getTime()) {

        tempPost = sortedPosts.get(i);

        sortedPosts.set(i, sortedPosts.get(j));
        sortedPosts.set(j, tempPost);
        
      }
    }
  }
}
