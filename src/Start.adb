pragma SPARK_Mode (On);

with GrafikStart, SchreibenVerzeichnisse, Einlesen, Intro, Hauptmenue;

procedure Start
is begin

   case
     GrafikStart.FensterErzeugen
   is
      when False =>
         return;

      when True =>
         null;
   end case;

   SchreibenVerzeichnisse.SchreibenVerzeichnisse;
   Einlesen.Einlesen;

   Intro.Intro;
   Hauptmenue.Hauptmenü;

   GrafikStart.FensterEntfernen;

end Start;
