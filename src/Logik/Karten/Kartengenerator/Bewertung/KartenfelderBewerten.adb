pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with LadezeitenDatentypen;

with FelderwerteFestlegen;
with Karten;
with LadezeitenLogik;

-- Den Aufbau hier an die Berechnungen der Ressourcenaufbau anpassen.
package body KartenfelderBewerten is

   -- Leerwert heineingeben um für alle Rassen die Werte zu berechnen, anderer Wert um für eine bestimmte Rasse die Werte zu berechnen.
   procedure KartenfelderBewerten
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
   is

      task Unterfläche;
      task Planetenkern;
      
      task body Unterfläche
      is begin
         
         -- Das mit den Teiler noch einmal überarbeiten. äöü
         Unterflächenteiler := Karten.Karteneinstellungen.Kartengröße.YAchse / 33 + 1;
         
         YAchseUnterwasserSchleife:
         for YAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Karteneinstellungen.Kartengröße.YAchse loop
            XAchseUnterwasserSchleife:
            for XAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Karteneinstellungen.Kartengröße.XAchse loop
               
               FelderwerteFestlegen.KartenfeldBewerten (RasseExtern       => RasseExtern,
                                                        KoordinatenExtern => (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert));
               
            end loop XAchseUnterwasserSchleife;
            
            case
              YAchseUnterwasserSchleifenwert mod Unterflächenteiler
            is
               when 0 =>
                  LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Bewerte_Kartenfelder_Enum);
               
               when others =>
                  null;
            end case;
            
         end loop YAchseUnterwasserSchleife;
         
      end Unterfläche;
      
      
      
      task body Planetenkern
      is begin
         
         Kernflächenteiler := Karten.Karteneinstellungen.Kartengröße.YAchse / 33 + 1;
         
         YAchseInneresSchleife:
         for YAchseInneresSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Karteneinstellungen.Kartengröße.YAchse loop
            XAchseInneresSchleife:
            for XAchseInneresSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Karteneinstellungen.Kartengröße.XAchse loop
               
               FelderwerteFestlegen.KartenfeldBewerten (RasseExtern       => RasseExtern,
                                                        KoordinatenExtern => (-2, YAchseInneresSchleifenwert, XAchseInneresSchleifenwert));
               
            end loop XAchseInneresSchleife;
            
            case
              YAchseInneresSchleifenwert mod Kernflächenteiler
            is
               when 0 =>
                  LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Bewerte_Kartenfelder_Enum);
               
               when others =>
                  null;
            end case;
            
         end loop YAchseInneresSchleife;
         
      end Planetenkern;
      
   begin
         
      Oberflächenteiler := Karten.Karteneinstellungen.Kartengröße.YAchse / 33 + 1;
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Karteneinstellungen.Kartengröße.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Karteneinstellungen.Kartengröße.XAchse loop
            
            FelderwerteFestlegen.KartenfeldBewerten (RasseExtern       => RasseExtern,
                                                     KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));
               
         end loop XAchseSchleife;
            
         case
           YAchseSchleifenwert mod Oberflächenteiler
         is
            when 0 =>
               LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Bewerte_Kartenfelder_Enum);
               
            when others =>
               null;
         end case;
         
      end loop YAchseSchleife;
      
      LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Bewerte_Kartenfelder_Enum);
   
   end KartenfelderBewerten;

end KartenfelderBewerten;
