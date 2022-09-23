pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen;

package EditorenGrafik is

   procedure Editoren
     (WelcherEditorExtern : in GrafikDatentypen.Editor_Enum);

end EditorenGrafik;
