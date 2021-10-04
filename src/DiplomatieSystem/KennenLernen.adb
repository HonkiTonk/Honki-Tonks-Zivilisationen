pragma SPARK_Mode (On);

with DiplomatischerZustand;

with KIDiplomatie;

package body KennenLernen is

   procedure Erstkontakt
     (EigeneRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => EigeneRasseExtern,
                                                           FremdeRasseExtern => FremdeRasseExtern)
      is
         when SonstigeDatentypen.Unbekannt =>
            DiplomatischerZustand.DiplomatischenStatusÄndern (RasseEinsExtern   => EigeneRasseExtern,
                                                               RasseZweiExtern   => FremdeRasseExtern,
                                                               NeuerStatusExtern => SonstigeDatentypen.Neutral);
               
         when others =>
            return;
      end case;
      
      if
        GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SonstigeDatentypen.Spieler_Mensch
        and
          GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) = SonstigeDatentypen.Spieler_Mensch
      then
         ErstkontaktMenschMensch (EigeneRasseExtern => EigeneRasseExtern,
                                  FremdeRasseExtern => FremdeRasseExtern);
      
      elsif
        GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SonstigeDatentypen.Spieler_Mensch
        or
          GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) = SonstigeDatentypen.Spieler_Mensch
      then
         ErstkontaktMenschKI (EigeneRasseExtern => EigeneRasseExtern,
                              FremdeRasseExtern => FremdeRasseExtern);
         
      else
         KIDiplomatie.DiplomatieKIKI (EigeneRasseExtern   => EigeneRasseExtern,
                                      FremdeRasseKIExtern => FremdeRasseExtern);
      end if;
      
   end Erstkontakt;
   
   
   
   procedure ErstkontaktMenschMensch
     (EigeneRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      null;
      
   end ErstkontaktMenschMensch;
   
   
   
   procedure ErstkontaktMenschKI
     (EigeneRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      null;
      
   end ErstkontaktMenschKI;

end KennenLernen;
