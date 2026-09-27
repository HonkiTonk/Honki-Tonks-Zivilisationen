private with Sf.System.Vector2;

with KartenzusatzgrundDatentypen;

package MausauswahlEditorLogik is
   pragma Elaborate_Body;

   function Kartengrundeditor
     return KartenzusatzgrundDatentypen.Kartengrund_Enum;
   
private
   
   Mausposition : Sf.System.Vector2.sfVector2f;

end MausauswahlEditorLogik;
