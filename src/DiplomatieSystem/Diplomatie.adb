pragma SPARK_Mode (On);

with GlobaleKonstanten;

with Auswahl, DiplomatischerZustand;

package body Diplomatie is

   procedure DiplomatieMenü
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      null;
      
   end DiplomatieMenü;



   function GegnerAngreifen
     (EigeneRasseExtern, GegnerischeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      case
        DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => EigeneRasseExtern,
                                                           FremdeRasseExtern => GegnerischeRasseExtern)
      is
         when GlobaleDatentypen.Neutral | GlobaleDatentypen.Offene_Grenzen =>
            if
              Auswahl.AuswahlJaNein (FrageZeileExtern => 11) = GlobaleKonstanten.JaKonstante
            then
               DiplomatischerZustand.KriegDurchDirektenAngriff (AngreifendeRasseExtern  => EigeneRasseExtern,
                                                                VerteidigendeRasseExtern => GegnerischeRasseExtern);
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

end Diplomatie;
