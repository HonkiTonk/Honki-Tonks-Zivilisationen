with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemRecords;
with VerzeichnisKonstanten;
with GrafikRecords;
with TonRecords;
with TastenbelegungDatenbank;
with OptionenVariablen;
with ZahlenDatentypen;

with LeseOptionen;
with LeseEinstellungenSound;
with LeseEinstellungenGrafik;
with LeseEinstellungenMusik;

with TexteinstellungenGrafik;
with SpezieseinstellungenGrafik;
with Fehlermeldungssystem;

package body SchreibenEinstellungenLogik is
   
   -- Gesamter Record ist SystemRecords.NutzerEinstellungenRecord;
   procedure Nutzereinstellungen
   is begin
      
      Create (File => DateiNutzereinstellungen,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.Spieleinstellungen,
              Form => "WCEM=8");
      
      Unbounded_Wide_Wide_String'Write (Stream (File => DateiNutzereinstellungen),
                                        LeseOptionen.Sprache);
      
      ZahlenDatentypen.EigenesNatural'Write (Stream (File => DateiNutzereinstellungen),
                                             LeseOptionen.AnzahlAutospeichern);
      
      ZahlenDatentypen.EigenesPositive'Write (Stream (File => DateiNutzereinstellungen),
                                              LeseOptionen.RundenAutospeichern);
      
      Close (File => DateiNutzereinstellungen);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibenEinstellungenLogik.Nutzereinstellungen - Konnte nicht geschrieben werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         
         case
           Is_Open (File => DateiNutzereinstellungen)
         is
            when True =>
               Close (File => DateiNutzereinstellungen);
               
            when False =>
               null;
         end case;
      
   end Nutzereinstellungen;
   
   
   
   procedure Grafikeinstellungen
   is begin
      
      Create (File => DateiGrafikeinstellungen,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.Grafikeinstellungen,
              Form => "WCEM=8");
            
      GrafikRecords.FensterRecord'Write (Stream (File => DateiGrafikeinstellungen),
                                         LeseEinstellungenGrafik.Fenstereinstellungen);
      GrafikRecords.GrafikeinstellungenRecord'Write (Stream (File => DateiGrafikeinstellungen),
                                                     LeseEinstellungenGrafik.Grafikeinstellungen);
      
      TexteinstellungenGrafik.SchriftgrößenArray'Write (Stream (File => DateiGrafikeinstellungen),
                                                          TexteinstellungenGrafik.SchriftgrößeneintragLesen);
      TexteinstellungenGrafik.SchriftfarbenArray'Write (Stream (File => DateiGrafikeinstellungen),
                                                        TexteinstellungenGrafik.SchriftfarbeneintragLesen);
      
      SpezieseinstellungenGrafik.SpeziesFarbenArray'Write (Stream (File => DateiGrafikeinstellungen),
                                                           SpezieseinstellungenGrafik.FarbenarrayLesen);
      SpezieseinstellungenGrafik.SpeziesFarbenArray'Write (Stream (File => DateiGrafikeinstellungen),
                                                           SpezieseinstellungenGrafik.RahmenarrayLesen);
      
      Close (File => DateiGrafikeinstellungen);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibenEinstellungenLogik.Grafikeinstellungen - Konnte nicht geschrieben werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         
         case
           Is_Open (File => DateiGrafikeinstellungen)
         is
            when True =>
               Close (File => DateiGrafikeinstellungen);
               
            when False =>
               null;
         end case;
      
   end Grafikeinstellungen;
   
   
   
   procedure Soundeinstellungen
   is begin
      
      Create (File => DateiSoundeinstellungen,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.Toneinstellungen,
              Form => "WCEM=8");
      
      TonRecords.SoundeinstellungenRecord'Write (Stream (File => DateiSoundeinstellungen),
                                                 LeseEinstellungenSound.GanzerEintrag);
      
      TonRecords.MusikeinstellungenRecord'Write (Stream (File => DateiSoundeinstellungen),
                                                 LeseEinstellungenMusik.GanzerEintrag);
      
      Close (File => DateiSoundeinstellungen);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibenEinstellungenLogik.Soundeinstellungen - Konnte nicht geschrieben werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         
         case
           Is_Open (File => DateiSoundeinstellungen)
         is
            when True =>
               Close (File => DateiSoundeinstellungen);
               
            when False =>
               null;
         end case;
            
   end Soundeinstellungen;
   
   

   procedure TastenbelegungSchreiben
   is begin
      
      Create (File => DateiTastenbelegung,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.Tasteneinstellungen,
              Form => "WCEM=8");
      
      TastenbelegungDatenbank.AllgemeineBelegungArray'Write (Stream (File => DateiTastenbelegung),
                                                             TastenbelegungDatenbank.AllgemeineBelegung);
      
      TastenbelegungDatenbank.EinheitenbelegungArray'Write (Stream (File => DateiTastenbelegung),
                                                            TastenbelegungDatenbank.Einheitenbelegung);
      
      TastenbelegungDatenbank.StadtbelegungArray'Write (Stream (File => DateiTastenbelegung),
                                                        TastenbelegungDatenbank.Stadtbelegung);
      
      Close (File => DateiTastenbelegung);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibenEinstellungenLogik.TastenbelegungSchreiben - Konnte nicht geschrieben werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         
         case
           Is_Open (File => DateiTastenbelegung)
         is
            when True =>
               Close (File => DateiTastenbelegung);
               
            when False =>
               null;
         end case;
      
   end TastenbelegungSchreiben;
   
   
   
   -- Hier später wieder den direkten Zugriff auf OptionenVariablen entfernen. äöü
   procedure SonstigeEinstellungenSpeichern
   is begin
      
      Create (File => DateiSonstigeEinstellungen,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.SonstigeEinstellungen,
              Form => "WCEM=8");
      
      SystemRecords.SonstigeEinstellungenRecord'Write (Stream (File => DateiSonstigeEinstellungen),
                                                       OptionenVariablen.SonstigeEinstellungen);
      
      Close (File => DateiSonstigeEinstellungen);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibenEinstellungenLogik.SonstigeEinstellungenSpeichern - Konnte nicht geschrieben werden: "
                                     & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         
         case
           Is_Open (File => DateiSonstigeEinstellungen)
         is
            when True =>
               Close (File => DateiSonstigeEinstellungen);
               
            when False =>
               null;
         end case;
      
   end SonstigeEinstellungenSpeichern;

end SchreibenEinstellungenLogik;
