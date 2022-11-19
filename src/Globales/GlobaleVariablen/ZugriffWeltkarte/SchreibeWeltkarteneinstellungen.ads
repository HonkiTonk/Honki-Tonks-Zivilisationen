with KartenRecords;

package SchreibeWeltkarteneinstellungen is
   pragma Elaborate_Body;

   procedure Fläche
     (AchsenExtern : in KartenRecords.YXAchsenKartenfeldPositivRecord);
   
   procedure Kartenform
     (KartenformExtern : in KartenRecords.KartenformRecord);

end SchreibeWeltkarteneinstellungen;
