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
            when SystemDatentypen.Kartenfeld_Editor =>
               KartenDatenbankEditor.KartenDatenbankEditor;
               
            when SystemDatentypen.Einheiten_Editor =>
               EinheitenDatenbankEditor.EinheitenDatenbankEditor;
               
            when SystemDatentypen.Gebäude_Editor =>
               GebaeudeDatenbankEditor.GebäudeDatenbankEditor;
               
            when SystemDatentypen.Forschung_Editor =>
               ForschungDatenbankEditor.ForschungDatenbankEditor;
               
            when SystemDatentypen.Verbesserungen_Editor =>
               VerbesserungenDatenbankEditor.VerbesserungenDatenbankEditor;
               
            when SystemKonstanten.ZurückKonstante | SystemKonstanten.SpielBeendenKonstante | SystemKonstanten.HauptmenüKonstante =>
               return AuswahlWert;
               
            when others =>
               Fehler.LogikStopp (FehlermeldungExtern => "DatenbankenEditoren.DatenbankenEditoren - Ungültige Menüauswahl.");
         end case;
         
      end loop EditorenSchleife;
      
   end DatenbankenEditoren;

end DatenbankenEditoren;
