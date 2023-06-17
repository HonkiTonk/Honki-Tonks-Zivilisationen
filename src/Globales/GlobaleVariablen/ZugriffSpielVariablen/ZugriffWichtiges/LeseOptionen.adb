with OptionenVariablen;

package body LeseOptionen is
   
   function Sprache
     return Unbounded_Wide_Wide_String
   is begin
      
      return OptionenVariablen.NutzerEinstellungen.Sprache;
      
   end Sprache;
   
   
   
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
   
   
   
   function AktuellerAutospeichernwert
     return ZahlenDatentypen.EigenesPositive
   is begin
      
      return OptionenVariablen.SonstigeEinstellungen.AktuellerAutospeichernwert;
      
   end AktuellerAutospeichernwert;
     
end LeseOptionen;
