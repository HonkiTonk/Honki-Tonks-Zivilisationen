pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with LadezeitenDatentypen;

with FelderwerteFestlegen;
with Karten;
with LadezeitenLogik;

package body KartenfelderBewerten is
   
   -- Leerwert heineingeben um für alle Rassen die Werte zu berechnen, anderer Wert um für eine bestimmte Rasse die Werte zu berechnen.
   procedure KartenfelderBewerten
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
   is
      
      task Unterfläche;
      task Planetenkern;
      
      task body Unterfläche
      is begin
         
         Kartenbewertung (RasseExtern => RasseExtern,
                          EbeneExtern => -1);
         
      end Unterfläche;
      
      task body Planetenkern
      is begin
         
         Kartenbewertung (RasseExtern => RasseExtern,
                          EbeneExtern => -2);
         
      end Planetenkern;
      
   begin
         
      Kartenbewertung (RasseExtern => RasseExtern,
                       EbeneExtern => 0);
         
   end KartenfelderBewerten;
   
   
   
   procedure Kartenbewertung
     (RasseExtern : in RassenDatentypen.Rassen_Enum;
      EbeneExtern : in KartenDatentypen.EbenePlanet)
   is begin
      
      Kartenzeitwert (EbeneExtern) := (Karten.Karteneinstellungen.Kartengröße.YAchse + (33 - 1)) / 33;
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Karteneinstellungen.Kartengröße.YAchse loop
         XAchsSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Karteneinstellungen.Kartengröße.XAchse loop
               
            FelderwerteFestlegen.KartenfeldBewerten (RasseExtern       => RasseExtern,
                                                     KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert));
               
         end loop XAchsSchleife;
            
         case
           YAchseSchleifenwert mod Kartenzeitwert (EbeneExtern)
         is
            when 0 =>
               LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Bewerte_Kartenfelder_Enum);
               
            when others =>
               null;
         end case;
            
      end loop YAchseSchleife;
      
   end Kartenbewertung;

end KartenfelderBewerten;
