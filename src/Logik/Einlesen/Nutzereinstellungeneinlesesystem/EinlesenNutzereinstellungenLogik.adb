with Ada.Exceptions; use Ada.Exceptions;

with DateizugriffssystemHTB5;

with OptionenVariablen;
with VerzeichnisKonstanten;
with SystemRecordKonstanten;
with TextKonstanten;

with SchreibeOptionen;

with Fehlermeldungssystem;
with VerzeichnisDateinamenTests;
with UmwandlungenAdaEigenes;

-- Beim Record kann ich theoretisch alles beliebig neu ordnen, beim Einlesen/Schreiben muss ich aber immer alles neue an das Ende anhängen!
package body EinlesenNutzereinstellungenLogik is

   procedure Nutzereinstellungen
   is begin
      
      case
        VerzeichnisDateinamenTests.StandardwerteEinleseprüfung (LinuxTextExtern   => TextKonstanten.LeerString,
                                                                 WindowsTextExtern => UmwandlungenAdaEigenes.EigenesDecode (TextExtern => VerzeichnisKonstanten.Spieleinstellungen))
      is
         when False =>
            OptionenVariablen.StandardNutzereinstellungenLaden;
            return;
            
         when True =>
            DateizugriffssystemHTB5.ÖffnenStream (DateiartExtern => DateiNutzereinstellungen,
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

      Close (File => DateiNutzereinstellungen);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenNutzereinstellungenLogik.Nutzereinstellungen: Konnte nicht geladen werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         OptionenVariablen.StandardNutzereinstellungenLaden;
         
         case
           Is_Open (File => DateiNutzereinstellungen)
         is
            when True =>
               Close (File => DateiNutzereinstellungen);
               
            when False =>
               null;
         end case;
      
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
         
         -- Diese Prüfung muss am Ende aller Einlesefunktionen stehen, um sicher zu sein dass die Datei vollständig eingelesen wurde!
         -- Sollte Probleme mit geänderten Datentypen teilweise vorbeugen.
         return End_Of_File (File => DateiLadenExtern);
      
      else
         SchreibeOptionen.GanzeSpieleinstellungen (EinstellungenExtern => (
                                                                           Sprache                   => Sprache,
                                                                           Texturen                  => Texturen,
                                                                           AnzahlAutospeichern       => AnzahlAutospeichern,
                                                                           RundenAutospeichern       => RundenAutospeichern,
                                                                           Dezimaltrennzeichen       => Dezimaltrennzeichen,
                                                                           SicherheitsfragenAnzeigen => SicherheitsfragenAnzeigen
                                                                          ));
      
         return True;
      end if;
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenNutzereinstellungenLogik.NutzereinstellungenDurchgehen: Konnte nicht geladen werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
                  
         return False;
         
   end NutzereinstellungenDurchgehen;

end EinlesenNutzereinstellungenLogik;
