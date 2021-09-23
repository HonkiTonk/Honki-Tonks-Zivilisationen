pragma SPARK_Mode (On);

with Einlesen, Hauptmenue, Intro, SchreibenVerzeichnisse;

package body Spielstart is
   
   procedure Spielstart
   is begin

      SchreibenVerzeichnisse.SchreibenVerzeichnisse;
      Einlesen.Einlesen;

      Intro.Intro;
      Hauptmenue.Hauptmenü;
      
   end Spielstart;

end Spielstart;
