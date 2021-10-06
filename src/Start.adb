pragma SPARK_Mode (On);

with GrafikStart;
with SchreibenVerzeichnisse;
with Einlesen;
with Intro;
with Hauptmenue;
with GrafikFenster;
with GrafikAllgemein;

procedure Start
is begin

   case
     GrafikStart.FensterErzeugen
   is
      when False =>
         return;

      when True =>
         GrafikAllgemein.AllgemeinesFestlegen;
         GrafikFenster.FensterFarbe;
   end case;

   SchreibenVerzeichnisse.SchreibenVerzeichnisse;
   Einlesen.Einlesen;

   Intro.Intro;
   Hauptmenue.Hauptmenü;

   GrafikStart.FensterEntfernen;

end Start;
