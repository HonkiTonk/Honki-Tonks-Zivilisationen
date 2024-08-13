with OptionenVariablen;

package body SchreibeOptionen is

   procedure Sprache
     (SpracheExtern : in Unbounded_Wide_Wide_String)
   is begin
      
      OptionenVariablen.NutzerEinstellungen.Sprache := SpracheExtern;
      
   end Sprache;
   
   
   
   procedure Texturen
     (TexturenExtern : in Unbounded_Wide_Wide_String)
   is begin
      
      OptionenVariablen.NutzerEinstellungen.Texturen := TexturenExtern;
      
   end Texturen;
   
   
   
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
   
   
   
   procedure Dezimaltrennzeichen
     (ZeichenExtern : in Wide_Wide_Character)
   is begin
      
      OptionenVariablen.NutzerEinstellungen.Dezimaltrennzeichen := ZeichenExtern;
      
   end Dezimaltrennzeichen;
   
   
   
   procedure SicherheitsfragenAnzeigen
     (JaNeinExtern : in Boolean)
   is begin
      
      OptionenVariablen.NutzerEinstellungen.SicherheitsfragenAnzeigen := JaNeinExtern;
      
   end SicherheitsfragenAnzeigen;
   
   

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
   
   
   
   procedure GanzeSpielendeEinstellungen
     (EinstellungenExtern : in SystemRecords.SpielendeEinstellungenRecord)
   is begin
      
      OptionenVariablen.SpielendeEinstellungen := EinstellungenExtern;
      
   end GanzeSpielendeEinstellungen;

end SchreibeOptionen;
