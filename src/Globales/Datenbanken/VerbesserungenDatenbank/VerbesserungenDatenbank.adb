pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibenDatenbankenLogik;

with WegeStandard;
with VerbesserungenStandard;

package body VerbesserungenDatenbank is
   
   procedure StandardVerbesserungenDatenbankLaden
   is begin
      
      VerbesserungenSchleife:
      for VerbesserungenSchleifenwert in KartenverbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum'Range loop
         
         case
           VerbesserungenSchleifenwert
         is
            when VerbesserungenStandard.StadtlisteArray'Range =>
               Verbesserungenliste (VerbesserungenSchleifenwert) := VerbesserungenStandard.Stadtliste (VerbesserungenSchleifenwert);
               
            when VerbesserungenStandard.GebildelisteArray'Range =>
               Verbesserungenliste (VerbesserungenSchleifenwert) := VerbesserungenStandard.Gebildeliste (VerbesserungenSchleifenwert);
         end case;
         
      end loop VerbesserungenSchleife;
      
   end StandardVerbesserungenDatenbankLaden;
   
   
   
   procedure StandardWegeDatenbankLaden
   is begin
      
      WegeSchleife:
      for WegeSchleifenwert in KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Range loop
         
         case
           WegeSchleifenwert
         is
            when WegeStandard.WegelisteArray'Range =>
               Wegeliste (WegeSchleifenwert) := WegeStandard.Wegeliste (WegeSchleifenwert);
               
            when WegeStandard.SchienenlisteArray'Range =>
               Wegeliste (WegeSchleifenwert) := WegeStandard.Schienenliste (WegeSchleifenwert);
               
            when WegeStandard.TunnellisteArray'Range =>
               Wegeliste (WegeSchleifenwert) := WegeStandard.Tunnelliste (WegeSchleifenwert);
         end case;
         
      end loop WegeSchleife;
      
   end StandardWegeDatenbankLaden;
   
   

   procedure VerbesserungenDatenbankSpeichern
   is begin
      
      SchreibenDatenbankenLogik.SchreibenVerbesserungenDatenbank;
      
   end VerbesserungenDatenbankSpeichern;
   
end VerbesserungenDatenbank;
