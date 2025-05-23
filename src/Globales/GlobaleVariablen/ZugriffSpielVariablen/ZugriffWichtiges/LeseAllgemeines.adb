with SpielVariablen;

package body LeseAllgemeines is

   function Gewonnen
     return Boolean
   is begin
      
      return SpielVariablen.Allgemeines.Gewonnen;
      
   end Gewonnen;
   
   
   
   function Weiterspielen
     return Boolean
   is begin
      
      return SpielVariablen.Allgemeines.Weiterspielen;
      
   end Weiterspielen;
   
   
   
   function SpezieszugNachLaden
     return SpeziesDatentypen.Spezies_Enum
   is begin
      
      return SpielVariablen.Allgemeines.SpezieszugNachLaden;
      
   end SpezieszugNachLaden;
   
   
   
   function Schwierigkeitsgrad
     return SpielDatentypen.Schwierigkeitsgrad_Enum
   is begin
      
      return SpielVariablen.Allgemeines.Schwierigkeitsgrad;
      
   end Schwierigkeitsgrad;
   
   
   
   function Rundenanzahl
     return ZahlenDatentypen.EigenesPositive
   is begin
      
      return SpielVariablen.Allgemeines.Rundenanzahl;
      
   end Rundenanzahl;
   
   
   
   function Rundengrenze
     return ZahlenDatentypen.EigenesNatural
   is begin
      
      return SpielVariablen.Allgemeines.Rundengrenze;
      
   end Rundengrenze;
   
   
   
   function Ironman
     return Unbounded_Wide_Wide_String
   is begin
      
      return SpielVariablen.Allgemeines.IronmanName;
      
   end Ironman;
   
   
   
   function PlanetVernichtet
     return SpeziesDatentypen.Spezies_Enum
   is begin
      
      return SpielVariablen.Allgemeines.PlanetVernichtet;
      
   end PlanetVernichtet;
   
   
   
   function EingesetztePZB
     return ZahlenDatentypen.EigenesNatural
   is begin
      
      return SpielVariablen.Allgemeines.EingesetztePZB;
      
   end EingesetztePZB;
   
   
   
   function Zusammenbruchszeit
     return ZahlenDatentypen.EigenerInteger
   is begin
      
      return SpielVariablen.Allgemeines.Zusammenbruchszeit;
      
   end Zusammenbruchszeit;
   
   
   
   function GanzerEintrag
     return SpielRecords.AllgemeinesRecord
   is begin
      
      return SpielVariablen.Allgemeines;
      
   end GanzerEintrag;

end LeseAllgemeines;
