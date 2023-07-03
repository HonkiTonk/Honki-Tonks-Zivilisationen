with SchreibeEinheitenGebaut;
with SchreibeStadtGebaut;
with LeseEinheitenGebaut;
with LeseStadtGebaut;

-- Was ist überhaupt bei mehreren Meldungen? äöü
package body MeldungenSetzenLogik is

   procedure MeldungenRundenende
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern) loop
         
         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               exit StadtSchleife;
               
               when others =>
               SchreibeStadtGebaut.LeerMeldungen (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert));
         end case;
                  
      end loop StadtSchleife;
      
      
                                             
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern) loop
         
         case
           LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               exit EinheitenSchleife;
               
            when others =>
               SchreibeEinheitenGebaut.LeerMeldungen (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert));
         end case;
                  
      end loop EinheitenSchleife;
      
   end MeldungenRundenende;
   
   
   
   procedure StadtmeldungSetzen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
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
      
      SchreibeStadtGebaut.Meldungen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                     WelcheMeldungExtern      => StadtMeldung,
                                     MeldungExtern            => EreignisExtern);
      
   end StadtmeldungSetzen;
   
   
   
   procedure EinheitmeldungSetzen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
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
      
      SchreibeEinheitenGebaut.Meldungen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                         MeldungExtern              => EreignisExtern,
                                         WelcheMeldungExtern        => EinheitMeldung);
      
   end EinheitmeldungSetzen;

end MeldungenSetzenLogik;
