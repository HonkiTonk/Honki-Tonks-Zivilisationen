with MenueDatentypen;

with AuswahlaufteilungLogik;
with Fehlermeldungssystem;
with StandardTastenbelegungDatenbank;
with SchreibenEinstellungenLogik;

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
               SchreibenEinstellungenLogik.TastenbelegungSchreiben;
               
            when RueckgabeDatentypen.Standard_Enum =>
               StandardTastenbelegungDatenbank.StandardTastenbelegungLaden;
               SchreibenEinstellungenLogik.TastenbelegungSchreiben;
            
            when RueckgabeDatentypen.Zurück_Beenden_Enum'Range =>
               return AuswahlWert;
                     
            when others =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "OptionenSteuerungLogik.SteuerungBelegen: Falsche Auswahl: " & AuswahlWert'Wide_Wide_Image);
         end case;
         
      end loop BelegungSchleife;
      
   end SteuerungBelegen;

end OptionenSteuerungLogik;
