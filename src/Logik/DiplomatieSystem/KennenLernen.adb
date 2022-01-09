pragma SPARK_Mode (On);

with DiplomatischerZustand;

with KIDiplomatie;

package body KennenLernen is

   procedure Erstkontakt
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => EigeneRasseExtern,
                                                           FremdeRasseExtern => FremdeRasseExtern)
      is
         when SystemDatentypen.Unbekannt =>
            DiplomatischerZustand.DiplomatischenStatusÄndern (RasseEinsExtern   => EigeneRasseExtern,
                                                               RasseZweiExtern   => FremdeRasseExtern,
                                                               NeuerStatusExtern => SystemDatentypen.Neutral);
               
         when others =>
            return;
      end case;
      
      if
        GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SystemDatentypen.Spieler_Mensch
        and
          GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) = SystemDatentypen.Spieler_Mensch
      then
         ErstkontaktMenschMensch (EigeneRasseExtern => EigeneRasseExtern,
                                  FremdeRasseExtern => FremdeRasseExtern);
      
      elsif
        GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SystemDatentypen.Spieler_Mensch
        or
          GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) = SystemDatentypen.Spieler_Mensch
      then
         ErstkontaktMenschKI (EigeneRasseExtern => EigeneRasseExtern,
                              FremdeRasseExtern => FremdeRasseExtern);
         
      else
         KIDiplomatie.DiplomatieKIKI (EigeneRasseExtern   => EigeneRasseExtern,
                                      FremdeRasseKIExtern => FremdeRasseExtern);
      end if;
      
   end Erstkontakt;
   
   
   
   procedure ErstkontaktMenschMensch
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      null;
      
   end ErstkontaktMenschMensch;
   
   
   
   procedure ErstkontaktMenschKI
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      null;
      
   end ErstkontaktMenschKI;

end KennenLernen;
