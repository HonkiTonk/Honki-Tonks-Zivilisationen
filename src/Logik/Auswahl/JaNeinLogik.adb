pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen;
with SystemKonstanten;
with TastenbelegungDatentypen;

with TasteneingabeLogik;
with NachGrafiktask;
with MausauswahlLogik;

package body JaNeinLogik is

   function JaNein
     (FrageZeileExtern : in Positive)
      return Boolean
   is begin
      
      NachGrafiktask.AnzeigeFrage := FrageZeileExtern;
      NachGrafiktask.Eingabe := GrafikDatentypen.Ja_Nein_Enum;
      
      AuswahlSchleife:
      loop
      
         AktuelleAuswahl := MausauswahlLogik.JaNein;
         NachGrafiktask.AktuelleAuswahl.AuswahlZwei := AktuelleAuswahl;
      
         case
           TasteneingabeLogik.VereinfachteEingabe
         is
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl = SystemKonstanten.LeerAuswahl
               then
                  null;
                  
               else
                  exit AuswahlSchleife;
               end if;
               
            when TastenbelegungDatentypen.Abwählen_Enum =>
               AktuelleAuswahl := SystemKonstanten.LeerAuswahl;
               exit AuswahlSchleife;
            
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
      NachGrafiktask.Eingabe := GrafikDatentypen.Keine_Eingabe_Enum;
      NachGrafiktask.AnzeigeFrage := 0;
      
      case
        AktuelleAuswahl
      is
         when 1 =>
            return True;
            
         when others =>
            return False;
      end case;
      
   end JaNein;

end JaNeinLogik;
