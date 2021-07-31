pragma SPARK_Mode (On);

with DiplomatischerZustand;

with KIDiplomatie;

package body KennenLernen is

   procedure Erstkontakt
     (EigeneRasseExtern, FremdeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => EigeneRasseExtern,
                                                           FremdeRasseExtern => FremdeRasseExtern)
      is
         when GlobaleDatentypen.Leer =>
            GlobaleVariablen.Diplomatie (EigeneRasseExtern, FremdeRasseExtern) := GlobaleDatentypen.Neutral;   
               
         when others =>
            return;
      end case;
      
      if
        GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = GlobaleDatentypen.Spieler_Mensch
        and
          GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) = GlobaleDatentypen.Spieler_Mensch
      then
         ErstkontaktMenschMensch (EigeneRasseExtern => EigeneRasseExtern,
                                  FremdeRasseExtern => FremdeRasseExtern);
      
      elsif
        GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = GlobaleDatentypen.Spieler_Mensch
        or
          GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) = GlobaleDatentypen.Spieler_Mensch
      then
         ErstkontaktMenschKI (EigeneRasseExtern => EigeneRasseExtern,
                              FremdeRasseExtern => FremdeRasseExtern);
         
      else
         KIDiplomatie.DiplomatieKIKI (EigeneRasseExtern   => EigeneRasseExtern,
                                      FremdeRasseKIExtern => FremdeRasseExtern);
      end if;
      
   end Erstkontakt;
   
   
   
   procedure ErstkontaktMenschMensch
     (EigeneRasseExtern, FremdeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      null;
      
   end ErstkontaktMenschMensch;
   
   
   
   procedure ErstkontaktMenschKI
     (EigeneRasseExtern, FremdeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      null;
      
   end ErstkontaktMenschKI;

end KennenLernen;
