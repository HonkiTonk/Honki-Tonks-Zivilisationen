pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar;

with Sf.System.Vector2;

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with SpielVariablen;

private with KartenRecords;

private with Karten;

package CursorplatzierungAltGrafik is

   procedure CursorplatzierungAlt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
      
   Scrollzeit : Ada.Calendar.Time := Ada.Calendar.Clock;
   
   Mausposition : Sf.System.Vector2.sfVector2f;
   
   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenwertKoordinatenberechnung : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   Koordinatenänderung : KartenRecords.AchsenKartenfeldRecord;
   
   procedure GeheZuFestlegung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   
   
   function AlteYAchseFestlegen
     (MausachseExtern : in Float;
      YAchseAlt : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.UmgebungsbereichEins
     with
       Pre => (
                 YAchseAlt <= Karten.Karteneinstellungen.Kartengröße.YAchse
              );
   
   function AlteXAchseFestlegen
     (MausachseExtern : in Float;
      XAchseAlt : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.UmgebungsbereichEins
     with
       Pre => (
                 XAchseAlt <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   function Koordinatenberechnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              ),
         
       Post => (
                  Koordinatenberechnung'Result.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
                and
                  Koordinatenberechnung'Result.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               );

end CursorplatzierungAltGrafik;
