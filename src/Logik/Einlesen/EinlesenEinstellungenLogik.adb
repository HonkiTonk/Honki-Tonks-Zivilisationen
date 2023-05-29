with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Exceptions; use Ada.Exceptions;

with VerzeichnisKonstanten;
with OptionenVariablen;

with SchreibeOptionen;
with SchreibeEinstellungenSound;
with SchreibeEinstellungenMusik;
with SchreibeEinstellungenGrafik;

with EinstellungenGrafik;
with EinstellungenMusik;
with EinstellungenSound;

with Fehlermeldungssystem;

package body EinlesenEinstellungenLogik is

   procedure EinlesenEinstellungen
   is begin
      
      Nutzereinstellungen;
      Grafikeinstellungen;
      Toneinstelllungen;
      SonstigeEinstellungen;
      
   end EinlesenEinstellungen;
   
   
   
   procedure Nutzereinstellungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Nutzereinstellungen)
      is
         when False =>
            OptionenVariablen.StandardNutzereinstellungenLaden;
            return;
            
         when True =>
            Open (File => DateiNutzereinstellungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Nutzereinstellungen,
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
            
      SystemRecords.NutzerEinstellungenRecord'Read (Stream (File => DateiLadenExtern),
                                                    ZwischenspeicherNutzereinstellungen);
      
      case
        LadenPrüfenExtern
      is
         when False =>
            null;
            
         when True =>
            SchreibeOptionen.GanzerEintrag (EintragExtern => ZwischenspeicherNutzereinstellungen);
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenEinstellungenLogik.NutzereinstellungenDurchgehen - Konnte nicht geladen werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end NutzereinstellungenDurchgehen;
   
   
   
   procedure Grafikeinstellungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafikeinstellungen)
      is
         when False =>
            EinstellungenGrafik.StandardeinstellungenLaden;
            return;
            
         when True =>
            Open (File => DateiGrafikeinstellungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafikeinstellungen,
                  Form => "WCEM=8");
      end case;
      
      case
        GrafikeinstellungenDurchgehen (LadenPrüfenExtern => False,
                                       DateiLadenExtern  => DateiGrafikeinstellungen)
      is
         when True =>
            Set_Index (File => DateiGrafikeinstellungen,
                       To   => 1);
            
            Nullwert := GrafikeinstellungenDurchgehen (LadenPrüfenExtern => True,
                                                       DateiLadenExtern  => DateiGrafikeinstellungen);
            
         when False =>
            EinstellungenGrafik.StandardeinstellungenLaden;
      end case;
                        
      Close (File => DateiGrafikeinstellungen);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenEinstellungenLogik.Grafikeinstellungen - Konnte nicht geladen werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         EinstellungenGrafik.StandardeinstellungenLaden;
         
         case
           Is_Open (File => DateiGrafikeinstellungen)
         is
            when True =>
               Close (File => DateiGrafikeinstellungen);
               
            when False =>
               null;
         end case;
      
   end Grafikeinstellungen;
   
   
   
   function GrafikeinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      GrafikRecords.FensterRecord'Read (Stream (File => DateiLadenExtern),
                                        Fenstereinstellungen);
      GrafikRecords.GrafikeinstellungenRecord'Read (Stream (File => DateiLadenExtern),
                                                    ZwischenspeicherGrafikeinstellungen);
      
      TexteinstellungenGrafik.SchriftgrößenArray'Read (Stream (File => DateiLadenExtern),
                                                         Schriftgrößen);
      TexteinstellungenGrafik.SchriftfarbenArray'Read (Stream (File => DateiLadenExtern),
                                                       Schriftfarben);
            
      SpezieseinstellungenGrafik.SpeziesFarbenArray'Read (Stream (File => DateiLadenExtern),
                                                          Speziesfarben);
      SpezieseinstellungenGrafik.SpeziesFarbenArray'Read (Stream (File => DateiLadenExtern),
                                                          Rahmenfarben);
      
      case
        LadenPrüfenExtern
      is
         when False =>
            null;
            
         when True =>
            SchreibeEinstellungenGrafik.Fenstereinstellungen (EintragExtern => Fenstereinstellungen);
            SchreibeEinstellungenGrafik.Grafikeinstellungen (EintragExtern => ZwischenspeicherGrafikeinstellungen);
            
            TexteinstellungenGrafik.SchriftgrößeneintragSchreiben (EintragExtern => Schriftgrößen);
            TexteinstellungenGrafik.SchriftfarbeneintragSchreiben (EintragExtern => Schriftfarben);
            
            SpezieseinstellungenGrafik.FarbenarraySchreiben (FarbenExtern => Speziesfarben);
            SpezieseinstellungenGrafik.RahmenarraySchreiben (FarbenExtern => Rahmenfarben);
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenEinstellungenLogik.GrafikeinstellungenDurchgehen - Konnte nicht geladen werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end GrafikeinstellungenDurchgehen;
   
   
   
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
