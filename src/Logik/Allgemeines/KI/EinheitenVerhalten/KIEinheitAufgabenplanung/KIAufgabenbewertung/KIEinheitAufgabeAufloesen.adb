pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtDatentypen; use StadtDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenKonstanten;
with StadtKonstanten;

with LeseStadtGebaut;
with LeseEinheitenDatenbank;
with LeseWichtiges;
with LeseEinheitenGebaut;

with EinheitenAllgemeines;

with KIDatentypen; use KIDatentypen;

with KIKriegErmitteln;
with KIPruefungen;

package body KIEinheitAufgabeAufloesen is

   function EinheitAuflösen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      -------------------------------- Später noch mal erweitern, bringt ja nichts die Einheit zu behalten, wenn die Städte dafür verhungern.
      if
        KIKriegErmitteln.IstImKrieg (RasseExtern => EinheitRasseNummerExtern.Rasse) = True
        and
          EinheitenAllgemeines.Kampfeinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         return -1;
         
      else
         -- Braucht hier keine Prüfung, da ja etwas zugewiesen wird und nicht berechnet.
         Aufgabenwert := Stadtzustand (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
      ------------------------------ Das mal in ein rassenspezifisches Array auslagern und sinnvolle Werte finden.
      if
        EinheitenDatentypen.MaximaleEinheiten (18 + LeseWichtiges.AnzahlStädte (RasseExtern => EinheitRasseNummerExtern.Rasse))
          < LeseWichtiges.AnzahlEinheiten (RasseExtern => EinheitRasseNummerExtern.Rasse)
      then
         return 3;
         
      else
         null;
      end if;
              
      case
        LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when 0 =>
            return 0;

         when others =>
            null;
      end case;

      KostenSchleife:
      for KostenSchleifenwert in ProduktionDatentypen.Permanente_Kosten_Verwendet_Enum'Range loop
         
         if
           LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                    IDExtern           => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                    WelcheKostenExtern => KostenSchleifenwert)
           = StadtKonstanten.LeerPermanenteKosten
         then
            null;
            
         else
            return 1;
         end if;
         
      end loop KostenSchleife;
                     
      return 0;
      
   end EinheitAuflösen;
   
   
   
   function Stadtzustand
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      Zwischenwert := 0;
      Heimatstadt := LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        Heimatstadt
      is
         when EinheitenKonstanten.LeerHeimatstadt =>
            return Zwischenwert;
            
         when others =>
            EinheitID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
      if
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Heimatstadt)) < 0
        and
          LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                   IDExtern           => EinheitID,
                                                   WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum)
        > 0
      then
         Zwischenwert := KIPruefungen.AufgabenWichtigkeitÄndern (AktuellerWertExtern => Zwischenwert,
                                                                  ÄnderungExtern     => 10);
         
      elsif
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Heimatstadt)) = 0
        and
          LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                   IDExtern           => EinheitID,
                                                   WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum)
        > 0
      then
         Zwischenwert := KIPruefungen.AufgabenWichtigkeitÄndern (AktuellerWertExtern => Zwischenwert,
                                                                  ÄnderungExtern     => 5);
         
      else
         null;
      end if;
      
      if
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Heimatstadt)) < 0
        and
          LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                   IDExtern           => EinheitID,
                                                   WelcheKostenExtern => ProduktionDatentypen.Ressourcen_Enum)
        > 0
      then
         Zwischenwert := KIPruefungen.AufgabenWichtigkeitÄndern (AktuellerWertExtern => Zwischenwert,
                                                                  ÄnderungExtern     => 10);
         
      elsif
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Heimatstadt)) = 0
        and
          LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                   IDExtern           => EinheitID,
                                                   WelcheKostenExtern => ProduktionDatentypen.Ressourcen_Enum)
        > 0
      then
         Zwischenwert := KIPruefungen.AufgabenWichtigkeitÄndern (AktuellerWertExtern => Zwischenwert,
                                                                  ÄnderungExtern     => 5);
         
      else
         null;
      end if;
      
      return Zwischenwert;
      
   end Stadtzustand;

end KIEinheitAufgabeAufloesen;
