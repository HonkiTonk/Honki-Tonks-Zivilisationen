pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with DiplomatischerZustand;
with SystemDatentypen;

with KIDiplomatie;

package body KennenLernen is

   procedure Erstkontakt
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => EigeneRasseExtern,
                                                           FremdeRasseExtern => FremdeRasseExtern)
      is
         when SystemDatentypen.Unbekannt_Enum =>
            DiplomatischerZustand.DiplomatischenStatusÄndern (RasseEinsExtern   => EigeneRasseExtern,
                                                               RasseZweiExtern   => FremdeRasseExtern,
                                                               NeuerStatusExtern => SystemDatentypen.Neutral_Enum);
               
         when others =>
            return;
      end case;
      
      if
        GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = RassenDatentypen.Spieler_Mensch_Enum
        and
          GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) = RassenDatentypen.Spieler_Mensch_Enum
      then
         ErstkontaktMenschMensch (EigeneRasseExtern => EigeneRasseExtern,
                                  FremdeRasseExtern => FremdeRasseExtern);
      
      elsif
        GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = RassenDatentypen.Spieler_Mensch_Enum
        or
          GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) = RassenDatentypen.Spieler_Mensch_Enum
      then
         ErstkontaktMenschKI (EigeneRasseExtern => EigeneRasseExtern,
                              FremdeRasseExtern => FremdeRasseExtern);
         
      else
         KIDiplomatie.DiplomatieKIKI (EigeneRasseExtern   => EigeneRasseExtern,
                                      FremdeRasseKIExtern => FremdeRasseExtern);
      end if;
      
   end Erstkontakt;
   
   
   
   procedure ErstkontaktMenschMensch
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      null;
      
   end ErstkontaktMenschMensch;
   
   
   
   procedure ErstkontaktMenschKI
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      null;
      
   end ErstkontaktMenschKI;

end KennenLernen;
