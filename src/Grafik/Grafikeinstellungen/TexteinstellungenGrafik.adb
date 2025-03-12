with Ada.Directories;

with Sf.Graphics.Font;

with DateizugriffssystemHTSEB;

with VerzeichnisKonstanten;
with TextKonstanten;
with EinstellungenGrafik;

with LeseOptionen;

with MeldungssystemHTSEB;
with EinlesenAllgemeinesLogik;
with TextaccesseSchriftartGrafik;
with UmwandlungssystemHTSEB;

-- Das hier auch mal in Lesen und Schreiben aufteilen? äöü
package body TexteinstellungenGrafik is
   
   procedure SchriftartFestlegen
   is
      use Ada.Directories;
   begin
      
      AktuelleSprache := LeseOptionen.Sprache;
        
      if
        AktuelleSprache = TextKonstanten.LeerUnboundedString
      then
         SchriftartAccess := SchriftartaccessFestlegen (SchriftartAccessExtern => SchriftartAccess,
                                                        FontpfadExtern         => StandardSchriftartVerwenden);
         
      elsif
        Exists (Name => VerzeichnisKonstanten.SprachenStrich & UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => AktuelleSprache) & VerzeichnisKonstanten.FontDatei) = False
      then
         SchriftartAccess := SchriftartaccessFestlegen (SchriftartAccessExtern => SchriftartAccess,
                                                        FontpfadExtern         => StandardSchriftartVerwenden);
         
      else
         SchriftartAccess := SchriftartaccessFestlegen (SchriftartAccessExtern => SchriftartAccess,
                                                        FontpfadExtern         => EigeneSchriftartVerwenden (SpracheExtern => To_Wide_Wide_String (Source => AktuelleSprache)));
      end if;
      
      TextaccesseSchriftartGrafik.SchriftartSetzen (SchriftaccessExtern => SchriftartAccess);
      
   end SchriftartFestlegen;
   
   
   
   function SchriftartaccessFestlegen
     (SchriftartAccessExtern : in Sf.Graphics.sfFont_Ptr;
      FontpfadExtern : in String)
      return Sf.Graphics.sfFont_Ptr
   is begin
      
      -- Muss immer auch destroyed werden damit es nicht zu einem Speicherleck kommt!
      Sf.Graphics.Font.destroy (font => SchriftartAccessExtern);
      
      return Sf.Graphics.Font.createFromFile (filename => FontpfadExtern);
      
   end SchriftartaccessFestlegen;
   
   
   
   function StandardSchriftartVerwenden
     return String
   is
      use Ada.Directories;
   begin
      
      case
        Exists (Name => VerzeichnisKonstanten.FontOrdner & VerzeichnisKonstanten.SchriftartStandard)
      is
         when False =>
            MeldungssystemHTSEB.Grafik (MeldungExtern => "TexteinstellungenGrafik.StandardSchriftartVerwenden: Standardfont nicht vorhanden");
            raise SchriftartFehlt;
            
         when True =>
            return VerzeichnisKonstanten.FontOrdner & VerzeichnisKonstanten.SchriftartStandard;
      end case;
            
   end StandardSchriftartVerwenden;
   
   
   
   function EigeneSchriftartVerwenden
     (SpracheExtern : in Wide_Wide_String)
      return String
   is
      use Ada.Directories;
   begin
      
      case
        Exists (Name => VerzeichnisKonstanten.SprachenStrich & UmwandlungssystemHTSEB.Encode (TextExtern => SpracheExtern) & VerzeichnisKonstanten.FontDatei)
      is
         when False =>
            return StandardSchriftartVerwenden;
            
         when True =>
            DateizugriffssystemHTSEB.ÖffnenText (DateiartExtern => DateiSchriftart,
                                                  NameExtern     => VerzeichnisKonstanten.SprachenStrich & UmwandlungssystemHTSEB.Encode (TextExtern => SpracheExtern) & VerzeichnisKonstanten.FontDatei);
      end case;
      
      case
        EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiSchriftart,
                                                         AktuelleZeileExtern => 1,
                                                         DateinameExtern     => "TexteinstellungenGrafik.EigeneSchriftartVerwenden")
      is
         when True =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "TexteinstellungenGrafik.EigeneSchriftartVerwenden: Fehlender Fontname");
               
         when False =>
            EigeneSchriftart := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiSchriftart,
                                                                                 AktuelleZeileExtern => 1,
                                                                                 DateinameExtern     => "TexteinstellungenGrafik.EigeneSchriftartVerwenden");
            
            if
              Exists (Name => VerzeichnisKonstanten.FontOrdner & UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => EigeneSchriftart)) = False
            then
               MeldungssystemHTSEB.Logik (MeldungExtern => "TexteinstellungenGrafik.EigeneSchriftartVerwenden: Fehlende Fontdatei");
               
            else
               DateizugriffssystemHTSEB.SchließenText (DateiartExtern => DateiSchriftart,
                                                        NameExtern     => VerzeichnisKonstanten.SprachenStrich & UmwandlungssystemHTSEB.Encode (TextExtern => SpracheExtern) & VerzeichnisKonstanten.FontDatei);
               return VerzeichnisKonstanten.FontOrdner & UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => EigeneSchriftart);
            end if;
      end case;
            
      DateizugriffssystemHTSEB.SchließenText (DateiartExtern => DateiSchriftart,
                                               NameExtern     => VerzeichnisKonstanten.SprachenStrich & UmwandlungssystemHTSEB.Encode (TextExtern => SpracheExtern) & VerzeichnisKonstanten.FontDatei);
      
      return StandardSchriftartVerwenden;
      
   end EigeneSchriftartVerwenden;
   
   
   
   function SchriftartLesen
     return Sf.Graphics.sfFont_Ptr
   is begin
      
      return SchriftartAccess;
      
   end SchriftartLesen;
   
   
   
   procedure SchriftgrößeSchreiben
     (GrößeExtern : in Sf.sfUint32;
      WelcheGrößeExtern : in TextDatentypen.Schriftgröße_Enum)
   is begin
      
      EinstellungenGrafik.Grafikeinstellungen.Schriftgrößen (WelcheGrößeExtern) := GrößeExtern;
      
   end SchriftgrößeSchreiben;



   procedure SchriftfarbeSchreiben
     (FarbeExtern : in Sf.Graphics.Color.sfColor;
      WelcheFarbeExtern : in TextDatentypen.Schriftfarbe_Enum)
   is begin

      EinstellungenGrafik.Grafikeinstellungen.Schriftfarben (WelcheFarbeExtern) := FarbeExtern;

   end SchriftfarbeSchreiben;



   function SchriftgrößeLesen
     (WelcheGrößeExtern : in TextDatentypen.Schriftgröße_Enum)
      return Sf.sfUint32
   is begin

      return EinstellungenGrafik.Grafikeinstellungen.Schriftgrößen (WelcheGrößeExtern);

   end SchriftgrößeLesen;
   
   
   
   function SchriftfarbeLesen
     (WelcheFarbeExtern : in TextDatentypen.Schriftfarbe_Enum)
      return Sf.Graphics.Color.sfColor
   is begin
      
      return EinstellungenGrafik.Grafikeinstellungen.Schriftfarben (WelcheFarbeExtern);
      
   end SchriftfarbeLesen;
   
   
   
   procedure SchriftstilSchreiben
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      EinstellungenGrafik.Grafikeinstellungen.Schriftstil := StilExtern;
      
   end SchriftstilSchreiben;
   
   
   
   function SchriftstilLesen
     return Sf.Graphics.Text.sfTextStyle
   is begin
      
      return EinstellungenGrafik.Grafikeinstellungen.Schriftstil;
      
   end SchriftstilLesen;
   
   
   
   procedure SchriftrahmenSchreiben
     (SchriftrahmenExtern : in Float)
   is begin
      
      EinstellungenGrafik.Grafikeinstellungen.Schriftrahmen := SchriftrahmenExtern;
      
   end SchriftrahmenSchreiben;
   
   
   
   function SchriftrahmenLesen
     return Float
   is begin
      
      return EinstellungenGrafik.Grafikeinstellungen.Schriftrahmen;
      
   end SchriftrahmenLesen;
        

end TexteinstellungenGrafik;
