pragma SPARK_Mode (On);

with GrafikStart, SchreibenVerzeichnisse, Einlesen, Intro, Hauptmenue, GrafikFenster;

procedure Start
is begin

   case
     GrafikStart.FensterErzeugen
   is
      when False =>
         return;

      when True =>
         GrafikFenster.FensterFarbe;
   end case;

   SchreibenVerzeichnisse.SchreibenVerzeichnisse;
   Einlesen.Einlesen;

   Intro.Intro;
   Hauptmenue.Hauptmenü;

   GrafikStart.FensterEntfernen;

end Start;
