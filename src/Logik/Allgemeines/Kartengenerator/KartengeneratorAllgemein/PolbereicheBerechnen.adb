pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Karten;
with KartengeneratorVariablen;

package body PolbereicheBerechnen is

   procedure PolbereicheBerechnen
   is begin
      
      KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse := Karten.Weltkarte'First (2) + Karten.Polgrößen (KartenDatentypen.Norden_Enum);
      KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse := Karten.Kartenparameter.Kartengröße.YAchse - Karten.Polgrößen (KartenDatentypen.Süden_Enum);
      
      KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse := Karten.Weltkarte'First (3) + Karten.Polgrößen (KartenDatentypen.Westen_Enum);
      KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse := Karten.Kartenparameter.Kartengröße.XAchse - Karten.Polgrößen (KartenDatentypen.Osten_Enum);

   end PolbereicheBerechnen;

end PolbereicheBerechnen;
