pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;

with Karten;

package Vergleiche is
   
   function KoordinateLeervergleich
     (KoordinateExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinateExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinateExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   function Koordinatenvergleich
     (KoordinateEinsExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      KoordinatenZweiExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinateEinsExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinateEinsExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               and
                 KoordinatenZweiExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenZweiExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );

end Vergleiche;
