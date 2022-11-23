with StadtKonstanten;
with StadtRecords;

with LeseStadtGebaut;
with LeseGrenzen;

with NachGrafiktask;

package body NaechsteStadtLogik is

   procedure NächsteStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
   begin

      StadtSchleifenbegrenzung := 0;
      
      StadtSuchenSchleife:
      loop

         if
           AktuelleStadt (RasseExtern) >= LeseGrenzen.Städtegrenzen (RasseExtern => RasseExtern)
         then
            AktuelleStadt (RasseExtern) := StadtKonstanten.AnfangNummer;
               
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
           StadtSchleifenbegrenzung < LeseGrenzen.Städtegrenzen (RasseExtern => RasseExtern)
         then
            StadtSchleifenbegrenzung := StadtSchleifenbegrenzung + 1;
            
         else
            return;
         end if;

      end loop StadtSuchenSchleife;
      
      NachGrafiktask.GeheZu := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (RasseExtern, AktuelleStadt (RasseExtern)));
      
   end NächsteStadt;
   
   
   
   procedure NächsteStadtMeldung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
      use type StadtDatentypen.Stadt_Meldung_Enum;
   begin
      
      MeldungSchleifenbegrenzung := 0;
      
      StadtSuchenSchleife:
      loop

         if
           AktuelleStadtMeldung (RasseExtern) >= LeseGrenzen.Städtegrenzen (RasseExtern => RasseExtern)
         then
            AktuelleStadtMeldung (RasseExtern) := StadtKonstanten.AnfangNummer;
               
         else
            AktuelleStadtMeldung (RasseExtern) := AktuelleStadtMeldung (RasseExtern) + 1;
         end if;
               
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, AktuelleStadtMeldung (RasseExtern)))
         is
            when StadtKonstanten.LeerID =>
               null;
         
            when others =>
               MeldungSchleife:
               for MeldungSchleifenwert in StadtRecords.StadtMeldungenArray'Range loop
               
                  if
                    StadtDatentypen.Leer_Stadt_Meldung_Enum = LeseStadtGebaut.Meldungen (StadtRasseNummerExtern => (RasseExtern, AktuelleStadtMeldung (RasseExtern)),
                                                                                         WelcheMeldungExtern    => MeldungSchleifenwert)
                  then
                     null;
                     
                  else
                     exit StadtSuchenSchleife;
                  end if;
                  
               end loop MeldungSchleife;
         end case;
         
         if
           MeldungSchleifenbegrenzung < LeseGrenzen.Städtegrenzen (RasseExtern => RasseExtern)
         then
            MeldungSchleifenbegrenzung := MeldungSchleifenbegrenzung + 1;
            
         else
            return;
         end if;

      end loop StadtSuchenSchleife;
      
      NachGrafiktask.GeheZu := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (RasseExtern, AktuelleStadtMeldung (RasseExtern)));
      
   end NächsteStadtMeldung;

end NaechsteStadtLogik;
