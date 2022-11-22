with DiplomatieDatentypen;

with LeseDiplomatie;

with DiplomatischerZustandLogik;

with KIDiplomatieLogik;

package body KennenlernenLogik is

   procedure Erstkontakt
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        LeseDiplomatie.AktuellerZustand (RasseEinsExtern => EigeneRasseExtern,
                                         RasseZweiExtern => FremdeRasseExtern)
      is
         when DiplomatieDatentypen.Unbekannt_Enum =>
            DiplomatischerZustandLogik.DiplomatischenStatusÄndern (RasseEinsExtern   => EigeneRasseExtern,
                                                                    RasseZweiExtern   => FremdeRasseExtern,
                                                                    NeuerStatusExtern => DiplomatieDatentypen.Neutral_Enum);
               
         when others =>
            return;
      end case;
      
      if
        LeseRassenbelegung.Belegung (RasseExtern => EigeneRasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
        and
          LeseRassenbelegung.Belegung (RasseExtern => FremdeRasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
      then
         ErstkontaktMenschMensch (EigeneRasseExtern => EigeneRasseExtern,
                                  FremdeRasseExtern => FremdeRasseExtern);
      
      elsif
        LeseRassenbelegung.Belegung (RasseExtern => EigeneRasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
        or
          LeseRassenbelegung.Belegung (RasseExtern => FremdeRasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
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
