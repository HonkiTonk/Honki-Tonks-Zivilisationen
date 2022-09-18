pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;

with Weltkarte;
with KartengeneratorVariablen;

package body PolbereicheBerechnenLogik is

   procedure PolbereicheBerechnen
   is begin
      
      KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse := Weltkarte.Karte'First (2) + KartengeneratorVariablen.Polgrößen (KartenDatentypen.Norden_Enum);
      KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse := Weltkarte.Karteneinstellungen.Kartengröße.YAchse - KartengeneratorVariablen.Polgrößen (KartenDatentypen.Süden_Enum);
      
      KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse := Weltkarte.Karte'First (3) + KartengeneratorVariablen.Polgrößen (KartenDatentypen.Westen_Enum);
      KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse := Weltkarte.Karteneinstellungen.Kartengröße.XAchse - KartengeneratorVariablen.Polgrößen (KartenDatentypen.Osten_Enum);

   end PolbereicheBerechnen;

end PolbereicheBerechnenLogik;
