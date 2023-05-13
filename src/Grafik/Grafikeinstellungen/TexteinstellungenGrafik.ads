with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with Sf.Graphics;
with Sf.Graphics.Color;

with TextDatentypen;

-- Später auch was für den Textstyle einbauen? äöü
package TexteinstellungenGrafik is
   pragma Elaborate_Body;
   use type Sf.Graphics.sfFont_Ptr;
      
   type SchriftgrößenArray is array (TextDatentypen.Schriftgröße_Enum'Range) of Sf.sfUint32;
   
   type SchriftfarbenArray is array (TextDatentypen.Schriftfarbe_Enum'Range) of Sf.Graphics.Color.sfColor;
   
   procedure StandardLaden;
   procedure SchriftartFestlegen;
   
   procedure SchriftgrößeSchreiben
     (GrößeExtern : in Sf.sfUint32;
      WelcheGrößeExtern : in TextDatentypen.Schriftgröße_Enum);
   
   procedure SchriftfarbeSchreiben
     (FarbeExtern : in Sf.Graphics.Color.sfColor;
      WelcheFarbeExtern : in TextDatentypen.Schriftfarbe_Enum);
   
   procedure SchriftgrößeneintragSchreiben
     (EintragExtern : in SchriftgrößenArray);
   
   procedure SchriftfarbeneintragSchreiben
     (EintragExtern : in SchriftfarbenArray);
   
   
   
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
   
   function SchriftgrößeneintragLesen
     return SchriftgrößenArray;
   
   function SchriftfarbeneintragLesen
     return SchriftfarbenArray;
   
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
   
private
   
   DateiSchriftart : File_Type;
   
   AktuelleSprache : Unbounded_Wide_Wide_String;
   EigeneSchriftart : Unbounded_Wide_Wide_String;

   SchriftartAccess : Sf.Graphics.sfFont_Ptr := null;
   
   Schriftgrößen : SchriftgrößenArray;
   
   Schriftfarben : SchriftfarbenArray;
   
   SchriftgrößenStandard : constant SchriftgrößenArray := (
                                                               TextDatentypen.Überschrift_Enum => 36,
                                                               TextDatentypen.Standard_Enum    => 24,
                                                               TextDatentypen.Klein_Enum       => 12
                                                              );
   
   SchriftfarbenStandard : constant SchriftfarbenArray := (
                                                           TextDatentypen.Überschrift_Enum => Sf.Graphics.Color.sfRed,
                                                           TextDatentypen.Standard_Enum    => Sf.Graphics.Color.sfWhite,
                                                           TextDatentypen.Ausgewählt_Enum  => Sf.Graphics.Color.sfGreen,
                                                           TextDatentypen.Mensch_Enum      => Sf.Graphics.Color.sfBlue,
                                                           TextDatentypen.KI_Enum          => Sf.Graphics.Color.sfYellow,
                                                           TextDatentypen.Sonstiges_Enum   => Sf.Graphics.Color.sfCyan
                                                          );
   
   SchriftartFehlt : exception;

end TexteinstellungenGrafik;
