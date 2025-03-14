with Ada.Exceptions; use Ada.Exceptions;

with DateizugriffssystemHTSEB;
with DateisystemtestsHTSEB;
with UmwandlungssystemHTSEB;
with MeldungssystemHTSEB;
with TextKonstantenHTSEB;

with OptionenVariablen;
with VerzeichnisKonstanten;
with SystemRecordKonstanten;

with SchreibeOptionen;

-- Beim Record kann ich theoretisch alles beliebig neu ordnen, beim Einlesen/Schreiben muss ich aber immer alles neue an das Ende anhängen!
package body EinlesenNutzereinstellungenLogik is

   procedure Nutzereinstellungen
   is begin
      
      case
        DateisystemtestsHTSEB.StandardwerteEinleseprüfung (LinuxTextExtern   => TextKonstantenHTSEB.LeerString,
                                                            WindowsTextExtern => UmwandlungssystemHTSEB.Decode (TextExtern => VerzeichnisKonstanten.Spieleinstellungen))
      is
         when False =>
            OptionenVariablen.StandardNutzereinstellungenLaden;
            return;
            
         when True =>
            DateizugriffssystemHTSEB.ÖffnenStream (DateiartExtern => DateiNutzereinstellungen,
                                                    NameExtern     => VerzeichnisKonstanten.Spieleinstellungen);
      end case;
      
      case
        NutzereinstellungenDurchgehen (LadenPrüfenExtern => False,
                                       DateiLadenExtern  => DateiNutzereinstellungen)
      is
         when False =>
            OptionenVariablen.StandardNutzereinstellungenLaden;
            
         when True =>
            Nullwert := NutzereinstellungenDurchgehen (LadenPrüfenExtern => True,
                                                       DateiLadenExtern  => DateiNutzereinstellungen);
      end case;
            
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiNutzereinstellungen,
                                                 NameExtern     => VerzeichnisKonstanten.Spieleinstellungen);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenNutzereinstellungenLogik.Nutzereinstellungen: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         OptionenVariablen.StandardNutzereinstellungenLaden;
            
         DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiNutzereinstellungen,
                                                    NameExtern     => VerzeichnisKonstanten.Spieleinstellungen);
      
   end Nutzereinstellungen;
   
   
   
   function NutzereinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      if
        LadenPrüfenExtern = False
      then
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               return False;
            
            when False =>
               Unbounded_Wide_Wide_String'Read (Stream (File => DateiLadenExtern),
                                                Sprache);
         end case;
      
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AnzahlAutospeichern := SystemRecordKonstanten.StandardNutzereinstellungen.AnzahlAutospeichern;
            
            when False =>
               ZahlenDatentypen.EigenesNatural'Read (Stream (File => DateiLadenExtern),
                                                     AnzahlAutospeichern);
         end case;
      
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               RundenAutospeichern := SystemRecordKonstanten.StandardNutzereinstellungen.RundenAutospeichern;
            
            when False =>
               ZahlenDatentypen.EigenesPositive'Read (Stream (File => DateiLadenExtern),
                                                      RundenAutospeichern);
         end case;
         
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Dezimaltrennzeichen := SystemRecordKonstanten.StandardNutzereinstellungen.Dezimaltrennzeichen;
               
            when False =>
               Wide_Wide_Character'Read (Stream (File => DateiLadenExtern),
                                         Dezimaltrennzeichen);
         end case;
         
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               SicherheitsfragenAnzeigen := SystemRecordKonstanten.StandardNutzereinstellungen.SicherheitsfragenAnzeigen;
               
            when False =>
               Boolean'Read (Stream (File => DateiLadenExtern),
                             SicherheitsfragenAnzeigen);
         end case;
         
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Texturen := SystemRecordKonstanten.StandardNutzereinstellungen.Texturen;
               
            when False =>
               Unbounded_Wide_Wide_String'Read (Stream (File => DateiLadenExtern),
                                                Texturen);
         end case;
         
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Musik := SystemRecordKonstanten.StandardNutzereinstellungen.Musik;
               
            when False =>
               Unbounded_Wide_Wide_String'Read (Stream (File => DateiLadenExtern),
                                                Musik);
         end case;
         
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Sound := SystemRecordKonstanten.StandardNutzereinstellungen.Sound;
               
            when False =>
               Unbounded_Wide_Wide_String'Read (Stream (File => DateiLadenExtern),
                                                Sound);
         end case;
         
         -- Diese Prüfung muss am Ende aller Einlesefunktionen stehen, um sicher zu sein dass die Datei vollständig eingelesen wurde!
         -- Sollte Probleme mit geänderten Datentypen teilweise vorbeugen.
         return End_Of_File (File => DateiLadenExtern);
      
      else
         SchreibeOptionen.GanzeSpieleinstellungen (EinstellungenExtern => (
                                                                           Sprache                   => Sprache,
                                                                           Texturen                  => Texturen,
                                                                           Musik                     => Musik,
                                                                           Sound                     => Sound,
                                                                           AnzahlAutospeichern       => AnzahlAutospeichern,
                                                                           RundenAutospeichern       => RundenAutospeichern,
                                                                           Dezimaltrennzeichen       => Dezimaltrennzeichen,
                                                                           SicherheitsfragenAnzeigen => SicherheitsfragenAnzeigen
                                                                          ));
      
         return True;
      end if;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenNutzereinstellungenLogik.NutzereinstellungenDurchgehen: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
                  
         return False;
         
   end NutzereinstellungenDurchgehen;

end EinlesenNutzereinstellungenLogik;
