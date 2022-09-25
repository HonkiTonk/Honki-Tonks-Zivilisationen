pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;

with Weltkarte;
with KartengeneratorVariablenLogik;

package body PolbereicheBerechnenLogik is

   procedure PolbereicheBerechnen
   is begin
      
      KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.YAchse := Weltkarte.Karte'First (2) + KartengeneratorVariablenLogik.Polgrößen (KartenDatentypen.Norden_Enum);
      KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.YAchse := Weltkarte.Karteneinstellungen.Kartengröße.YAchse - KartengeneratorVariablenLogik.Polgrößen (KartenDatentypen.Süden_Enum);
      
      KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.XAchse := Weltkarte.Karte'First (3) + KartengeneratorVariablenLogik.Polgrößen (KartenDatentypen.Westen_Enum);
      KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.XAchse := Weltkarte.Karteneinstellungen.Kartengröße.XAchse - KartengeneratorVariablenLogik.Polgrößen (KartenDatentypen.Osten_Enum);

   end PolbereicheBerechnen;

end PolbereicheBerechnenLogik;
