with Sf.Window.Window;

with Menuetexte;
with TextKonstanten;

with LeseEinstellungenGrafik;
with LeseEinstellungenTon;
with LeseOptionen;

with Fehlermeldungssystem;

package body MenuestringsSetzenGrafik is
   
   function MenüstringsSetzen
     (WelcheZeileExtern : in Positive;
      WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      if
        WelcheZeileExtern <= MenueKonstanten.EndeMenü (WelchesMenüExtern)
      then
         null;
            
      else
         Fehlermeldungssystem.Grafik (FehlermeldungExtern => "MenuestringsSetzenGrafik.MenüstringsSetzen: Zeile zu groß: " & WelcheZeileExtern'Wide_Wide_Image & " " & WelchesMenüExtern'Wide_Wide_Image);
         return "";
      end if;
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Haupt_Menü_Enum =>
            AktuellerText := Menuetexte.Hauptmenü (WelcheZeileExtern);
            
         when MenueDatentypen.Spiel_Menü_Enum =>
            AktuellerText := Menuetexte.Spielmenü (WelcheZeileExtern);
            
         when MenueDatentypen.Optionen_Menü_Enum =>
            AktuellerText := Menuetexte.Optionsmenü (WelcheZeileExtern);
            
         when MenueDatentypen.Kartenpole_Menü_Enum =>
            AktuellerText := Menuetexte.Kartenpole (WelcheZeileExtern);
            
         when MenueDatentypen.Kartengröße_Menü_Enum =>
            AktuellerText := Menuetexte.Kartengröße (WelcheZeileExtern);
            
         when MenueDatentypen.Kartenart_Menü_Enum =>
            AktuellerText := Menuetexte.Kartenart (WelcheZeileExtern);
            
         when MenueDatentypen.Kartenform_Menü_Enum =>
            AktuellerText := Menuetexte.Kartenform (WelcheZeileExtern);
            
         when MenueDatentypen.Kartentemperatur_Menü_Enum =>
            AktuellerText := Menuetexte.Kartentemperatur (WelcheZeileExtern);
            
         when MenueDatentypen.Kartenressourcen_Menü_Enum =>
            AktuellerText := Menuetexte.Ressourcenmenge (WelcheZeileExtern);
            
         when MenueDatentypen.Schwierigkeitsgrad_Menü_Enum =>
            AktuellerText := Menuetexte.Schwierigkeitsgrad (WelcheZeileExtern);
                        
         when MenueDatentypen.Spezies_Menü_Enum =>
            AktuellerText := Menuetexte.Speziesauswahl (WelcheZeileExtern);
            
         when MenueDatentypen.Grafik_Menü_Enum =>
            AktuellerText := Grafikmenü (WelcheZeileExtern => WelcheZeileExtern);
            
         when MenueDatentypen.Sound_Menü_Enum =>
            AktuellerText := Soundmenü (WelcheZeileExtern => WelcheZeileExtern);
            
         when MenueDatentypen.Sonstiges_Menü_Enum =>
            AktuellerText := SonstigesMenü (WelcheZeileExtern => WelcheZeileExtern);
            
         when MenueDatentypen.Steuerung_Menü_Enum =>
            AktuellerText := Menuetexte.Steuerungsmenü (WelcheZeileExtern);
            
         when MenueDatentypen.Editoren_Menü_Enum =>
            AktuellerText := Menuetexte.Editorenmenü (WelcheZeileExtern);
            
         when MenueDatentypen.Einstellungen_Menü_Enum =>
            AktuellerText := Menuetexte.Einstellungsmenü (WelcheZeileExtern);
            
         when MenueDatentypen.Debug_Menü_Enum =>
            AktuellerText := Menuetexte.Debugmenü (WelcheZeileExtern);
            
         when MenueDatentypen.Diplomatie_Menü_Enum =>
            AktuellerText := Menuetexte.Diplomatiemenü (WelcheZeileExtern);
            
         when MenueDatentypen.Spielstand_Menü_Enum =>
            AktuellerText := Menuetexte.Spielstandmenü (WelcheZeileExtern);
            
         when MenueDatentypen.Handel_Menü_Enum =>
            AktuellerText := Menuetexte.Handelsmenü (WelcheZeileExtern);
      end case;
            
      return To_Wide_Wide_String (Source => AktuellerText);
      
   end MenüstringsSetzen;
   
   
   
   function Grafikmenü
     (WelcheZeileExtern : in Positive)
      return Unbounded_Wide_Wide_String
   is begin
      
      Zwischenspeicher := Menuetexte.Grafikmenü (WelcheZeileExtern);
      
      if
        WelcheZeileExtern = 2
      then
         AktuelleAuflösung := LeseEinstellungenGrafik.Auflösung;
         Zwischenspeicher := Zwischenspeicher & " (" & ZahlAlsString (ZahlExtern => Positive (AktuelleAuflösung.x)) & "x" & ZahlAlsString (ZahlExtern => Positive (AktuelleAuflösung.y)) & ")";
            
      elsif
        WelcheZeileExtern = 3
      then
         case
           LeseEinstellungenGrafik.Fenstermodus
         is
            when Sf.Window.Window.sfFullscreen =>
               Zwischenspeicher := Zwischenspeicher & TextKonstanten.Haken;
               
            when others =>
               Zwischenspeicher := Zwischenspeicher & TextKonstanten.Kreuz;
         end case;
            
      elsif
        WelcheZeileExtern = 4
      then
         case
           LeseEinstellungenGrafik.Bildrate
         is
            when 0 =>
               Zwischenspeicher := Zwischenspeicher & TextKonstanten.Kreuz;
               
            when others =>
               Zwischenspeicher := Zwischenspeicher & " (" & ZahlAlsString (ZahlExtern => Positive (LeseEinstellungenGrafik.Bildrate)) & ")";
         end case;
            
      elsif
        WelcheZeileExtern = 5
      then
         case
           LeseEinstellungenGrafik.EbenenUnterhalbSichtbar
         is
            when True =>
               Zwischenspeicher := Zwischenspeicher & TextKonstanten.Haken;
               
            when False =>
               Zwischenspeicher := Zwischenspeicher & TextKonstanten.Kreuz;
         end case;
            
      elsif
        WelcheZeileExtern = 6
      then
         case
           LeseEinstellungenGrafik.BildrateAnzeigen
         is
            when True =>
               Zwischenspeicher := Zwischenspeicher & TextKonstanten.Haken;
               
            when False =>
               Zwischenspeicher := Zwischenspeicher & TextKonstanten.Kreuz;
         end case;

      else
         null;
      end if;
      
      return Zwischenspeicher;
      
   end Grafikmenü;
   
   
   
   function Soundmenü
     (WelcheZeileExtern : in Positive)
      return Unbounded_Wide_Wide_String
   is begin

      Zwischenspeicher := Menuetexte.Soundmenü (WelcheZeileExtern);
      
      if
        WelcheZeileExtern = 2
      then
         Zwischenspeicher := Zwischenspeicher & " (" & ZahlAlsString (ZahlExtern => Natural (LeseEinstellungenTon.Soundlautstärke)) & ")";
         
      elsif
        WelcheZeileExtern = 3
      then
         Zwischenspeicher := Zwischenspeicher & " (" & ZahlAlsString (ZahlExtern => Natural (LeseEinstellungenTon.Musiklautstärke)) & ")";
         
      else
         null;
      end if;
      
      return Zwischenspeicher;
      
   end Soundmenü;
   
   
   
   function SonstigesMenü
     (WelcheZeileExtern : in Positive)
      return Unbounded_Wide_Wide_String
   is begin

      Zwischenspeicher := Menuetexte.Sonstigesmenü (WelcheZeileExtern);
      
      if
        WelcheZeileExtern = 2
      then
         case
           LeseOptionen.AnzahlAutospeichern
         is
            when 0 =>
               Zwischenspeicher := Zwischenspeicher & TextKonstanten.Kreuz;
               
            when others =>
               Zwischenspeicher := Zwischenspeicher & " (" & ZahlAlsString (ZahlExtern => Natural (LeseOptionen.AnzahlAutospeichern)) & ")";
         end case;
         
      elsif
        WelcheZeileExtern = 3
      then
         case
           LeseOptionen.AnzahlAutospeichern
         is
            when 0 =>
               Zwischenspeicher := Zwischenspeicher & TextKonstanten.Kreuz;
               
            when others =>
               Zwischenspeicher := Zwischenspeicher & " (" & ZahlAlsString (ZahlExtern => Natural (LeseOptionen.RundenAutospeichern)) & ")";
         end case;
         
      else
         null;
      end if;
         
      return Zwischenspeicher;
      
   end SonstigesMenü;

end MenuestringsSetzenGrafik;
