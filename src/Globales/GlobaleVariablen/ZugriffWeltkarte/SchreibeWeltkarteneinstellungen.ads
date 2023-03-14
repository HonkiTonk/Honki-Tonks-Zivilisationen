with KartenRecords;

package SchreibeWeltkarteneinstellungen is
   pragma Elaborate_Body;

   procedure Fläche
     (AchsenExtern : in KartenRecords.YXAchsenKartenfeldPositivRecord);
   pragma Inline (Fläche);
   
   procedure Kartenform
     (KartenformExtern : in KartenRecords.KartenformRecord);
   pragma Inline (Kartenform);
   
   procedure GesamteEinstellungen
     (EinstellungenExtern : in KartenRecords.PermanenteKartenparameterRecord);
   pragma Inline (GesamteEinstellungen);
   
   procedure Standardeinstellungen;
   pragma Inline (Standardeinstellungen);

end SchreibeWeltkarteneinstellungen;
