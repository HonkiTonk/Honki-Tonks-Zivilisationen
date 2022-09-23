pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;

private with GrafikRecordKonstanten;

package KartengrundEditorGrafik is

   procedure KartengrundEditor;

private

   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   Grafikposition : Sf.System.Vector2.sfVector2f;
   Feldgröße : Sf.System.Vector2.sfVector2f;

end KartengrundEditorGrafik;
