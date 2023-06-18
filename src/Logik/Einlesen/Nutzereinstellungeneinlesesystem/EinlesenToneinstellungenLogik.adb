with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Exceptions; use Ada.Exceptions;

with VerzeichnisKonstanten;

with SchreibeEinstellungenTon;

with Fehlermeldungssystem;
with EinstellungenTon;

-- Beim Record kann ich theoretisch alles beliebig neu ordnen, beim Einlesen/Schreiben muss ich aber immer alles neue an das Ende anhängen!
package body EinlesenToneinstellungenLogik is

   procedure Toneinstelllungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Toneinstellungen)
      is
         when False =>
            EinstellungenTon.StandardeinstellungenLaden;
            return;
            
         when True =>
            Open (File => DateiToneinstellungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Toneinstellungen,
                  Form => "WCEM=8");
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
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenToneinstellungenLogik.Toneinstelllungen - Konnte nicht geladen werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
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
         -- TonRecords.ToneinstellungenRecord
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
         -- TonRecords.ToneinstellungenRecord
      
      else
         SchreibeEinstellungenTon.GesamteToneinstellungen (EinstellungenExtern => (
                                                                                   Soundlautstärke => Soundlautstärke,
                                                                                   Musiklautstärke => Musiklautstärke
                                                                                  ));
      end if;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenToneinstellungenLogik.ToneinstellungenDurchgehen - Konnte nicht geladen werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end ToneinstellungenDurchgehen;

end EinlesenToneinstellungenLogik;
