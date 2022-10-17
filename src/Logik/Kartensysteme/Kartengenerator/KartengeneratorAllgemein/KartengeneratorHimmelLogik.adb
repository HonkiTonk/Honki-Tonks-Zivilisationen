pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen;
with LadezeitenDatentypen;
with KartenKonstanten;

with SchreibeWeltkarte;

with Weltkarte;
with LadezeitenLogik;

package body KartengeneratorHimmelLogik is

   procedure Himmel
   is begin
      
      Kartenzeitwert := (Weltkarte.Karteneinstellungen.Kartengröße.YAchse + (25 - 1)) / 25;
               
      YAchseSchleife:
      for YAchseSchleifenwert in Weltkarte.KarteArray'First (2) .. Weltkarte.Karteneinstellungen.Kartengröße.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in Weltkarte.KarteArray'First (3) .. Weltkarte.Karteneinstellungen.Kartengröße.XAchse loop
               
            SchreibeWeltkarte.GleicherGrund (KoordinatenExtern => (KartenKonstanten.HimmelKonstante, YAchseSchleifenwert, XAchseSchleifenwert),
                                             GrundExtern       => KartengrundDatentypen.Wolken_Enum);
               
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
         
   end Himmel;

end KartengeneratorHimmelLogik;
