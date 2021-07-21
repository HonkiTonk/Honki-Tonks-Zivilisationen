pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen;
use GlobaleDatentypen;

package KIStadtSuchen is

   function KINähesteStadtSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      AnfangKoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord;

private

   AktuellGefundeneStadt : GlobaleDatentypen.MaximaleStädteMitNullWert;
   Entfernung : Positive;
   EntfernungNeu : Positive;

end KIStadtSuchen;
