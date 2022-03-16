pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatenbankEditor;
with ForschungDatenbankEditor;
with GebaeudeDatenbankEditor;
with KartenDatenbankEditor;
with VerbesserungenDatenbankEditor;

with AuswahlMenue;
with Fehler;

package body DatenbankenEditoren is

   function DatenbankenEditoren
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      EditorenSchleife:
      loop
         
         AuswahlWert := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Editoren_Menü_Enum);
         
         case
           AuswahlWert
         is
            when SystemDatentypen.Kartenfeld_Editor_Enum =>
               KartenDatenbankEditor.KartenDatenbankEditor;
               
            when SystemDatentypen.Einheiten_Editor_Enum =>
               EinheitenDatenbankEditor.EinheitenDatenbankEditor;
               
            when SystemDatentypen.Gebäude_Editor_Enum =>
               GebaeudeDatenbankEditor.GebäudeDatenbankEditor;
               
            when SystemDatentypen.Forschung_Editor_Enum =>
               ForschungDatenbankEditor.ForschungDatenbankEditor;
               
            when SystemDatentypen.Verbesserungen_Editor_Enum =>
               VerbesserungenDatenbankEditor.VerbesserungenDatenbankEditor;
               
            when SystemDatentypen.Zurück_Enum | SystemDatentypen.Spiel_Beenden_Enum | SystemDatentypen.Hauptmenü_Enum =>
               return AuswahlWert;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "DatenbankenEditoren.DatenbankenEditoren - Ungültige Menüauswahl.");
         end case;
         
      end loop EditorenSchleife;
      
   end DatenbankenEditoren;

end DatenbankenEditoren;
