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
            return ZufälligeKartengrößeWählen.Random (ZufälligeKartengrößeGewählt); 

         when 2 => -- Kartenart wählen
            ZufälligeKartenartWählen.Reset (ZufälligeKartenartGewählt);
            return ZufälligeKartenartWählen.Random (ZufälligeKartenartGewählt);

         when 3 => -- Kartentemperatur wählen
            ZufälligeKartentemperaturWählen.Reset (ZufälligeKartentemperaturGewählt);
            return ZufälligeKartentemperaturWählen.Random (ZufälligeKartentemperaturGewählt);

         when 4 .. 5 => -- Spieleranzahl oder Rasse wählen
            ZufälligeSpieleranzahlRasseWählen.Reset (ZufälligeSpieleranzahlRasseGewählt);
            return ZufälligeSpieleranzahlRasseWählen.Random (ZufälligeSpieleranzahlRasseGewählt);

         when 6 => -- Schwierigkeitsgrad wählen
            ZufälligenSchwierigkeitsgradWählen.Reset (ZufälligerSchwierigkeitsgradGewählt);
            return ZufälligenSchwierigkeitsgradWählen.Random (ZufälligerSchwierigkeitsgradGewählt);
              
         when others =>
            return 1;
      end case;
      
   end Spieleinstellungen;

end ZufallGeneratorenSpieleinstellungen;
