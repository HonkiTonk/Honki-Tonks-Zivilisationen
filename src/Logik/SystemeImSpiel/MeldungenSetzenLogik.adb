with SchreibeEinheitenGebaut;
with SchreibeStadtGebaut;

package body MeldungenSetzenLogik is

   procedure MeldungenRundenende
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           LeseRassenbelegung.Belegung (RasseExtern => RasseSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => RasseSchleifenwert) loop
                  
                  SchreibeStadtGebaut.LeerMeldungen (StadtRasseNummerExtern => (RasseSchleifenwert, StadtSchleifenwert));
                  
               end loop StadtSchleife;
                                             
               EinheitenSchleife:
               for EinheitSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => RasseSchleifenwert) loop
                  
                  SchreibeEinheitenGebaut.LeerMeldungen (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitSchleifenwert));
                  
               end loop EinheitenSchleife;
         end case;
         
      end loop RassenSchleife;
      
   end MeldungenRundenende;
   
   
   
   procedure StadtmeldungSetzen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EreignisExtern : in StadtDatentypen.Stadt_Meldungen_Verwendet_Enum)
   is begin
      
      case
        EreignisExtern
      is
         when StadtDatentypen.Produktion_Abgeschlossen_Enum | StadtDatentypen.Einheit_Unplatzierbar_Enum =>
            StadtMeldung := StadtDatentypen.Produktion_Fertig_Enum;
            
         when StadtDatentypen.Einwohner_Wachstum_Enum | StadtDatentypen.Einwohner_Reduktion_Enum =>
            StadtMeldung := StadtDatentypen.Hungersnot_Enum;
            
         when StadtDatentypen.Fremde_Einheit_Nahe_Stadt_Enum =>
            StadtMeldung := StadtDatentypen.Einheit_In_Stadtnähe_Enum;
      end case;
      
      SchreibeStadtGebaut.Meldungen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                     WelcheMeldungExtern    => StadtMeldung,
                                     MeldungExtern          => EreignisExtern);
      
   end StadtmeldungSetzen;
   
   
   
   procedure EinheitmeldungSetzen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      EreignisExtern : in EinheitenDatentypen.Einheit_Meldung_Verwendet_Enum)
   is begin
      
      case
        EreignisExtern
      is
         when EinheitenDatentypen.Aufgabe_Abgeschlossen_Enum =>
            EinheitMeldung := EinheitenDatentypen.Aufgabe_Fertig_Enum;
            
         when EinheitenDatentypen.Fremde_Einheit_Nahe_Enum =>
            EinheitMeldung := EinheitenDatentypen.Einheit_In_Der_Nähe_Enum;
      end case;
      
      SchreibeEinheitenGebaut.Meldungen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                         MeldungExtern            => EreignisExtern,
                                         WelcheMeldungExtern      => EinheitMeldung);
      
   end EinheitmeldungSetzen;

end MeldungenSetzenLogik;
