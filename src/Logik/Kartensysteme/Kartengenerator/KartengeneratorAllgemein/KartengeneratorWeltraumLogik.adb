with KartengrundDatentypen;
with LadezeitenDatentypen;
with KartenKonstanten;

with SchreibeWeltkarte;
with LeseWeltkarteneinstellungen;

with LadezeitenLogik;

package body KartengeneratorWeltraumLogik is

   procedure Weltraum
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      Kartenzeitwert := (LeseWeltkarteneinstellungen.YAchse + (25 - 1)) / 25;
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse loop

            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.WeltraumKonstante, YAchseSchleifenwert, XAchseSchleifenwert),
                                          GrundExtern       => KartengrundDatentypen.Weltraum_Enum);
            
         end loop XAchseSchleife;
            
         case
           YAchseSchleifenwert mod Kartenzeitwert
         is
            when 0 =>
               LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Allgemeines_Enum);
               
            when others =>
               null;
         end case;
         
      end loop YAchseSchleife;
      
   end Weltraum;

end KartengeneratorWeltraumLogik;
