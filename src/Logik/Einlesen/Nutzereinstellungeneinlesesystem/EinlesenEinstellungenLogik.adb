with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Exceptions; use Ada.Exceptions;

with VerzeichnisKonstanten;
with OptionenVariablen;

with SchreibeOptionen;
with SchreibeEinstellungenSound;
with SchreibeEinstellungenMusik;

with EinstellungenMusik;
with EinstellungenSound;

with Fehlermeldungssystem;
with EinlesenGrafikeinstellungenLogik;

package body EinlesenEinstellungenLogik is

   procedure EinlesenEinstellungen
   is begin
      
      Nutzereinstellungen;
      EinlesenGrafikeinstellungenLogik.Grafikeinstellungen;
      Toneinstelllungen;
      SonstigeEinstellungen;
      
   end EinlesenEinstellungen;
   
   
   
   procedure Nutzereinstellungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Spieleinstellungen)
      is
         when False =>
            OptionenVariablen.StandardNutzereinstellungenLaden;
            return;
            
         when True =>
            Open (File => DateiNutzereinstellungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Spieleinstellungen,
                  Form => "WCEM=8");
      end case;
      
      case
        NutzereinstellungenDurchgehen (LadenPrüfenExtern => False,
                                       DateiLadenExtern  => DateiNutzereinstellungen)
      is
         when False =>
            OptionenVariablen.StandardNutzereinstellungenLaden;
            
         when True =>
            Set_Index (File => DateiNutzereinstellungen,
                       To   => 1);
              
            Nullwert := NutzereinstellungenDurchgehen (LadenPrüfenExtern => True,
                                                       DateiLadenExtern  => DateiNutzereinstellungen);
      end case;

      Close (File => DateiNutzereinstellungen);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenEinstellungenLogik.Nutzereinstellungen - Konnte nicht geladen werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
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
      
      Unbounded_Wide_Wide_String'Read (Stream (File => DateiLadenExtern),
                                       Sprache);
      ZahlenDatentypen.EigenesNatural'Read (Stream (File => DateiLadenExtern),
                                            AnzahlAutospeichern);
      ZahlenDatentypen.EigenesPositive'Read (Stream (File => DateiLadenExtern),
                                             RundenAutospeichern);
      
      case
        LadenPrüfenExtern
      is
         when False =>
            null;
            
         when True =>
            SchreibeOptionen.Sprache (SpracheExtern => Sprache);
            SchreibeOptionen.AnzahlAutospeichern (AutospeicheranzahlExtern => AnzahlAutospeichern);
            SchreibeOptionen.RundenAutospeichern (RundenanzahlExtern => RundenAutospeichern);
      end case;
      
      return True;
      
   exception
      when End_Error =>
         return False;
         
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenEinstellungenLogik.NutzereinstellungenDurchgehen - Konnte nicht geladen werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
                  
         return False;
      
   end NutzereinstellungenDurchgehen;
   
   
   
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
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenEinstellungenLogik.Toneinstelllungen - Konnte nicht geladen werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
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
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenEinstellungenLogik.ToneinstellungenDurchgehen - Konnte nicht geladen werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end ToneinstellungenDurchgehen;
   
   
   
   procedure SonstigeEinstellungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.SonstigeEinstellungen)
      is
         when False =>
            OptionenVariablen.SonstigeStandardeinstellungenLaden;
            return;
            
         when True =>
            Open (File => DateiSonstigeEinstellungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.SonstigeEinstellungen,
                  Form => "WCEM=8");
      end case;
      
      case
        SonstigeEinstellungenDurchgehen (LadenPrüfenExtern => False,
                                         DateiLadenExtern  => DateiSonstigeEinstellungen)
      is
         when True =>
            Set_Index (File => DateiSonstigeEinstellungen,
                       To   => 1);
            
            Nullwert := SonstigeEinstellungenDurchgehen (LadenPrüfenExtern => True,
                                                         DateiLadenExtern  => DateiSonstigeEinstellungen);
            
         when False =>
            OptionenVariablen.SonstigeStandardeinstellungenLaden;
      end case;
      
      Close (File => DateiSonstigeEinstellungen);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenEinstellungenLogik.SonstigeEinstellungen - Konnte nicht geladen werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         OptionenVariablen.SonstigeStandardeinstellungenLaden;
         
         case
           Is_Open (File => DateiSonstigeEinstellungen)
         is
            when True =>
               Close (File => DateiSonstigeEinstellungen);
               
            when False =>
               null;
         end case;
      
   end SonstigeEinstellungen;
   
   
   
   function SonstigeEinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      SystemRecords.SonstigeEinstellungenRecord'Read (Stream (File => DateiLadenExtern),
                                                      ZwischenspeicherSonstigeEinstellungen);
      
      case
        LadenPrüfenExtern
      is
         when False =>
            null;
            
         when True =>
            OptionenVariablen.SonstigeEinstellungen := ZwischenspeicherSonstigeEinstellungen;
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenEinstellungenLogik.SonstigeEinstellungenDurchgehen - Konnte nicht geladen werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end SonstigeEinstellungenDurchgehen;

end EinlesenEinstellungenLogik;
