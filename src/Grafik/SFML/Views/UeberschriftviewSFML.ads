pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;

with GrafikDatentypen;
with MenueDatentypen;

package UeberschriftviewSFML is
   
   procedure Überschrift
     (ÜberschriftExtern : in Wide_Wide_String;
      HintergrundExtern : in GrafikDatentypen.Hintergrund_Texturen_Enum);
   
   procedure ÜberschriftErmitteln
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum);
   
   procedure Versionsnummer
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Texturen_Enum);
   
private
   
   type Flächen_Enum is (Überschrift_Enum, Versionsnummer_Enum);
   
   type ViewflächenArray is array (Flächen_Enum'Range) of Sf.System.Vector2.sfVector2f;
   Viewfläche : ViewflächenArray := (others => (5.00, 5.00));
   
   TextPosition : Sf.System.Vector2.sfVector2f;

end UeberschriftviewSFML;
