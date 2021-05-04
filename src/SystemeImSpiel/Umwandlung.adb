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
   
   
   
   function EinheitNachKoordinaten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      KoordinatenEinheit := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition;
        
      return KoordinatenEinheit;
      
   end EinheitNachKoordinaten;
   
   
   
   function StadtNachKoordinaten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      KoordinatenStadt := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AchsenPosition;
        
      return KoordinatenStadt;
      
   end StadtNachKoordinaten;

end Umwandlung;
