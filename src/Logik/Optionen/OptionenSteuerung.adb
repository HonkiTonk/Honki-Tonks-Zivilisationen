pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with MenueDatentypen;

with AuswahlaufteilungLogik;
with SchreibenTastatur;
with TastenbelegungVariablen;
with Fehler;

package body OptionenSteuerung is

   function SteuerungBelegen
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      BelegungSchleife:
      loop
                  
         AuswahlWert := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Steuerung_Menü_Enum);
         
         case
           AuswahlWert
         is   
            when RueckgabeDatentypen.Speichern_Enum =>
               SchreibenTastatur.TastenbelegungSchreiben;
               
            when RueckgabeDatentypen.Wiederherstellen_Enum =>
               TastenbelegungVariablen.StandardTastenbelegungLaden;
               -- Das Schreiben rauswerfen oder durch zusätzliche Abfrage erweitern? äöü
               SchreibenTastatur.TastenbelegungSchreiben;
            
            when RueckgabeDatentypen.Zurück_Beenden_Enum'Range =>
               return AuswahlWert;
                     
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "OptionenSteuerung.SteuerungBelegen - Falsche Menüauswahl.");
         end case;
         
      end loop BelegungSchleife;
      
   end SteuerungBelegen;

end OptionenSteuerung;
