pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;

with Karten;
with KartengeneratorVariablen;

package body PolbereicheBerechnen is

   procedure PolbereicheBerechnen
   is begin
      
      KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse := Karten.Weltkarte'First (2) + KartengeneratorVariablen.Polgrößen (KartenDatentypen.Norden_Enum);
      KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse := Karten.Karteneinstellungen.Kartengröße.YAchse - KartengeneratorVariablen.Polgrößen (KartenDatentypen.Süden_Enum);
      
      KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse := Karten.Weltkarte'First (3) + KartengeneratorVariablen.Polgrößen (KartenDatentypen.Westen_Enum);
      KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse := Karten.Karteneinstellungen.Kartengröße.XAchse - KartengeneratorVariablen.Polgrößen (KartenDatentypen.Osten_Enum);

   end PolbereicheBerechnen;

end PolbereicheBerechnen;
