pragma SPARK_Mode (On);

with Kampfsystem, Auswahl;

package body Diplomatie is

   procedure DiplomatieAuswählen is
   begin
      
      null;
      
   end DiplomatieAuswählen;



   procedure KriegDurchDirektenAngriff (AngreifendeRasse, VerteidigendeRasse : in GlobaleDatentypen.Rassen) is
   begin
      
      GlobaleVariablen.Diplomatie (AngreifendeRasse, VerteidigendeRasse) := -1;
      GlobaleVariablen.Diplomatie (VerteidigendeRasse, AngreifendeRasse) := -1;
      
   end KriegDurchDirektenAngriff;



   function DiplomatischenStatusPrüfen (AngreifendeRasse, VerteidigendeRasse : in GlobaleDatentypen.Rassen) return Integer is
   begin
      
      return GlobaleVariablen.Diplomatie (AngreifendeRasse, VerteidigendeRasse);
      
   end DiplomatischenStatusPrüfen;



   function GegnerAngreifenOderNicht (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord; Gegner : in GlobaleRecords.RasseUndPlatznummerRecord) return Boolean is
   begin

      Gewonnen := False;
      Angreifen := False;
      
      BereitsImKrieg := Diplomatie.DiplomatischenStatusPrüfen (AngreifendeRasse   => EinheitRasseUndNummer.Rasse,
                                                                VerteidigendeRasse => Gegner.Rasse);
      case BereitsImKrieg is
         when 1 .. 2 =>
            Wahl := Auswahl.AuswahlNeu (AuswahlOderAnzeige => True,
                                        FrageDatei         => 10,
                                        FrageZeile         => 11,
                                        TextDatei          => 5,
                                        ErsteZeile         => 10,
                                        LetzteZeile        => 11);
            case Wahl is
               when -3 =>
                  Angreifen := True;
                  --Diplomatie.KriegDurchDirektenAngriff (AngreifendeRasse   => EinheitRasseUndNummer.Rasse,
                  -- VerteidigendeRasse => Gegner.Rasse);
                  return True;   
                  
               when others =>
                  Angreifen := False;
            end case;
                  
         when -1 =>
            Angreifen := True;

         when others =>
            Angreifen := False;
      end case;
         
      case Angreifen is
         when True =>
            Gewonnen := Kampfsystem.KampfsystemNahkampf (GegnerStadtNummer           => Gegner.Platznummer,
                                                         RasseAngriff                => EinheitRasseUndNummer.Rasse,
                                                         EinheitenNummerAngriff      => EinheitRasseUndNummer.Platznummer,
                                                         RasseVerteidigung           => Gegner.Rasse,
                                                         EinheitenNummerVerteidigung => Gegner.Platznummer);
               
         when False =>
            return False;
      end case;
      
      return Gewonnen;
      
   end GegnerAngreifenOderNicht;

end Diplomatie;
