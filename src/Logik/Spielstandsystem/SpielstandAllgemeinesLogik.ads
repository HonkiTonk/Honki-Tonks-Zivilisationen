with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with SystemRecords;

package SpielstandAllgemeinesLogik is
   pragma Elaborate_Body;

   function SpielstandNameErmitteln
     return Unbounded_Wide_Wide_String;
   
   function SpielstandVorhanden
     (SpielstandnameExtern : in Unbounded_Wide_Wide_String)
      return Boolean;
   
private
   
   SpielstandName : SystemRecords.TextEingabeRecord;

end SpielstandAllgemeinesLogik;
