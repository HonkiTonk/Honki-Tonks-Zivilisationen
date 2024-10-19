with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

package HTB3_Umwandlungsvariablen is
   pragma Elaborate_Body;

   procedure KodierungWechseln
     (KodierungExtern : in Ada.Strings.UTF_Encoding.Encoding_Scheme);
   pragma Inline (KodierungWechseln);
   
   procedure TrennzeichenWechseln
     (TrennzeichenExtern : in Wide_Wide_Character);
   pragma Inline (TrennzeichenWechseln);
   
   
   
   function KodierungAbfragen
     return Ada.Strings.UTF_Encoding.Encoding_Scheme;
   pragma Inline (KodierungAbfragen);
   
   function TrennzeichenAbfragen
     return Wide_Wide_Character;
   pragma Inline (TrennzeichenAbfragen);
   
private
   
   Trennzeichen : Wide_Wide_Character := ',';
   
   Kodierung : Ada.Strings.UTF_Encoding.Encoding_Scheme := Ada.Strings.UTF_Encoding.UTF_8;
   
   -- Das ist nur hier um "pragma Restrictions (No_Implementation_Units)" in "Lokale Pragmas" verwenden zu können.
   Test : constant Wide_Wide_String (1 .. 1) := Decode (Item         => "1",
                                                        Input_Scheme => Ada.Strings.UTF_Encoding.UTF_8);

end HTB3_Umwandlungsvariablen;
