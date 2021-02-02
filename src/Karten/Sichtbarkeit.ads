with GlobaleDatentypen, GlobaleRecords, Karten;
use GlobaleDatentypen, GlobaleRecords;

package Sichtbarkeit is

   procedure SichtbarkeitsprüfungFürRasse (RasseExtern : in GlobaleDatentypen.Rassen);
   procedure SichtbarkeitsprüfungFürEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive);
   procedure SichtbarkeitsprüfungFürStadt (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive);
   procedure Sichtbarkeit (InDerStadt : Boolean; EAchse : GlobaleDatentypen.Ebene; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv; RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => EAchse /= -3 and YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

   procedure Farben (Einheit : GlobaleDatentypen.EinheitenIDMitNullWert; Verbesserung : GlobaleDatentypen.KartenVerbesserung; Ressource, Grund : in GlobaleDatentypen.KartenGrund;
                     Cursor : in Boolean; RasseExtern, RasseIntern : in GlobaleDatentypen.RassenMitNullwert) with
     Pre => Grund >= 0 and Ressource >= 0;

private

   NichtSichtbar : constant Wide_Wide_Character := ' ';

   Sichtweite : GlobaleDatentypen.Sichtweite := 2;
   Wert : Integer;

   Kartenwert : GlobaleRecords.AchsenAusKartenfeldRecord;

end Sichtbarkeit;
