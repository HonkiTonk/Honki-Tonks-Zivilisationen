pragma SPARK_Mode (On);

with GlobaleTexte;

with Einlesen, Anzeige, Hauptmenue, Intro, SchreibenVerzeichnisse, AllesAufStandardSetzen;

procedure Start
is begin

   SchreibenVerzeichnisse.SchreibenVerzeichnisse;

   case
     Einlesen.Einlesen
   is
      when True =>
         null;

      when False =>
         AllesAufStandardSetzen.AllesAufStandardSetzen;
   end case;

   Intro.Intro;
   Hauptmenue.Hauptmenü;

   Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                  TextDateiExtern        => GlobaleTexte.Start,
                                  ÜberschriftZeileExtern => 0,
                                  ErsteZeileExtern       => 8,
                                  LetzteZeileExtern      => 8,
                                  AbstandAnfangExtern    => GlobaleTexte.Neue_Zeile,
                                  AbstandMitteExtern     => GlobaleTexte.Leer,
                                  AbstandEndeExtern      => GlobaleTexte.Leer);

end Start;
