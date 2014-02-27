import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;
float foclen=4.4;
float sensheight;
float realheight=239;
float camframheight;
float roomsize;
float [] pixeldist;
float [] anglesin;
float [] angle;
float [] zdist;
float [] distance;

void setup() {
  size(640, 480, P2D);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  video.start();
}

void draw() {
  scale(2);
  opencv.loadImage(video);

  image(video, 0, 0 );
  // fill(0);
  //noStroke();
  //rect(0,0,width,height);


  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  println(faces.length);

  for (int i = 0; i < faces.length; i++) {
    println(faces[i].x + "," + faces[i].y);
    // PVector v = new PVector(faces[i].x,0,40);

    // ellipse(v.x,v.z,10,10);
    ellipse(0, 0, 5, 5);
    ellipse(100, 0, 5, 5);

    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    for (int j =0; j<distance.length; j++) {
      
      distance[j]=(foclen*realheight*camframheight)/(faces[i].height * sensheight);

      pixeldist[j] = map(distance[j], 0, roomsize, 0, 640/2);//8elw mia array timwn
      anglesin [j] = faces[i].x/pixeldist[j];
      angle [j] = asin(anglesin[j]);
      zdist [j]= cos(angle[j])*pixeldist[j];
    //  println('zdist '+'[' + j + ']'+ ' is ' + zdist[j]);
    }
  }
}

void captureEvent(Capture c) {
  c.read();
}

