import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public static int NUM_ROWS = 5;
public static int NUM_COLS = 5;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton> (); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r <NUM_ROWS; r++){
      for(int c = 0; c <NUM_COLS; c++){
        buttons[r][c] = new MSButton(r,c);
      }
    }
    setMines();
}
public void setMines()
{
    int row = (int)(Math.random()*NUM_ROWS);
    int col = (int)(Math.random()*NUM_COLS);
    if (mines.contains(buttons[row][col])){
}
else{
  mines.add(buttons[row][col]);
}
}
public void draw ()
{
    background( 0 );
    textSize(15);
    buttons[0][1].setLabel("double click square to play");
    if(isWon() == true)
        displayWinningMessage();
}

public boolean isWon()
{
  mousePressed();
    return false;
}
public void displayLosingMessage()
{
    fill(255,0,255);
    textSize(40);
    textAlign(CENTER);
    buttons[2][2].setLabel("LOSER!!!!!");


}
public void displayWinningMessage()
{
    fill(255,0,255);
    textSize(40);
    textAlign(CENTER);
    buttons[2][2].setLabel("YAY!!!");
    
}
public boolean isValid(int r, int c)
{
   if(r<0|| c<0){
    return false;
  }
  if(r<NUM_ROWS && c<NUM_COLS){
    return true;
  }
  else{
    return false;
  }
}
public int countMines(int row, int col)
{
    int numMines = 0;
    int isValid = 0;
for(int r = row-1; r<row+2; r++){
  for(int c = col-1;c<col+2;c++){
  if(r<0|| c<0){
    isValid = isValid;
  }
  else if(r<NUM_ROWS && c<NUM_COLS){
    isValid++;
    if(mines.contains(buttons[r][c])== true){
      numMines ++;
    }
    else{
      numMines = numMines;
    }
  }
  else{
    isValid = isValid;
  }
}
}
if(mines.contains(buttons[row][col])==true){
  numMines --;
}
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton (int row, int col)
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(isValid(myRow,myCol)== true){
          flagged = !flagged;
        }
        else if(flagged == false){
            clicked = false;
          }
        if(mines.contains(buttons[myRow][myCol])){
          displayLosingMessage();
        }
        if(countMines(myRow,myCol)>0){
          myLabel = (""+countMines(myRow,myCol)+"");
        }
          int q = 0;
        if(!mines.contains(buttons[myRow][myCol]) && clicked == true){
          q++;
        }
    if((NUM_ROWS*NUM_COLS)-q == countMines(NUM_ROWS,NUM_COLS)){
      displayWinningMessage();
    }
        else{
          for(int z = myRow-1; z<myRow+2;z++){
            for(int m = myCol - 1; m<myCol+2; m++){
              isValid(z,m);
            }
          }
        }
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
         else if(clicked && mines.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
