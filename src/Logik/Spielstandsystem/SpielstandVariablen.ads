with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with TextKonstanten;
with TextArrays;

package SpielstandVariablen is
   pragma Elaborate_Body;
         
   procedure Nullsetzung;
   
   procedure SpielstandnameSchreiben
     (NameExtern : in Unbounded_Wide_Wide_String;
      NummerExtern : in Positive);
   
   
   
   function SpielstandnameLesen
     (NummerExtern : in Positive)
      return Unbounded_Wide_Wide_String;
   
   function GanzeSpielstandliste
     return TextArrays.SpielstandArray;
   
private
      
   Spielstand : TextArrays.SpielstandArray := (others => TextKonstanten.LeerUnboundedString);
   
end SpielstandVariablen;
