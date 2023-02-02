private with Sf.System.Vector2;

private with GrafikRecordKonstanten;

package KartengrundEditorGrafik is
   pragma Elaborate_Body;

   procedure KartengrundEditor;

private

   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Grafikposition : Sf.System.Vector2.sfVector2f;
   Feldgröße : Sf.System.Vector2.sfVector2f;

end KartengrundEditorGrafik;
