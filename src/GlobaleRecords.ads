with GlobaleDatentypen;

package GlobaleRecords is

   type AchsenAusStadtfeld is record
      
      YAchse : GlobaleDatentypen.Stadtfeld;
      XAchse : GlobaleDatentypen.Stadtfeld;
      
   end record;
   
   type AchsenAusKartenfeldPositiv is record
      
      EAchse : GlobaleDatentypen.Ebene;
      YAchse : GlobaleDatentypen.KartenfeldPositiv;
      XAchse : GlobaleDatentypen.KartenfeldPositiv;
      
   end record;

   type AchsenAusKartenfeld is record
      
      EAchse : GlobaleDatentypen.Ebene;
      YAchse : GlobaleDatentypen.Kartenfeld;
      XAchse : GlobaleDatentypen.Kartenfeld;
      
   end record;

   type RasseUndPlatznummerRecord is record
      
      Rasse : GlobaleDatentypen.RassenMitNullwert;
      Platznummer : Integer;
      
   end record;

end GlobaleRecords;
