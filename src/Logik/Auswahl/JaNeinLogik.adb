with GrafikDatentypen;
with TastenbelegungDatentypen;
with AuswahlKonstanten;

with SchreibeGrafiktask;

with TasteneingabeLogik;
with MausauswahlLogik;

package body JaNeinLogik is

   function JaNein
     (FrageZeileExtern : in Positive)
      return Boolean
   is begin
      
      SchreibeGrafiktask.Fragenanzeige (FrageExtern => FrageZeileExtern);
      SchreibeGrafiktask.Eingabeart (EingabeartExtern => GrafikDatentypen.Ja_Nein_Enum);
      
      AuswahlSchleife:
      loop
      
         AktuelleAuswahl := MausauswahlLogik.JaNein;
         SchreibeGrafiktask.Zweitauswahl (AuswahlExtern => AktuelleAuswahl);
      
         case
           TasteneingabeLogik.VereinfachteEingabe
         is
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl = AuswahlKonstanten.LeerAuswahl
               then
                  null;
                  
               else
                  exit AuswahlSchleife;
               end if;
               
            when TastenbelegungDatentypen.Abwählen_Enum =>
               AktuelleAuswahl := AuswahlKonstanten.LeerAuswahl;
               exit AuswahlSchleife;
            
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
      SchreibeGrafiktask.Eingabeart (EingabeartExtern => GrafikDatentypen.Keine_Eingabe_Enum);
      SchreibeGrafiktask.Fragenanzeige (FrageExtern => 0);
      
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
