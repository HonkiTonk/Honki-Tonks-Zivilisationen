with Ada.Directories; use Ada.Directories;

with Sf.Graphics.Font;

with VerzeichnisKonstanten;

with Fehlermeldungssystem;

package body TexteinstellungenGrafik is

   procedure StandardLaden
   is begin
      
      Schriftgrößen := SchriftgrößenStandard;
      Schriftfarben := SchriftfarbenStandard;
      
   end StandardLaden;
   
   
   
   procedure SchriftartFestlegen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Schriftart)
      is
         when False =>
            Fehlermeldungssystem.Grafik (FehlermeldungExtern => "TexteinstellungenGrafik.SchriftartFestlegen: Fontdatei ist nicht vorhanden");
            raise SchriftartFehlt;
            
         when True =>
            TexteinstellungenGrafik.SchriftartAccess := Sf.Graphics.Font.createFromFile (filename => VerzeichnisKonstanten.Schriftart);
      end case;
      
   end SchriftartFestlegen;
   
   
   
   function SchriftartLesen
     return Sf.Graphics.sfFont_Ptr
   is begin
      
      return SchriftartAccess;
      
   end SchriftartLesen;
   
   
   
   procedure SchriftgrößeSchreiben
     (GrößeExtern : in Sf.sfUint32;
      WelcheGrößeExtern : in TextDatentypen.Schriftgröße_Enum)
   is begin
      
      Schriftgrößen (WelcheGrößeExtern) := GrößeExtern;
      
   end SchriftgrößeSchreiben;



   procedure SchriftfarbeSchreiben
     (FarbeExtern : in Sf.Graphics.Color.sfColor;
      WelcheFarbeExtern : in TextDatentypen.Schriftfarbe_Enum)
   is begin

      Schriftfarben (WelcheFarbeExtern) := FarbeExtern;

   end SchriftfarbeSchreiben;


   
   procedure SchriftgrößeneintragSchreiben
     (EintragExtern : in SchriftgrößenArray)
   is begin

      Schriftgrößen := EintragExtern;

   end SchriftgrößeneintragSchreiben;
   
   
   
   procedure SchriftfarbeneintragSchreiben
     (EintragExtern : in SchriftfarbenArray)
   is begin
      
      Schriftfarben := EintragExtern;
      
   end SchriftfarbeneintragSchreiben;



   function SchriftgrößeLesen
     (WelcheGrößeExtern : in TextDatentypen.Schriftgröße_Enum)
      return Sf.sfUint32
   is begin

      return Schriftgrößen (WelcheGrößeExtern);

   end SchriftgrößeLesen;
   
   
   
   function SchriftfarbeLesen
     (WelcheFarbeExtern : in TextDatentypen.Schriftfarbe_Enum)
      return Sf.Graphics.Color.sfColor
   is begin
      
      return Schriftfarben (WelcheFarbeExtern);
      
   end SchriftfarbeLesen;



   function SchriftgrößeneintragLesen
     return SchriftgrößenArray
   is begin

      return Schriftgrößen;

   end SchriftgrößeneintragLesen;
   
   
   
   function SchriftfarbeneintragLesen
     return SchriftfarbenArray
   is begin
      
      return Schriftfarben;
      
   end SchriftfarbeneintragLesen;

end TexteinstellungenGrafik;
