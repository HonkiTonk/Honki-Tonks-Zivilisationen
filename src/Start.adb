pragma SPARK_Mode (On);

with GlobaleTexte;

with Einlesen, Anzeige, Hauptmenue, Intro, SchreibenVerzeichnisse;

procedure Start
is begin

   SchreibenVerzeichnisse.SchreibenVerzeichnisse;
   Einlesen.Einlesen;

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
