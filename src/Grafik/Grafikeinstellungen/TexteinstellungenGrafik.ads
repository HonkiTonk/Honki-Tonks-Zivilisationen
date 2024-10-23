private with Ada.Strings.Wide_Wide_Unbounded;
private with Ada.Wide_Wide_Text_IO;

with Sf.Graphics;
with Sf.Graphics.Color;
with Sf.Graphics.Text;

with TextDatentypen;

package TexteinstellungenGrafik is
   pragma Elaborate_Body;
   use type Sf.Graphics.sfFont_Ptr;
      
   procedure SchriftartFestlegen;
   
   procedure SchriftgrößeSchreiben
     (GrößeExtern : in Sf.sfUint32;
      WelcheGrößeExtern : in TextDatentypen.Schriftgröße_Enum);
   
   procedure SchriftfarbeSchreiben
     (FarbeExtern : in Sf.Graphics.Color.sfColor;
      WelcheFarbeExtern : in TextDatentypen.Schriftfarbe_Enum);
   
   procedure SchriftstilSchreiben
     (StilExtern : in Sf.Graphics.Text.sfTextStyle);
   
   procedure SchriftrahmenSchreiben
     (SchriftrahmenExtern : in Float)
     with
       Pre => (
                 SchriftrahmenExtern >= 0.00
              );
   
   
   
   function SchriftartLesen
     return Sf.Graphics.sfFont_Ptr
     with
       Post => (
                  SchriftartLesen'Result /= null
               );
      
   function SchriftgrößeLesen
     (WelcheGrößeExtern : in TextDatentypen.Schriftgröße_Enum)
      return Sf.sfUint32;
   
   function SchriftfarbeLesen
     (WelcheFarbeExtern : in TextDatentypen.Schriftfarbe_Enum)
      return Sf.Graphics.Color.sfColor;
   
   function StandardSchriftartVerwenden
     return String
     with
       Post => (
                  StandardSchriftartVerwenden'Result'Length > 0
               );
   
   function EigeneSchriftartVerwenden
     (SpracheExtern : in Wide_Wide_String)
      return String
     with
       Pre => (
                 SpracheExtern'Length > 0
              ),
         
       Post => (
                  EigeneSchriftartVerwenden'Result'Length > 0
               );
   
   function SchriftstilLesen
     return Sf.Graphics.Text.sfTextStyle;
   
   function SchriftrahmenLesen
     return Float
     with
       Post => (
                 SchriftrahmenLesen'Result >= 0.00 
               );
   
private
   use Ada.Strings.Wide_Wide_Unbounded;
   use Ada.Wide_Wide_Text_IO;
   
   DateiSchriftart : File_Type;
   
   AktuelleSprache : Unbounded_Wide_Wide_String;
   EigeneSchriftart : Unbounded_Wide_Wide_String;

   SchriftartAccess : Sf.Graphics.sfFont_Ptr := null;
   
   SchriftartFehlt : exception;

end TexteinstellungenGrafik;
