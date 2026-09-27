with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with TextKonstantenHTSEB;
private with UmwandlungssystemHTSEB;

package EinlesenTextSonstigesLogik is
   pragma Elaborate_Body;
   
   procedure Ersetzungen
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Debugmenü;
   
   
   
   function TextErsetzen
     (TextExtern : in Unbounded_Wide_Wide_String)
      return Unbounded_Wide_Wide_String;
      
   function Einsprachig
     (EinsprachigExtern : in Boolean;
      EingelesenerTextExtern : in Unbounded_Wide_Wide_String;
      VorhandenerTextExtern : in Unbounded_Wide_Wide_String)
      return Unbounded_Wide_Wide_String;
   
private
   
   EinzulesendeZeile : Positive;
   AktuelleZeile : Positive;
   
   Zwischenspeicher : Unbounded_Wide_Wide_String;
   
   type ErsetzungenEingelesenArray is array (1 .. 7) of Unbounded_Wide_Wide_String;
   ErsetzungenEingelesen : ErsetzungenEingelesenArray := (others => TextKonstantenHTSEB.FehlenderText);
   
   
   
   function ZahlAlsString is new UmwandlungssystemHTSEB.Zahlenstring (GanzeZahl => Positive);

end EinlesenTextSonstigesLogik;
