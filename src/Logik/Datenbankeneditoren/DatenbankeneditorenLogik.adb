with MenueDatentypen;

with SchreibenDatenbankenLogik;
with StandardVerbesserungenDatenbank;
with StandardSpeziesDatenbank;
with StandardKartenDatenbank;
with StandardGebaeudeDatenbank;
with StandardForschungenDatenbank;
with StandardEinheitenDatenbank;

with AuswahlaufteilungLogik;
with Fehlermeldungssystem;
-- with EinheitenDatenbankeditorLogik;
-- with ForschungenDatenbankeditorLogik;
-- with GebaeudeDatenbankeditorLogik;
-- with KartenDatenbankeneditorLogik;
-- with VerbesserungenDatenbankeditorLogik;

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
               -- KartenDatenbankeneditorLogik.KartenDatenbankenEditor;
               null;
               
            when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
               -- EinheitenDatenbankeditorLogik.EinheitenDatenbankEditor;
               null;
               
            when RueckgabeDatentypen.Auswahl_Drei_Enum =>
               -- GebaeudeDatenbankeditorLogik.GebäudeDatenbankEditor;
               null;
               
            when RueckgabeDatentypen.Auswahl_Vier_Enum =>
               -- ForschungenDatenbankeditorLogik.ForschungenDatenbankEditor;
               null;
               
            when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
               -- VerbesserungenDatenbankeditorLogik.VerbesserungenDatenbankEditor;
               null;
               
            when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
               AlleAufStandard;
               
            when RueckgabeDatentypen.Zurück_Beenden_Enum'Range =>
               return AuswahlWert;
               
            when others =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "DatenbankeneditorenLogik.DatenbankenEditoren: Falsche Auswahl: " & AuswahlWert'Wide_Wide_Image);
         end case;
         
      end loop EditorenSchleife;
      
   end DatenbankenEditoren;
   
   
   
   procedure AlleAufStandard
   is begin
      
      StandardEinheitenDatenbank.StandardEinheitenDatenbankLaden;
      StandardForschungenDatenbank.StandardForschungenDatenbankLaden;
      StandardGebaeudeDatenbank.StandardGebaeudeDatenbankLaden;
      StandardKartenDatenbank.StandardBasisgrundDatenbankLaden;
      StandardKartenDatenbank.StandardKartenflussDatenbankLaden;
      StandardKartenDatenbank.StandardKartenressourcenDatenbankLaden;
      StandardVerbesserungenDatenbank.StandardVerbesserungenDatenbankLaden;
      StandardVerbesserungenDatenbank.StandardWegeDatenbankLaden;
      StandardSpeziesDatenbank.StandardSpeziesDatenbankLaden;
      
      SchreibenDatenbankenLogik.SchreibenAlleDatenbanken;
      
   end AlleAufStandard;

end DatenbankeneditorenLogik;
