pragma SPARK_Mode (On);

with GrafikStart;
with SchreibenVerzeichnisse;
with Einlesen;
with Intro;
with Hauptmenue;
with EinlesenEinstellungen;

procedure Start
is begin

   SchreibenVerzeichnisse.SchreibenVerzeichnisse;
   EinlesenEinstellungen.EinlesenEinstellungen;

   GrafikStart.FensterErzeugen;
   Einlesen.Einlesen;

   Intro.Intro;
   Hauptmenue.Hauptmenü;

   GrafikStart.FensterEntfernen;

end Start;
