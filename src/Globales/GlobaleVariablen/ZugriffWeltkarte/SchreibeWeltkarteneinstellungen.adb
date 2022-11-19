with Weltkarte;

package body SchreibeWeltkarteneinstellungen is
   
   procedure Fläche
     (AchsenExtern : in KartenRecords.YXAchsenKartenfeldPositivRecord)
   is begin
      
      Weltkarte.Karteneinstellungen.Kartengröße := AchsenExtern;
      
   end Fläche;
   
   
   
   procedure Kartenform
     (KartenformExtern : in KartenRecords.KartenformRecord)
   is begin
      
      Weltkarte.Karteneinstellungen.Kartenform := KartenformExtern;
      
   end Kartenform;

end SchreibeWeltkarteneinstellungen;
