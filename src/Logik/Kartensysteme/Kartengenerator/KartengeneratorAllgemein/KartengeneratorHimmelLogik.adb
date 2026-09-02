with KartengrundDatentypen;
with LadezeitenDatentypen;
with KartenKonstanten;

with SchreibeWeltkarte;
with LeseWeltkarteneinstellungen;

with LadezeitenLogik;

package body KartengeneratorHimmelLogik is

   procedure Himmel
   is begin
      
      LadezeitBasis := 100.00 / Float (LeseWeltkarteneinstellungen.Senkrechte);
      Ladezeit := LadezeitBasis;
               
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte loop
               
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.HimmelKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                          GrundExtern       => KartengrundDatentypen.Wolken_Enum);
               
         end loop WaagerechteSchleife;
         
         LadezeitenLogik.KartengeneratorSchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Allgemeines_Enum,
                                                   ZeitExtern            => Ladezeit);
               
         Ladezeit := LadezeitTesten (GrundwertExtern  => Ladezeit,
                                     ZusatzwertExtern => LadezeitBasis);
         
      end loop SenkrechteSchleife;
      
   end Himmel;

end KartengeneratorHimmelLogik;
