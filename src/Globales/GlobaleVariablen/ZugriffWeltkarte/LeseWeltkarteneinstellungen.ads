with KartenDatentypen;
with KartenartDatentypen;
with KartenRecords;

package LeseWeltkarteneinstellungen is
   pragma Elaborate_Body;

   function YAchse
     return KartenDatentypen.SenkrechtePositiv;
   pragma Inline (YAchse);
   
   function XAchse
     return KartenDatentypen.WaagerechtePositiv;
   pragma Inline (XAchse);
   
   function EAchseOben
     return KartenartDatentypen.Kartenform_E_Einstellbar_Enum;
   pragma Inline (EAchseOben);
   
   function EAchseUnten
     return KartenartDatentypen.Kartenform_E_Einstellbar_Enum;
   pragma Inline (EAchseUnten);
   
   function YAchseNorden
     return KartenartDatentypen.Kartenform_Y_Einstellbar_Enum;
   pragma Inline (YAchseNorden);
   
   function YAchseSüden
     return KartenartDatentypen.Kartenform_Y_Einstellbar_Enum;
   pragma Inline (YAchseSüden);
   
   function XAchseWesten
     return KartenartDatentypen.Kartenform_X_Einstellbar_Enum;
   pragma Inline (XAchseWesten);
   
   function XAchseOsten
     return KartenartDatentypen.Kartenform_X_Einstellbar_Enum;
   pragma Inline (XAchseOsten);
   
   function KartenformYAchse
     return KartenRecords.KartenformYAchseRecord;
   pragma Inline (KartenformYAchse);
   
   function KartenformXAchse
     return KartenRecords.KartenformXAchseRecord;
   pragma Inline (KartenformXAchse);
   
   function GesamteEinstellungen
     return KartenRecords.PermanenteKartenparameterRecord;
   pragma Inline (GesamteEinstellungen);

end LeseWeltkarteneinstellungen;
