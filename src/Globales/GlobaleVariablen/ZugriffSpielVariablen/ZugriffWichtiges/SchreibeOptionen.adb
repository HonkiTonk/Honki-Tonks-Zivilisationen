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
   
   

   procedure GanzerEintrag
     (EintragExtern : in SystemRecords.NutzerEinstellungenRecord)
   is begin
      
      OptionenVariablen.NutzerEinstellungen := EintragExtern;
      
   end GanzerEintrag;

end SchreibeOptionen;
