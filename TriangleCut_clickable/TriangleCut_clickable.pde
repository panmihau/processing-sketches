static class TileParams {
  static final float minTileSize = 50;
  static final float maxTileSize = 200;
  
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
    triangleTipY = pa.random(tileSize / 8, tileSize / 2);
  }
  
  public static void incrementRandomly() {
    PApplet pa = new PApplet();
    triangleTipX = triangleTipX + pa.random(-0.5, 0.5);
    triangleTipY = triangleTipY + pa.random(-0.5, 0.5);
  }
}

ArrayList<TriangleCutRectTile> tiles = new ArrayList<TriangleCutRectTile>();

void setup() {
  size(1000, 800);  
  noFill();
  strokeWeight(1);
  background(255);
  drawTiles();
}

void draw() {   //<>//
}

void mousePressed() {
  if (mouseButton == LEFT) {
    background(255);
    TileParams.randomizeAll();
    drawTiles();
  } else {
    TileParams.randomizeWithoutSize();
    drawTiles();
  }  
}

void drawTiles() {
  createTiles();
  
  for (TriangleCutRectTile tile : tiles) {
    tile.draw();
  }
}

void createTiles() {  
  tiles.clear();
  
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
  
  public void draw() {
    line(x, y, x + TileParams.triangleBase, y);
    line(x, y, x, y + TileParams.triangleBase);
    
    line(x + TileParams.tileSize, y, x + TileParams.tileSize - TileParams.triangleBase, y);
    
    line(x, y + TileParams.tileSize, x, y + TileParams.tileSize - TileParams.triangleBase);
  }
  
  public TriangleCutRectTile(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

class TriangleCutRectTileA extends TriangleCutRectTile {
  
  public void draw() {
    super.draw();
    
    line(x + TileParams.triangleBase, y, x + TileParams.triangleTipX, y + TileParams.triangleTipY);
    line(x + TileParams.tileSize - TileParams.triangleBase, y, x + TileParams.triangleTipX, y + TileParams.triangleTipY);
    
    line(x, y + TileParams.triangleBase, x - TileParams.triangleTipY, y + TileParams.tileSize - TileParams.triangleTipX);
    line(x, y + TileParams.tileSize - TileParams.triangleBase, x - TileParams.triangleTipY, y + TileParams.tileSize - TileParams.triangleTipX);
  }
  
  public TriangleCutRectTileA(float x, float y) {
    super(x, y);
  }
}

class TriangleCutRectTileB extends TriangleCutRectTile {
  
  public void draw() {
    super.draw();
    
    line(x + TileParams.triangleBase, y, x + TileParams.tileSize - TileParams.triangleTipX, y - TileParams.triangleTipY);
    line(x + TileParams.tileSize - TileParams.triangleBase, y,x + TileParams.tileSize - TileParams.triangleTipX, y - TileParams.triangleTipY);
    
    line(x, y + TileParams.triangleBase, x + TileParams.triangleTipY, y + TileParams.triangleTipX);
    line(x, y + TileParams.tileSize - TileParams.triangleBase, x + TileParams.triangleTipY, y + TileParams.triangleTipX);
  }
  
  public TriangleCutRectTileB(float x, float y) {
    super(x, y);
  }
}