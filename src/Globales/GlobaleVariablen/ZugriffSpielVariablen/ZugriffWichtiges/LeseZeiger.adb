with SpielVariablen;

package body LeseZeiger is

   function KoordinatenAktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenRecords.KartenfeldNaturalRecord
   is begin
      
      return SpielVariablen.Spielzeiger (SpeziesExtern).KoordinatenAktuell;
      
   end KoordinatenAktuell;
   
   
   
   function EbeneAktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenDatentypen.Ebene
   is begin
      
      return SpielVariablen.Spielzeiger (SpeziesExtern).KoordinatenAktuell.Ebene;
      
   end EbeneAktuell;
   
   

   function KoordinatenAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenRecords.KartenfeldNaturalRecord
   is begin
      
      return SpielVariablen.Spielzeiger (SpeziesExtern).KoordinatenAlt;
      
   end KoordinatenAlt;
   
   
   
   function SenkrechteAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenDatentypen.SenkrechtePositiv
   is begin
      
      return SpielVariablen.Spielzeiger (SpeziesExtern).KoordinatenAlt.Senkrechte;
      
   end SenkrechteAlt;
   
   
   
   function WaagerechteAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenDatentypen.WaagerechtePositiv
   is begin
      
      return SpielVariablen.Spielzeiger (SpeziesExtern).KoordinatenAlt.Waagerechte;
      
   end WaagerechteAlt;
   
   
      
   function GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenRecords.ZeigerRecord
   is begin
      
      return SpielVariablen.Spielzeiger (SpeziesExtern);
      
   end GanzerEintrag;

end LeseZeiger;
