pragma SPARK_Mode (On);

with GlobaleKonstanten, GlobaleRecords;

with LeseEinheitenGebaut;

package body NaechstesObjekt is  

   procedure NächsteEinheit
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      BewegungspunkteExtern : in Bewegungspunkte)
   is begin
      
      SchleifenBegrenzung := 0;
      
      EinheitSuchenSchleife:
      loop

         if
           AktuelleEinheit (RasseExtern) >= GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze
         then
            AktuelleEinheit (RasseExtern) := GlobaleVariablen.EinheitenGebautArray'First (2);
               
         else
            AktuelleEinheit (RasseExtern) := AktuelleEinheit (RasseExtern) + 1;
         end if;
               
         if
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, AktuelleEinheit (RasseExtern))) = GlobaleKonstanten.LeerEinheitenID
           or
             (LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => (RasseExtern, AktuelleEinheit (RasseExtern))) = GlobaleKonstanten.LeerEinheit.Bewegungspunkte
              and
                BewegungspunkteExtern = Hat_Bewegungspunkte)
           or
             (LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => (RasseExtern, AktuelleEinheit (RasseExtern))) > GlobaleKonstanten.LeerEinheit.Bewegungspunkte
              and
                BewegungspunkteExtern = Keine_Bewegungspunkte)
         then
            null;
         
         else
            exit EinheitSuchenSchleife;
         end if;
         
         if
           SchleifenBegrenzung < GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze
         then            
            SchleifenBegrenzung := SchleifenBegrenzung + 1;
            
         else
            return;
         end if;

      end loop EinheitSuchenSchleife;
      
      GlobaleVariablen.CursorImSpiel (RasseExtern).Position := LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => (RasseExtern, AktuelleEinheit (RasseExtern)));
      
   end NächsteEinheit;
   
   
   
   procedure NächsteStadt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin

      SchleifenBegrenzung := 0;
      
      StadtSuchenSchleife:
      loop

         if
           AktuelleStadt (RasseExtern) >= GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze
         then
            AktuelleStadt (RasseExtern) := GlobaleVariablen.StadtGebautArray'First (2);
               
         else
            AktuelleStadt (RasseExtern) := AktuelleStadt (RasseExtern) + 1;
         end if;
               
         if
           GlobaleVariablen.StadtGebaut (RasseExtern, AktuelleStadt (RasseExtern)).ID = GlobaleKonstanten.LeerStadtID
         then
            null;
         
         else
            exit StadtSuchenSchleife;
         end if;
         
         if
           SchleifenBegrenzung < GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze
         then
            SchleifenBegrenzung := SchleifenBegrenzung + 1;
            
         else
            return;
         end if;

      end loop StadtSuchenSchleife;
      
      GlobaleVariablen.CursorImSpiel (RasseExtern).Position := GlobaleVariablen.StadtGebaut (RasseExtern, AktuelleStadt (RasseExtern)).Position;
      
   end NächsteStadt;
   
   
   
   procedure NächsteStadtMeldung
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      SchleifenBegrenzung := 0;
      
      StadtSuchenSchleife:
      loop

         if
           AktuelleStadtMeldung (RasseExtern) >= GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze
         then
            AktuelleStadtMeldung (RasseExtern) := GlobaleVariablen.StadtGebautArray'First (2);
               
         else
            AktuelleStadtMeldung (RasseExtern) := AktuelleStadtMeldung (RasseExtern) + 1;
         end if;
               
         if
           GlobaleVariablen.StadtGebaut (RasseExtern, AktuelleStadtMeldung (RasseExtern)).ID = GlobaleKonstanten.LeerStadtID
         then
            null;
         
         else
            MeldungSchleife:
            for MeldungSchleifenwert in GlobaleRecords.StadtMeldungenArray'Range loop
               
               case
                 GlobaleVariablen.StadtGebaut (RasseExtern, AktuelleStadtMeldung (RasseExtern)).Meldungen (MeldungSchleifenwert)
               is
                  when GlobaleDatentypen.Leer =>
                     null;
                     
                  when others =>
                     exit StadtSuchenSchleife;
               end case;
               
            end loop MeldungSchleife;
         end if;
         
         if
           SchleifenBegrenzung < GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze
         then
            SchleifenBegrenzung := SchleifenBegrenzung + 1;
            
         else
            return;
         end if;

      end loop StadtSuchenSchleife;
      
      GlobaleVariablen.CursorImSpiel (RasseExtern).Position := GlobaleVariablen.StadtGebaut (RasseExtern, AktuelleStadtMeldung (RasseExtern)).Position;
      
   end NächsteStadtMeldung;
   
   
   
   procedure NächsteEinheitMeldung
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      SchleifenBegrenzung := 0;
      
      EinheitSuchenSchleife:
      loop

         if
           AktuelleEinheitMeldung (RasseExtern) >= GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze
         then
            AktuelleEinheitMeldung (RasseExtern) := GlobaleVariablen.EinheitenGebautArray'First (2);
               
         else
            AktuelleEinheitMeldung (RasseExtern) := AktuelleEinheitMeldung (RasseExtern) + 1;
         end if;
               
         if
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, AktuelleEinheitMeldung (RasseExtern))) = GlobaleKonstanten.LeerEinheitenID
         then
            null;
         
         else
            MeldungSchleife:
            for MeldungSchleifenwert in GlobaleRecords.EinheitMeldungenArray'Range loop
               
               case
                 LeseEinheitenGebaut.Meldungen (EinheitRasseNummerExtern => (RasseExtern, AktuelleEinheitMeldung (RasseExtern)),
                                                WelcheMeldungExtern      => MeldungSchleifenwert)
               is
                  when GlobaleDatentypen.Leer =>
                     null;
                     
                  when others =>
                     exit EinheitSuchenSchleife;
               end case;
               
            end loop MeldungSchleife;
         end if;
         
         if
           SchleifenBegrenzung < GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze
         then            
            SchleifenBegrenzung := SchleifenBegrenzung + 1;
            
         else
            return;
         end if;

      end loop EinheitSuchenSchleife;
      
      GlobaleVariablen.CursorImSpiel (RasseExtern).Position := LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => (RasseExtern, AktuelleEinheitMeldung (RasseExtern)));
      
   end NächsteEinheitMeldung;
   
end NaechstesObjekt;
