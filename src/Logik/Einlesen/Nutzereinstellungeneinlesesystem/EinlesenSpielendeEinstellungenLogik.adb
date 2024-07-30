with Ada.Exceptions; use Ada.Exceptions;

with VerzeichnisKonstanten;
with OptionenVariablen;
with TextKonstanten;

with SchreibeOptionen;

with Fehlermeldungssystem;
with VerzeichnisDateinamenTests;
with UmwandlungenAdaEigenes;

-- Beim Record kann ich theoretisch alles beliebig neu ordnen, beim Einlesen/Schreiben muss ich aber immer alles neue an das Ende anhängen!
package body EinlesenSpielendeEinstellungenLogik is

   procedure SpielendeEinstellungen
   is begin
      
      case
        VerzeichnisDateinamenTests.StandardwerteEinleseprüfung (LinuxTextExtern   => TextKonstanten.LeerString,
                                                                    WindowsTextExtern => UmwandlungenAdaEigenes.EigenesDecode (TextExtern => VerzeichnisKonstanten.SpielendeEinstellungen))
      is
         when False =>
            OptionenVariablen.SpielendeStandardeinstellungenLaden;
            return;
            
         when True =>
            Open (File => DateiSonstigeEinstellungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.SpielendeEinstellungen,
                  Form => "WCEM=8");
      end case;
      
      case
        SpielendeEinstellungenDurchgehen (LadenPrüfenExtern => False,
                                          DateiLadenExtern  => DateiSonstigeEinstellungen)
      is
         when True =>
            Nullwert := SpielendeEinstellungenDurchgehen (LadenPrüfenExtern => True,
                                                          DateiLadenExtern  => DateiSonstigeEinstellungen);
            
         when False =>
            OptionenVariablen.SpielendeStandardeinstellungenLaden;
      end case;
      
      Close (File => DateiSonstigeEinstellungen);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSpielendeEinstellungenLogik.SpielendeEinstellungen: Konnte nicht geladen werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         OptionenVariablen.SpielendeStandardeinstellungenLaden;
         
         case
           Is_Open (File => DateiSonstigeEinstellungen)
         is
            when True =>
               Close (File => DateiSonstigeEinstellungen);
               
            when False =>
               null;
         end case;
      
   end SpielendeEinstellungen;
   
   
   
   function SpielendeEinstellungenDurchgehen
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
               ZahlenDatentypen.EigenesPositive'Read (Stream (File => DateiLadenExtern),
                                                      Autospeichernwert);
         end case;
         
         -- Diese Prüfung muss am Ende aller Einlesefunktionen stehen, um sicher zu sein dass die Datei vollständig eingelesen wurde!
         -- Sollte Probleme mit geänderten Datentypen teilweise vorbeugen.
         return End_Of_File (File => DateiLadenExtern);
      
      else
         SchreibeOptionen.GanzeSpielendeEinstellungen (EinstellungenExtern => (
                                                                               AktuellerAutospeichernwert => Autospeichernwert
                                                                              ));
      
         return True;
      end if;
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSpielendeEinstellungenLogik.SonstigeEinstellungenDurchgehen: Konnte nicht geladen werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end SpielendeEinstellungenDurchgehen;

end EinlesenSpielendeEinstellungenLogik;
