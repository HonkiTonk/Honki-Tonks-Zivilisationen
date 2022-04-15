pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with EinheitStadtDatentypen;
with RassenDatentypen;

with Karten;

package UmgebungErreichbarTesten is
   
   function UmgebungErreichbarTesten
     (AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.MinimimMaximumID;
      NotwendigeFelderExtern : in Positive)
      return KartenRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (AktuelleKoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
          and
            AktuelleKoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße),
         Post =>
           (UmgebungErreichbarTesten'Result.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
            and
              UmgebungErreichbarTesten'Result.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße);
   
private
   
   BereitsGetestet : KartenDatentypen.UmgebungsbereichZwei;
   Umgebung : KartenDatentypen.UmgebungsbereichDrei;
   
   GefundeneFelder : Positive;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWertZwei : KartenRecords.AchsenKartenfeldPositivRecord;
   
   function NochErreichbar
     (AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.MinimimMaximumID)
      return Boolean;

end UmgebungErreichbarTesten;
