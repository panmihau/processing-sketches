static class TileParams {
  static final float minTileSize = 50;
  static final float maxTileSize = 200;
  static final int maxIterations = 10;
  
  static float tileSize = 100;
  static float triangleBase = 5;
  static float triangleTipX = 15;
  static float triangleTipY = 20;
  
  static PApplet pa = new PApplet();
  
  public static void randomizeAll() {
    tileSize = pa.random(50, 200);
    randomizeWithoutSize();
  }
  
  public static void randomizeWithoutSize() {
    triangleBase = pa.random(tileSize / 4);
    triangleTipX = pa.random(tileSize);
    triangleTipY = pa.random(tileSize / 8, tileSize);
  }
  
  public static void incrementRandomly() {
    PApplet pa = new PApplet();
    triangleTipX = triangleTipX + pa.random(-0.5, 0.5);
    triangleTipY = triangleTipY + pa.random(-0.5, 0.5);
  }
}

ArrayList<TriangleCutRectTile> tiles = new ArrayList<TriangleCutRectTile>();

void setup() {
  //size(500, 500);  
  fullScreen();
  noFill();
  strokeWeight(1);
  background(255);
  drawTiles();
}

void draw() {   //<>//
  background(255);
  TileParams.randomizeWithoutSize();
  drawTiles();
  delay(30);
}

void drawTiles() {
  createTiles(); //<>//
  
  for (TriangleCutRectTile tile : tiles) {
    tile.draw();
  }
}

void createTiles() {  
  for (int i = 0; i < tiles.size(); i++) { //<>//
    if (tiles.get(i).iteration > TileParams.maxIterations) {
      tiles.remove(i);
    } //<>//
  }
  
  float x;
  float y = -TileParams.tileSize;
  boolean firstTileA = true;
  
  while (y < height + TileParams.tileSize) {
    
    x = -TileParams.tileSize;
    boolean currentTileA = firstTileA;

    while (x < width + TileParams.tileSize) {      
      if (currentTileA) {
        addTileA(x, y);
        addTileA(x + TileParams.tileSize / 2, y + TileParams.tileSize / 2);
      } else {
        addTileB(x, y);
        addTileB(x + TileParams.tileSize / 2, y + TileParams.tileSize / 2);
      }
      
      currentTileA = !currentTileA;      
      
      x += TileParams.tileSize;
    }
    
    y += TileParams.tileSize;
    firstTileA = !firstTileA;
  }
}

void addTileA(float x, float y) {
    TriangleCutRectTile tile = new TriangleCutRectTileA(x, y);
    tiles.add(tile);
}

void addTileB(float x, float y) {
    TriangleCutRectTile tile = new TriangleCutRectTileB(x, y);
    tiles.add(tile);
}

class TriangleCutRectTile {
  protected float x;
  protected float y;
  public int iteration = 0;
  
  protected float tileSize;
  protected float triangleBase;
  protected float triangleTipX;
  protected float triangleTipY;
  
  public void draw() {
    stroke(255*(iteration/TileParams.maxIterations));
    stroke(25*iteration);
    line(x, y, x + triangleBase, y);
    line(x, y, x, y + triangleBase);
    
    line(x + tileSize, y, x + tileSize - triangleBase, y);
    
    line(x, y + tileSize, x, y + tileSize - triangleBase);
    
    iteration++;
  }
  
  public TriangleCutRectTile(float x, float y) {
    this.x = x;
    this.y = y;
    this.tileSize = TileParams.tileSize;
    this.triangleBase = TileParams.triangleBase;
    this.triangleTipX = TileParams.triangleTipX;
    this.triangleTipY = TileParams.triangleTipY;
  }
}

class TriangleCutRectTileA extends TriangleCutRectTile {
  
  public void draw() {
    super.draw();
    
    line(x + triangleBase, y, x + triangleTipX, y + triangleTipY);
    line(x + tileSize - triangleBase, y, x + triangleTipX, y + triangleTipY);
    
    line(x, y + triangleBase, x - triangleTipY, y + tileSize - triangleTipX);
    line(x, y + tileSize - triangleBase, x - triangleTipY, y + tileSize - triangleTipX);
  }
  
  public TriangleCutRectTileA(float x, float y) {
    super(x, y);
  }
}

class TriangleCutRectTileB extends TriangleCutRectTile {
  
  public void draw() {
    super.draw();
    
    line(x + triangleBase, y, x + tileSize - triangleTipX, y - triangleTipY);
    line(x + tileSize - triangleBase, y,x + tileSize - triangleTipX, y - triangleTipY);
    
    line(x, y + triangleBase, x + triangleTipY, y + triangleTipX);
    line(x, y + tileSize - triangleBase, x + triangleTipY, y + triangleTipX);
  }
  
  public TriangleCutRectTileB(float x, float y) {
    super(x, y);
  }
}