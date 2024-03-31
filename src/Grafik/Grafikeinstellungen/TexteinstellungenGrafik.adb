with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with Sf.Graphics.Font;

with VerzeichnisKonstanten;
with TextKonstanten;
with EinstellungenGrafik;

with LeseOptionen;

with Fehlermeldungssystem;
with EinlesenAllgemeinesLogik;
with TextaccesseSchriftartGrafik;

-- Das hier auch mal in Lesen und Schreiben aufteilen? äöü
package body TexteinstellungenGrafik is
   
   procedure SchriftartFestlegen
   is begin
      
      AktuelleSprache := LeseOptionen.Sprache;
      
      if
        AktuelleSprache = TextKonstanten.LeerUnboundedString
      then
         SchriftartAccess := Sf.Graphics.Font.createFromFile (filename => StandardSchriftartVerwenden);
         
      elsif
        Exists (Name => VerzeichnisKonstanten.SprachenStrich & Encode (Item => To_Wide_Wide_String (Source => AktuelleSprache)) & VerzeichnisKonstanten.FontDatei) = False
      then
         SchriftartAccess := Sf.Graphics.Font.createFromFile (filename => StandardSchriftartVerwenden);
         
      else
         SchriftartAccess := Sf.Graphics.Font.createFromFile (filename => EigeneSchriftartVerwenden (SpracheExtern => To_Wide_Wide_String (Source => AktuelleSprache)));
      end if;
      
      TextaccesseSchriftartGrafik.SchriftartSetzen (SchriftaccessExtern => SchriftartAccess);
      
   end SchriftartFestlegen;
   
   
   
   function StandardSchriftartVerwenden
     return String
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.FontOrdner & VerzeichnisKonstanten.SchriftartStandard)
      is
         when False =>
            Fehlermeldungssystem.Grafik (FehlermeldungExtern => "TexteinstellungenGrafik.StandardSchriftartVerwenden: Standardfont nicht vorhanden");
            raise SchriftartFehlt;
            
         when True =>
            return VerzeichnisKonstanten.FontOrdner & VerzeichnisKonstanten.SchriftartStandard;
      end case;
            
   end StandardSchriftartVerwenden;
   
   
   
   function EigeneSchriftartVerwenden
     (SpracheExtern : in Wide_Wide_String)
      return String
   is begin
            
      Open (File => DateiSchriftart,
            Mode => In_File,
            Name => VerzeichnisKonstanten.SprachenStrich & Encode (Item => SpracheExtern) & VerzeichnisKonstanten.FontDatei,
            Form => "WCEM=8");
      
      case
        EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiSchriftart,
                                                         AktuelleZeileExtern => 1,
                                                         DateinameExtern     => "TexteinstellungenGrafik.EigeneSchriftartVerwenden")
      is
         when True =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "TexteinstellungenGrafik.EigeneSchriftartVerwenden: Fehlender Fontname");
               
         when False =>
            EigeneSchriftart := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiSchriftart,
                                                                       AktuelleZeileExtern => 1,
                                                                       DateinameExtern     => "TexteinstellungenGrafik.EigeneSchriftartVerwenden");
            
            if
              Exists (Name => VerzeichnisKonstanten.FontOrdner & Encode (Item => To_Wide_Wide_String (Source => EigeneSchriftart))) = False
            then
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "TexteinstellungenGrafik.EigeneSchriftartVerwenden: Fehlende Fontdatei");
               
            else
               Close (File => DateiSchriftart);
               return VerzeichnisKonstanten.FontOrdner & Encode (Item => To_Wide_Wide_String (Source => EigeneSchriftart));
            end if;
      end case;
      
      Close (File => DateiSchriftart);
      
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
