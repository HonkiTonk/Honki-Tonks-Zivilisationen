pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatenbankeditorLogik;
with ForschungenDatenbankeditorLogik;
with GebaeudeDatenbankeditorLogik;
with KartenDatenbankeneditorLogik;
with VerbesserungenDatenbankeditorLogik;
with MenueDatentypen;

with AuswahlaufteilungLogik;
with Fehler;

package body DatenbankeneditorenLogik is

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
               KartenDatenbankeneditorLogik.KartenDatenbankenEditor;
               
            when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
               EinheitenDatenbankeditorLogik.EinheitenDatenbankEditor;
               
            when RueckgabeDatentypen.Auswahl_Drei_Enum =>
               GebaeudeDatenbankeditorLogik.GebäudeDatenbankEditor;
               
            when RueckgabeDatentypen.Auswahl_Vier_Enum =>
               ForschungenDatenbankeditorLogik.ForschungenDatenbankEditor;
               
            when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
               VerbesserungenDatenbankeditorLogik.VerbesserungenDatenbankEditor;
               
            when RueckgabeDatentypen.Zurück_Beenden_Enum'Range =>
               return AuswahlWert;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "DatenbankenEditoren.DatenbankenEditoren - Falsche Menüauswahl.");
         end case;
         
      end loop EditorenSchleife;
      
   end DatenbankenEditoren;

end DatenbankeneditorenLogik;
