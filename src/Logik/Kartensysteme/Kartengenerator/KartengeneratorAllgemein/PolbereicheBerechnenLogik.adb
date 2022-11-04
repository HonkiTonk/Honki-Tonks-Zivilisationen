pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenartDatentypen;
with Weltkarte;

with KartengeneratorVariablenLogik;

package body PolbereicheBerechnenLogik is

   procedure PolbereicheBerechnen
   is begin
      
      KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.YAchse := Weltkarte.Karte'First (2) + KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Norden_Enum);
      KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.YAchse := Weltkarte.Karteneinstellungen.Kartengröße.YAchse - KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Süden_Enum);
      
      KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.XAchse := Weltkarte.Karte'First (3) + KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Westen_Enum);
      KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.XAchse := Weltkarte.Karteneinstellungen.Kartengröße.XAchse - KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Osten_Enum);

   end PolbereicheBerechnen;

end PolbereicheBerechnenLogik;
