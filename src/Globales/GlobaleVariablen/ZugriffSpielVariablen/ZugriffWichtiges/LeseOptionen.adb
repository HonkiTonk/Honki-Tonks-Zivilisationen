with OptionenVariablen;

package body LeseOptionen is
   
   function Sprache
     return Unbounded_Wide_Wide_String
   is begin
      
      return OptionenVariablen.NutzerEinstellungen.Sprache;
      
   end Sprache;
   
   
   
   function Texturen
     return Unbounded_Wide_Wide_String
   is begin
      
      return OptionenVariablen.NutzerEinstellungen.Texturen;
      
   end Texturen;
   
   
   
   function Musik
     return Unbounded_Wide_Wide_String
   is begin
      
      return OptionenVariablen.NutzerEinstellungen.Musik;
      
   end Musik;
   
   
   
   function Sound
     return Unbounded_Wide_Wide_String
   is begin
      
      return OptionenVariablen.NutzerEinstellungen.Sound;
      
   end Sound;
   
   
   
   function AnzahlAutospeichern
     return ZahlenDatentypen.EigenesNatural
   is begin
      
      return OptionenVariablen.NutzerEinstellungen.AnzahlAutospeichern;
      
   end AnzahlAutospeichern;
   
   
   
   function RundenAutospeichern
     return ZahlenDatentypen.EigenesPositive
   is begin
      
      return OptionenVariablen.NutzerEinstellungen.RundenAutospeichern;
      
   end RundenAutospeichern;
   
   
   
   function Dezimaltrennzeichen
     return Wide_Wide_Character
   is begin
      
      return OptionenVariablen.NutzerEinstellungen.Dezimaltrennzeichen;
      
   end Dezimaltrennzeichen;
   
   
   
   function SicherheitsfragenAnzeigen
     return Boolean
   is begin
      
      return OptionenVariablen.NutzerEinstellungen.SicherheitsfragenAnzeigen;
      
   end SicherheitsfragenAnzeigen;
   
   
   
   function AktuellerAutospeichernwert
     return ZahlenDatentypen.EigenesPositive
   is begin
      
      return OptionenVariablen.SpielendeEinstellungen.AktuellerAutospeichernwert;
      
   end AktuellerAutospeichernwert;
     
end LeseOptionen;
