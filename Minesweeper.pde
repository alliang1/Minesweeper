import de.bezier.guido.*;
int NUM_ROWS =20;
int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton> (); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{   //mines = new ArrayList <MSButton> ();
    size(400, 400);
    textAlign(CENTER,CENTER);
   
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r<NUM_ROWS;r++){
      for(int c =0; c<NUM_COLS;c++){
        buttons[r][c]=new MSButton(r,c);}}
   
   for(int i=0;i<20;i++)    
      setMines();
}
public void setMines()
{
    int r = (int)(Math.random()*NUM_ROWS);
    int c = (int)(Math.random()*NUM_COLS);
   if(mines.contains(buttons[r][c])==false)
        mines.add(buttons[r][c]);
    
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
      for(int r=0;r<NUM_ROWS;r++)
        for(int c=0;c<NUM_COLS;c++)
        {
            if(mines.contains(buttons[r][c])&&buttons[r][c].isFlagged()==false)
                return false;
            if(mines.contains(buttons[r][c])==false&&buttons[r][c].isFlagged())
                return false;
        }
    return true;
}
public void displayLosingMessage()
{
    buttons[0][0].setLabel("l");
    buttons[0][1].setLabel("o");
    buttons[0][2].setLabel("s");
    buttons[0][3].setLabel("e");
}
public void displayWinningMessage()
{
    buttons[0][0].setLabel("w");
     buttons[0][1].setLabel("i");
    buttons[0][2].setLabel("n");
}
public boolean isValid(int r, int c)
{
  if(r<NUM_ROWS  && c < NUM_COLS  && r >=0 && c >=0)
    return true;
  return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    if(isValid(row+1,col)==true && mines.contains(buttons[row+1][col]))
    numMines++;
  if(isValid(row-1,col)==true && mines.contains(buttons[row-1][col]))
    numMines++;
  if(isValid(row,col+1)==true && mines.contains(buttons[row][col+1]))
    numMines++;
  if(isValid(row,col-1)==true && mines.contains(buttons[row][col-1]))
    numMines++;
  if(isValid(row+1,col+1)==true && mines.contains(buttons[row+1][col+1]))
    numMines++;
  if(isValid(row-1,col-1)==true && mines.contains(buttons[row-1][col-1]))
    numMines++;
  if(isValid(row+1,col-1)==true && mines.contains(buttons[row+1][col-1]))
    numMines++;
  if(isValid(row-1,col+1)==true && mines.contains(buttons[row-1][col+1]))
    numMines++;
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
   
    public MSButton ( int row, int col )
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
        if (mouseButton == RIGHT){
          if(flagged){
            flagged = false;
            clicked = false;}
          else
            flagged = true;   
        }
        else if (mines.contains(this)){
          displayLosingMessage();
          

        }
        else if(countMines(myRow,myCol)>0){
          setLabel(str(countMines(myRow,myCol)));}
        else{
          for(int r = myRow-1; r<myRow+2;r++)
            for(int c = myCol-1; c<myCol+2; c++)
              if (isValid(r,c)&&!buttons[r][c].clicked==true)
                buttons[r][c].mousePressed();
          //if(isValid(myRow-1,myCol)){
          //      if(!mines.contains(buttons[myRow-1][myCol])){
          //          buttons[myRow-1][myCol].mousePressed();}}
          //if(isValid(myRow-1,myCol-1)){
          //      if(!mines.contains(buttons[myRow-1][myCol-1])){
          //          buttons[myRow-1][myCol-1].mousePressed();}}
          //  if(isValid(myRow-1,myCol+1)){
          //      if(!mines.contains(buttons[myRow-1][myCol+1])){
          //          buttons[myRow-1][myCol+1].mousePressed();}}
          //  if(isValid(myRow,myCol-1)){
          //      if(!mines.contains(buttons[myRow][myCol-1])){
          //          buttons[myRow][myCol-1].mousePressed();}}
          //  if(isValid(myRow,myCol+1)){
          //      if(!mines.contains(buttons[myRow][myCol+1])){
          //          buttons[myRow][myCol+1].mousePressed();}}
          //  if(isValid(myRow+1,myCol-1))
          //      if(!mines.contains(buttons[myRow+1][myCol]))
          //          buttons[myRow+1][myCol-1].mousePressed();
          //  if(isValid(myRow+1,myCol))
          //      if(!mines.contains(buttons[myRow+1][myCol]))
          //          buttons[myRow+1][myCol].mousePressed();
          //  if(isValid(myRow+1,myCol+1))
          //      if(!mines.contains(buttons[myRow+1][myCol]))
          //          buttons[myRow+1][myCol+1].mousePressed();
          
          
        }
    }
    public void draw ()
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) )
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
