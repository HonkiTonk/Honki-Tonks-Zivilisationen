with StadtKonstanten;
with StadtRecords;

with LeseStadtGebaut;
with LeseGrenzen;

with NachGrafiktask;

package body NaechsteStadtLogik is

   procedure NächsteStadt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
   begin

      StadtSchleifenbegrenzung := 0;
      
      StadtSuchenSchleife:
      loop

         if
           AktuelleStadt (SpeziesExtern) >= LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern)
         then
            AktuelleStadt (SpeziesExtern) := StadtKonstanten.AnfangNummer;
               
         else
            AktuelleStadt (SpeziesExtern) := AktuelleStadt (SpeziesExtern) + 1;
         end if;
         
         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, AktuelleStadt (SpeziesExtern)))
         is
            when StadtKonstanten.LeerID =>
               null;
               
            when others =>
               exit StadtSuchenSchleife;
         end case;
         
         if
           StadtSchleifenbegrenzung < LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern)
         then
            StadtSchleifenbegrenzung := StadtSchleifenbegrenzung + 1;
            
         else
            return;
         end if;

      end loop StadtSuchenSchleife;
      
      NachGrafiktask.GeheZu := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => (SpeziesExtern, AktuelleStadt (SpeziesExtern)));
      
   end NächsteStadt;
   
   
   
   procedure NächsteStadtMeldung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
      use type StadtDatentypen.Stadt_Meldung_Enum;
   begin
      
      MeldungSchleifenbegrenzung := 0;
      
      StadtSuchenSchleife:
      loop

         if
           AktuelleStadtMeldung (SpeziesExtern) >= LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern)
         then
            AktuelleStadtMeldung (SpeziesExtern) := StadtKonstanten.AnfangNummer;
               
         else
            AktuelleStadtMeldung (SpeziesExtern) := AktuelleStadtMeldung (SpeziesExtern) + 1;
         end if;
               
         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, AktuelleStadtMeldung (SpeziesExtern)))
         is
            when StadtKonstanten.LeerID =>
               null;
         
            when others =>
               MeldungSchleife:
               for MeldungSchleifenwert in StadtRecords.StadtMeldungenArray'Range loop
               
                  if
                    StadtDatentypen.Leer_Stadt_Meldung_Enum = LeseStadtGebaut.Meldungen (StadtSpeziesNummerExtern => (SpeziesExtern, AktuelleStadtMeldung (SpeziesExtern)),
                                                                                         WelcheMeldungExtern      => MeldungSchleifenwert)
                  then
                     null;
                     
                  else
                     exit StadtSuchenSchleife;
                  end if;
                  
               end loop MeldungSchleife;
         end case;
         
         if
           MeldungSchleifenbegrenzung < LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern)
         then
            MeldungSchleifenbegrenzung := MeldungSchleifenbegrenzung + 1;
            
         else
            return;
         end if;

      end loop StadtSuchenSchleife;
      
      NachGrafiktask.GeheZu := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => (SpeziesExtern, AktuelleStadtMeldung (SpeziesExtern)));
      
   end NächsteStadtMeldung;

end NaechsteStadtLogik;
