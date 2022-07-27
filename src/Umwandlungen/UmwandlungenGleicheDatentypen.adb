pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body UmwandlungenGleicheDatentypen is

   function KartenfeldNaturalNachKartenfeldVorhanden
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenRecords.AchsenKartenfeldVorhandenRecord
   is begin
      
      return (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse);
      
   end KartenfeldNaturalNachKartenfeldVorhanden;

end UmwandlungenGleicheDatentypen;
