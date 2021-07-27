pragma SPARK_Mode (On);

with Diplomatie, KIDiplomatie;

package body KennenLernen is

   procedure Erstkontakt
     (EigeneRasseExtern, FremdeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        Diplomatie.DiplomatischenStatusPrüfen (EigeneRasseExtern => EigeneRasseExtern,
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
         Diplomatie.ErstkontaktMenschMensch (EigeneRasseExtern => EigeneRasseExtern,
                                             FremdeRasseExtern => FremdeRasseExtern);
      
      elsif
        GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = GlobaleDatentypen.Spieler_Mensch
        or
          GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) = GlobaleDatentypen.Spieler_Mensch
      then
         Diplomatie.ErstkontaktMenschKI (EigeneRasseExtern => EigeneRasseExtern,
                                         FremdeRasseExtern => FremdeRasseExtern);
         
      else
         KIDiplomatie.DiplomatieKIKI (EigeneRasseExtern   => EigeneRasseExtern,
                                      FremdeRasseKIExtern => FremdeRasseExtern);
      end if;
      
   end Erstkontakt;

end KennenLernen;
