pragma SPARK_Mode (On);

with GlobaleKonstanten, GlobaleDatentypen;
use GlobaleDatentypen;

with Karten, ZufallGeneratorenKarten;

package body KartenGeneratorRessourcen is

   -- Die Verteilung mehrmals loopen lassen? Einmal von oben zur mitte, von unten zur mitte, von mitte nach oben und von mitte nach unten?
   procedure GenerierungRessourcen
   is begin

      NochVerteilbareRessourcen := Karten.Kartengrößen (Karten.Kartengröße).Ressourcenmenge;

      RessourcenSchleife:
      while NochVerteilbareRessourcen /= 0 loop      
         YAchseSchleife:
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
            XAchseSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop            
               
               exit RessourcenSchleife when NochVerteilbareRessourcen = 0;

               BeliebigerRessourcenwert := ZufallGeneratorenKarten.ZufälligerWert;
               if
                 BeliebigerRessourcenwert >= 0.98
                 and
                   (Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund = GlobaleDatentypen.Wasser
                    or
                      Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund = GlobaleDatentypen.Küstengewässer)
               then
                  if
                    Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund = GlobaleDatentypen.Wasser
                    and
                      BeliebigerRessourcenwert > 0.99
                  then
                     Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Ressource := GlobaleDatentypen.Wal;
                     NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;
                           
                  else
                     Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Ressource := GlobaleDatentypen.Fisch;
                     NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;
                  end if;
                        
               elsif
                 BeliebigerRessourcenwert <= 0.05
                 and
                   Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund /= GlobaleDatentypen.Wasser
                 and
                   Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund /= GlobaleDatentypen.Küstengewässer
               then
                  if
                    BeliebigerRessourcenwert < 0.01
                  then
                     Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Ressource := GlobaleDatentypen.Eisen;
                     NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;                      

                  elsif
                    BeliebigerRessourcenwert < 0.02
                  then
                     Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Ressource := GlobaleDatentypen.Öl;
                     NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;                      

                  elsif
                    BeliebigerRessourcenwert < 0.03
                  then
                     Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Ressource := GlobaleDatentypen.Hochwertiger_Boden;
                     NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;                      

                  elsif
                    BeliebigerRessourcenwert < 0.04
                  then
                     Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Ressource := GlobaleDatentypen.Gold;
                     NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;                           
                           
                  else
                     Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Ressource := GlobaleDatentypen.Kohle;
                     NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;
                  end if;
                        
               else
                  null;
               end if;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop RessourcenSchleife;
      
   end GenerierungRessourcen;

end KartenGeneratorRessourcen;
