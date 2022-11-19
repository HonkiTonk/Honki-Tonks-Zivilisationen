with KartenDatentypen;
with KartenartDatentypen;

package LeseWeltkarteneinstellungen is
   pragma Elaborate_Body;

   function YAchse
     return KartenDatentypen.KartenfeldPositiv;
   
   function XAchse
     return KartenDatentypen.KartenfeldPositiv;
   
   function EAchseOben
     return KartenartDatentypen.Kartenform_E_Einstellbar_Enum;
   
   function EAchseUnten
     return KartenartDatentypen.Kartenform_E_Einstellbar_Enum;
   
   function YAchseNorden
     return KartenartDatentypen.Kartenform_Y_Einstellbar_Enum;
   
   function YAchseSüden
     return KartenartDatentypen.Kartenform_Y_Einstellbar_Enum;
   
   function XAchseWesten
     return KartenartDatentypen.Kartenform_X_Einstellbar_Enum;
   
   function XAchseOsten
     return KartenartDatentypen.Kartenform_X_Einstellbar_Enum;

end LeseWeltkarteneinstellungen;
