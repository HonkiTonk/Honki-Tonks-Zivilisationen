pragma SPARK_Mode (On);

with GrafikStart;
with SchreibenVerzeichnisse;
with Einlesen;
with Intro;
with Hauptmenue;

procedure Start
is begin

   GrafikStart.FensterErzeugen;

   SchreibenVerzeichnisse.SchreibenVerzeichnisse;
   Einlesen.Einlesen;

   Intro.Intro;
   Hauptmenue.Hauptmenü;

   GrafikStart.FensterEntfernen;

end Start;
