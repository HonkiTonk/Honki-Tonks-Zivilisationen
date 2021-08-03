pragma SPARK_Mode (On);

with GlobaleKonstanten;

with Auswahl;

package body DiplomatischerZustand is

   procedure DiplomatischenStatusÄndern
     (RasseEinsExtern, RasseZweiExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      NeuerStatusExtern : in GlobaleDatentypen.Status_Untereinander_Enum)
   is begin
      
      GlobaleVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).AktuellerZustand := NeuerStatusExtern;
      GlobaleVariablen.Diplomatie (RasseZweiExtern, RasseEinsExtern).AktuellerZustand := NeuerStatusExtern;
      
      GlobaleVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).ZeitSeitLetzterÄnderung := 0;
      GlobaleVariablen.Diplomatie (RasseZweiExtern, RasseEinsExtern).ZeitSeitLetzterÄnderung := 0;
      
   end DiplomatischenStatusÄndern;



   function DiplomatischenStatusPrüfen
     (EigeneRasseExtern, FremdeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.Status_Untereinander_Enum
   is begin
      
      return GlobaleVariablen.Diplomatie (EigeneRasseExtern, FremdeRasseExtern).AktuellerZustand;
      
   end DiplomatischenStatusPrüfen;



   function GegnerAngreifen
     (EigeneRasseExtern, GegnerischeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      case
        DiplomatischenStatusPrüfen (EigeneRasseExtern => EigeneRasseExtern,
                                     FremdeRasseExtern => GegnerischeRasseExtern)
      is
         when GlobaleDatentypen.Neutral | GlobaleDatentypen.Offene_Grenzen =>
            if
              Auswahl.AuswahlJaNein (FrageZeileExtern => 11) = GlobaleKonstanten.JaKonstante
            then
               DiplomatischenStatusÄndern (RasseEinsExtern   => EigeneRasseExtern,
                                            RasseZweiExtern   => GegnerischeRasseExtern,
                                            NeuerStatusExtern => GlobaleDatentypen.Krieg);
               return True;
                  
            else
               return False;
            end if;
                  
         when GlobaleDatentypen.Krieg =>
            return True;

         when others =>
            return False;
      end case;
      
   end GegnerAngreifen;

end DiplomatischerZustand;
