pragma SPARK_Mode (On);

with GrafikStart, SchreibenVerzeichnisse, Einlesen, Intro, Hauptmenue;

procedure Start
is begin

   SchreibenVerzeichnisse.SchreibenVerzeichnisse;
   Einlesen.Einlesen;

   case
     GrafikStart.FensterErzeugen
   is
      when False =>
         return;

      when True =>
         Intro.Intro;
         Hauptmenue.Hauptmenü;
         GrafikStart.FensterEntfernen;
   end case;

end Start;
