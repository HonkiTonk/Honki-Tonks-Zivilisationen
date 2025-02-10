with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypenHTSEB;

package SystemRecordsHTSEB is
   pragma Preelaborate;
   
   type ZahlenEingabeRecord is record
      
      ErfolgreichAbbruch : Boolean;
      EingegebeneZahl : SystemDatentypenHTSEB.EigenerInteger;
      
   end record;
   
   

   type TextEingabeRecord is record
      
      ErfolgreichAbbruch : Boolean;
      EingegebenerText : Unbounded_Wide_Wide_String;
      
   end record;

end SystemRecordsHTSEB;
