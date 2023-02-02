with EinheitenKonstanten;
with EinheitenRecords;

with LeseEinheitenGebaut;
with LeseGrenzen;

with NachGrafiktask;

package body NaechsteEinheitLogik is

   procedure NächsteEinheit
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      BewegungspunkteExtern : in Bewegungspunkte_Enum)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
      use type EinheitenDatentypen.Bewegungspunkte;
   begin
      
      EinheitSchleifenbegrenzung := 0;
      
      EinheitSuchenSchleife:
      loop

         if
           AktuelleEinheit (SpeziesExtern) >= LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern)
         then
            AktuelleEinheit (SpeziesExtern) := EinheitenKonstanten.AnfangNummer;
               
         else
            AktuelleEinheit (SpeziesExtern) := AktuelleEinheit (SpeziesExtern) + 1;
         end if;
         
         Bewegungspunkte := LeseEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => (SpeziesExtern, AktuelleEinheit (SpeziesExtern)));
               
         if
           LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (SpeziesExtern, AktuelleEinheit (SpeziesExtern))) = EinheitenKonstanten.LeerID
           or
             (Bewegungspunkte <= EinheitenKonstanten.LeerBewegungspunkte
              and
                BewegungspunkteExtern = Hat_Bewegungspunkte_Enum)
           or
             (Bewegungspunkte > EinheitenKonstanten.LeerBewegungspunkte
              and
                BewegungspunkteExtern = Keine_Bewegungspunkte_Enum)
         then
            null;
         
         else
            exit EinheitSuchenSchleife;
         end if;
         
         if
           EinheitSchleifenbegrenzung < LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern)
         then
            EinheitSchleifenbegrenzung := EinheitSchleifenbegrenzung + 1;
            
         else
            return;
         end if;

      end loop EinheitSuchenSchleife;
      
      NachGrafiktask.GeheZu := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => (SpeziesExtern, AktuelleEinheit (SpeziesExtern)));
      
   end NächsteEinheit;
   
   
   
   procedure NächsteEinheitMeldung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
   begin
      
      MeldungSchleifenbegrenzung := 0;
      
      EinheitSuchenSchleife:
      loop

         if
           AktuelleEinheitMeldung (SpeziesExtern) >= LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern)
         then
            AktuelleEinheitMeldung (SpeziesExtern) := EinheitenKonstanten.AnfangNummer;
               
         else
            AktuelleEinheitMeldung (SpeziesExtern) := AktuelleEinheitMeldung (SpeziesExtern) + 1;
         end if;
               
         if
           LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (SpeziesExtern, AktuelleEinheitMeldung (SpeziesExtern))) = EinheitenKonstanten.LeerID
         then
            null;
         
         else
            MeldungSchleife:
            for MeldungSchleifenwert in EinheitenRecords.EinheitMeldungenArray'Range loop
               
               case
                 LeseEinheitenGebaut.Meldungen (EinheitSpeziesNummerExtern => (SpeziesExtern, AktuelleEinheitMeldung (SpeziesExtern)),
                                                WelcheMeldungExtern        => MeldungSchleifenwert)
               is
                  when EinheitenDatentypen.Leer_Einheit_Meldung_Enum =>
                     null;
                     
                  when others =>
                     exit EinheitSuchenSchleife;
               end case;
               
            end loop MeldungSchleife;
         end if;
         
         if
           MeldungSchleifenbegrenzung < LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern)
         then
            MeldungSchleifenbegrenzung := MeldungSchleifenbegrenzung + 1;
            
         else
            return;
         end if;

      end loop EinheitSuchenSchleife;
      
      NachGrafiktask.GeheZu := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => (SpeziesExtern, AktuelleEinheitMeldung (SpeziesExtern)));
      
   end NächsteEinheitMeldung;

end NaechsteEinheitLogik;
