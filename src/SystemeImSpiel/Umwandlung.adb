pragma SPARK_Mode (On);

package body Umwandlung is

   function KartenfeldNachKartenfeldPositiv
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      KoordinatenUmgewandelt := (GlobaleDatentypen.EbeneVorhanden (KoordinatenExtern.EAchse),
                                 GlobaleDatentypen.KartenfeldPositiv (KoordinatenExtern.YAchse),
                                 GlobaleDatentypen.KartenfeldPositiv (KoordinatenExtern.XAchse));
      return KoordinatenUmgewandelt;
      
   end KartenfeldNachKartenfeldPositiv;

end Umwandlung;
