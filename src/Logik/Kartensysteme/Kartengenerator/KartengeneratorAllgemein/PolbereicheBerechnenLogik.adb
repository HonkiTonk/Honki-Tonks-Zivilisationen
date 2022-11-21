with KartenartDatentypen;
with KartenKonstanten;

with LeseWeltkarteneinstellungen;

with KartengeneratorVariablenLogik;

package body PolbereicheBerechnenLogik is

   procedure PolbereicheBerechnen
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.YAchse := KartenKonstanten.AnfangYAchse + KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Norden_Enum);
      KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.YAchse := LeseWeltkarteneinstellungen.YAchse - KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Süden_Enum);
      
      KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.XAchse := KartenKonstanten.AnfangXAchse + KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Westen_Enum);
      KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.XAchse := LeseWeltkarteneinstellungen.XAchse - KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Osten_Enum);

   end PolbereicheBerechnen;

end PolbereicheBerechnenLogik;
