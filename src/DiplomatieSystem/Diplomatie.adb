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
      
      GlobaleVariablen.Diplomatie (AngreifendeRasseExtern, VerteidigendeRasseExtern) := GlobaleVariablen.Krieg;
      GlobaleVariablen.Diplomatie (VerteidigendeRasseExtern, AngreifendeRasseExtern) := GlobaleVariablen.Krieg;
      
   end KriegDurchDirektenAngriff;



   function DiplomatischenStatusPrüfen
     (AngreifendeRasseExtern, VerteidigendeRasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleVariablen.StatusUntereinander
   is begin
      
      return GlobaleVariablen.Diplomatie (AngreifendeRasseExtern, VerteidigendeRasseExtern);
      
   end DiplomatischenStatusPrüfen;



   procedure GegnerAngreifenOderNicht
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GegnerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      BereitsImKrieg := Diplomatie.DiplomatischenStatusPrüfen (AngreifendeRasseExtern   => EinheitRasseNummerExtern.Rasse,
                                                                VerteidigendeRasseExtern => GegnerExtern.Rasse);
      case
        BereitsImKrieg
      is
         when GlobaleVariablen.Neutral | GlobaleVariablen.Offene_Grenzen =>
            Wahl := Auswahl.AuswahlJaNein (FrageZeileExtern => 11);
            case
              Wahl
            is
               when -3 =>
                  Diplomatie.KriegDurchDirektenAngriff (AngreifendeRasseExtern => EinheitRasseNummerExtern.Rasse,
                                                        VerteidigendeRasseExtern => GegnerExtern.Rasse);
                  
               when others =>
                  return;
            end case;
                  
         when GlobaleVariablen.Krieg =>
            null;

         when others =>
            return;
      end case;
      
      Gewonnen := Kampfsystem.KampfsystemNahkampf (GegnerStadtNummerExtern           => GegnerExtern.Platznummer,
                                                   RasseAngriffExtern                => EinheitRasseNummerExtern.Rasse,
                                                   EinheitenNummerAngriffExtern      => EinheitRasseNummerExtern.Platznummer,
                                                   RasseVerteidigungExtern           => GegnerExtern.Rasse,
                                                   EinheitenNummerVerteidigungExtern => GegnerExtern.Platznummer);
      
   end GegnerAngreifenOderNicht;

end Diplomatie;
