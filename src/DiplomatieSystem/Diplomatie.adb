pragma SPARK_Mode (On);

with GlobaleKonstanten;

with Auswahl;

package body Diplomatie is

   procedure DiplomatieAuswählen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      null;
      
   end DiplomatieAuswählen;
   
   
   
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



   procedure KriegDurchDirektenAngriff
     (AngreifendeRasseExtern, VerteidigendeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      GlobaleVariablen.Diplomatie (AngreifendeRasseExtern, VerteidigendeRasseExtern) := GlobaleDatentypen.Krieg;
      GlobaleVariablen.Diplomatie (VerteidigendeRasseExtern, AngreifendeRasseExtern) := GlobaleDatentypen.Krieg;
      
   end KriegDurchDirektenAngriff;



   function DiplomatischenStatusPrüfen
     (EigeneRasseExtern, FremdeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.Status_Untereinander_Enum
   is begin
      
      return GlobaleVariablen.Diplomatie (EigeneRasseExtern, FremdeRasseExtern);
      
   end DiplomatischenStatusPrüfen;



   function GegnerAngreifen
     (EigeneRasseExtern, GegnerischeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      case
        Diplomatie.DiplomatischenStatusPrüfen (EigeneRasseExtern => EigeneRasseExtern,
                                                FremdeRasseExtern => GegnerischeRasseExtern)
      is
         when GlobaleDatentypen.Neutral | GlobaleDatentypen.Offene_Grenzen =>
            if
              Auswahl.AuswahlJaNein (FrageZeileExtern => 11) = GlobaleKonstanten.JaKonstante
            then
               Diplomatie.KriegDurchDirektenAngriff (AngreifendeRasseExtern => EigeneRasseExtern,
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
