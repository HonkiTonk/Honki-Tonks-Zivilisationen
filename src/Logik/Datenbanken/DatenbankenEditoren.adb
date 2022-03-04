pragma SPARK_Mode (On);

with SystemKonstanten;

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
         
         AuswahlWert := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Editoren_Menü);
         
         case
           AuswahlWert
         is
            when SystemKonstanten.KartenfeldEditorKonstante =>
               KartenDatenbankEditor.KartenDatenbankEditor;
               
            when SystemKonstanten.EinheitenEditorKonstante =>
               EinheitenDatenbankEditor.EinheitenDatenbankEditor;
               
            when SystemKonstanten.GebäudeEditorKonstante =>
               GebaeudeDatenbankEditor.GebäudeDatenbankEditor;
               
            when SystemKonstanten.ForschungEditorKonstante =>
               ForschungDatenbankEditor.ForschungDatenbankEditor;
               
            when SystemKonstanten.VerbesserungenEditorKonstante =>
               VerbesserungenDatenbankEditor.VerbesserungenDatenbankEditor;
               
            when SystemKonstanten.ZurückKonstante | SystemKonstanten.SpielBeendenKonstante | SystemKonstanten.HauptmenüKonstante =>
               return AuswahlWert;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "DatenbankenEditoren.DatenbankenEditoren - Ungültige Menüauswahl.");
         end case;
         
      end loop EditorenSchleife;
      
   end DatenbankenEditoren;

end DatenbankenEditoren;
