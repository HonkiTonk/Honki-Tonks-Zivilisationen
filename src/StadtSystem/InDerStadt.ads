with GlobaleRecords, GlobaleDatentypen;
use GlobaleDatentypen;

package InDerStadt is

   procedure InDerStadt (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive);
   procedure StadtProduktionPrüfen (RasseExtern : in GlobaleDatentypen.RassenMitNullwert; StadtNummer : in Natural);
   procedure BelegteStadtfelderFreigeben (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive);

   function StadtBauen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive) return Boolean;
   function StadtBauenPrüfen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive) return Boolean;

private

   BauMöglich : Boolean;

   Taste : Wide_Wide_Character;

   Überhang : Integer;
   Stadtart : Integer;
   Wahl : Integer;

   NutzbarerBereich : GlobaleDatentypen.Kartenfeld;
   RelativeCursorPositionY : GlobaleDatentypen.Kartenfeld;
   RelativeCursorPositionX : GlobaleDatentypen.Kartenfeld;

   KartenWert : GlobaleRecords.AchsenAusKartenfeldRecord;

   procedure StadtProduktionPrüfenBerechnung (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive);

end InDerStadt;
