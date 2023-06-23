with OptionenVariablen;

package body SchreibeOptionen is

   procedure Sprache
     (SpracheExtern : in Unbounded_Wide_Wide_String)
   is begin
      
      OptionenVariablen.NutzerEinstellungen.Sprache := SpracheExtern;
      
   end Sprache;
   
   
   
   procedure AnzahlAutospeichern
     (AutospeicheranzahlExtern : in ZahlenDatentypen.EigenesNatural)
   is begin
      
      OptionenVariablen.NutzerEinstellungen.AnzahlAutospeichern := AutospeicheranzahlExtern;
      
   end AnzahlAutospeichern;
   
   
   
   procedure RundenAutospeichern
     (RundenanzahlExtern : in ZahlenDatentypen.EigenesPositive)
   is begin
      
      OptionenVariablen.NutzerEinstellungen.RundenAutospeichern := RundenanzahlExtern;
      
   end RundenAutospeichern;
   
   

   procedure GanzeSpieleinstellungen
     (EinstellungenExtern : in SystemRecords.NutzerEinstellungenRecord)
   is begin
      
      OptionenVariablen.NutzerEinstellungen := EinstellungenExtern;
      
   end GanzeSpieleinstellungen;
   
   
   
   procedure AktuellerAutospeichernwert
     (AutospeichernwertExtern : in ZahlenDatentypen.EigenesPositive)
   is begin
      
      OptionenVariablen.SpielendeEinstellungen.AktuellerAutospeichernwert := AutospeichernwertExtern;
      
   end AktuellerAutospeichernwert;
   
   
   
   procedure GanzeSonstigeEinstellungen
     (EinstellungenExtern : in SystemRecords.SpielendeEinstellungenRecord)
   is begin
      
      OptionenVariablen.SpielendeEinstellungen := EinstellungenExtern;
      
   end GanzeSonstigeEinstellungen;

end SchreibeOptionen;
