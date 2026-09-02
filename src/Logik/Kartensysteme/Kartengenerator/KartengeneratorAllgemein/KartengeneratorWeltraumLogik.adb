with KartengrundDatentypen;
with LadezeitenDatentypen;
with KartenKonstanten;

with SchreibeWeltkarte;
with LeseWeltkarteneinstellungen;

with LadezeitenLogik;

package body KartengeneratorWeltraumLogik is

   procedure Weltraum
     (LadezeitbasisExtern : in Float)
   is begin
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte loop

            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.WeltraumKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                          GrundExtern       => KartengrundDatentypen.Weltraum_Enum);
            
         end loop WaagerechteSchleife;
         
         LadezeitenLogik.KartengeneratorSchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Allgemeines_Enum,
                                                   ZeitExtern            => LadezeitbasisExtern);
         
      end loop SenkrechteSchleife;
      
   end Weltraum;

end KartengeneratorWeltraumLogik;
