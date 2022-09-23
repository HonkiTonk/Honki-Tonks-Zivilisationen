pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with MenueDatentypen;

with EinheitenDatenbank;
with ForschungenDatenbank;
with GebaeudeDatenbank;
with KartenDatenbank;
with VerbesserungenDatenbank;
with RassenDatenbank;

with SchreibenDatenbankenLogik;

with AuswahlaufteilungLogik;
with Fehler;
with EinheitenDatenbankeditorLogik;
with ForschungenDatenbankeditorLogik;
with GebaeudeDatenbankeditorLogik;
with KartenDatenbankeneditorLogik;
with VerbesserungenDatenbankeditorLogik;

package body DatenbankeneditorenLogik is

   function DatenbankenEditoren
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      EditorenSchleife:
      loop
         
         AuswahlWert := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Editoren_Menü_Enum);
         
         -- Karten- und Verbesserungeneditor in die entsprechenden Bereiche aufteilen und dann einfach mehr Editoren einbauen? äöü
         -- Wäre mehr Arbeit aber vielleicht auch einfacher? äöü
         -- Oder einfach die Felder anzeigen und auswählbar machen? äöü
         -- Und je nach Auswahl dann die entsprechenden Einstellungen aufrufen? äöü
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
               
            when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
               AlleAufStandard;
               
            when RueckgabeDatentypen.Zurück_Beenden_Enum'Range =>
               return AuswahlWert;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "DatenbankeneditorenLogik.DatenbankenEditoren: Falsche Auswahl: " & AuswahlWert'Wide_Wide_Image);
         end case;
         
      end loop EditorenSchleife;
      
   end DatenbankenEditoren;
   
   
   
   -- Hier später noch eine Warnmeldung einbauen? äöü
   procedure AlleAufStandard
   is begin
      
      EinheitenDatenbank.StandardEinheitenDatenbankLaden;
      ForschungenDatenbank.StandardForschungenDatenbankLaden;
      GebaeudeDatenbank.StandardGebaeudeDatenbankLaden;
      KartenDatenbank.StandardKartengrundDatenbankLaden;
      KartenDatenbank.StandardKartenflussDatenbankLaden;
      KartenDatenbank.StandardKartenressourcenDatenbankLaden;
      VerbesserungenDatenbank.StandardVerbesserungenDatenbankLaden;
      VerbesserungenDatenbank.StandardWegeDatenbankLaden;
      RassenDatenbank.StandardRassenDatenbankLaden;
      
      SchreibenDatenbankenLogik.SchreibenAlleDatenbanken;
      
   end AlleAufStandard;

end DatenbankeneditorenLogik;
