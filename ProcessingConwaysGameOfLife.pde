void setup() {
  size(600, 600);
  frameRate(500);
  noStroke();
  cellHeight = height / (float) rowCount;
  cellWidth = width / (float) colCount;

   toggleLife(grid, 5,10, true);
   toggleLife(grid, 5,11, true);
   toggleLife(grid, 6,10, true);
   toggleLife(grid, 6,11, true);
   toggleLife(grid, 15,10, true);
   toggleLife(grid, 15,11, true);
   toggleLife(grid, 15,12, true);
   toggleLife(grid, 16,9, true);
   toggleLife(grid, 16,13, true);
   toggleLife(grid, 17,8, true);
   toggleLife(grid, 18,8, true);
   toggleLife(grid, 17,14, true);
   toggleLife(grid, 18,14, true);
   toggleLife(grid, 19,11, true);
   toggleLife(grid, 20,9, true);
   toggleLife(grid, 20,13, true);
   toggleLife(grid, 21,10, true);
   toggleLife(grid, 21,11, true);
   toggleLife(grid, 21,12, true);
   toggleLife(grid, 22,11, true);
   toggleLife(grid, 25,10, true);
   toggleLife(grid, 25,9, true);
   toggleLife(grid, 25,8, true);
   toggleLife(grid, 26,10, true);
   toggleLife(grid, 26,9, true);
   toggleLife(grid, 26,8, true);
   toggleLife(grid, 27,7, true);
   toggleLife(grid, 27,11, true);
   toggleLife(grid, 29,7, true);
   toggleLife(grid, 29,6, true);
   toggleLife(grid, 29,11, true);
   toggleLife(grid, 29,12, true);
   toggleLife(grid, 39,9, true);
   toggleLife(grid, 39,8, true);
   toggleLife(grid, 40,9, true);
   toggleLife(grid, 40,8, true);
   //*/
}

void toggleLife(boolean grid[][], int row, int col, boolean life) {
  if ((row >= 0 && row < rowCount) && (col >= 0 && col < rowCount)) {
    grid[row][col] = life;
  }
}


void drawGrid(boolean grid[][]) {
  for (i=0; i<rowCount; i++) {
    for (j=0; j<colCount; j++) {
      if (grid[i][j] == true)
        fill(200);
      else
        fill(100);

      rect(i*cellWidth, j*cellHeight, cellWidth, cellHeight);
    }
  }
}

//returns number of living neighbours
int checkNeighbours(int i, int j) {
  /* i-1 j, i-1 j-1, i-1 j+1,
   i j-1, i j+1
   i+1 j, i+1 j-1, i+1 j+1*/
  int number = 0;

  if (i > 0) {
    if (grid[i-1][j] == true)
      number ++;

    if (j < colCount-1 && grid[i-1][j+1] == true)
      number ++;

    if (j > 0 && grid[i-1][j-1] == true)
      number ++;
  }

  if (i < rowCount-1) {
    if (grid[i+1][j] == true)
      number ++;

    if (j > 0 && grid[i+1][j-1] == true)
      number ++;

    if (j < colCount-1 && grid[i+1][j+1] == true)
      number ++;
  }

  if (j > 0 && grid[i][j-1] == true)
    number ++;

  if (j < colCount-1 && grid[i][j+1] == true)
    number ++;

  return number;
}


void protocols() {
  for (int i=0; i<rowCount; i++) {
    for (int j=0; j<colCount; j++) {
      num = checkNeighbours(i, j);
      /*Any live cell with fewer than two live neighbours dies, as if caused by under-population.
       Any live cell with two or three live neighbours lives on to the next generation.
       Any live cell with more than three live neighbours dies, as if by over-population.
       Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.*/
      if (grid[i][j] == true) {
        if (num < 2 /*under pop*/ || num > 3 /*over pop*/)
          toggleLife(temp, i, j, false);
        else if (num == 3 /* three live neighbours*/ || num == 2 /* two live neighbours */)
          toggleLife(temp, i, j, true);
      }


      if (num == 3 && grid[i][j] == false)
        toggleLife(temp, i, j, true);
    }
  }
}

void copyGrid() {
  for (int i=0; i<rowCount; i++) {
    for (int j=0; j<colCount; j++) {
      grid[i][j] = temp[i][j];
      temp[i][j] = false;
    }
  }
}

int rowCount = 300, colCount = 300;
boolean grid[][] = new boolean[rowCount][colCount];
boolean temp[][] = new boolean[rowCount][colCount];
float cellHeight;
float cellWidth;
float x, y;
int i, j, num;
boolean run = false;

void draw() {
  background(0);
  drawGrid(grid);
  if(run == true){
    protocols();
    copyGrid();
  }
}

void keyPressed(){
  if(key != 'r'){
    if(run == false)
      run = true;
    else if(run == true)
      run = false;
  }
  else if(key == 'r'){
    for(int i=0;i<rowCount;i++){
      for(int j=0;j<colCount;j++){
        temp[i][j] = false;
        grid[i][j] = false;
      }
    }
    run = false;
  }
}

void mousePressed(){
  int x = (int)(mouseX/cellWidth);
  int y = (int)(mouseY/cellHeight);
  toggleLife(grid, x, y, true);   
}

void mouseDragged(){
  int x = (int)(mouseX/cellWidth);
  int y = (int)(mouseY/cellHeight);
  toggleLife(grid, x, y, true);  
}