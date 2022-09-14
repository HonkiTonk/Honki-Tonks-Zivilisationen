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
            when RueckgabeDatentypen.Auswahl_Eins_Enum =>
               KartenDatenbankenEditor.KartenDatenbankenEditor;
               
            when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
               EinheitenDatenbankEditor.EinheitenDatenbankEditor;
               
            when RueckgabeDatentypen.Auswahl_Drei_Enum =>
               GebaeudeDatenbankEditor.GebäudeDatenbankEditor;
               
            when RueckgabeDatentypen.Auswahl_Vier_Enum =>
               ForschungenDatenbankEditor.ForschungenDatenbankEditor;
               
            when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
               VerbesserungenDatenbankEditor.VerbesserungenDatenbankEditor;
               
            when RueckgabeDatentypen.Zurück_Beenden_Enum'Range =>
               return AuswahlWert;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "DatenbankenEditoren.DatenbankenEditoren - Falsche Menüauswahl.");
         end case;
         
      end loop EditorenSchleife;
      
   end DatenbankenEditoren;

end DatenbankenEditoren;
