with GlobaleDatentypen, GlobaleRecords, Karten, GlobaleVariablen;
use GlobaleDatentypen, GlobaleRecords;

package Sichtbarkeit is

   procedure SichtbarkeitsprüfungFürRasse (RasseExtern : in GlobaleDatentypen.Rassen);
   procedure SichtbarkeitsprüfungFürEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive) with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

   procedure SichtbarkeitsprüfungFürStadt (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive) with
     Pre => StadtNummer in GlobaleVariablen.StadtGebaut'Range (2);

   procedure Sichtbarkeit (InDerStadt : Boolean; EAchse : GlobaleDatentypen.EbeneVorhanden; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv; RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

   procedure Farben (Einheit : GlobaleDatentypen.EinheitenIDMitNullWert; Verbesserung : GlobaleDatentypen.KartenVerbesserung; Ressource, Grund : in GlobaleDatentypen.KartenGrund;
                     Cursor : in Boolean; RasseExtern, RasseIntern : in GlobaleDatentypen.RassenMitNullwert) with
     Pre => Grund >= 0 and Ressource >= 0;

private

   NichtSichtbar : constant Wide_Wide_Character := ' ';

   Sichtweite : GlobaleDatentypen.Sichtweite := 2;
   Wert : Integer;

   Kartenwert : GlobaleRecords.AchsenAusKartenfeldRecord;

end Sichtbarkeit;
