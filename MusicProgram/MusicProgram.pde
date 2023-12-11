import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
//
//Global Variables
int appWidth, appHeight, smallerDimension;
Minim minim; //crates object to access all functions
AudioPlayer song1; // creates "playlist" variable holding extensions WAV, AIFF, AU, mp3
AudioMetaData songMetaData1; //stores everything from .mp3 properties TAB
Boolean loopOn = false;
float actionBarX, actionBarY, actionBarWidth, actionBarHeight;
float playPauseButtonX, playPauseButtonY, playPauseButtonWidth, playPauseButtonHeight;
void  setup() {
  //fullScreen();
  //size(300, 700); //Portrait size
  size(1200, 800);
  appWidth = width;
  appHeight = height;
  smallerDimension = (appWidth >= appHeight) ? appHeight : appWidth;
  //
  //Population
  actionBarX = appWidth*0;
  actionBarY = appHeight-actionBarHeight ;
  //make it at the bottom
  actionBarWidth =appWidth-1;
  actionBarHeight =appHeight*1/12;
  //
  playPauseButtonX = appWidth*1/2-playPauseButtonWidth;
  playPauseButtonY = appHeight*0;
  playPauseButtonWidth = appWidth*1/15;
  playPauseButtonHeight = appHeight*1/15;
  //
  //DIVs
  rect(actionBarX, actionBarY, actionBarWidth, actionBarHeight);
  rect(playPauseButtonX, playPauseButtonY, playPauseButtonWidth, playPauseButtonHeight);
  //
  minim = new Minim(this);
  String yoasobiIphone = "YOASOBI - Yoru ni Kakeru (iPhone Ringtone Remix).mp3";
  String TwelveSpeed = "Twelve Speed - Slynk.mp3";
  String extension = ".mp3";
  String pathway = "MusicUsed/";
  String path = sketchPath(pathway + yoasobiIphone);
  song1 = minim.loadFile(path);
  songMetaData1 = song1.getMetaData();
  //
  //
  //song1.loop(0);
  //
  // Meta Data PRintln Testing
  // for prototyping, print all info to the console  first
  //verifying meta data, 18 println's
  //println("?", songMetaData1.?());
  println("File Name", songMetaData1.fileName());
  //must use pure java at os level to list fileName before loading Playlist
  println("Song Length (in Milliseconds)", songMetaData1.length());
  println("Song Length (in Seconds)", songMetaData1.length()/1000);
  println("Song Length (in Minutes and Seconds)", songMetaData1.length()/); //?
  println("Song Title", songMetaData1.title());
  println("Author", songMetaData1.author());
  println("Composer", songMetaData1.composer());
  println("Orchestra", songMetaData1.orchestra());
  println("Album", songMetaData1.album());
  println("Disc", songMetaData1.disc());
  println("Publisher", songMetaData1.publisher());
  println("Date Released", songMetaData1.date());
  println("Copyright", songMetaData1.copyright());
  println("Comments", songMetaData1.comment());
  println("Lyrics", songMetaData1.lyrics()); //Optional: music and sing along (i have no lyrics in my songs...)
  println("Track", songMetaData1.track());
  println("Genre", songMetaData1.genre());
  println("Encoded", songMetaData1.encoded());
} //End setup
//
void draw() {
  //if (song1.isLooping() )println(there is

  //
  if ( song1.isLooping() && song1.loopCount()==-1 ) println("Looping Forever");
  if ( song1.isPlaying() && !song1.isLooping() ) println("Playing Once");
  //
  //println("Song Position", song1.position()/1000, "Song Length", song1.length()/1000 );
} //End draw
//
void keyPressed() {

  if (key == 'L' | key == 'l') {
    /*
    String songStr = String.valueOf(song1.position());
     int loopFix = int(songStr);*/
    if (song1.isLooping() && loopOn == true) {
      song1.loop(0);
    } else {
      song1.loop(-1);
    }

    if (loopOn==true) { //why does this fix mute button going to the start?????
      loopOn = false;
    } else {
      loopOn = true;
    }
  }

  //
  if (key == 'M' | key == 'm') {//MUTE Button
    //MUTE Behavior: stops electricy to speakers, does not stop file
    //NOTE: MUTE has NO built-in PAUSE button, NO built-in rewind button
    //ERROR: if song near end of file, user will not know song is at the end
    // Know ERROR: once song plays; MUTE acts like it doesn't work
    if (song1.isMuted()) {
      // ERROR song might not be playing
      //CATCH: ask .isPlaying() or !.isPlaying()
      song1.unmute();
    } else {
      //Possible ERROR: song could go back and go to the start; acts if its a play button
      song1.mute();
    }
  } //End MUTE
  //
  //Actual .skip() allows for variable ff and fr using .position()+-
  if (key == CODED && keyCode == RIGHT) song1.skip(1000);
  if (key == CODED && keyCode == LEFT) song1.skip(-1000);
  //
  if (key == CODED && keyCode == UP) song1.play(song1.length());  //song next or end
  //
  //Simple STOP Behaviour: ask if.playing()
  if (key == ' ') {
    if (song1.isPlaying() ) {
      song1.pause();
    } else {
      song1.play();
    }
  }
  //simple Pause Button
} //End keyPressed
//
void mousePressed() {
} //End mousePressed
//
//End MAIN Program
