pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with GlobaleVariablen;
with EinheitStadtRecords;
with SystemKonstanten;

with Karten;

package TransporterSuchen is

   function KoordinatenTransporterMitRasseSuchen
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
   
   function EinheitAufTransporterSuchen
     (TransporterExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      LadungExtern : in EinheitStadtDatentypen.MaximaleEinheiten)
      return EinheitStadtDatentypen.Transportwerte
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (TransporterExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante
          and
            TransporterExtern.Platznummer > 0);

   function HatTransporterLadung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante
          and
            EinheitRasseNummerExtern.Platznummer > 0);

end TransporterSuchen;
