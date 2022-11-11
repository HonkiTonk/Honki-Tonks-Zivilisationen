private with Sf.System.Vector2;

with KartengrundDatentypen;

package MausauswahlEditorLogik is
   pragma Elaborate_Body;

   function Kartengrundeditor
     return KartengrundDatentypen.Kartengrund_Enum;
   
private
   
   Mausposition : Sf.System.Vector2.sfVector2f;

end MausauswahlEditorLogik;
