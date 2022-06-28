pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtDatentypen; use StadtDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenKonstanten;

with LeseStadtGebaut;
with LeseEinheitenDatenbank;
with LeseWichtiges;
with LeseEinheitenGebaut;

with EinheitenAllgemeines;

with KIDatentypen; use KIDatentypen;

with KIKriegErmitteln;
with KIGrenzpruefungen;

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
         Aufgabenwert := Stadtzustand (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
      if
        MaximaleEinheiten (EinheitRasseNummerExtern.Rasse) + EinheitenDatentypen.MaximaleEinheitenMitNullWert (LeseWichtiges.AnzahlStädte (RasseExtern => EinheitRasseNummerExtern.Rasse))
        < LeseWichtiges.AnzahlEinheiten (RasseExtern => EinheitRasseNummerExtern.Rasse)
      then
         Aufgabenwert := KIGrenzpruefungen.AufgabenWichtigkeit (AktuellerWertExtern => Aufgabenwert,
                                                                ÄnderungExtern      => 3);
         
      else
         null;
      end if;
      
      Aufgabenwert := KIGrenzpruefungen.AufgabenWichtigkeit (AktuellerWertExtern => Aufgabenwert,
                                                             ÄnderungExtern      => GlobalerZustand (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      return Aufgabenwert;
      
   end EinheitAuflösen;
   
   
   
   --------------------------------- Die folgenden Sachen mal rassenspezifisch bauen.
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
         Zwischenwert := KIGrenzpruefungen.AufgabenWichtigkeit (AktuellerWertExtern => Zwischenwert,
                                                                ÄnderungExtern      => 10);
         
      elsif
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Heimatstadt)) = 0
        and
          LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                   IDExtern           => EinheitID,
                                                   WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum)
        > 0
      then
         Zwischenwert := KIGrenzpruefungen.AufgabenWichtigkeit (AktuellerWertExtern => Zwischenwert,
                                                                ÄnderungExtern      => 5);
         
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
         Zwischenwert := KIGrenzpruefungen.AufgabenWichtigkeit (AktuellerWertExtern => Zwischenwert,
                                                                ÄnderungExtern      => 10);
         
      elsif
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Heimatstadt)) = 0
        and
          LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                   IDExtern           => EinheitID,
                                                   WelcheKostenExtern => ProduktionDatentypen.Ressourcen_Enum)
        > 0
      then
         Zwischenwert := KIGrenzpruefungen.AufgabenWichtigkeit (AktuellerWertExtern => Zwischenwert,
                                                                ÄnderungExtern      => 5);
         
      else
         null;
      end if;
      
      return Zwischenwert;
      
   end Stadtzustand;
   
   
   
   function GlobalerZustand
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      Zwischenwert := 0;
         
      if
        LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                 IDExtern           => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                 WelcheKostenExtern => ProduktionDatentypen.Geld_Enum)
        > 0
        and
          LeseWichtiges.GeldZugewinnProRunde (RasseExtern => EinheitRasseNummerExtern.Rasse) < 0
      then
         Zwischenwert := KIGrenzpruefungen.AufgabenWichtigkeit (AktuellerWertExtern => Zwischenwert,
                                                                ÄnderungExtern      => 5);
            
      else
         null;
      end if;
      
      return Zwischenwert;
      
   end GlobalerZustand;

end KIEinheitAufgabeAufloesen;
