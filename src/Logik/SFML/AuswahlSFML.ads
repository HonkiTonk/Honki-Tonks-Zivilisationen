pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

with RueckgabeDatentypen;

package AuswahlSFML is

   function AuswahlJaNeinSFML
     (FrageZeileExtern : in Positive)
      return RueckgabeDatentypen.Ja_Nein_Enum;

private

   AktuelleAuswahl : Natural;

   MausZeigerPosition : Sf.System.Vector2.sfVector2i;

   function MausAuswahl
     return Natural;

end AuswahlSFML;
