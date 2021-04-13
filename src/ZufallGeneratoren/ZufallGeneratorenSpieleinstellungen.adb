pragma SPARK_Mode (Off);

package body ZufallGeneratorenSpieleinstellungen is

   function Spieleinstellungen
     (WelcheEinstellungExtern : in Positive)
      return Positive
   is begin
      
      case
        WelcheEinstellungExtern
      is
         when 1 => -- Kartengröße wählen
            ZufälligeKartengrößeWählen.Reset (ZufälligeKartenGrößeGewählt);
            SpieleinstellungenAuswahl := ZufälligeKartengrößeWählen.Random (ZufälligeKartengrößeGewählt); 
            return SpieleinstellungenAuswahl;

         when 2 => -- Kartenart wählen
            ZufälligeKartenartWählen.Reset (ZufälligeKartenartGewählt);
            SpieleinstellungenAuswahl := ZufälligeKartenartWählen.Random (ZufälligeKartenartGewählt);
            return SpieleinstellungenAuswahl;

         when 3 => -- Kartentemperatur wählen
            ZufälligeKartentemperaturWählen.Reset (ZufälligeKartentemperaturGewählt);
            SpieleinstellungenAuswahl := ZufälligeKartentemperaturWählen.Random (ZufälligeKartentemperaturGewählt);
            return SpieleinstellungenAuswahl;

         when 4 .. 5 => -- Spieleranzahl oder Rasse wählen
            ZufälligeSpieleranzahlRasseWählen.Reset (ZufälligeSpieleranzahlRasseGewählt);
            SpieleinstellungenAuswahl := ZufälligeSpieleranzahlRasseWählen.Random (ZufälligeSpieleranzahlRasseGewählt);
            return SpieleinstellungenAuswahl;

         when 6 => -- Schwierigkeitsgrad wählen
            ZufälligenSchwierigkeitsgradWählen.Reset (ZufälligerSchwierigkeitsgradGewählt);
            SpieleinstellungenAuswahl := ZufälligenSchwierigkeitsgradWählen.Random (ZufälligerSchwierigkeitsgradGewählt);
            return SpieleinstellungenAuswahl;
              
         when others =>
            return 1;
      end case;
      
   end Spieleinstellungen;

end ZufallGeneratorenSpieleinstellungen;
