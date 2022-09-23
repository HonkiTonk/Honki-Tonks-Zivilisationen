pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;

with KartengrundDatentypen;

package MausauswahlEditorLogik is

   function Kartengrundeditor
     return KartengrundDatentypen.Kartengrund_Enum;
   
private
   
   Mausposition : Sf.System.Vector2.sfVector2f;

end MausauswahlEditorLogik;
