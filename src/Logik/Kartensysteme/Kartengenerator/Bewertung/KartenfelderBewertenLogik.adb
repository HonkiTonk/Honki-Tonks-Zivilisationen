pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with LadezeitenDatentypen;

with FelderwerteFestlegenLogik;
with Weltkarte;
with LadezeitenLogik;

package body KartenfelderBewertenLogik is
   
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
      
      Kartenzeitwert (EbeneExtern) := (Weltkarte.Karteneinstellungen.Kartengröße.YAchse + (33 - 1)) / 33;
      
      YAchseSchleife:
      for YAchseSchleifenwert in Weltkarte.KarteArray'First (2) .. Weltkarte.Karteneinstellungen.Kartengröße.YAchse loop
         XAchsSchleife:
         for XAchseSchleifenwert in Weltkarte.KarteArray'First (3) .. Weltkarte.Karteneinstellungen.Kartengröße.XAchse loop
               
            FelderwerteFestlegenLogik.KartenfeldBewerten (RasseExtern       => RasseExtern,
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

end KartenfelderBewertenLogik;
