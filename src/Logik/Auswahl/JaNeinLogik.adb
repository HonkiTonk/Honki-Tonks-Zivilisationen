with GrafikDatentypen;
with TastenbelegungDatentypen;
with AuswahlKonstanten;

with SchreibeGrafiktask;
with LeseOptionen;

with TasteneingabeLogik;
with MausauswahlLogik;
with EingabeAllgemeinLogik;

package body JaNeinLogik is

   -- Das noch einmal in umgedreht bauen oder über einen zusätzlichen Parameter kreieren und dann die Abfragen deaktivierbar machen. äöü
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
      
      EingabeAllgemeinLogik.LeerEingabeartFrage;
      
      -- Hülle für später. äöü
      case
        LeseOptionen.SicherheitsfragenAnzeigen
      is
         when True =>
            null;
            
         when False =>
            null;
      end case;
      
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
