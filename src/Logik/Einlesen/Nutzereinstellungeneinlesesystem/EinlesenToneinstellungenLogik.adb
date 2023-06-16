with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Exceptions; use Ada.Exceptions;

with VerzeichnisKonstanten;

with SchreibeEinstellungenSound;
with SchreibeEinstellungenMusik;

with EinstellungenMusik;
with EinstellungenSound;
with Fehlermeldungssystem;

package body EinlesenToneinstellungenLogik is

   procedure Toneinstelllungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Toneinstellungen)
      is
         when False =>
            EinstellungenMusik.StandardeinstellungenLaden;
            EinstellungenSound.StandardeinstellungenLaden;
            return;
            
         when True =>
            Open (File => DateiSoundeinstellungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Toneinstellungen,
                  Form => "WCEM=8");
      end case;
      
      case
        ToneinstellungenDurchgehen (LadenPrüfenExtern => False,
                                    DateiLadenExtern  => DateiSoundeinstellungen)
      is
         when True =>
            Set_Index (File => DateiSoundeinstellungen,
                       To   => 1);
            
            Nullwert := ToneinstellungenDurchgehen (LadenPrüfenExtern => True,
                                                    DateiLadenExtern  => DateiSoundeinstellungen);
            
         when False =>
            EinstellungenMusik.StandardeinstellungenLaden;
            EinstellungenSound.StandardeinstellungenLaden;
      end case;
      
      Close (File => DateiSoundeinstellungen);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenToneinstellungenLogik.Toneinstelllungen - Konnte nicht geladen werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         EinstellungenMusik.StandardeinstellungenLaden;
         EinstellungenSound.StandardeinstellungenLaden;
         
         case
           Is_Open (File => DateiSoundeinstellungen)
         is
            when True =>
               Close (File => DateiSoundeinstellungen);
               
            when False =>
               null;
         end case;
      
   end Toneinstelllungen;
   
   
   
   function ToneinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      TonRecords.SoundeinstellungenRecord'Read (Stream (File => DateiLadenExtern),
                                                Soundeinstellungen);
      
      TonRecords.MusikeinstellungenRecord'Read (Stream (File => DateiLadenExtern),
                                                Musikeinstellungen);
      
      case
        LadenPrüfenExtern
      is
         when False =>
            null;
            
         when True =>
            SchreibeEinstellungenSound.GanzerEintrag (EintragExtern => Soundeinstellungen);
            SchreibeEinstellungenMusik.GanzerEintrag (EintrageExtern => Musikeinstellungen);
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenToneinstellungenLogik.ToneinstellungenDurchgehen - Konnte nicht geladen werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end ToneinstellungenDurchgehen;

end EinlesenToneinstellungenLogik;
