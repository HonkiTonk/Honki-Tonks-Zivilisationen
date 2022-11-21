with Weltkarte;
with KartenRecordKonstanten;

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
   
   
   
   procedure Standardeinstellungen
   is begin
      
      Weltkarte.Karteneinstellungen := KartenRecordKonstanten.Standardkartenparameter;
      
   end Standardeinstellungen;
   
   
   
   procedure GesamteEinstellungen
     (EinstellungenExtern : in KartenRecords.PermanenteKartenparameterRecord)
   is begin
      
      Weltkarte.Karteneinstellungen := EinstellungenExtern;
      
   end GesamteEinstellungen;

end SchreibeWeltkarteneinstellungen;
