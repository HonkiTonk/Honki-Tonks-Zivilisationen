with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with ZahlenDatentypen;

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
     return ZahlenDatentypen.EigenesNatural;
   pragma Inline (AnzahlAutospeichern);
   
   function RundenAutospeichern
     return ZahlenDatentypen.EigenesPositive;
   pragma Inline (RundenAutospeichern);
   
   function Dezimaltrennzeichen
     return Wide_Wide_Character;
   pragma Inline (Dezimaltrennzeichen);
   
   function SicherheitsfragenAnzeigen
     return Boolean;
   pragma Inline (SicherheitsfragenAnzeigen);
   
   function AktuellerAutospeichernwert
     return ZahlenDatentypen.EigenesPositive;
   pragma Inline (AktuellerAutospeichernwert);

end LeseOptionen;
