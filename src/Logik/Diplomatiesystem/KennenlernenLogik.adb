pragma Warnings (Off, "*array aggregate*");

with DiplomatieDatentypen;

with DiplomatischerZustandLogik;

with KIDiplomatieLogik;

package body KennenlernenLogik is

   procedure Erstkontakt
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        DiplomatischerZustandLogik.DiplomatischenStatusPrüfen (EigeneRasseExtern => EigeneRasseExtern,
                                                                FremdeRasseExtern => FremdeRasseExtern)
      is
         when DiplomatieDatentypen.Unbekannt_Enum =>
            DiplomatischerZustandLogik.DiplomatischenStatusÄndern (RasseEinsExtern   => EigeneRasseExtern,
                                                                    RasseZweiExtern   => FremdeRasseExtern,
                                                                    NeuerStatusExtern => DiplomatieDatentypen.Neutral_Enum);
               
         when others =>
            return;
      end case;
      
      if
        SpielVariablen.Rassenbelegung (EigeneRasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
        and
          SpielVariablen.Rassenbelegung (FremdeRasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
      then
         ErstkontaktMenschMensch (EigeneRasseExtern => EigeneRasseExtern,
                                  FremdeRasseExtern => FremdeRasseExtern);
      
      elsif
        SpielVariablen.Rassenbelegung (EigeneRasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
        or
          SpielVariablen.Rassenbelegung (FremdeRasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
      then
         ErstkontaktMenschKI (EigeneRasseExtern => EigeneRasseExtern,
                              FremdeRasseExtern => FremdeRasseExtern);
         
      else
         KIDiplomatieLogik.DiplomatieKIKI (EigeneRasseExtern   => EigeneRasseExtern,
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

end KennenlernenLogik;
