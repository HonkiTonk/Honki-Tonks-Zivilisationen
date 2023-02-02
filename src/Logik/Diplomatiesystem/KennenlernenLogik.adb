with DiplomatieDatentypen;

with LeseDiplomatie;

with DiplomatischerZustandLogik;

with KIDiplomatieLogik;

package body KennenlernenLogik is

   procedure Erstkontakt
     (EigeneSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      FremdeSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      case
        LeseDiplomatie.AktuellerZustand (SpeziesEinsExtern => EigeneSpeziesExtern,
                                         SpeziesZweiExtern => FremdeSpeziesExtern)
      is
         when DiplomatieDatentypen.Unbekannt_Enum =>
            DiplomatischerZustandLogik.DiplomatischenStatusÄndern (SpeziesEinsExtern => EigeneSpeziesExtern,
                                                                    SpeziesZweiExtern => FremdeSpeziesExtern,
                                                                    NeuerStatusExtern => DiplomatieDatentypen.Neutral_Enum);
               
         when others =>
            return;
      end case;
      
      if
        LeseSpeziesbelegung.Belegung (SpeziesExtern => EigeneSpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
        and
          LeseSpeziesbelegung.Belegung (SpeziesExtern => FremdeSpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
      then
         ErstkontaktMenschMensch (EigeneSpeziesExtern => EigeneSpeziesExtern,
                                  FremdeSpeziesExtern => FremdeSpeziesExtern);
      
      elsif
        LeseSpeziesbelegung.Belegung (SpeziesExtern => EigeneSpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
        or
          LeseSpeziesbelegung.Belegung (SpeziesExtern => FremdeSpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
      then
         ErstkontaktMenschKI (EigeneSpeziesExtern => EigeneSpeziesExtern,
                              FremdeSpeziesExtern => FremdeSpeziesExtern);
         
      else
         KIDiplomatieLogik.DiplomatieKIKI (EigeneSpeziesExtern   => EigeneSpeziesExtern,
                                           FremdeSpeziesKIExtern => FremdeSpeziesExtern);
      end if;
      
   end Erstkontakt;
   
   
   
   procedure ErstkontaktMenschMensch
     (EigeneSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      FremdeSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      null;
      
   end ErstkontaktMenschMensch;
   
   
   
   procedure ErstkontaktMenschKI
     (EigeneSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      FremdeSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      null;
      
   end ErstkontaktMenschKI;

end KennenlernenLogik;
