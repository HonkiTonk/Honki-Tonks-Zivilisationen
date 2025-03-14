with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with ArraysHTSEB;
with TextKonstantenHTSEB;

with SystemDatentypen;

package SpielstandVariablen is
   pragma Elaborate_Body;
         
   procedure Nullsetzung;
   
   procedure SpielstandnameSchreiben
     (NameExtern : in Unbounded_Wide_Wide_String;
      NummerExtern : in Positive);
   
   procedure SpielstandartSchreiben
     (SpielstandartExtern : in SystemDatentypen.Spielstand_Enum);
   
   
   
   function SpielstandnameLesen
     (NummerExtern : in Positive)
      return Unbounded_Wide_Wide_String;
   
   function GanzeSpielstandliste
     return ArraysHTSEB.SetsArray;
   
   function SpielstandartLesen
     return SystemDatentypen.Spielstand_Enum;
   
private
      
   Spielstand : ArraysHTSEB.SetsArray := (others => TextKonstantenHTSEB.LeerUnboundedString);
   
   Spielstandart : SystemDatentypen.Spielstand_Enum := SystemDatentypen.Manueller_Spielstand_Enum;
   
end SpielstandVariablen;
