pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with KartenDatentypen; use KartenDatentypen;
with GlobaleVariablen;
with KartenRecords;
with EinheitStadtRecords;
with EinheitStadtDatentypen;
with SystemKonstanten;

with Karten;

package EinheitSuchen is

   function KoordinatenEinheitMitRasseSuchen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return EinheitStadtDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);

   function KoordinatenEinheitOhneRasseSuchen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return EinheitStadtRecords.RassePlatznummerRecord
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   function KoordinatenEinheitOhneSpezielleRasseSuchen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return EinheitStadtRecords.RassePlatznummerRecord
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);
   
private
   
   EinheitNummer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   
end EinheitSuchen;
