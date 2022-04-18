pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with EinheitStadtRecords;
with EinheitenKonstanten;
with StadtKonstanten;
with SpielVariablen;

with LeseEinheitenGebaut;
with LeseStadtGebaut;

package body NaechstesObjekt is

   procedure NächsteEinheit
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      BewegungspunkteExtern : in Bewegungspunkte)
   is begin
      
      SchleifenBegrenzung := 0;
      
      EinheitSuchenSchleife:
      loop

         if
           AktuelleEinheit (RasseExtern) >= SpielVariablen.Grenzen (RasseExtern).Einheitengrenze
         then
            AktuelleEinheit (RasseExtern) := SpielVariablen.EinheitenGebautArray'First (2);
               
         else
            AktuelleEinheit (RasseExtern) := AktuelleEinheit (RasseExtern) + 1;
         end if;
               
         if
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, AktuelleEinheit (RasseExtern))) = EinheitenKonstanten.LeerID
           or
             (LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => (RasseExtern, AktuelleEinheit (RasseExtern))) <= EinheitenKonstanten.LeerEinheit.Bewegungspunkte
              and
                BewegungspunkteExtern = Hat_Bewegungspunkte)
           or
             (LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => (RasseExtern, AktuelleEinheit (RasseExtern))) > EinheitenKonstanten.LeerEinheit.Bewegungspunkte
              and
                BewegungspunkteExtern = Keine_Bewegungspunkte)
         then
            null;
         
         else
            exit EinheitSuchenSchleife;
         end if;
         
         if
           SchleifenBegrenzung < SpielVariablen.Grenzen (RasseExtern).Einheitengrenze
         then
            SchleifenBegrenzung := SchleifenBegrenzung + 1;
            
         else
            return;
         end if;

      end loop EinheitSuchenSchleife;
      
      SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (RasseExtern, AktuelleEinheit (RasseExtern)));
      
   end NächsteEinheit;
   
   
   
   procedure NächsteStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin

      SchleifenBegrenzung := 0;
      
      StadtSuchenSchleife:
      loop

         if
           AktuelleStadt (RasseExtern) >= SpielVariablen.Grenzen (RasseExtern).Städtegrenze
         then
            AktuelleStadt (RasseExtern) := SpielVariablen.StadtGebautArray'First (2);
               
         else
            AktuelleStadt (RasseExtern) := AktuelleStadt (RasseExtern) + 1;
         end if;
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, AktuelleStadt (RasseExtern)))
         is
            when StadtKonstanten.LeerID =>
               null;
               
            when others =>
               exit StadtSuchenSchleife;
         end case;
         
         if
           SchleifenBegrenzung < SpielVariablen.Grenzen (RasseExtern).Städtegrenze
         then
            SchleifenBegrenzung := SchleifenBegrenzung + 1;
            
         else
            return;
         end if;

      end loop StadtSuchenSchleife;
      
      SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (RasseExtern, AktuelleStadt (RasseExtern)));
      
   end NächsteStadt;
   
   
   
   procedure NächsteStadtMeldung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      SchleifenBegrenzung := 0;
      
      StadtSuchenSchleife:
      loop

         if
           AktuelleStadtMeldung (RasseExtern) >= SpielVariablen.Grenzen (RasseExtern).Städtegrenze
         then
            AktuelleStadtMeldung (RasseExtern) := SpielVariablen.StadtGebautArray'First (2);
               
         else
            AktuelleStadtMeldung (RasseExtern) := AktuelleStadtMeldung (RasseExtern) + 1;
         end if;
               
         if
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, AktuelleStadtMeldung (RasseExtern))) = StadtKonstanten.LeerID
         then
            null;
         
         else
            MeldungSchleife:
            for MeldungSchleifenwert in EinheitStadtRecords.StadtMeldungenArray'Range loop
               
               case
                 LeseStadtGebaut.Meldungen (StadtRasseNummerExtern => (RasseExtern, AktuelleStadtMeldung (RasseExtern)),
                                            WelcheMeldungExtern    => MeldungSchleifenwert)
               is
                  when EinheitStadtDatentypen.Leer_Enum =>
                     null;
                     
                  when others =>
                     exit StadtSuchenSchleife;
               end case;
               
            end loop MeldungSchleife;
         end if;
         
         if
           SchleifenBegrenzung < SpielVariablen.Grenzen (RasseExtern).Städtegrenze
         then
            SchleifenBegrenzung := SchleifenBegrenzung + 1;
            
         else
            return;
         end if;

      end loop StadtSuchenSchleife;
      
      SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (RasseExtern, AktuelleStadtMeldung (RasseExtern)));
      
   end NächsteStadtMeldung;
   
   
   
   procedure NächsteEinheitMeldung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      SchleifenBegrenzung := 0;
      
      EinheitSuchenSchleife:
      loop

         if
           AktuelleEinheitMeldung (RasseExtern) >= SpielVariablen.Grenzen (RasseExtern).Einheitengrenze
         then
            AktuelleEinheitMeldung (RasseExtern) := SpielVariablen.EinheitenGebautArray'First (2);
               
         else
            AktuelleEinheitMeldung (RasseExtern) := AktuelleEinheitMeldung (RasseExtern) + 1;
         end if;
               
         if
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, AktuelleEinheitMeldung (RasseExtern))) = EinheitenKonstanten.LeerID
         then
            null;
         
         else
            MeldungSchleife:
            for MeldungSchleifenwert in EinheitStadtRecords.EinheitMeldungenArray'Range loop
               
               case
                 LeseEinheitenGebaut.Meldungen (EinheitRasseNummerExtern => (RasseExtern, AktuelleEinheitMeldung (RasseExtern)),
                                                WelcheMeldungExtern      => MeldungSchleifenwert)
               is
                  when EinheitStadtDatentypen.Leer_Enum =>
                     null;
                     
                  when others =>
                     exit EinheitSuchenSchleife;
               end case;
               
            end loop MeldungSchleife;
         end if;
         
         if
           SchleifenBegrenzung < SpielVariablen.Grenzen (RasseExtern).Einheitengrenze
         then
            SchleifenBegrenzung := SchleifenBegrenzung + 1;
            
         else
            return;
         end if;

      end loop EinheitSuchenSchleife;
      
      SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (RasseExtern, AktuelleEinheitMeldung (RasseExtern)));
      
   end NächsteEinheitMeldung;
   
end NaechstesObjekt;
