/*
  * Mirror 2 Rainbow Gradient
  * Remix by Evan Rost. 
*/
 
import processing.video.*;

// Size of each cell in the grid
int cellSize = 5;

// Number of columns and rows in our system
int cols, 
    rows;
    
// Initialize gradient value     
float gradient;

// Variable for capture device
Capture video;

void setup() {
  
  size(640, 480, P3D);
  
  // Set up columns and rows
  cols = width / cellSize;
  rows = height / cellSize;
  
  //
  colorMode(HSB);
  rectMode(CENTER);

  // Default video input
  video = new Capture(this, width, height);
  
  // Start capturing the images from the camera
  video.start();  
  
}

void draw() { 
  //
  background(0);
  
  //
  if (video.available()){
    video.read();
    video.loadPixels();
 }
 
    // Begin loop for columns
    for (int i = 0; i < cols;i++) {
      
      // Begin loop for rows
      for (int j = 0; j < rows;j++) {

        // Where are we, pixel-wise?
        int x = i * cellSize;
        int y = j * cellSize; 
        
        //
        int hsbMax = 255;
        
        // Reversing x to mirror the image
        int loc = (video.width - x - 1) + y*video.width; 
        
        //         //
        //GRADIENTS//
        //         //
        
        // Diagonal rainbow gradient
        //gradient = ( (((float)i + (float)j) * (float)cols) / (( (float)cols * (float)rows)) * hsbMax);
        
        //Diagonal rotating rainbow gradient
        //gradient = ( ((((float)i + (float)j) * (float)cols) / (( (float)cols * (float)rows)) * hsbMax) + frameCount) % hsbMax;
        
        //Top down rainbow gradient
        //gradient = ((float)i / (float)cols) * hsbMax;
        
        //Top down rotating rainbow gradient
        gradient = ((((float)i / (float)cols) * hsbMax) + frameCount) % hsbMax;
       
        // Each rect is colored white with a size determined by brightness
        color c = video.pixels[loc];
        float sz = (brightness(c) / 255.0) * cellSize;
        
        fill(gradient, 225, 255);
        noStroke();


        //rect(x + cellSize/2, y + cellSize/2, sz, sz);
        
        //triangle(i, j, x, y, sz, sz);
        ellipse(x + cellSize/2, y + cellSize/2, sz, sz);
        //line(x + cellSize/2, y + cellSize/2, c, c);
       
        rotate( ((float)i * PI) - ((float)j * PI));
      }
    }
  }
