pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;

with Karten;

package KIEinheitAllgemeinePruefungen is
   
   function BlockiertDurchWasser
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse);
   
private
   
   Wasserfelder : KartenDatentypen.KartenfeldNatural;
   
   Wasserumgebung : KartenRecords.AchsenKartenfeldNaturalRecord;

end KIEinheitAllgemeinePruefungen;
