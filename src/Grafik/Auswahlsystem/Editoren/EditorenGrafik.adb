with KartengrundEditorGrafik;

package body EditorenGrafik is

   procedure Editoren
     (WelcherEditorExtern : in GrafikDatentypen.Editor_Enum)
   is begin
      
      case
        WelcherEditorExtern
      is
         when GrafikDatentypen.Kartengrund_Editor_Enum =>
            KartengrundEditorGrafik.KartengrundEditor;
            
         when GrafikDatentypen.Einheiten_Editor_Enum =>
            null;
            
         when GrafikDatentypen.Gebäude_Editor_Enum =>
            null;
            
         when GrafikDatentypen.Forschungen_Editor_Enum =>
            null;
      end case;
      
   end Editoren;

end EditorenGrafik;
