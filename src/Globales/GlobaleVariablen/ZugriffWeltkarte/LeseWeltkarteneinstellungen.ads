with KartenDatentypen;
with KartenartDatentypen;
with KartenRecords;

package LeseWeltkarteneinstellungen is
   pragma Elaborate_Body;

   function Senkrechte
     return KartenDatentypen.SenkrechtePositiv;
   pragma Inline (Senkrechte);
   
   function Waagerechte
     return KartenDatentypen.WaagerechtePositiv;
   pragma Inline (Waagerechte);
   
   function EbeneOben
     return KartenartDatentypen.Kartenform_Ebene_Einstellbar_Enum;
   pragma Inline (EbeneOben);
   
   function EbeneUnten
     return KartenartDatentypen.Kartenform_Ebene_Einstellbar_Enum;
   pragma Inline (EbeneUnten);
   
   function SenkrechteNorden
     return KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum;
   pragma Inline (SenkrechteNorden);
   
   function SenkrechteSüden
     return KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum;
   pragma Inline (SenkrechteSüden);
   
   function WaagerechteWesten
     return KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum;
   pragma Inline (WaagerechteWesten);
   
   function WaagerechteOsten
     return KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum;
   pragma Inline (WaagerechteOsten);
   
   function KartenformSenkrechte
     return KartenRecords.KartenformSenkrechteRecord;
   pragma Inline (KartenformSenkrechte);
   
   function KartenformWaagerechte
     return KartenRecords.KartenformWaagerechteRecord;
   pragma Inline (KartenformWaagerechte);
   
   function GesamteEinstellungen
     return KartenRecords.PermanenteKartenparameterRecord;
   pragma Inline (GesamteEinstellungen);

end LeseWeltkarteneinstellungen;
