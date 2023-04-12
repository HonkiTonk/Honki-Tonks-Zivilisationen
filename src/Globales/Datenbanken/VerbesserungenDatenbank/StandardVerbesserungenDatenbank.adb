with KartenverbesserungDatentypen;
with VerbesserungenDatenbank;

with WegeStandard;
with VerbesserungenStandard;

package body StandardVerbesserungenDatenbank is

   -- Man kann immer noch die Sachen einzeln zurücksetzen, aber sie dennoch gemeinsam speichern. äöü
   -- Relevant wenn ich irgendwann einmal die Editoren einbaue. äöü
   procedure StandardVerbesserungenDatenbankLaden
   is begin
            
      VerbesserungenSchleife:
      for VerbesserungenSchleifenwert in KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum'Range loop
         
         case
           VerbesserungenSchleifenwert
         is
            when VerbesserungenStandard.StadtlisteArray'Range =>
               VerbesserungenDatenbank.Verbesserungenliste (VerbesserungenSchleifenwert) := VerbesserungenStandard.Stadtliste (VerbesserungenSchleifenwert);
               
            when VerbesserungenStandard.GebildelisteArray'Range =>
               VerbesserungenDatenbank.Verbesserungenliste (VerbesserungenSchleifenwert) := VerbesserungenStandard.Gebildeliste (VerbesserungenSchleifenwert);
         end case;
         
      end loop VerbesserungenSchleife;
      
   end StandardVerbesserungenDatenbankLaden;
   
   
   
   procedure StandardWegeDatenbankLaden
   is begin
      
      WegeSchleife:
      for WegeSchleifenwert in KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Range loop
         
         case
           WegeSchleifenwert
         is
            when WegeStandard.WegelisteArray'Range =>
               VerbesserungenDatenbank.Wegeliste (WegeSchleifenwert) := WegeStandard.Wegeliste (WegeSchleifenwert);
               
            when WegeStandard.SchienenlisteArray'Range =>
               VerbesserungenDatenbank.Wegeliste (WegeSchleifenwert) := WegeStandard.Schienenliste (WegeSchleifenwert);
               
            when WegeStandard.TunnellisteArray'Range =>
               VerbesserungenDatenbank.Wegeliste (WegeSchleifenwert) := WegeStandard.Tunnelliste (WegeSchleifenwert);
         end case;
         
      end loop WegeSchleife;
      
   end StandardWegeDatenbankLaden;

end StandardVerbesserungenDatenbank;
