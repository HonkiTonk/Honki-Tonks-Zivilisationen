with Ada.Exceptions; use Ada.Exceptions;

with DateizugriffssystemHTSEB;
with DateisystemtestsHTSEB;
with UmwandlungssystemHTSEB;
with MeldungssystemHTSEB;

with VerzeichnisKonstanten;
with TextKonstanten;

with SchreibeEinstellungenTon;

with EinstellungenTon;

-- Beim Record kann ich theoretisch alles beliebig neu ordnen, beim Einlesen/Schreiben muss ich aber immer alles neue an das Ende anhängen!
package body EinlesenToneinstellungenLogik is

   procedure Toneinstelllungen
   is begin
      
      case
        DateisystemtestsHTSEB.StandardwerteEinleseprüfung (LinuxTextExtern   => TextKonstanten.LeerString,
                                                            WindowsTextExtern => UmwandlungssystemHTSEB.Decode (TextExtern => VerzeichnisKonstanten.Toneinstellungen))
      is
         when False =>
            EinstellungenTon.StandardeinstellungenLaden;
            return;
            
         when True =>
            DateizugriffssystemHTSEB.ÖffnenStream (DateiartExtern => DateiToneinstellungen,
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
            
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiToneinstellungen,
                                                 NameExtern     => VerzeichnisKonstanten.Toneinstellungen);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenToneinstellungenLogik.Toneinstelllungen: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         EinstellungenTon.StandardeinstellungenLaden;
            
         DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiToneinstellungen,
                                                    NameExtern     => VerzeichnisKonstanten.Toneinstellungen);
      
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
         MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenToneinstellungenLogik.ToneinstellungenDurchgehen: Konnte nicht geladen werden: " &
                                      UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end ToneinstellungenDurchgehen;

end EinlesenToneinstellungenLogik;
