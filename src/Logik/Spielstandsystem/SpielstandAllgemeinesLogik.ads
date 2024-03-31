with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with SystemRecords;

with SystemDatentypen;

package SpielstandAllgemeinesLogik is
   pragma Elaborate_Body;
      
   procedure FortschrittErhöhen
     (AutospeichernExtern : in Boolean);
   
   

   function SpielstandNameErmitteln
     return Unbounded_Wide_Wide_String;
   
   function SpielstandVorhanden
     (SpielstandnameExtern : in Unbounded_Wide_Wide_String;
      SpielstandartExtern : in SystemDatentypen.Spielstand_Enum)
      return Boolean;
   
private
   
   SpielstandName : SystemRecords.TextEingabeRecord;

end SpielstandAllgemeinesLogik;
