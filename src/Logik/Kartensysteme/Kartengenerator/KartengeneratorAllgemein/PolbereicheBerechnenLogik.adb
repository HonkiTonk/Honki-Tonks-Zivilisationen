with KartenartDatentypen;
with Weltkarte;

with LeseWeltkarteneinstellungen;

with KartengeneratorVariablenLogik;

package body PolbereicheBerechnenLogik is

   procedure PolbereicheBerechnen
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.YAchse := Weltkarte.Karte'First (2) + KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Norden_Enum);
      KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.YAchse := LeseWeltkarteneinstellungen.YAchse - KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Süden_Enum);
      
      KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.XAchse := Weltkarte.Karte'First (3) + KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Westen_Enum);
      KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.XAchse := LeseWeltkarteneinstellungen.XAchse - KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Osten_Enum);

   end PolbereicheBerechnen;

end PolbereicheBerechnenLogik;
