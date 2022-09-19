pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with MenueDatentypen;

with AuswahlaufteilungLogik;
with SchreibenTastaturLogik;
with TastenbelegungVariablen;
with Fehler;

package body OptionenSteuerungLogik is

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
               SchreibenTastaturLogik.TastenbelegungSchreiben;
               
            when RueckgabeDatentypen.Standard_Enum =>
               TastenbelegungVariablen.StandardTastenbelegungLaden;
               -- Das Schreiben rauswerfen oder durch zusätzliche Abfrage erweitern? äöü
               SchreibenTastaturLogik.TastenbelegungSchreiben;
            
            when RueckgabeDatentypen.Zurück_Beenden_Enum'Range =>
               return AuswahlWert;
                     
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "OptionenSteuerung.SteuerungBelegen: Falsche Auswahl: " & AuswahlWert'Wide_Wide_Image);
         end case;
         
      end loop BelegungSchleife;
      
   end SteuerungBelegen;

end OptionenSteuerungLogik;
