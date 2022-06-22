pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;

with Karten;

package UmwandlungenEigenesNachEigenes is

   function KartenfeldNaturalNachKartenfeldVorhanden
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenRecords.AchsenKartenfeldVorhandenRecord
     with
       Pre => (
                 KoordinatenExtern.EAchse in Karten.WeltkarteArray'Range (1)
               and
                 KoordinatenExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Karteneinstellungen.Kartengröße.XAchse
              ),
         
       Post => (
                  KartenfeldNaturalNachKartenfeldVorhanden'Result.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
                and
                  KartenfeldNaturalNachKartenfeldVorhanden'Result.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               );

end UmwandlungenEigenesNachEigenes;
