pragma SPARK_Mode (On);

with Kampfsystem, Auswahl;

package body Diplomatie is

   procedure DiplomatieAuswählen is
   begin
      
      null;
      
   end DiplomatieAuswählen;



   procedure KriegDurchDirektenAngriff (AngreifendeRasse, VerteidigendeRasse : in GlobaleDatentypen.Rassen) is
   begin
      
      GlobaleVariablen.Diplomatie (AngreifendeRasse, VerteidigendeRasse) := GlobaleVariablen.Krieg;
      GlobaleVariablen.Diplomatie (VerteidigendeRasse, AngreifendeRasse) := GlobaleVariablen.Krieg;
      
   end KriegDurchDirektenAngriff;



   function DiplomatischenStatusPrüfen (AngreifendeRasse, VerteidigendeRasse : in GlobaleDatentypen.Rassen) return GlobaleVariablen.StatusUntereinander is
   begin
      
      return GlobaleVariablen.Diplomatie (AngreifendeRasse, VerteidigendeRasse);
      
   end DiplomatischenStatusPrüfen;



   function GegnerAngreifenOderNicht (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; Gegner : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin

      Gewonnen := False;
      Angreifen := False;
      
      BereitsImKrieg := Diplomatie.DiplomatischenStatusPrüfen (AngreifendeRasse   => EinheitRasseNummer.Rasse,
                                                                VerteidigendeRasse => Gegner.Rasse);
      case BereitsImKrieg is
         when GlobaleVariablen.Neutral | GlobaleVariablen.Offene_Grenzen =>
            Wahl := Auswahl.AuswahlNeu (AuswahlOderAnzeige => True,
                                        FrageDatei         => 10,
                                        FrageZeile         => 11,
                                        TextDatei          => 5,
                                        ErsteZeile         => 10,
                                        LetzteZeile        => 11);
            case Wahl is
               when -3 =>
                  Angreifen := True;
                  --Diplomatie.KriegDurchDirektenAngriff (AngreifendeRasse   => EinheitRasseNummer.Rasse,
                  -- VerteidigendeRasse => Gegner.Rasse);
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
            Gewonnen := Kampfsystem.KampfsystemNahkampf (GegnerStadtNummer           => Gegner.Platznummer,
                                                         RasseAngriff                => EinheitRasseNummer.Rasse,
                                                         EinheitenNummerAngriff      => EinheitRasseNummer.Platznummer,
                                                         RasseVerteidigung           => Gegner.Rasse,
                                                         EinheitenNummerVerteidigung => Gegner.Platznummer);
               
         when False =>
            return False;
      end case;
      
      return Gewonnen;
      
   end GegnerAngreifenOderNicht;

end Diplomatie;
