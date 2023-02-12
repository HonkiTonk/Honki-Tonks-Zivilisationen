with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with TextKonstanten;

package SpielstandVariablen is
   pragma Elaborate_Body;
   
   type SpielstandArray is array (1 .. 11) of Unbounded_Wide_Wide_String;
   
   procedure Nullsetzung;
   
   procedure SpielstandnameSchreiben
     (NameExtern : in Unbounded_Wide_Wide_String;
      NummerExtern : in Positive);
   
   
   
   function SpielstandnameLesen
     (NummerExtern : in Positive)
      return Unbounded_Wide_Wide_String;
   
   function GanzeSpielstandliste
     return SpielstandArray;
   
private
      
   Spielstand : SpielstandArray := (others => TextKonstanten.LeerUnboundedString);
   
end SpielstandVariablen;
