with KartenartDatentypen;
with KartenKonstanten;

with LeseWeltkarteneinstellungen;

with KartengeneratorVariablenLogik;

package body PolbereicheBerechnenLogik is

   procedure PolbereicheBerechnen
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
      
      KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Senkrechte := KartenKonstanten.AnfangSenkrechte + KartengeneratorVariablenLogik.SenkrechtePolgrößen (KartenartDatentypen.Norden_Enum);
      KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte := LeseWeltkarteneinstellungen.Senkrechte - KartengeneratorVariablenLogik.SenkrechtePolgrößen (KartenartDatentypen.Süden_Enum);
      
      KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Waagerechte := KartenKonstanten.AnfangWaagerechte + KartengeneratorVariablenLogik.WaagerechtePolgrößen (KartenartDatentypen.Westen_Enum);
      KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Waagerechte := LeseWeltkarteneinstellungen.Waagerechte - KartengeneratorVariablenLogik.WaagerechtePolgrößen (KartenartDatentypen.Osten_Enum);

   end PolbereicheBerechnen;

end PolbereicheBerechnenLogik;
