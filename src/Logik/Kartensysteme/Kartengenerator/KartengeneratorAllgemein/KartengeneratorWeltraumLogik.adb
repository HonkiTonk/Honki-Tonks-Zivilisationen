pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen;
with LadezeitenDatentypen;
with KartenKonstanten;
with Weltkarte;

with SchreibeWeltkarte;

with LadezeitenLogik;

package body KartengeneratorWeltraumLogik is

   procedure Weltraum
   is begin
      
      Kartenzeitwert := (Weltkarte.Karteneinstellungen.Kartengröße.YAchse + (25 - 1)) / 25;
      
      YAchseSchleife:
      for YAchseSchleifenwert in Weltkarte.KarteArray'First (2) .. Weltkarte.Karteneinstellungen.Kartengröße.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in Weltkarte.KarteArray'First (3) .. Weltkarte.Karteneinstellungen.Kartengröße.XAchse loop

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
