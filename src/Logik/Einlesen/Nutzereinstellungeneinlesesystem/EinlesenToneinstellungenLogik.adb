with Ada.Exceptions; use Ada.Exceptions;

with VerzeichnisKonstanten;
with TextKonstanten;

with SchreibeEinstellungenTon;

with Fehlermeldungssystem;
with EinstellungenTon;
with VerzeichnisDateinamenTests;
with UmwandlungenAdaEigenes;
with DateiLogik;

-- Beim Record kann ich theoretisch alles beliebig neu ordnen, beim Einlesen/Schreiben muss ich aber immer alles neue an das Ende anhängen!
package body EinlesenToneinstellungenLogik is

   procedure Toneinstelllungen
   is begin
      
      case
        VerzeichnisDateinamenTests.StandardwerteEinleseprüfung (LinuxTextExtern   => TextKonstanten.LeerString,
                                                                    WindowsTextExtern => UmwandlungenAdaEigenes.EigenesDecode (TextExtern => VerzeichnisKonstanten.Toneinstellungen))
      is
         when False =>
            EinstellungenTon.StandardeinstellungenLaden;
            return;
            
         when True =>
            DateiLogik.ÖffnenStream (DateiartExtern => DateiToneinstellungen,
                                      NameExtern     => VerzeichnisKonstanten.Toneinstellungen);
      end case;
      
      case
        ToneinstellungenDurchgehen (LadenPrüfenExtern => False,
                                    DateiLadenExtern  => DateiToneinstellungen)
      is
         when True =>
            Nullwert := ToneinstellungenDurchgehen (LadenPrüfenExtern => True,
                                                    DateiLadenExtern  => DateiToneinstellungen);
            
         when False =>
            EinstellungenTon.StandardeinstellungenLaden;
      end case;
      
      Close (File => DateiToneinstellungen);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenToneinstellungenLogik.Toneinstelllungen: Konnte nicht geladen werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         EinstellungenTon.StandardeinstellungenLaden;
         
         case
           Is_Open (File => DateiToneinstellungen)
         is
            when True =>
               Close (File => DateiToneinstellungen);
               
            when False =>
               null;
         end case;
      
   end Toneinstelllungen;
   
   
   
   function ToneinstellungenDurchgehen
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
               Float'Read (Stream (File => DateiLadenExtern),
                           Soundlautstärke);
         end case;
      
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Musiklautstärke := EinstellungenTon.ToneinstellungenStandard.Musiklautstärke;
            
            when False =>
               Float'Read (Stream (File => DateiLadenExtern),
                           Musiklautstärke);
         end case;
         
         -- Diese Prüfung muss am Ende aller Einlesefunktionen stehen, um sicher zu sein dass die Datei vollständig eingelesen wurde!
         -- Sollte Probleme mit geänderten Datentypen teilweise vorbeugen.
         return End_Of_File (File => DateiLadenExtern);
      
      else
         SchreibeEinstellungenTon.GesamteToneinstellungen (EinstellungenExtern => (
                                                                                   Soundlautstärke => Soundlautstärke,
                                                                                   Musiklautstärke => Musiklautstärke
                                                                                  ));
      
         return True;
      end if;
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenToneinstellungenLogik.ToneinstellungenDurchgehen: Konnte nicht geladen werden: " &
                                       UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end ToneinstellungenDurchgehen;

end EinlesenToneinstellungenLogik;
