with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Window.Window;
with Sf.System.Vector2;
with Sf.Graphics.Color;

with SystemRecords;
with VerzeichnisKonstanten;
with TonRecords;
with TastenbelegungDatenbank;
with OptionenVariablen;
with ZahlenDatentypen;
with TextDatentypen;
with SpeziesDatentypen;

with LeseOptionen;
with LeseEinstellungenSound;
with LeseEinstellungenGrafik;
with LeseEinstellungenMusik;

with Fehlermeldungssystem;
with TexteinstellungenGrafik;

package body SchreibenEinstellungenLogik is
   
   procedure Nutzereinstellungen
   is begin
      
      Create (File => DateiNutzereinstellungen,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.Spieleinstellungen,
              Form => "WCEM=8");
      
      -- SystemRecords.NutzerEinstellungenRecord
      Unbounded_Wide_Wide_String'Write (Stream (File => DateiNutzereinstellungen),
                                        LeseOptionen.Sprache);
      
      ZahlenDatentypen.EigenesNatural'Write (Stream (File => DateiNutzereinstellungen),
                                             LeseOptionen.AnzahlAutospeichern);
      
      ZahlenDatentypen.EigenesPositive'Write (Stream (File => DateiNutzereinstellungen),
                                              LeseOptionen.RundenAutospeichern);
      -- SystemRecords.NutzerEinstellungenRecord
      
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
   
   
   
   -- Beim Record kann ich theoretisch alles beliebig neu ordnen, beim Einlesen/Schreiben muss ich aber immer alles neue an das Ende anhängen!
   -- Keine Schleifen einbauen, sonst wird das automatisch irgendwo dazwischen eingebaut und nicht am Ende wenn der Schleifenbereich erweitert wird!
   procedure Grafikeinstellungen
   is begin
      
      Create (File => DateiGrafikeinstellungen,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.Grafikeinstellungen,
              Form => "WCEM=8");
      
      -- GrafikRecords.GrafikeinstellungenRecord
      Sf.Window.Window.sfWindowStyle'Write (Stream (File => DateiGrafikeinstellungen),
                                            LeseEinstellungenGrafik.Fenstermodus);
      
      Sf.System.Vector2.sfVector2u'Write (Stream (File => DateiGrafikeinstellungen),
                                          LeseEinstellungenGrafik.Auflösung);
      
      Sf.sfUint32'Write (Stream (File => DateiGrafikeinstellungen),
                         LeseEinstellungenGrafik.Farbtiefe);
      
      Sf.sfUint32'Write (Stream (File => DateiGrafikeinstellungen),
                         LeseEinstellungenGrafik.Bildrate);
      
      
      
      Sf.sfUint32'Write (Stream (File => DateiGrafikeinstellungen),
                         TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Überschrift_Enum));
      
      Sf.sfUint32'Write (Stream (File => DateiGrafikeinstellungen),
                         TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Standard_Enum));
      
      Sf.sfUint32'Write (Stream (File => DateiGrafikeinstellungen),
                         TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Klein_Enum));
            
      Sf.Graphics.Color.sfColor'Write (Stream (File => DateiGrafikeinstellungen),
                                       TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Überschrift_Enum));
      
      Sf.Graphics.Color.sfColor'Write (Stream (File => DateiGrafikeinstellungen),
                                       TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Standard_Enum));
      
      Sf.Graphics.Color.sfColor'Write (Stream (File => DateiGrafikeinstellungen),
                                       TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Ausgewählt_Enum));
      
      Sf.Graphics.Color.sfColor'Write (Stream (File => DateiGrafikeinstellungen),
                                       TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Mensch_Enum));
      
      Sf.Graphics.Color.sfColor'Write (Stream (File => DateiGrafikeinstellungen),
                                       TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.KI_Enum));
      
      Sf.Graphics.Color.sfColor'Write (Stream (File => DateiGrafikeinstellungen),
                                       TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Sonstiges_Enum));
      
      
      
      -- Die Schleife kann ich hier verwenden, weil sich die Speziesanzahl nicht mehr ändern wird.
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
      
         Sf.Graphics.Color.sfColor'Write (Stream (File => DateiGrafikeinstellungen),
                                          LeseEinstellungenGrafik.SpeziesfarbeLesen (SpeziesExtern => SpeziesSchleifenwert));
         
      end loop SpeziesSchleife;
      
      
      
      Boolean'Write (Stream (File => DateiGrafikeinstellungen),
                     LeseEinstellungenGrafik.EbenenUnterhalbSichtbar);
      
      Boolean'Write (Stream (File => DateiGrafikeinstellungen),
                     LeseEinstellungenGrafik.BildrateAnzeigen);
      -- GrafikRecords.GrafikeinstellungenRecord
      
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
              Name => VerzeichnisKonstanten.Tastatureinstellungen,
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
