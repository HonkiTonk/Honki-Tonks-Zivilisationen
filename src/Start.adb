pragma SPARK_Mode (On);

with SchreibenVerzeichnisse;
with Einlesen;
with Intro;
with Hauptmenue;
with EinlesenEinstellungen;
with GrafikStartEnde;

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
