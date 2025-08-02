with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with ArraysHTSEB;
with TextKonstantenHTSEB;
with SystemDatentypenHTSEB;

package SpielstandVariablen is
   pragma Elaborate_Body;
         
   procedure Nullsetzung;
   
   procedure SpielstandnameSchreiben
     (NameExtern : in Unbounded_Wide_Wide_String;
      NummerExtern : in Positive);
   
   procedure SpielstandartSchreiben
     (SpielstandartExtern : in SystemDatentypenHTSEB.Spielstand_Enum);
   
   
   
   function SpielstandnameLesen
     (NummerExtern : in Positive)
      return Unbounded_Wide_Wide_String;
   
   function GanzeSpielstandliste
     return ArraysHTSEB.SetsArray;
   
   function SpielstandartLesen
     return SystemDatentypenHTSEB.Spielstand_Enum;
   
private
      
   Spielstand : ArraysHTSEB.SetsArray := (others => TextKonstantenHTSEB.LeerUnboundedString);
   
   Spielstandart : SystemDatentypenHTSEB.Spielstand_Enum := SystemDatentypenHTSEB.Manueller_Spielstand_Enum;
   
end SpielstandVariablen;
