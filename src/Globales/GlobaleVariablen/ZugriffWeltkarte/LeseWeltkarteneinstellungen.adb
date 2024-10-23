with Weltkarte;

package body LeseWeltkarteneinstellungen is

   function Senkrechte
     return KartenDatentypen.SenkrechtePositiv
   is begin
      
      return Weltkarte.Karteneinstellungen.Kartengröße.Senkrechte;
      
   end Senkrechte;
   
   
   
   function Waagerechte
     return KartenDatentypen.WaagerechtePositiv
   is begin
      
      return Weltkarte.Karteneinstellungen.Kartengröße.Waagerechte;
      
   end Waagerechte;
   
   
   
   function EbeneOben
     return KartenartDatentypen.Kartenform_Ebene_Einstellbar_Enum
   is begin
      
      return Weltkarte.Karteneinstellungen.Kartenform.EbeneOben;
      
   end EbeneOben;
   
   
   
   function EbeneUnten
     return KartenartDatentypen.Kartenform_Ebene_Einstellbar_Enum
   is begin
      
      return Weltkarte.Karteneinstellungen.Kartenform.EbeneUnten;
      
   end EbeneUnten;
   
   
   
   function SenkrechteNorden
     return KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum
   is begin
      
      return Weltkarte.Karteneinstellungen.Kartenform.SenkrechteNorden;
      
   end SenkrechteNorden;
   
   
   
   function SenkrechteSüden
     return KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum
   is begin
      
      return Weltkarte.Karteneinstellungen.Kartenform.SenkrechteSüden;
      
   end SenkrechteSüden;
   
   
   
   function WaagerechteWesten
     return KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum
   is begin
      
      return Weltkarte.Karteneinstellungen.Kartenform.WaagerechteWesten;
      
   end WaagerechteWesten;
   
   
   
   function WaagerechteOsten
     return KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum
   is begin
      
      return Weltkarte.Karteneinstellungen.Kartenform.WaagerechteOsten;
      
   end WaagerechteOsten;
   
   
   
   function KartenformSenkrechte
     return KartenRecords.KartenformSenkrechteRecord
   is begin
      
      return (SenkrechteNorden, SenkrechteSüden);
      
   end KartenformSenkrechte;
   
   
   
   function KartenformWaagerechte
     return KartenRecords.KartenformWaagerechteRecord
   is begin
      
      return (WaagerechteWesten, WaagerechteOsten);
      
   end KartenformWaagerechte;
   
   
   
   function GesamteEinstellungen
     return KartenRecords.PermanenteKartenparameterRecord
   is begin
      
      return Weltkarte.Karteneinstellungen;
      
   end GesamteEinstellungen;

end LeseWeltkarteneinstellungen;
