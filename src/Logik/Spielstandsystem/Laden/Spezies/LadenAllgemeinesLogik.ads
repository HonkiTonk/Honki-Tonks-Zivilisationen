with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with Ada.Strings.Wide_Wide_Unbounded;

private with SystemDatentypenHTSEB;

private with SpielRecords;
private with SpeziesDatentypen;
private with SpielDatentypen;
private with SpeziesArrays;

package LadenAllgemeinesLogik is
   pragma Elaborate_Body;

   function Aufteilung
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
private
   use Ada.Strings.Wide_Wide_Unbounded;
   
   Gewonnen : Boolean;
   Weiterspielen : Boolean;
   
   AktuellerArraybereich : SystemDatentypenHTSEB.EigenesPositive;
   
   SpeziesVorhanden : SpeziesDatentypen.SpeziesnummernBasis;
   
   GewonnenWeiterspielen : SystemDatentypenHTSEB.EinByte;
      
   SpezieszugNachLaden : SpeziesDatentypen.Spezies_Enum;
      
   Schwierigkeitsgrad : SpielDatentypen.Schwierigkeitsgrad_Enum;
      
   Rundenanzahl : SystemDatentypenHTSEB.EigenesPositive;
      
   Rundengrenze : SystemDatentypenHTSEB.EigenesNatural;
      
   Ironman : Unbounded_Wide_Wide_String;
      
   PlanetVernichtet : SpeziesDatentypen.Spezies_Enum;
      
   Zusammenbruchszeit : SystemDatentypenHTSEB.EigenerInteger;
      
   EingesetztePZB : SystemDatentypenHTSEB.EigenesNatural;

   Belegung : SpielRecords.SpeziesbelegungArray;
   
   Potenz : SystemDatentypenHTSEB.EigenesNatural;
   
   Besiegt : SpeziesArrays.SpeziesByteArray;
   
   
   
   function Allgemeines
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
   function Speziesbelegung
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;

end LadenAllgemeinesLogik;
