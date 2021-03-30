pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

with Karten;

package BewegungssystemEinheiten is

   procedure BewegungEinheitenRichtung (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and EinheitRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 1));

   procedure BewegungEinheitenBerechnung (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) with
     Pre => (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and EinheitRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
             and NeuePositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and NeuePositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
             and (if EinheitRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= 0));
   
private

   EinheitBewegtNichtEingeladen : Boolean;
   ErgebnisGegnerAngreifen : Boolean;

   FeldPassierbar : GlobaleDatentypen.LoopRangeMinusEinsZuEins;
   RückgabeWert : GlobaleDatentypen.LoopRangeMinusEinsZuEins;
   Gegner : GlobaleDatentypen.LoopRangeMinusEinsZuEins;

   Richtung : Wide_Wide_Character;
      
   EinheitNummerTransporter : GlobaleDatentypen.MaximaleEinheiten;
   EinheitAusladen : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   
   FreierPlatzNummer : Positive;
   
   BonusBeiBewegung : Integer;
   Stadtnummer : Integer;
   StraßeFlussVorhanden : Integer;
   
   BewegungspunkteModifikator : Float;

   Änderung : GlobaleRecords.AchsenKartenfeldRecord;
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;
   GegnerWert : GlobaleRecords.RassePlatznummerRecord;
   GegnerEinheitWert : GlobaleRecords.RassePlatznummerRecord;
   GegnerStadtWert : GlobaleRecords.RassePlatznummerRecord;

   procedure TransporterBeladen (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord);
   
   function StraßeUndFlussPrüfen (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) return Integer with
     Pre => (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and EinheitRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
             and NeuePositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and NeuePositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
             and (if EinheitRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= 0));

end BewegungssystemEinheiten;
