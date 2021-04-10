pragma SPARK_Mode (On);

with GlobaleKonstanten, GlobaleDatentypen;
use GlobaleDatentypen;

with Karten, ZufallGeneratorenKarten;

package body KartenGeneratorRessourcen is

   procedure GenerierungRessourcen -- Die Verteilung mehrmals loopen lassen? Einmal von oben zur mitte, von unten zur mitte, von mitte nach oben und von mitte nach unten?
   is begin

      NochVerteilbareRessourcen := Karten.Kartengrößen (Karten.Kartengröße).Ressourcenmenge;

      while NochVerteilbareRessourcen /= 0 loop      
         YAchseSchleife:
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
            XAchseSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
               case
                 NochVerteilbareRessourcen
               is
                  when 0 =>
                     return;
                  
                  when others =>
                     null;
               end case;

               BeliebigerRessourcenwert := ZufallGeneratorenKarten.ZufälligerWert;
               if
                 BeliebigerRessourcenwert >= 0.98
                 and
                   (Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund = 2
                    or
                      Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund = 31)
               then
                  if
                    Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund = 2
                    and
                      BeliebigerRessourcenwert > 0.99
                  then
                     Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Ressource := 30;
                     NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;
                           
                  else
                     Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Ressource := 29;
                     NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;
                  end if;
                        
               elsif
                 BeliebigerRessourcenwert <= 0.05
                 and
                   Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund /= 2
                 and
                   Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund /= 31
               then
                  if
                    BeliebigerRessourcenwert < 0.01
                  then
                     Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Ressource := 11;
                     NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;                      

                  elsif
                    BeliebigerRessourcenwert < 0.02
                  then
                     Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Ressource := 12;
                     NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;                      

                  elsif
                    BeliebigerRessourcenwert < 0.03
                  then
                     Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Ressource := 13;
                     NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;                      

                  elsif
                    BeliebigerRessourcenwert < 0.04
                  then
                     Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Ressource := 33;
                     NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;                           
                           
                  else
                     Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Ressource := 10;
                     NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;
                  end if;
                        
               else
                  null;
               end if;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop;
      
   end GenerierungRessourcen;

end KartenGeneratorRessourcen;
