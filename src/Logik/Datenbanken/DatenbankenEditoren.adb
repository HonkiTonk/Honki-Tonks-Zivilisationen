pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatenbankEditor;
with ForschungenDatenbankEditor;
with GebaeudeDatenbankEditor;
with KartenDatenbankenEditor;
with VerbesserungenDatenbankEditor;
with MenueDatentypen;

with AuswahlaufteilungLogik;
with Fehler;

package body DatenbankenEditoren is

   function DatenbankenEditoren
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      EditorenSchleife:
      loop
         
         AuswahlWert := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Editoren_Menü_Enum);
         
         case
           AuswahlWert
         is
            when RueckgabeDatentypen.Kartenfeld_Editor_Enum =>
               KartenDatenbankenEditor.KartenDatenbankenEditor;
               
            when RueckgabeDatentypen.Einheiten_Editor_Enum =>
               EinheitenDatenbankEditor.EinheitenDatenbankEditor;
               
            when RueckgabeDatentypen.Gebäude_Editor_Enum =>
               GebaeudeDatenbankEditor.GebäudeDatenbankEditor;
               
            when RueckgabeDatentypen.Forschung_Editor_Enum =>
               ForschungenDatenbankEditor.ForschungenDatenbankEditor;
               
            when RueckgabeDatentypen.Verbesserungen_Editor_Enum =>
               VerbesserungenDatenbankEditor.VerbesserungenDatenbankEditor;
               
            when RueckgabeDatentypen.Zurück_Enum | RueckgabeDatentypen.Spiel_Beenden_Enum | RueckgabeDatentypen.Hauptmenü_Enum =>
               return AuswahlWert;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "DatenbankenEditoren.DatenbankenEditoren - Falsche Menüauswahl.");
         end case;
         
      end loop EditorenSchleife;
      
   end DatenbankenEditoren;

end DatenbankenEditoren;
