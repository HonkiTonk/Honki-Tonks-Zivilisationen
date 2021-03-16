pragma SPARK_Mode (On);

with Kampfsystem, Auswahl;

package body Diplomatie is

   procedure DiplomatieAuswählen is
   begin
      
      null;
      
   end DiplomatieAuswählen;



   procedure KriegDurchDirektenAngriff (AngreifendeRasseExtern, VerteidigendeRasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      GlobaleVariablen.Diplomatie (AngreifendeRasseExtern, VerteidigendeRasseExtern) := GlobaleVariablen.Krieg;
      GlobaleVariablen.Diplomatie (VerteidigendeRasseExtern, AngreifendeRasseExtern) := GlobaleVariablen.Krieg;
      
   end KriegDurchDirektenAngriff;



   function DiplomatischenStatusPrüfen (AngreifendeRasseExtern, VerteidigendeRasseExtern : in GlobaleDatentypen.Rassen) return GlobaleVariablen.StatusUntereinander is
   begin
      
      return GlobaleVariablen.Diplomatie (AngreifendeRasseExtern, VerteidigendeRasseExtern);
      
   end DiplomatischenStatusPrüfen;



   function GegnerAngreifenOderNicht (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; GegnerExtern : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin

      Gewonnen := False;
      Angreifen := False;
      
      BereitsImKrieg := Diplomatie.DiplomatischenStatusPrüfen (AngreifendeRasseExtern   => EinheitRasseNummerExtern.Rasse,
                                                                VerteidigendeRasseExtern => GegnerExtern.Rasse);
      case BereitsImKrieg is
         when GlobaleVariablen.Neutral | GlobaleVariablen.Offene_Grenzen =>
            Wahl := Auswahl.AuswahlJaNein (FrageZeileExtern => 11);
            case Wahl is
               when -3 =>
                  Angreifen := True;
                  -- Diplomatie.KriegDurchDirektenAngriff (AngreifendeRasseExtern => EinheitRasseNummerExtern.Rasse,
                  -- VerteidigendeRasseExtern => GegnerExtern.Rasse);
                  return True;   
                  
               when others =>
                  Angreifen := False;
            end case;
                  
         when GlobaleVariablen.Krieg =>
            Angreifen := True;

         when others =>
            Angreifen := False;
      end case;
         
      case Angreifen is
         when True =>
            Gewonnen := Kampfsystem.KampfsystemNahkampf (GegnerStadtNummerExtern           => GegnerExtern.Platznummer,
                                                         RasseAngriffExtern                => EinheitRasseNummerExtern.Rasse,
                                                         EinheitenNummerAngriffExtern      => EinheitRasseNummerExtern.Platznummer,
                                                         RasseVerteidigungExtern           => GegnerExtern.Rasse,
                                                         EinheitenNummerVerteidigungExtern => GegnerExtern.Platznummer);
               
         when False =>
            return False;
      end case;
      
      return Gewonnen;
      
   end GegnerAngreifenOderNicht;

end Diplomatie;
