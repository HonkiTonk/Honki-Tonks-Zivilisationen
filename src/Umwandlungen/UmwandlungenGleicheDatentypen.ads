pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;

with Weltkarte;

package UmwandlungenGleicheDatentypen is

   function KartenfeldNaturalNachKartenfeldVorhanden
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenRecords.AchsenKartenfeldVorhandenRecord
     with
       Pre => (
                 KoordinatenExtern.EAchse in Weltkarte.KarteArray'Range (1)
               and
                 KoordinatenExtern.YAchse in Weltkarte.KarteArray'First (2) .. Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse in Weltkarte.KarteArray'First (3) .. Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              ),
         
       Post => (
                  KartenfeldNaturalNachKartenfeldVorhanden'Result.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
                and
                  KartenfeldNaturalNachKartenfeldVorhanden'Result.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               );

end UmwandlungenGleicheDatentypen;
