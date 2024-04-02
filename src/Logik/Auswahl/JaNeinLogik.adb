with GrafikDatentypen;
with TastenbelegungDatentypen;
with AuswahlKonstanten;

with SchreibeGrafiktask;
with LeseOptionen;

with TasteneingabeLogik;
with MausauswahlLogik;
with EingabeAllgemeinLogik;

package body JaNeinLogik is

   function JaNein
     (FrageZeileExtern : in Positive)
      return Boolean
   is begin
      
      case
        LeseOptionen.SicherheitsfragenAnzeigen
      is
         when False =>
            return True;
            
         when True =>
            SchreibeGrafiktask.Fragenanzeige (FrageExtern => FrageZeileExtern);
            SchreibeGrafiktask.Eingabeart (EingabeartExtern => GrafikDatentypen.Ja_Nein_Enum);
      end case;
      
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
      
      EingabeAllgemeinLogik.LeerEingabeartFrage;
      
      case
        AktuelleAuswahl
      is
         when AuswahlKonstanten.ErstAuswahl =>
            return True;
            
         when others =>
            return False;
      end case;
      
   end JaNein;

end JaNeinLogik;
