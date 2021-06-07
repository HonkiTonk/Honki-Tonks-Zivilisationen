pragma SPARK_Mode (On);

with Kampfsystem, Auswahl;

package body Diplomatie is

   procedure DiplomatieAuswählen
   is begin
      
      null;
      
   end DiplomatieAuswählen;



   procedure KriegDurchDirektenAngriff
     (AngreifendeRasseExtern, VerteidigendeRasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      GlobaleVariablen.Diplomatie (AngreifendeRasseExtern, VerteidigendeRasseExtern) := GlobaleDatentypen.Krieg;
      GlobaleVariablen.Diplomatie (VerteidigendeRasseExtern, AngreifendeRasseExtern) := GlobaleDatentypen.Krieg;
      
   end KriegDurchDirektenAngriff;



   function DiplomatischenStatusPrüfen
     (AngreifendeRasseExtern, VerteidigendeRasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleDatentypen.StatusUntereinander
   is begin
      
      return GlobaleVariablen.Diplomatie (AngreifendeRasseExtern, VerteidigendeRasseExtern);
      
   end DiplomatischenStatusPrüfen;



   procedure GegnerAngreifenOderNicht
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GegnerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        Diplomatie.DiplomatischenStatusPrüfen (AngreifendeRasseExtern   => EinheitRasseNummerExtern.Rasse,
                                                VerteidigendeRasseExtern => GegnerExtern.Rasse)
      is
         when GlobaleDatentypen.Neutral | GlobaleDatentypen.Offene_Grenzen =>
            if
              Auswahl.AuswahlJaNein (FrageZeileExtern => 11) = -3
            then
               Diplomatie.KriegDurchDirektenAngriff (AngreifendeRasseExtern => EinheitRasseNummerExtern.Rasse,
                                                     VerteidigendeRasseExtern => GegnerExtern.Rasse);
                  
            else
               return;
            end if;
                  
         when GlobaleDatentypen.Krieg =>
            null;

         when others =>
            return;
      end case;
      
      Gewonnen := Kampfsystem.KampfsystemNahkampf (AngreiferRasseNummerExtern   => EinheitRasseNummerExtern,
                                                   VerteidigerRasseNummerExtern => GegnerExtern);
      
   end GegnerAngreifenOderNicht;

end Diplomatie;
