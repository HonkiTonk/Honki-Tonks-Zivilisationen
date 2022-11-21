with KartenRecords;

package SchreibeWeltkarteneinstellungen is
   pragma Elaborate_Body;

   procedure Fläche
     (AchsenExtern : in KartenRecords.YXAchsenKartenfeldPositivRecord);
   
   procedure Kartenform
     (KartenformExtern : in KartenRecords.KartenformRecord);
   
   procedure GesamteEinstellungen
     (EinstellungenExtern : in KartenRecords.PermanenteKartenparameterRecord);
   
   procedure Standardeinstellungen;

end SchreibeWeltkarteneinstellungen;
