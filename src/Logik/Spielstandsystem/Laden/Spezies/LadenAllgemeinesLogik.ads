with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with Ada.Strings.Wide_Wide_Unbounded;

private with SpielRecords;
private with SystemDatentypen;
private with SpeziesDatentypen;
private with SpielDatentypen;
private with ZahlenDatentypen;

package LadenAllgemeinesLogik is

   function Aufteilung
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
private
   use Ada.Strings.Wide_Wide_Unbounded;
   
   Gewonnen : Boolean;
   Weiterspielen : Boolean;
   
   GewonnenWeiterspielen : SystemDatentypen.EinByte;
      
   SpezieszugNachLaden : SpeziesDatentypen.Spezies_Enum;
      
   Schwierigkeitsgrad : SpielDatentypen.Schwierigkeitsgrad_Enum;
      
   Rundenanzahl : ZahlenDatentypen.EigenesPositive;
      
   Rundengrenze : ZahlenDatentypen.EigenesNatural;
      
   Ironman : Unbounded_Wide_Wide_String;
      
   PlanetVernichtet : SpeziesDatentypen.Spezies_Enum;
      
   Zusammenbruchszeit : ZahlenDatentypen.EigenerInteger;
      
   EingesetztePZB : ZahlenDatentypen.EigenesNatural;

   Belegung : SpielRecords.SpeziesbelegungArray;
   
   
   
   function Allgemeines
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
   function Speziesbelegung
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;

end LadenAllgemeinesLogik;
