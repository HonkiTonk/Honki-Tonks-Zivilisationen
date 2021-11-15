pragma SPARK_Mode (On);

with GrafikStartEnde;
with SchreibenVerzeichnisse;
with Einlesen;
with Intro;
with Hauptmenue;
with EinlesenEinstellungen;

procedure Start
is begin

   SchreibenVerzeichnisse.SchreibenVerzeichnisse;
   EinlesenEinstellungen.EinlesenEinstellungen;

   GrafikStartEnde.FensterErzeugen;
   Einlesen.Einlesen;

   Intro.Intro;
   Hauptmenue.Hauptmenü;

   GrafikStartEnde.FensterEntfernen;

end Start;
