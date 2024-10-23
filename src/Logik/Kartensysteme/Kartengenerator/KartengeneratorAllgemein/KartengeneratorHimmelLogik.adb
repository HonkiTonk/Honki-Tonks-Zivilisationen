with KartengrundDatentypen;
with LadezeitenDatentypen;
with KartenKonstanten;

with SchreibeWeltkarte;
with LeseWeltkarteneinstellungen;

with LadezeitenLogik;

package body KartengeneratorHimmelLogik is

   procedure Himmel
   is
      use type KartenDatentypen.Senkrechte;
   begin
      
      Kartenzeitwert := Basiszeitwert (ZusatzwertExtern => LeseWeltkarteneinstellungen.Senkrechte,
                                       TeilerExtern     => 25);
               
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte loop
               
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.HimmelKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                          GrundExtern       => KartengrundDatentypen.Wolken_Enum);
               
         end loop WaagerechteSchleife;
         
         case
           SenkrechteSchleifenwert mod Kartenzeitwert
         is
            when 0 =>
               LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Allgemeines_Enum);
               
            when others =>
               null;
         end case;
         
      end loop SenkrechteSchleife;
         
   end Himmel;

end KartengeneratorHimmelLogik;
