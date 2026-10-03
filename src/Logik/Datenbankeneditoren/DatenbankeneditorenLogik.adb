with MenueDatentypen;

with SchreibenDatenbankenLogik;
with StandardVerbesserungenDatenbank;
with StandardSpeziesDatenbank;
with StandardKartenDatenbank;
with StandardGebaeudeDatenbank;
with StandardForschungenDatenbank;
with StandardEinheitenDatenbank;

with AuswahlaufteilungLogik;
with MeldungssystemHTSEB;
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
            when Kartendatenbank =>
               -- KartenDatenbankeneditorLogik.KartenDatenbankenEditor;
               null;
               
            when Einheitendatenbank =>
               -- EinheitenDatenbankeditorLogik.EinheitenDatenbankEditor;
               null;
               
            when Gebäudedatenbank =>
               -- GebaeudeDatenbankeditorLogik.GebäudeDatenbankEditor;
               null;
               
            when Forschungsdatenbank =>
               -- ForschungenDatenbankeditorLogik.ForschungenDatenbankEditor;
               null;
               
            when Verbesserungendatenbank =>
               -- VerbesserungenDatenbankeditorLogik.VerbesserungenDatenbankEditor;
               null;
               
            when Standardwerte =>
               AlleAufStandard;
               
            when RueckgabeDatentypen.Zurück_Beenden_Enum'Range =>
               return AuswahlWert;
               
            when others =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "DatenbankeneditorenLogik.DatenbankenEditoren: Falsche Auswahl: " & AuswahlWert'Wide_Wide_Image);
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
      StandardKartenDatenbank.StandardKartenrohstoffeDatenbankLaden;
      StandardVerbesserungenDatenbank.StandardVerbesserungenDatenbankLaden;
      StandardVerbesserungenDatenbank.StandardWegeDatenbankLaden;
      StandardSpeziesDatenbank.StandardSpeziesDatenbankLaden;
      
      SchreibenDatenbankenLogik.SchreibenAlleDatenbanken;
      
   end AlleAufStandard;

end DatenbankeneditorenLogik;
