with Weltkarte;

package body LeseWeltkarteneinstellungen is

   function YAchse
     return KartenDatentypen.KartenfeldPositiv
   is begin
      
      return Weltkarte.Karteneinstellungen.Kartengröße.YAchse;
      
   end YAchse;
   
   
   
   function XAchse
     return KartenDatentypen.KartenfeldPositiv
   is begin
      
      return Weltkarte.Karteneinstellungen.Kartengröße.XAchse;
      
   end XAchse;
   
   
   
   function EAchseOben
     return KartenartDatentypen.Kartenform_E_Einstellbar_Enum
   is begin
      
      return Weltkarte.Karteneinstellungen.Kartenform.EAchseOben;
      
   end EAchseOben;
   
   
   
   function EAchseUnten
     return KartenartDatentypen.Kartenform_E_Einstellbar_Enum
   is begin
      
      return Weltkarte.Karteneinstellungen.Kartenform.EAchseUnten;
      
   end EAchseUnten;
   
   
   
   function YAchseNorden
     return KartenartDatentypen.Kartenform_Y_Einstellbar_Enum
   is begin
      
      return Weltkarte.Karteneinstellungen.Kartenform.YAchseNorden;
      
   end YAchseNorden;
   
   
   
   function YAchseSüden
     return KartenartDatentypen.Kartenform_Y_Einstellbar_Enum
   is begin
      
      return Weltkarte.Karteneinstellungen.Kartenform.YAchseSüden;
      
   end YAchseSüden;
   
   
   
   function XAchseWesten
     return KartenartDatentypen.Kartenform_X_Einstellbar_Enum
   is begin
      
      return Weltkarte.Karteneinstellungen.Kartenform.XAchseWesten;
      
   end XAchseWesten;
   
   
   
   function XAchseOsten
     return KartenartDatentypen.Kartenform_X_Einstellbar_Enum
   is begin
      
      return Weltkarte.Karteneinstellungen.Kartenform.XAchseOsten;
      
   end XAchseOsten;
   
   
   
   function KartenformYAchse
     return KartenRecords.KartenformYAchseRecord
   is begin
      
      return (YAchseNorden, YAchseSüden);
      
   end KartenformYAchse;
   
   
   
   function KartenformXAchse
     return KartenRecords.KartenformXAchseRecord
   is begin
      
      return (XAchseWesten, XAchseOsten);
      
   end KartenformXAchse;
   
   
   
   function GesamteEinstellungen
     return KartenRecords.PermanenteKartenparameterRecord
   is begin
      
      return Weltkarte.Karteneinstellungen;
      
   end GesamteEinstellungen;

end LeseWeltkarteneinstellungen;
