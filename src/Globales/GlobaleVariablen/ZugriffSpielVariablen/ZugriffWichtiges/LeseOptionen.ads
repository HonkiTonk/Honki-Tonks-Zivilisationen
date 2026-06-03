with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypenHTSEB;

package LeseOptionen is
   pragma Elaborate_Body;
   
   function Sprache
     return Unbounded_Wide_Wide_String;
   pragma Inline (Sprache);
   
   function Texturen
     return Unbounded_Wide_Wide_String;
   pragma Inline (Texturen);
   
   function Musik
     return Unbounded_Wide_Wide_String;
   pragma Inline (Musik);
   
   function Sound
     return Unbounded_Wide_Wide_String;
   pragma Inline (Sound);
   
   function AnzahlAutospeichern
     return SystemDatentypenHTSEB.EigenesNatural;
   pragma Inline (AnzahlAutospeichern);
   
   function RundenAutospeichern
     return SystemDatentypenHTSEB.EigenesPositive;
   pragma Inline (RundenAutospeichern);
   
   function Dezimaltrennzeichen
     return Wide_Wide_Character;
   pragma Inline (Dezimaltrennzeichen);
   
   function SicherheitsfragenAnzeigen
     return Boolean;
   pragma Inline (SicherheitsfragenAnzeigen);
   
   function AktuellerAutospeichernwert
     return SystemDatentypenHTSEB.EigenesPositive;
   pragma Inline (AktuellerAutospeichernwert);

end LeseOptionen;
