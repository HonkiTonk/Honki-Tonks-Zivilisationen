pragma SPARK_Mode (On);

package body Umwandlung is

   function KartenfeldNachKartenfeldPositiv (Koordinaten : in GlobaleRecords.AchsenKartenfeldRecord) return GlobaleRecords.AchsenKartenfeldPositivRecord is
   begin
      
      KoordinatenUmgewandelt := (GlobaleDatentypen.EbeneVorhanden (Koordinaten.EAchse),
                                 GlobaleDatentypen.KartenfeldPositiv (Koordinaten.YAchse),
                                 GlobaleDatentypen.KartenfeldPositiv (Koordinaten.XAchse));
      return KoordinatenUmgewandelt;
      
   end KartenfeldNachKartenfeldPositiv;

end Umwandlung;
